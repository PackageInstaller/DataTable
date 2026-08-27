local UINSpring23StoryTeamLiveSuccess = class("UINSpring23StoryTeamLiveSuccess", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local CS_DOTween = CS.DG.Tweening.DOTween

function UINSpring23StoryTeamLiveSuccess:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickBtnBack)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
end

function UINSpring23StoryTeamLiveSuccess:InitUINSpring23StoryTeamLiveSuccess(rewardIds, rewardNums)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Hide):PushTopStatusDataToBackStack()
  self._itemPool:HideAll()
  for i, itemId in ipairs(rewardIds) do
    local itemCfg = ConfigData.item[itemId]
    local itemCount = rewardNums[i]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount, nil, false)
  end
end

function UINSpring23StoryTeamLiveSuccess:OnClickBtnBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UINSpring23StoryTeamLiveSuccess:OnDelete()
  base.OnDelete(self)
end

return UINSpring23StoryTeamLiveSuccess
