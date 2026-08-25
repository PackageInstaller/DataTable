local DungeonMaterialCell, Super = NewViewComponent("DungeonMaterialCell")

function DungeonMaterialCell:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Common_ElementResource(uiNode)
  self.stageData = data.stageData
  self.stageGroupId = self.stageData.ID
  self.featureId = data.featureId
  self.redFunc = data.redFunc
  self.redType = data.redType
end

function DungeonMaterialCell:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnMaterialStageGroupChange, self._OnStageGroupChanged, self)
end

function DungeonMaterialCell:OnEnterComponent()
  self.binder:BindEvent(EventMgr.Instance.OnActivityDataSynced, System.fn(self, self._OnActivityDataSynced))
  self:_RefreshInfo()
end

function DungeonMaterialCell:_OnActivityDataSynced()
  self:_RefreshInfo()
end

function DungeonMaterialCell:_RefreshInfo()
  if self.stageData then
    local _, unlock = PlayerDataUtils.IsFeatureUnlock(self.featureId, self.stageGroupId)
    local curStageGroup = DungeonMaterialModel.Instance:GetStageGroupId()
    local isSelect = curStageGroup == self.stageGroupId
    local isDouble = ActivityManager.Instance:CheckDoubleOutputEffect(self.stageGroupId)
    local tipDesc = self.stageData.StageGroupRewardDescription
    if not unlock then
      tipDesc = PlayerDataUtils.GetFeatureLogicUnlockTips(self.featureId, self.stageGroupId)
    end
    self:SetText(self.ui.Text_Title, self.stageData.Name)
    self:SetText(self.ui.Text_Tip, tipDesc)
    self:SetText(self.ui.Text_Desc, self.stageData.Desc)
    self:SetText(self.ui.Text_Award, LT.Text("DoubleOutputActivityBonusHead"))
    self:SetTextColorType(self.ui.Text_Title, unlock and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
    self:SetTextColorType(self.ui.Text_Tip, unlock and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
    local imageNormal = self.stageData.DailyIcon[1]
    local searchString = "Untie"
    local replaceWith = "Not"
    local imageGrey = string.gsub(imageNormal, searchString, replaceWith)
    self:SetImage(self.ui.Image_D_Icon, imageNormal)
    self:SetImage(self.ui.Image_Mask_Icon, imageGrey)
    self.ui.Group_Mask:SetActive(not unlock)
    self.ui.Group_Nor:SetActive(unlock)
    self.ui.Image_D_Bg:SetActive(unlock)
    self.ui.Image_D_Icon:SetActive(unlock)
    self.ui.Image_Award:SetActive(isDouble)
    self:_SetIsSelected(isSelect)
    self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
  end
  self.binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.TextNew, nil, function()
    do return self.redFunc end
    return self.redFunc, self.stageGroupId
  end))
end

function DungeonMaterialCell:_OnStageGroupChanged(stageGroupId)
  self:_SetIsSelected(stageGroupId == self.stageGroupId)
end

function DungeonMaterialCell:_SetIsSelected(isSelected)
  if self._isSelected == isSelected then
    return
  end
  self._isSelected = isSelected
  self.ui.Group_Select:SetActive(isSelected)
end

function DungeonMaterialCell:_OnClick()
  self:LocalNotify(NotifyId.OnMaterialStageGroupChange, self.stageGroupId)
  RedPointDataUtils.ReqRemoveData(self.redType, RedPointDataUtils.RedAttrType.IsNew, self.stageGroupId)
end

function DungeonMaterialCell:OnExitComponent()
  Super.OnExitComponent(self)
end

return DungeonMaterialCell
