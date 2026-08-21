_class("UISeasonMazeRoomBeadItemData", Object)
UISeasonMazeRoomBeadItemData = UISeasonMazeRoomBeadItemData

function UISeasonMazeRoomBeadItemData:Constructor(slotIndex, slotData)
  self._slotIndex = slotIndex
  self._slotData = slotData
end

_class("UISeasonMazeRoomBead", UISeasonMazeRoomBase)
UISeasonMazeRoomBead = UISeasonMazeRoomBead

function UISeasonMazeRoomBead:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeRoomBead:OnShowUI(uiParams)
  self._mulitOpen = UnityEngine.Input.multiTouchEnabled
  UnityEngine.Input.multiTouchEnabled = false
  self._seasonMazeObj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  self._component = self._seasonMazeObj:GetMazeComponent()
  self._comCfgID = self._component:GetComponentCfgId()
  self._cfg_global = Cfg.cfg_component_season_maze_global[self._comCfgID]
  self._uiSeasonMazeModule = GameGlobal.GetUIModule(SeasonMazeModule)
  self._showInAnimPlayed = false
  self:InitWidget()
  self:SetTopBtn()
  self:SetUISeasonMazeTopIcon()
  self:CreateData()
  self:PlayTalk()
end

function UISeasonMazeRoomBead:InitWidget()
  self.topBtn = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._pool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._ResetTex = self:GetUIComponent("UILocalizationText", "ResetTex")
  self._ResetCostText = self:GetUIComponent("UILocalizationText", "ResetCostText")
  self._ResetCostIcon = self:GetUIComponent("RawImageLoader", "ResetCostIcon")
  self.UISeasonMazeTopIcon = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeTopIcon")
  self._ResetBtnAnim = self:GetUIComponent("Animation", "ResetBtn")
  self._ResetBtnRect = self:GetUIComponent("RectTransform", "ResetBtn")
  self._ResetMaskImage = self:GetUIComponent("Image", "mask")
  self._talkGo = self:GetGameObject("talkGo")
  self._talkTex = self:GetUIComponent("UILocalizationText", "talkTex")
  self._talkAnim = self:GetUIComponent("Animation", "talkGo")
  self._talks = {
    [1] = "str_season_maze_shop_room_npc_talk_1",
    [2] = "str_season_maze_shop_room_npc_talk_2",
    [3] = "str_season_maze_shop_room_npc_talk_3"
  }
  self._talkIdx = 0
  self._beadBtnObj = self:GetGameObject("BeadBtn")
  self._red = self:GetGameObject("Red")
  self._redCount = self:GetGameObject("Count")
  self._redCountValue = self:GetUIComponent("UILocalizationText", "CountValue")
  self:AttachEvent(GameEventType.OnSeasonMazeShowRewardsFinish, self.OnSeasonMazeShowRewardsFinish)
end

function UISeasonMazeRoomBead:SetTopBtn()
  self.topBtn:SpawnObject("UISMazeCommonTopButton"):SetData(function()
    self:OnHideUI()
  end, nil, nil, true)
end

function UISeasonMazeRoomBead:PetBtnOnClick()
  self:PlayTalk()
end

