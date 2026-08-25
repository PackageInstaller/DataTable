local UIAnimationController = CS.Z1Client.UIAnimationController
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local TITLEHEIGHT = 50
local SPACE = 15
local ResonanceDetailComp, Super = System.NewComponent("ResonanceDetailComp")

function ResonanceDetailComp:ctor(uiNode, resonanceModel, view)
  Super.ctor(self)
  self.view = view
  self.ui = UI_Chapter_Popup_Vibes_ListResource(uiNode)
  self.resonanceModel = resonanceModel
  self.selectResonanceID = self.resonanceModel:GetSelectResonanceID()
  self.contentHeight = 0
end

function ResonanceDetailComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:BindResonanceDefaultDesc()
  self:BindDetailsViewLayout()
  self:BindResonanceItemComp()
  self:BindResonanceStory()
  self:BindResonanceResultTips()
  self:BindResonanceUpgradeCost()
  self:BindResonanceUpgradeButtonState()
  self:BindText_LockTip()
  if self.ui.Btn_Mask then
    self.ui.Btn_Mask:SetActive(false)
  end
  binder:BindEvent(EventMgr.Instance.AddItemEvent, function(item)
    self:UpdateItemCost(item.tid)
  end)
  binder:BindEvent(EventMgr.Instance.RemoveItemEvent, function(item)
    self:UpdateItemCost(item.tid)
  end)
  self.binder:BindTimer(0.1, 0, nil, function()
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Content)
    self.scrollView = self.ui.ScrollView_Exhibit:GetComponent(T_ScrollRect)
    self.scrollView.verticalNormalizedPosition = 1
  end)
end

function ResonanceDetailComp:BindText_LockTip()
  self.binder:BindToVisible(self.ui.Image_Gradient_1, function()
    return not ResonanceDataUtils.IsResonanceUnLocked(self.selectResonanceID)
  end)
  self.binder:BindToRaw(function(_, newValue, _)
    local lock = not newValue
    self.ui.Text_LockTip:SetActive(lock)
    local taskLockDesc = self:GetTaskLockTaskDesc(self.selectResonanceID, lock)
    if taskLockDesc then
      self.binder:SetText(self.ui.Text_LockTip, taskLockDesc)
      return
    end
    local list = ResonanceDataUtils.GetPreResonanceIds(self.selectResonanceID)
    local desc = ""
    local unlockCommon = ResonanceDataUtils.GetResonanceUnlockCommon(self.selectResonanceID)
    for i, v in ipairs(list) do
      local name = ResonanceDataUtils.GetResonanceName(v)
      name = string.format(LT.Text("ResonanceTipsName"), name)
      if i ~= #list then
        desc = desc .. name .. ResonanceDataUtils.GetResonanceUnlockConditionText(unlockCommon)
      else
        desc = desc .. name
      end
    end
    local tips = LT.Textf("ResonanceUnlockTips", desc)
    self.binder:SetText(self.ui.Text_LockTip, tips)
  end, function()
    do return ResonanceDataUtils.IsResonanceUnLocked end
    return ResonanceDataUtils.IsResonanceUnLocked, self.selectResonanceID
  end)
end

function ResonanceDetailComp:GetTaskLockTaskDesc(id, isLock)
  if not isLock then
    return
  end
  local cfg = DT.Resonance[id]
  local data = cfg.data_list[1]
  local taskId = data.ConsumeType
  if taskId and TaskDataUtils.GetTaskConfigByTid(taskId) then
    local taskCfg = TaskDataUtils.GetTaskConfigByTid(taskId)
    return taskCfg.UnlockCondDesc
  end
end

function ResonanceDetailComp:BindResonanceUpgradeButtonState()
  self.binder:BindZ1Button(self.ui.UI_Common_Btn_Level1, function()
    self:TryUpdateResoanace()
  end, function()
    do return self.resonanceModel.CheckResonanceUpgradeButtonState, self.resonanceModel end
    return self.resonanceModel.CheckResonanceUpgradeButtonState, self.resonanceModel, self.selectResonanceID
  end, function()
    do return self.resonanceModel.GetResonanceUpgradeButtonStateText, self.resonanceModel end
    return self.resonanceModel.GetResonanceUpgradeButtonStateText, self.resonanceModel, self.selectResonanceID
  end)
end

