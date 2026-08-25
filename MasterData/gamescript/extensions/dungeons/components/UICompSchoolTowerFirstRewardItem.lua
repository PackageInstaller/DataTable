local MAX_REWARD_COUNT = 6
local UICompSchoolTowerFirstRewardItem, Super = NewViewComponent("UICompSchoolTowerFirstRewardItem")

function UICompSchoolTowerFirstRewardItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeous_Item_Popup_Award2Resource(uiNode)
  self.isGot = data.isGot
  self.rewards = data.rewards
  self.stageId = data.stageId
end

function UICompSchoolTowerFirstRewardItem:OnEnterComponent()
  self.ui.Text_Title:SetActive(false)
  self.ui.RootStar:SetActive(false)
  self.ui.Group_Bar:SetActive(true)
  self.ui.Image_Finish:SetActive(self.isGot)
  self.ui.Text_Lost:SetActive(not self.isGot)
  self:SetText(self.ui.Text_Bar, LT.Text(DT.Stage[self.stageId].Name))
  local rewards = self.rewards or {}
  for i = 1, MAX_REWARD_COUNT do
    local gameObj = self.ui["UI_Dungeous_Item_Award_" .. i]
    gameObj:SetActive(i <= #rewards)
    if i <= #rewards then
      local viewData = {
        itemTid = rewards[i].tid,
        itemCount = rewards[i].num
      }
      self:AddViewComponentOnce(gameObj, CompPublicIconItemType2, viewData)
    end
  end
end

return UICompSchoolTowerFirstRewardItem
