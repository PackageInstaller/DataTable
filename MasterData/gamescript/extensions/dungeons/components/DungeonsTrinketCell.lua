local DungeonsTrinketCell, Super = NewViewComponent("DungeonsTrinketCell")

function DungeonsTrinketCell:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Common_ElementResource(uiNode)
  self.data = data
  self.stageGroupId = data.ID
  self.featureId = CommonDefine.FeatureId.TrinketCopy
end

function DungeonsTrinketCell:OnEnterComponent()
  self:_RefreshInfo()
end

function DungeonsTrinketCell:_RefreshInfo()
  if self.data then
    local _, unlock = PlayerDataUtils.IsFeatureUnlock(self.featureId, self.stageGroupId)
    local curStageGroup = DungeonMaterialModel.Instance:GetStageGroupId()
    local isSelect = curStageGroup == self.stageGroupId
    local isDouble = ActivityManager.Instance:CheckDoubleOutputEffect(self.stageGroupId)
    self:SetText(self.ui.Text_Title, self.data.Name)
    self:SetText(self.ui.Text_Tip, self.data.StageGroupRewardDescription)
    self:SetText(self.ui.Text_Desc, self.data.Desc)
    self:SetTextColorType(self.ui.Text_Title, unlock and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
    self:SetTextColorType(self.ui.Text_Tip, unlock and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
    self:SetImage(self.ui.Image_D_Icon, self.data.DailyIcon[1])
    self:SetImage(self.ui.Image_Mask_Icon, self.data.DailyIcon[1])
    self.ui.Group_Select:SetActive(isSelect)
    self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
  end
end

function DungeonsTrinketCell:_OnClick()
  self:LocalNotify(NotifyId.OnTrinketStageGroupChange, self.stageGroupId)
end

function DungeonsTrinketCell:OnExitComponent()
  Super.OnExitComponent(self)
end

return DungeonsTrinketCell
