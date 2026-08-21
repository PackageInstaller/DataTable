require("ui_season_maze_room_base")
_class("UISeasonMazeRoomShop", UISeasonMazeRoomBase)
UISeasonMazeRoomShop = UISeasonMazeRoomShop

function UISeasonMazeRoomResources:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeRoomShop:InitWidget()
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
  self:AttachEvent(GameEventType.OnSeasonMazeShowRewardsFinish, self.OnSeasonMazeShowRewardsFinish)
end

function UISeasonMazeRoomShop:SetTopBtn()
  self.topBtn:SpawnObject("UISMazeCommonTopButton"):SetData(function()
    self:OnHideUI()
  end, nil, nil, true)
end

function UISeasonMazeRoomShop:PetBtnOnClick()
  self:PlayTalk()
end

function UISeasonMazeRoomShop:PlayTalk()
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

function UISeasonMazeRoomShop:PlayTalkShowAnim()
  self._talkAnim:Stop()
  self._talkAnim:Play("uieffanim_UISeasonMaze_Campsites_Smithy_talkGo_in")
end

function UISeasonMazeRoomShop:PlayTalkHideAnim()
  self._talkAnim:Stop()
  self._talkAnim:Play("uieffanim_UISeasonMaze_Campsites_Smithy_talkGo_out")
end

function UISeasonMazeRoomShop:OnShowUI(uiParams)
  self._mulitOpen = UnityEngine.Input.multiTouchEnabled
  UnityEngine.Input.multiTouchEnabled = false
  self._seasonMazeObj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  self._com = self._seasonMazeObj:GetMazeComponent()
  self._comCfgID = self._com:GetComponentCfgId()
  self._cfg_global = Cfg.cfg_component_season_maze_global[self._comCfgID]
  self._uiSeasonMazeModule = GameGlobal.GetUIModule(SeasonMazeModule)
  self._showInAnimPlayed = false
  self:InitWidget()
  self:SetTopBtn()
  self:SetUISeasonMazeTopIcon()
  self:CreateData()
  self:PlayTalk()
end

function UISeasonMazeRoomShop:SetUISeasonMazeTopIcon()
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