function ResonanceDetailComp:TryUpdateResoanace()
  if not ResonanceDataUtils.IsResonanceUnLocked(self.selectResonanceID) then
    return
  end
  if self.resonanceModel:CheckResonanceMaxLevel(self.selectResonanceID) then
    Alert.Show(10573)
    return
  end
  
  local function DoReqUpdate()
    if not self.resonanceModel:CheckResonanceUpgradeMaterialEnough(self.selectResonanceID) then
      Alert.Show(10571)
      return
    end
    local isActive = ResonanceDataUtils.IsResonanceActive(self.selectResonanceID)
    ResonanceDataUtils.ReqUpgradeResonance(self.selectResonanceID, function()
      if isActive then
        Alert.Show(10574)
      else
        AudioManager.Instance:PostSoundEvent("Play_Popup_GM_Info_POP")
        Alert.Show(10718)
      end
    end)
  end
  
  local curLevel = ResonanceDataUtils.GetResonanceLevel(self.selectResonanceID)
  local itemsConfigs = ResonanceDataUtils.GetResonanceLevelCost(self.selectResonanceID, curLevel)
  if itemsConfigs.extraItemId then
    local tipsId = 20152
    local desc = LT.Textf(DT.TipsType[tipsId].Desc, ItemDataUtils.GetItemName(itemsConfigs.itemId), itemsConfigs.extraItemNum)
    Alert.Show(tipsId, nil, DoReqUpdate, nil, desc)
    return
  end
  DoReqUpdate()
end

function ResonanceDetailComp:BindResonanceUpgradeCost()
  self.binder:BindToVisible(self.ui.Image_Require, function()
    if not ResonanceDataUtils.IsResonanceUnLocked(self.selectResonanceID) then
      return false
    end
    if self.resonanceModel:CheckResonanceMaxLevel(self.selectResonanceID) then
      return false
    end
    return true
  end)
  self.binder:SetText(self.ui.Text_Need, "")
  self.binder:BindToRaw(function(_, _, _)
    self:UpdateItemCost()
  end, function()
    do return ResonanceDataUtils.GetResonanceLevel end
    return ResonanceDataUtils.GetResonanceLevel, self.selectResonanceID
  end)
end

function ResonanceDetailComp:UpdateItemCost(checkItemId)
  local curLevel = ResonanceDataUtils.GetResonanceLevel(self.selectResonanceID)
  local itemsConfigs = ResonanceDataUtils.GetResonanceLevelCost(self.selectResonanceID, curLevel)
  if not itemsConfigs or not itemsConfigs.itemId then
    self.binder:SetText(self.ui.Text_Coin_Count, "")
    self.binder:SetText(self.ui.Text_Need, "")
    self.ui.Text_ExtraItemsTip:SetActive(false)
    return
  end
  if checkItemId and checkItemId ~= itemsConfigs.itemId then
    return
  end
  self.binder:SetImage(self.ui.Image_Coin_Icon, ItemDataUtils.GetIcon(itemsConfigs.itemId))
  local numStr = ItemNumUtils.GetStr(itemsConfigs.itemNum)
  if itemsConfigs.ownedNum < itemsConfigs.itemNum then
    numStr = string.format("<color=%s>x%d</color>", DT.ColorConfig.Red.Light, itemsConfigs.itemNum)
  end
  self.binder:SetText(self.ui.Text_Coin_Count, numStr)
  self.ui.Text_ExtraItemsTip:SetActive(itemsConfigs.extraItemId)
  if itemsConfigs.extraItemId then
    self.binder:SetText(self.ui.Text_ExtraItemsTip, LT.Textf("ResonanceActiveExtraItem", ItemDataUtils.GetItemName(itemsConfigs.extraItemId)))
  else
    self.binder:SetText(self.ui.Text_ExtraItemsTip, "")
  end
end

function ResonanceDetailComp:BindResonanceResultTips()
  self.ui.Image_Fail_Tips:SetActive(false)
  self.ui.Image_Succeed_Tips:SetActive(false)
  self.ui.Image_Fail_Tips_Text:SetActive(false)
  self.ui.Image_Succeed_Tips_Text:SetActive(false)
end

