require("ui_season_maze_campsites_base")
_class("UiSmithyItemData", Object)
UiSmithyItemData = UiSmithyItemData

function UiSmithyItemData:Constructor(slotIndex, slotData)
  self._slotIndex = slotIndex
  self._slotData = slotData
end

_class("UISeasonMaze_Campsites_Smithy", UISeasonMaze_Campsites_Base)
UISeasonMaze_Campsites_Smithy = UISeasonMaze_Campsites_Smithy

function UISeasonMaze_Campsites_Smithy:InitWidget()
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

function UISeasonMaze_Campsites_Smithy:SetTopBtn()
  self.topBtn:SpawnObject("UISMazeCommonTopButton"):SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
end

function UISeasonMaze_Campsites_Smithy:PetBtnOnClick()
  self:PlayTalk()
end

function UISeasonMaze_Campsites_Smithy:PlayTalk()
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

function UISeasonMaze_Campsites_Smithy:PlayTalkShowAnim()
  self._talkAnim:Stop()
  self._talkAnim:Play("uieffanim_UISeasonMaze_Campsites_Smithy_talkGo_in")
end

function UISeasonMaze_Campsites_Smithy:PlayTalkHideAnim()
  self._talkAnim:Stop()
  self._talkAnim:Play("uieffanim_UISeasonMaze_Campsites_Smithy_talkGo_out")
end

function UISeasonMaze_Campsites_Smithy:OnShowUI(uiParams)
  self._mulitOpen = UnityEngine.Input.multiTouchEnabled
  UnityEngine.Input.multiTouchEnabled = false
  self._showInAnimPlayed = false
  self:InitWidget()
  self:SetTopBtn()
  self:SetUISeasonMazeTopIcon()
  self:CreateData()
  self:PlayTalk()
end

function UISeasonMaze_Campsites_Smithy:SetUISeasonMazeTopIcon()
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

function UISeasonMaze_Campsites_Smithy:SetItemList()
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

function UISeasonMaze_Campsites_Smithy:TryPlayFirstShowInAnim()
  if self._showInAnimPlayed then
    return
  end
  self._showInAnimPlayed = true
  self:PlayCellsShowInAnim()
end

function UISeasonMaze_Campsites_Smithy:PlayCellsShowInAnim()
  self._cellCountPerRow = 4
  local lockName = "UISeasonMaze_Campsites_Smithy:PlayCellsShowInAnim"
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

function UISeasonMaze_Campsites_Smithy:PlayCellsOutAnim()
  if self._cellWidgets then
    for index, widget in ipairs(self._cellWidgets) do
      widget:PlayShowOutAnim()
    end
  end
end

function UISeasonMaze_Campsites_Smithy:OnItemClick(idx)
  self._chooseIdx = idx
  self:RefreshSelectItem()
  self:ShowBuy()
end

function UISeasonMaze_Campsites_Smithy:RefreshSelectItem()
  if self._cellWidgets then
    for index, widget in ipairs(self._cellWidgets) do
      widget:ShowSelected(index == self._chooseIdx)
    end
  end
end

function UISeasonMaze_Campsites_Smithy:ShowBuy()
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

function UISeasonMaze_Campsites_Smithy:CreateData()
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

function UISeasonMaze_Campsites_Smithy:RefreshInfos()
  self._chooseIdx = 0
  self:SetItemList()
  self:RefreshSelectItem()
  self:ShowResetPrice()
  self:RefreshMoney()
end

function UISeasonMaze_Campsites_Smithy:ReqSlotInfos()
  self:Lock("UISeasonMaze_Campsites_Smithy:ReqSlotInfos")
  GameGlobal.TaskManager():StartTask(self.TaskReqSlotInfos, self)
end

function UISeasonMaze_Campsites_Smithy:TaskReqSlotInfos(TT)
  local res = AsyncRequestRes:New()
  local response = self._com:HandleSeasonMazeGetSlot(TT, res)
  self:UnLock("UISeasonMaze_Campsites_Smithy:ReqSlotInfos")
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
    Log.error("###[UISeasonMaze_Campsites_Smithy] HandleSeasonMazeGetSlot fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMaze_Campsites_Smithy:ReqSmithBuy()
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
  self:Lock("UISeasonMaze_Campsites_Smithy:ReqSmithBuy")
  GameGlobal.TaskManager():StartTask(self.TaskReqSmithBuy, self)
end

function UISeasonMaze_Campsites_Smithy:TaskReqSmithBuy(TT)
  local res = AsyncRequestRes:New()
  local uiData = self._itemList[self._chooseIdx]
  if uiData then
    local slotIndex = uiData._slotIndex
    local response = self._com:HandleSeasonMazeOperaSlot(TT, res, slotIndex, false)
    self:UnLock("UISeasonMaze_Campsites_Smithy:ReqSmithBuy")
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

function UISeasonMaze_Campsites_Smithy:OnBuyEnd()
  self:CreateData()
  self._chooseIdx = 0
  self:RefreshSelectItem()
  self:ShowResetPrice()
end

function UISeasonMaze_Campsites_Smithy:RefreshMoney()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Gold)
end

function UISeasonMaze_Campsites_Smithy:OnHide()
  UnityEngine.Input.multiTouchEnabled = self._mulitOpen
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UISeasonMaze_Campsites_Smithy:GetResetCost()
  return self:CalcResetCost(self._resetCount, self._cfg_global.SlotParam)
end

function UISeasonMaze_Campsites_Smithy:ShowResetPrice()
  local cost = self:GetResetCost()
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local costStr = tostring(cost)
  if cost > curGold then
    costStr = "<color=#c97d7d>" .. costStr .. "</color>"
  end
  self._ResetCostText:SetText(costStr)
end

function UISeasonMaze_Campsites_Smithy:PlayResetBtnAnim()
  self._ResetBtnAnim:Stop()
  self._ResetBtnRect.localScale = Vector3(1, 1, 1)
  self._ResetMaskImage.color = Color(0.5490196078431373, 0.5490196078431373, 0.5490196078431373, 0)
  self._ResetBtnAnim:Play("uieffanim_UISeasonMaze_Campsites_Bank_SaveBtn1_click")
end

function UISeasonMaze_Campsites_Smithy:ResetBtnMaskOnClick(go)
  self:PlayResetBtnAnim()
  self:ReqResetSlots()
end

function UISeasonMaze_Campsites_Smithy:ReqResetSlots()
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local cost = self:GetResetCost()
  if curGold < cost then
    local tips = StringTable.Get("str_season_maze_gold_not_enough")
    ToastManager.ShowToast(tips)
    return
  end
  self:Lock("UISeasonMaze_Campsites_Smithy:ReqResetSlots")
  GameGlobal.TaskManager():StartTask(self.TaskReqResetSlots, self)
end

function UISeasonMaze_Campsites_Smithy:TaskReqResetSlots(TT)
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
      self:UnLock("UISeasonMaze_Campsites_Smithy:ReqResetSlots")
    end
  else
    self:UnLock("UISeasonMaze_Campsites_Smithy:ReqResetSlots")
    local result = res:GetResult()
    Log.error("###[UISeasonMaze_Campsites_Recruit] HandleSeasonMazeOperaSlot fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMaze_Campsites_Smithy:BagBtnOnClick(go)
  self:ShowDialog("UISeasonMazeBackPackController", 2)
end

function UISeasonMaze_Campsites_Smithy:OnSeasonMazeShowRewardsFinish(flag)
  if self._waitGetRewardsFinishCb then
    self._waitGetRewardsFinishCb()
    self._waitGetRewardsFinishCb = nil
  end
end