function UISeasonMazeRoomShop:SetItemList()
  self._pool:SpawnObjects("UISeasonMaze_Campsites_SmithyWidget", #self._itemList)
  local pools = self._pool:GetAllSpawnList()
  self._cellWidgets = pools
  for i = 1, #self._itemList do
    local widget = pools[i]
    local item = self._itemList[i]
    widget:SetData(i, item, function(idx)
      self:OnItemClick(idx)
    end, self._com)
  end
end

function UISeasonMazeRoomShop:TryPlayFirstShowInAnim()
  if self._showInAnimPlayed then
    return
  end
  self._showInAnimPlayed = true
  self:PlayCellsShowInAnim()
end

function UISeasonMazeRoomShop:PlayCellsShowInAnim()
  self._cellCountPerRow = 4
  local lockName = "UISeasonMazeRoomShop:PlayCellsShowInAnim"
  self:StartTask(function(TT)
    local eachDelay = 50
    local lockTime = 500
    local maxDelayMs = 0
    if self._cellWidgets then
      for index, widget in ipairs(self._cellWidgets) do
        local col = index % self._cellCountPerRow
        if col == 0 then
          col = self._cellCountPerRow
        end
        local delayMs = (col - 1) * eachDelay
        widget:PlayShowInAnim(delayMs)
        maxDelayMs = delayMs
      end
    end
    lockTime = lockTime + maxDelayMs
  end)
end

function UISeasonMazeRoomShop:PlayCellsOutAnim()
  if self._cellWidgets then
    for index, widget in ipairs(self._cellWidgets) do
      widget:PlayShowOutAnim()
    end
  end
end

function UISeasonMazeRoomShop:OnItemClick(idx)
  self._chooseIdx = idx
  self:RefreshSelectItem()
  self:ShowBuy()
end

function UISeasonMazeRoomShop:RefreshSelectItem()
  if self._cellWidgets then
    for index, widget in ipairs(self._cellWidgets) do
      widget:ShowSelected(index == self._chooseIdx)
    end
  end
end

function UISeasonMazeRoomShop:ShowBuy()
  local uiData = self._itemList[self._chooseIdx]
  if uiData then
    local seasomMazeEffectType = uiData._slotData.item.type
    if seasomMazeEffectType == SeasonMazeEffectType.SMET_Once then
      self:ShowDialog("UISeasonMaze_Campsites_SmithyBuyItem", uiData, self._com, function()
        self:ReqSmithBuy()
      end)
    elseif uiData._slotData.item.id == SeasonMazeAttrType.SMAT_WorldBossTicket then
      self:ShowDialog("UISeasonMaze_Campsites_SmithyBuyItem", uiData, self._com, function()
        self:ReqSmithBuy()
      end, true)
    else
      self:ShowDialog("UISeasonMaze_Campsites_SmithyBuyRelic", uiData, self._com, function()
        self:ReqSmithBuy()
      end)
    end
  end
end

function UISeasonMazeRoomShop:CreateData()
  self._itemList = {}
  local comInfo = self._com:GetComponentInfo()
  local slotInfo = comInfo.slot_info
  if slotInfo and table.count(slotInfo.items) > 0 then
    local slotItems = slotInfo.items
    for key, value in pairs(slotItems) do
      if value.item.id == 0 and value.price == 0 then
      else
        local uiSmithyItemData = UiSmithyItemData:New(key, value)
        table.insert(self._itemList, uiSmithyItemData)
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

function UISeasonMazeRoomShop:RefreshInfos()
  self._chooseIdx = 0
  self:SetItemList()
  self:RefreshSelectItem()
  self:ShowResetPrice()
  self:RefreshMoney()
end

function UISeasonMazeRoomShop:ReqSlotInfos()
  self:Lock("UISeasonMazeRoomShop:ReqSlotInfos")
  GameGlobal.TaskManager():StartTask(self.TaskReqSlotInfos, self)
end

function UISeasonMazeRoomShop:TaskReqSlotInfos(TT)
  local res = AsyncRequestRes:New()
  local response = self._com:HandleSeasonMazeGetSlot(TT, res)
  self:UnLock("UISeasonMazeRoomShop:ReqSlotInfos")
  if res:GetSucc() then
    self._itemList = {}
    local comInfo = self._com:GetComponentInfo()
    local slotInfo = comInfo.slot_info
    if slotInfo then
      local slotItems = slotInfo.items
      for key, value in pairs(slotItems) do
        if value.item.id == 0 and value.price == 0 then
        else
          local uiSmithyItemData = UiSmithyItemData:New(key, value)
          table.insert(self._itemList, uiSmithyItemData)
        end
      end
      self._resetCount = slotInfo.reset_cnt
      self:RefreshInfos()
      self:TryPlayFirstShowInAnim()
    end
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazeRoomShop] HandleSeasonMazeGetSlot fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoomShop:ReqSmithBuy()
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local uiData = self._itemList[self._chooseIdx]
  if uiData then
    local cost = uiData._slotData.price
    if curGold < cost then
      local tips = StringTable.Get("str_season_maze_gold_not_enough")
      ToastManager.ShowToast(tips)
      return
    end
  end
  self:Lock("UISeasonMazeRoomShop:ReqSmithBuy")
  GameGlobal.TaskManager():StartTask(self.TaskReqSmithBuy, self)
end

function UISeasonMazeRoomShop:TaskReqSmithBuy(TT)
  local res = AsyncRequestRes:New()
  local uiData = self._itemList[self._chooseIdx]
  if uiData then
    local slotIndex = uiData._slotIndex
    local response = self._com:HandleSeasonMazeOperaSlot(TT, res, slotIndex, false)
    self:UnLock("UISeasonMazeRoomShop:ReqSmithBuy")
    if res:GetSucc() then
      self:OnBuyEnd()
      local showRewards = {}
      for _, value in ipairs(response.reward) do
        local reward = value
        if reward.type == SeasonMazeEffectType.SMET_Relic then
          table.insert(showRewards, reward)
        end
      end
      if 0 < #showRewards then
        function self._waitGetRewardsFinishCb()
          SMazeAdaptor.OnRelicObtained(response.reward, SMazeRelicReason.BuyRelic)
        end
        
        SeasonMazeTool:GetInstance():ShowUIGetRewards(showRewards)
      else
        SMazeAdaptor.OnRelicObtained(response.reward, SMazeRelicReason.BuyRelic)
      end
    else
      do
        local result = res:GetResult()
        Log.error("###[UISeasonMaze_Campsites_Recruit] HandleSeasonMazeOperaSlot fail! result:", result)
        if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
          return
        end
      end
    end
  end
