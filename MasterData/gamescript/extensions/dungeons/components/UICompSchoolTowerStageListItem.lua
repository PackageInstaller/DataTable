local ColorType = CommonDefine.ColorType
local MAX_STAR_NUM = 3
local UICompSchoolTowerStageListItem, Super = NewViewComponent("UICompSchoolTowerStageListItem")

function UICompSchoolTowerStageListItem:ctor(uiNode, view, stageData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Common_TierResource(uiNode)
  self.stageData = stageData or {}
  self.model = SchoolTowerModel.Instance
end

function UICompSchoolTowerStageListItem:OnEnterComponent()
  local stageId = self.stageData.stageID or 0
  local stageCfg = DT.Stage[stageId] or {}
  self:AddButtonClickListener(self.ui.Btn_Click, function()
    self.model:Set_selectStageTid(stageId)
  end)
  self:SetText(self.ui.Text_Title, LT.Text(stageCfg.Name or ""))
  self:SetText(self.ui.Text_Tip, self.model:GetShowUnlockTips(stageId))
  self:SetTextColorType(self.ui.Text_Tip, self.model:GetCanChallenge(stageId) and ColorType.Dark or ColorType.Light)
  self.ui.Image_Select:SetActive(stageId == self.model.selectStageTid)
  self.ui.Image_Mask:SetActive(self.model:GetCanChallenge(stageId))
  for i = 1, MAX_STAR_NUM do
    self.ui["Image_Star" .. i]:SetActive(i <= self.stageData.star)
  end
end

return UICompSchoolTowerStageListItem