function ResonanceDetailComp:BindResonanceEfectsView()
  local resonanceLevelsConfig = self.resonanceModel.resonanceLevelsConfig
  local effectGroupHeight = 0
  local effectGos = {}
  for index = 1, #resonanceLevelsConfig do
    local uiNode = CS.UnityEngine.GameObject.Instantiate(self.ui.Image_Lv, self.ui.Effect_Group.transform)
    self.binder:onDestroy(function()
      if not IsNil(uiNode) then
        uiNode:SetActive(false)
      end
      CS.UnityEngine.GameObject.Destroy(uiNode)
    end)
    uiNode:SetActive(true)
    local textIntroduce = CS.Framework.GameObjectUtil.FindChildByPath(uiNode, "Text_Introduce")
    self.binder:BindToText(textIntroduce, function()
      do return self.resonanceModel.GetResonanceLevelDesc, self.resonanceModel, self.selectResonanceID end
      return self.resonanceModel.GetResonanceLevelDesc, self.resonanceModel, self.selectResonanceID, index
    end)
    self.binder:BindToTextColorOld(textIntroduce, function()
      do return self.resonanceModel.GetResonanceLevelDescColor, self.resonanceModel, self.selectResonanceID end
      return self.resonanceModel.GetResonanceLevelDescColor, self.resonanceModel, self.selectResonanceID, index
    end)
    table.insert(effectGos, uiNode)
  end
  if table.length(effectGos) > 0 then
    self.binder:BindTimer(0.05, 0, nil, function()
      for _, uiNode in ipairs(effectGos) do
        CS.Framework.TransformUtil.SetAnchoredPos(uiNode.transform, 0, effectGroupHeight * -1)
        local textIntroduce = CS.Framework.GameObjectUtil.FindChildByPath(uiNode, "Text_Introduce")
        local introductionHeight = StrUtils.SetPreferredHeight(textIntroduce)
        effectGroupHeight = effectGroupHeight + introductionHeight + SPACE
        self:_SetItemHeight(uiNode.gameObject, introductionHeight)
      end
      local effectConHeight = effectGroupHeight + TITLEHEIGHT + SPACE
      self:_SetItemHeight(self.ui.Effect_Group.gameObject, effectGroupHeight)
      self.contentHeight = self.contentHeight + effectConHeight
      self:_SetItemHeight(self.ui.Image_Effect.gameObject, effectConHeight)
    end)
  end
end

function ResonanceDetailComp:BindResonanceItemComp()
  self.binder:BindUIBehavior(self.ui.UI_Chaper_Item_Level_Vibes, self.resonanceModel, DT.Resonance[self.selectResonanceID], false, self.view)
  self.binder:BindToText(self.ui.Text_Name, function()
    do return self.resonanceModel.GetResonanceName, self.resonanceModel end
    return self.resonanceModel.GetResonanceName, self.resonanceModel, self.selectResonanceID
  end)
  self.binder:BindToText(self.ui.Text_Level, function()
    do return self.resonanceModel.GetResonanceLevelProgress, self.resonanceModel end
    return self.resonanceModel.GetResonanceLevelProgress, self.resonanceModel, self.selectResonanceID
  end)
end

function ResonanceDetailComp:BindResonanceDefaultDesc()
  self.binder:BindToText(self.ui.Tex_Snitch, function()
    local showVal = ""
    local belongGroup = ResonanceDataUtils.GetResonanceBelongGroup(self.selectResonanceID)
    local groupConstData = DT.GetOriginalConstant(belongGroup)
    if not groupConstData then
      do return LT.Text end
      return LT.Text, showVal, nil
    end
    local languageKey = groupConstData[5]
    do return LT.Text end
    return LT.Text, languageKey
  end, nil, nil, true)
end

function ResonanceDetailComp:BindResonanceDesc()
  self.binder:BindToText(self.ui.Tex_Story, function()
    local showVal = ""
    local belongGroup = ResonanceDataUtils.GetResonanceBelongGroup(self.selectResonanceID)
    local groupConstData = DT.GetOriginalConstant(belongGroup)
    if not groupConstData then
      do return LT.Text end
      return LT.Text, showVal, nil
    end
    local languageKey = groupConstData[5]
    do return LT.Text end
    return LT.Text, languageKey
  end, nil, nil, true)
end

function ResonanceDetailComp:BindResonanceStory()
  self.binder:BindToVisible(self.ui.Image_Story, function()
    return not string.isempty(self.resonanceModel:GetResonanceStory(self.selectResonanceID))
  end)
  self.binder:BindToText(self.ui.Tex_Story, function()
    do return self.resonanceModel.GetResonanceStory, self.resonanceModel end
    return self.resonanceModel.GetResonanceStory, self.resonanceModel, self.selectResonanceID
  end)
  self.binder:BindTimer(0.05, 0, nil, function()
    local stroyHeight = StrUtils.SetPreferredHeight(self.ui.Tex_Story)
    local stroyConHeight = stroyHeight + TITLEHEIGHT + SPACE
    self:_SetItemHeight(self.ui.Image_Story, stroyConHeight)
    self.contentHeight = self.contentHeight + stroyConHeight
  end)
end

function ResonanceDetailComp:BindDetailsViewLayout()
  self.binder:BindToRaw(function(_, v, _)
  end, function()
    self.binder:SetActive(self.ui.Tex_Snitch, false)
    self.binder:SetActive(self.ui.Effect_Group, true)
    self:BindResonanceEfectsView()
  end)
end

function ResonanceDetailComp:_SetItemHeight(go, height)
  if not go then
    return
  end
  local sizeDelta = go.transform.sizeDelta
  local Vector2 = CS.UnityEngine.Vector2(0, 0)
  Vector2.x = sizeDelta.x
  Vector2.y = height
  go.transform.sizeDelta = Vector2
end

function ResonanceDetailComp:StopTween()
  self.isClosingView = true
  if self.uiTween then
    self.uiTween:Kill(true)
  end
end

return ResonanceDetailComp