end

function UISeasonMazeRoomShop:OnBuyEnd()
  self:CreateData()
  self._chooseIdx = 0
  self:RefreshSelectItem()
  self:ShowResetPrice()
end

function UISeasonMazeRoomShop:RefreshMoney()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Gold)
end

function UISeasonMazeRoomShop:OnHide()
  UnityEngine.Input.multiTouchEnabled = self._mulitOpen
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UISeasonMazeRoomShop:GetResetCost()
  return self:CalcResetCost(self._resetCount, self._cfg_global.SlotParam)
end

function UISeasonMazeRoomShop:ShowResetPrice()
  local cost = self:GetResetCost()
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local costStr = tostring(cost)
  if cost > curGold then
    costStr = "<color=#c97d7d>" .. costStr .. "</color>"
  end
  self._ResetCostText:SetText(costStr)
end

function UISeasonMazeRoomShop:PlayResetBtnAnim()
  self._ResetBtnAnim:Stop()
  self._ResetBtnRect.localScale = Vector3(1, 1, 1)
  self._ResetMaskImage.color = Color(0.5490196078431373, 0.5490196078431373, 0.5490196078431373, 0)
  self._ResetBtnAnim:Play("uieffanim_UISeasonMaze_Campsites_Bank_SaveBtn1_click")
end

function UISeasonMazeRoomShop:ResetBtnMaskOnClick(go)
  self:PlayResetBtnAnim()
  self:ReqResetSlots()
end

function UISeasonMazeRoomShop:ReqResetSlots()
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local cost = self:GetResetCost()
  if curGold < cost then
    local tips = StringTable.Get("str_season_maze_gold_not_enough")
    ToastManager.ShowToast(tips)
    return
  end
  self:Lock("UISeasonMazeRoomShop:ReqResetSlots")
  GameGlobal.TaskManager():StartTask(self.TaskReqResetSlots, self)
end

function UISeasonMazeRoomShop:TaskReqResetSlots(TT)
  local res = AsyncRequestRes:New()
  local tmpIndex = 1
  local response = self._com:HandleSeasonMazeOperaSlot(TT, res, tmpIndex, true)
  if res:GetSucc() then
    self._itemList = {}
    local comInfo = self._com:GetComponentInfo()
    local slotInfo = comInfo.slot_info
    if slotInfo then
      local slotItems = slotInfo.items
      for key, value in pairs(slotItems) do
        if value.item.id == 0 and value.price == 0 then
        else
          local uiSmithyItemData = UiSmithyItemData:New(key, value)
          table.insert(self._itemList, uiSmithyItemData)
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
      self:UnLock("UISeasonMazeRoomShop:ReqResetSlots")
    end
  else
    self:UnLock("UISeasonMazeRoomShop:ReqResetSlots")
    local result = res:GetResult()
    Log.error("###[UISeasonMaze_Campsites_Recruit] HandleSeasonMazeOperaSlot fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoomShop:BagBtnOnClick(go)
  self:ShowDialog("UISeasonMazeBackPackController", 2)
end

function UISeasonMazeRoomShop:OnSeasonMazeShowRewardsFinish(flag)
  if self._waitGetRewardsFinishCb then
    self._waitGetRewardsFinishCb()
    self._waitGetRewardsFinishCb = nil
  end
end

function UISeasonMazeRoomShop:BackBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
  self._seasonMazeModule:UIModule():SetTempRoom(self:GetName())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTempCloseRoom, true)
  self:CloseDialog()
end

function UISeasonMazeRoomShop:CloseBtnOnClick(go)
  self:OnHideUI()
end

function UISeasonMazeRoomShop:GetSeasonMazeCfg(hardLevel)
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

function UISeasonMazeRoomShop:CalcResetCost(resetCount, cfgParam)
  local x = resetCount or 0
  local cfg_reset = cfgParam
  local a = cfg_reset[1]
  local b = cfg_reset[2]
  local c = cfg_reset[3]
  if not (a and b) or not c then
    Log.error("###[UISeasonMazeRoomShop] self._cfg_global.PetParam is nil !")
  end
  local baseCost = a * x ^ 2 + b * x + c
  local shopParam = 1
  local comInfo = self._com:GetComponentInfo()
  local priceAttr = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Goods_Price_Percent)
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
