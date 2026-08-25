local WorldStageCmdDataComp = System.NewComponent("WorldStageCmdDataComp")
local WorldStageSelectSingleCardPanel_MaxCardCount = 5

function WorldStageCmdDataComp:ctor(stageComp)
  self.stageComp = stageComp
  self.cmdDataList = {}
  self:SetBusy(false)
  self.handleFuncs = {
    SelectAwakenCard = self.SelectAwakenCard,
    SelectCard = self.SelectCard,
    SelectRelic = self.CmdGainRelic,
    SelectAwaker = self.SelectAwaker,
    CmdGainRelic = self.CmdGainRelic,
    CmdConfirmEnchant = self.CmdConfirmEnchant,
    Select_intention = self.SelectCard
  }
end

function WorldStageCmdDataComp:OnBind(binder)
  self.binder = binder
  binder:BindResponse(self, "World", "OnCmdChooseData", System.fn(self, self.OnNewCmdData))
  binder:BindTimer(0.2, -1, System.fn(self, self.Update), nil)
  binder:BindEvent(EventMgr.Instance.MapEnterFinished, System.fn(self, self.OnMapEnterFinished))
end

function WorldStageCmdDataComp:Init(cmdData)
  if cmdData then
    if table.isarray(cmdData) then
      for _, cmd in pairs(cmdData) do
        table.insert(self.cmdDataList, cmd)
      end
    else
      table.insert(self.cmdDataList, cmdData)
    end
  end
end

function WorldStageCmdDataComp:OnMapEnterFinished()
  self._isMapEnterFinished = true
end

function WorldStageCmdDataComp:IsHaveCmdData()
  do return table.next end
  return table.next, self.cmdDataList
end

function WorldStageCmdDataComp:OnNewCmdData(cmdData)
  local isNew = true
  for _, cmd in ipairs(self.cmdDataList or {}) do
    if cmd.uid == cmdData.uid then
      isNew = false
      break
    end
  end
  if isNew then
    table.insert(self.cmdDataList, cmdData)
  end
end

function WorldStageCmdDataComp:Update()
  if self:IsBusy() then
    return
  end
  local mapEntity = self.stageComp.map
  if not mapEntity or not mapEntity.isShow then
    return
  end
  if not self._isMapEnterFinished then
    return
  end
  if not SceneMgr.Instance:IsEnableSceneUI() then
    return
  end
  if not self:IsHaveCmdData() then
    return
  end
  if UIManager.Instance:GetWindow(Urls.LevelUnlockRelicView) then
    return
  end
  local cmdData = table.remove(self.cmdDataList, 1)
  if cmdData then
    self:DealCmdData(cmdData)
  end
end

function WorldStageCmdDataComp:SetBusy(isBusy)
  self._isBusy = isBusy
end

function WorldStageCmdDataComp:IsBusy()
  return self._isBusy
end

function WorldStageCmdDataComp:SetMapClickable(isClickable)
  local mapEntiy = self.stageComp.map
  if mapEntiy then
    mapEntiy:SetClickState(isClickable)
  end
end

function WorldStageCmdDataComp:DealCmdData(svrData)
  local targetData = svrData.targetData
  local cmdType = targetData.cmdType
  local handleFunc = self.handleFuncs[cmdType]
  if handleFunc then
    self:SetBusy(true)
    handleFunc(self, svrData.uid, targetData)
  else
    Logger.Warn("MapNetEventManager.OnCmdChoose 暂时没有处理该类型", cmdType)
  end
end

function WorldStageCmdDataComp:ReqCmdChooseTarget(cmdUid, uids, callFunc)
  ProtoManager.Instance:ReqServer("WorldRequest", "OnCmdChooseTarget", function(data)
    self:SetBusy(false)
    if callFunc then
      callFunc()
    end
  end, function()
    self:SetBusy(false)
  end, cmdUid, uids)
end

function WorldStageCmdDataComp:SelectAwakenCard(cmdUid, targetData)
  local title
  if targetData.desc and targetData.desc ~= "" then
    title = LT.Text(targetData.desc)
  else
    title = LT.Text("Card_Awaker_Select")
  end
  UIManager.Instance:Show(Urls.CardUnlockAbPanel, targetData.chooseData, function(awakerUid)
    if type(awakerUid) == "table" then
      self:ReqCmdChooseTarget(cmdUid, awakerUid)
    else
      self:ReqCmdChooseTarget(cmdUid, {awakerUid})
    end
  end, {
    hideCancelBtn = true,
    cardType = targetData.isAwaken or 1,
    selectCount = targetData.chooseNum or 1,
    titleStr = title
  })
end

function WorldStageCmdDataComp:SelectAwaker(cmdUid, targetData)
  UIManager.Instance:Reopen(Urls.DbgMainCopyAwakerSelectionPanel, targetData.chooseData, function(uid)
    if type(uid) == "table" then
      self:ReqCmdChooseTarget(cmdUid, uid)
    else
      self:ReqCmdChooseTarget(cmdUid, {uid})
    end
  end, {
    hideCancelBtn = true,
    cardType = targetData.isAwaken or 1,
    selectCount = targetData.chooseNum or 1,
    isAllChoose = 1 ~= targetData.isAllChoose,
    desc = targetData.desc
  })
end