function UISeasonMazeRoomBead:PlayTalk()
  local randomList = {}
  for index, value in ipairs(self._talks) do
    if index ~= self._talkIdx then
      table.insert(randomList, value)
    end
  end
  self._talkIdx = math.random(1, #randomList)
  local tex = randomList[self._talkIdx]
  self._talkTex:SetText(StringTable.Get(tex))
  self:PlayTalkShowAnim()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEvent(5000, function()
    self:PlayTalkHideAnim()
  end)
end

function UISeasonMazeRoomBead:PlayTalkShowAnim()
  self._talkAnim:Stop()
  self._talkAnim:Play("uieffanim_UISeasonMaze_Campsites_Smithy_talkGo_in")
end

function UISeasonMazeRoomBead:PlayTalkHideAnim()
  self._talkAnim:Stop()
  self._talkAnim:Play("uieffanim_UISeasonMaze_Campsites_Smithy_talkGo_out")
end

function UISeasonMazeRoomBead:SetUISeasonMazeTopIcon()
  if self.UISeasonMazeTopIcon then
    if not self.UISeasonMazeTopIconWidget then
      self.UISeasonMazeTopIconWidget = self.UISeasonMazeTopIcon:SpawnObject("UISeasonMazeTopIcon")
    end
    local typeList = {
      SeasonMazeTopIconType.Money
    }
    self.UISeasonMazeTopIconWidget:SetData(typeList)
  end
end

function UISeasonMazeRoomBead:SetItemList()
  self._pool:SpawnObjects("UISeasonMazeRoomBeadItem", #self._itemList)
  self._cellWidgets = self._pool:GetAllSpawnList()
  for i = 1, #self._itemList do
    local widget = self._cellWidgets[i]
    local item = self._itemList[i]
    widget:SetData(i, item, function(index)
      self:OnItemClick(index)
    end, self._component)
  end
end

function UISeasonMazeRoomBead:TryPlayFirstShowInAnim()
  if self._showInAnimPlayed then
    return
  end
  self._showInAnimPlayed = true
  self:PlayCellsShowInAnim()
end

function UISeasonMazeRoomBead:PlayCellsShowInAnim()
  if self._inAnimationTask then
    GameGlobal.TaskManager():KillTask(self._inAnimationTask)
    self._inAnimationTask = nil
  end
  self._inAnimationTask = self:StartTask(function(TT)
    if self._cellWidgets then
      for _, widget in ipairs(self._cellWidgets) do
        widget:PlayShowInAnim()
      end
    end
  end)
end

function UISeasonMazeRoomBead:PlayCellsOutAnim()
  if self._cellWidgets then
    for index, widget in ipairs(self._cellWidgets) do
      widget:PlayShowOutAnim()
    end
  end
end

function UISeasonMazeRoomBead:OnItemClick(index)
  self._chooseIdx = index
  self:RefreshSelectItem()
  self:ShowBuy()
end

function UISeasonMazeRoomBead:RefreshSelectItem()
  if self._cellWidgets then
    for index, widget in ipairs(self._cellWidgets) do
      widget:OnSelect(index == self._chooseIdx)
    end
  end
end

function UISeasonMazeRoomBead:ShowBuy()
  local beadItemData = self._itemList[self._chooseIdx]
  if beadItemData then
    if beadItemData._slotData.price <= 0 then
      self:ReqBeadBuy()
    else
      self:ShowDialog("UISeasonMazeRoomBeadBuy", beadItemData, self._component, function()
        self:ReqBeadBuy()
      end)
    end
  end
end

function UISeasonMazeRoomBead:CreateData()
  self._itemList = {}
  local comInfo = self._component:GetComponentInfo()
  local slotInfo = comInfo.slot_info
  if slotInfo and table.count(slotInfo.items) > 0 then
    local slotItems = slotInfo.items
    for key, value in pairs(slotItems) do
      if value.item.id ~= 0 then
        local beadItemData = UISeasonMazeRoomBeadItemData:New(key, value)
        table.insert(self._itemList, beadItemData)
      end
    end
    table.sort(self._itemList, function(a, b)
      return a._slotIndex < b._slotIndex
    end)
    self._resetCount = slotInfo.reset_cnt
    self:RefreshInfos()
    self:TryPlayFirstShowInAnim()
  else
    self:ReqSlotInfos()
  end
end

function UISeasonMazeRoomBead:RefreshInfos()
  self._chooseIdx = 0
  self:SetItemList()
  self:RefreshSelectItem()
  self:ShowResetPrice()
  self:RefreshMoney()
end

function UISeasonMazeRoomBead:ReqSlotInfos()
  self:Lock("UISeasonMazeRoomBead:ReqSlotInfos")
  GameGlobal.TaskManager():StartTask(self.TaskReqSlotInfos, self)
end

function UISeasonMazeRoomBead:TaskReqSlotInfos(TT)
  local res = AsyncRequestRes:New()
  self._component:HandleSeasonMazeGetSlot(TT, res)
  self:UnLock("UISeasonMazeRoomBead:ReqSlotInfos")
  if res:GetSucc() then
    self._itemList = {}
    local comInfo = self._component:GetComponentInfo()
    local slotInfo = comInfo.slot_info
    if slotInfo then
      local slotItems = slotInfo.items
      for key, value in pairs(slotItems) do
        if value.item.id ~= 0 then
          local beadItemData = UISeasonMazeRoomBeadItemData:New(key, value)
          table.insert(self._itemList, beadItemData)
        end
      end
      self._resetCount = slotInfo.reset_cnt
      self:RefreshInfos()
      self:TryPlayFirstShowInAnim()
    end
  else
    local result = res:GetResult()
    Log.error("[UISeasonMazeRoomBead] HandleSeasonMazeGetSlot fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoomBead:ReqBeadBuy()
  local curGold = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local data = self._itemList[self._chooseIdx]
  if data then
    local cost = data._slotData.price
    if curGold < cost then
      local tips = StringTable.Get("str_season_maze_gold_not_enough")
      ToastManager.ShowToast(tips)
      return
    end
  end
  self:Lock("UISeasonMazeRoomBead:ReqBeadBuy")
  GameGlobal.TaskManager():StartTask(self.TaskReqBeadBuy, self)
end

function UISeasonMazeRoomBead:TaskReqBeadBuy(TT)
  local res = AsyncRequestRes:New()
  local data = self._itemList[self._chooseIdx]
  if data then
    local slotIndex = data._slotIndex
    local response = self._component:HandleSeasonMazeOperaSlot(TT, res, slotIndex, false)
    self:UnLock("UISeasonMazeRoomBead:ReqBeadBuy")
    if res:GetSucc() then
      self:OnBuyEnd()
      local reward = response.reward
      local showRewards = {}
      local data = SeasonMazeEffect:New()
      data.type = SeasonMazeEffectType.SMET_Bead
      data.id = reward[1].id
      data.value_min = 1
      data.value_max = 1
      table.insert(showRewards, data)
      SeasonMazeTool:GetInstance():ShowUIGetRewards(showRewards)
    else
      GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res:GetResult())
    end
  end
end

function UISeasonMazeRoomBead:OnBuyEnd()
  self:CreateData()
  self._chooseIdx = 0
  self:RefreshSelectItem()
  self:ShowResetPrice()
end

function UISeasonMazeRoomBead:RefreshMoney()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Gold)
end

function UISeasonMazeRoomBead:OnHide()
  UnityEngine.Input.multiTouchEnabled = self._mulitOpen
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  if self._inAnimationTask then
    GameGlobal.TaskManager():KillTask(self._inAnimationTask)
    self._inAnimationTask = nil
  end
end

function UISeasonMazeRoomBead:GetResetCost()
  return self:CalcResetCost(self._resetCount, self._cfg_global.SlotParam)
end

function UISeasonMazeRoomBead:ShowResetPrice()
  local cost = self:GetResetCost()
  local curGold = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local costStr = tostring(cost)
  if cost > curGold then
    costStr = "<color=#c97d7d>" .. costStr .. "</color>"
  end
  self._ResetCostText:SetText(costStr)
end

function UISeasonMazeRoomBead:PlayResetBtnAnim()
  self._ResetBtnAnim:Stop()
  self._ResetBtnRect.localScale = Vector3(1, 1, 1)
  self._ResetMaskImage.color = Color(0.5490196078431373, 0.5490196078431373, 0.5490196078431373, 0)
  self._ResetBtnAnim:Play("uieffanim_UISeasonMaze_Campsites_Bank_SaveBtn1_click")
end

function UISeasonMazeRoomBead:ResetBtnMaskOnClick(go)
  self:PlayResetBtnAnim()
  self:ReqResetSlots()
end

function UISeasonMazeRoomBead:ReqResetSlots()
  local curGold = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local cost = self:GetResetCost()
  if curGold < cost then
    local tips = StringTable.Get("str_season_maze_gold_not_enough")
    ToastManager.ShowToast(tips)
    return
  end
  self:Lock("UISeasonMazeRoomBead:ReqResetSlots")
  GameGlobal.TaskManager():StartTask(self.TaskReqResetSlots, self)
end

function UISeasonMazeRoomBead:TaskReqResetSlots(TT)
  local res = AsyncRequestRes:New()
  local tmpIndex = 1
  self._component:HandleSeasonMazeOperaSlot(TT, res, tmpIndex, true)
  if res:GetSucc() then
    self._itemList = {}
    local componentInfo = self._component:GetComponentInfo()
    local slotInfo = componentInfo.slot_info
    if slotInfo then
      local slotItems = slotInfo.items
      for key, value in pairs(slotItems) do
        if value.item.id ~= 0 then
          local beadItemData = UISeasonMazeRoomBeadItemData:New(key, value)
          table.insert(self._itemList, beadItemData)
        end
      end
      self._resetCount = slotInfo.reset_cnt
      self._chooseIdx = 0
      self:RefreshSelectItem()
      self:ShowResetPrice()
      self:RefreshMoney()
      self:PlayCellsOutAnim()
      YIELD(TT, 333)
      self:SetItemList()
      self:PlayCellsShowInAnim()
      self:UnLock("UISeasonMazeRoomBead:ReqResetSlots")
    end
  else
    self:UnLock("UISeasonMazeRoomBead:ReqResetSlots")
    local result = res:GetResult()
    Log.error("[UISeasonMaze_Campsites_Recruit] HandleSeasonMazeOperaSlot fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoomBead:BeadBtnOnClick(go)
  self:ShowDialog("UISeasonMazeBead")
end

function UISeasonMazeRoomBead:OnSeasonMazeShowRewardsFinish(flag)
  if self._waitGetRewardsFinishCb then
    self._waitGetRewardsFinishCb()
    self._waitGetRewardsFinishCb = nil
  end
end

function UISeasonMazeRoomBead:BackBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
  self._seasonMazeModule:UIModule():SetTempRoom(self:GetName())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTempCloseRoom, true)
  self:CloseDialog()
end

function UISeasonMazeRoomBead:CloseBtnOnClick(go)
  self:OnHideUI()
end

function UISeasonMazeRoomBead:GetSeasonMazeCfg(hardLevel)
  local cfgs = Cfg.cfg_component_season_maze({
    ComponentID = self._comCfgID
  })
  if cfgs and table.count(cfgs) > 0 then
    for _, v in pairs(cfgs) do
      if v.Hard == hardLevel then
        return v
      end
    end
  end
  return nil
end

function UISeasonMazeRoomBead:CalcResetCost(resetCount, cfgParam)
  local x = resetCount or 0
  local cfg_reset = cfgParam
  local a = cfg_reset[1]
  local b = cfg_reset[2]
  local c = cfg_reset[3]
  if not (a and b) or not c then
    Log.error("[UISeasonMazeRoomBead] self._cfg_global.PetParam is nil !")
  end
  local baseCost = a * (x * x) + b * x + c
  local shopParam = 1
  local comInfo = self._component:GetComponentInfo()
  local priceAttr = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Goods_Price_Percent)
  local currentHard = comInfo.hard
  local seasonMazeCfg = self:GetSeasonMazeCfg(currentHard)
  if seasonMazeCfg then
    local bossInfos = comInfo.boss_info
    local bossCount = table.count(bossInfos)
    for i = 0, bossCount - 1 do
      local bossInfo = bossInfos[i]
      if bossInfo.do_cnt ~= -1 then
        shopParam = (seasonMazeCfg.ShopIndex[i + 1] + priceAttr) / 1000
        break
      end
    end
  end
  local cost = baseCost * shopParam
  cost = lmathext.round(cost)
  return cost
end

function UISeasonMazeRoomBead:RefreshNew()
  local count = 0
  local isUnlock = false
  local componentInfo = self._component:GetComponentInfo()
  if componentInfo then
    if componentInfo.m_auto_bead_map then
      for _, value in pairs(componentInfo.m_auto_bead_map) do
        local data = value
        if data and data.bead_info.b_new then
          count = count + 1
        end
      end
    end
    local cfgs = Cfg.cfg_component_season_maze({
      Hard = componentInfo.hard
    })
    if cfgs and cfgs[1] then
      isUnlock = 0 < cfgs[1].BeadSlotCnt
    end
  end
  if isUnlock then
    self._red:SetActive(count == 1)
    self._redCount:SetActive(1 < count)
    self._redCountValue:SetText(tostring(count))
  end
  self._beadBtnObj:SetActive(isUnlock)
end