function WorldStageCmdDataComp:SelectCard(cmdUid, targetData)
  Logger.Info("[WorldStageCmdDataComp] SelectCard")
  local showCards = {}
  for _, v in ipairs(targetData.chooseData) do
    local cardInfo, index = CardDataUtils.GetCardInfo(v.uid)
    if cardInfo then
      cardInfo = table.deepclone(cardInfo)
      cardInfo.sortIndex = index
      table.insert(showCards, cardInfo)
    end
  end
  table.sort(showCards, function(a, b)
    return a.sortIndex < b.sortIndex
  end)
  local chooseNum = targetData.chooseNum or 1
  if #showCards <= WorldStageSelectSingleCardPanel_MaxCardCount and chooseNum <= 1 then
    self:OpenWorldStageSelectSingleCardPanel(showCards, cmdUid, targetData)
  else
    self:OpenWorldStageCardSelectPanel(showCards, cmdUid, targetData)
  end
end

function WorldStageCmdDataComp:OpenWorldStageSelectSingleCardPanel(showCards, cmdUid, targetData)
  local function onSelectComplete(cardUid)
    self:ReqCmdChooseTarget(cmdUid, {cardUid})
    
    self:SetMapClickable(true)
  end
  
  local desc = targetData.desc or "ResonanceSelectCard"
  local properties = {}
  properties.callback = onSelectComplete
  properties.title = LT.Text(desc)
  UIManager.Instance:Show(Urls.WorldStageSelectSingleCardPanel, showCards, properties)
  self:SetMapClickable(false)
end

function WorldStageCmdDataComp:OpenWorldStageCardSelectPanel(showCards, cmdUid, targetData, desc)
  local function onSelectComplete(cardUids)
    Logger.Info("onSelectComplete", table.tostring(cardUids))
    
    self:ReqCmdChooseTarget(cmdUid, cardUids)
    self:SetMapClickable(true)
  end
  
  local properties = {}
  properties.selectNum = targetData.chooseNum or 1
  properties.callback = onSelectComplete
  properties.tip = LT.Text("RemoveCardHint")
  if targetData.desc ~= "" then
    properties.desc = desc or targetData.desc
  end
  if 1 == targetData.isAllChoose then
    properties.minSelectNum = properties.selectNum
  else
    properties.minSelectNum = 0
  end
  print("OpenWorldStageCardSelectPanel", table.tostring(targetData))
  UIManager.Instance:Show(Urls.WorldStageCardSelectPanel, showCards, properties)
  self:SetMapClickable(false)
end

function WorldStageCmdDataComp:CmdGainRelic(cmdUid, targetData)
  local userData = {
    confirmCb = function(uids, callFunc)
      self:ReqCmdChooseTarget(cmdUid, uids, callFunc)
    end,
    maxCount = targetData.chooseNum,
    mustSelect = 1 == targetData.isAllChoose,
    relics = targetData.chooseData,
    titleStr = self.GetTreeSelectTitleDesc(targetData.desc, targetData.chooseNum)
  }
  if #targetData.chooseData > 3 then
    UIManager.Instance:InsertCopyUIShowQueue(Urls.WorldStageRelicSelectPanel, userData)
  else
    UIManager.Instance:InsertCopyUIShowQueue(Urls.WorldStageRelicThreeSelectPanel, userData)
  end
end

function WorldStageCmdDataComp.GetTreeSelectTitleDesc(desc, chooseNum)
  local rst = ""
  if desc and "" ~= desc then
    rst = LT.Text(desc)
  else
    rst = LT.Textf("Relic_Select", chooseNum or 1)
  end
  return rst
end

function WorldStageCmdDataComp:CmdConfirmEnchant(cmdUid, targetData)
  local data = {}
  local enchantToUid = {}
  for _, v in ipairs(targetData.chooseData) do
    local cardInfo, index = CardDataUtils.GetCardInfo(v.cardUid)
    local info = table.clone(cardInfo or {})
    info.sortIndex = index or v.cardUid
    info.num = 1
    info.tid = v.enchant
    info.type = v.targetType
    info.cardUid = v.cardUid and v.cardUid > 0 and v.cardUid or v.uid
    info.uid = v.uid
    info.index = v.uid
    info.cardTid = v.tid
    enchantToUid[v.uid] = v.uid
    table.insert(data, info)
  end
  table.sort(data, function(a, b)
    return a.sortIndex < b.sortIndex
  end)
  local panelParam = {
    true,
    {
      gainNum = 1,
      type = "enchant",
      items = data
    },
    function(r)
      Logger.Info("Callback====>", r)
    end,
    function(param, callFunc)
      Logger.Info("======confirm", table.tostring(param))
      local selectUids = {}
      if param and param[1] then
        table.insert(selectUids, enchantToUid[param[1].uid])
      end
      self:ReqCmdChooseTarget(cmdUid, selectUids, callFunc)
    end
  }
  if #data <= 4 then
    local isOpened = UIManager.Instance:GetWindow(Urls.WorldStageBattleRewardPanel) ~= nil
    if isOpened then
      UIManager.Instance:Reopen(Urls.WorldStageBattleRewardPanel, table.unpack(panelParam))
    else
      UIManager.Instance:InsertCopyUIReopenQueue(Urls.WorldStageBattleRewardPanel, table.unpack(panelParam))
    end
  else
    self:OpenWorldStageCardSelectPanel(data, cmdUid, targetData)
  end
end

return WorldStageCmdDataComp
