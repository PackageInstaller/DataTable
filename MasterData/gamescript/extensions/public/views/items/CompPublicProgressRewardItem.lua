local CompPublicProgressRewardItem, Super = NewViewComponent("CompPublicProgressRewardItem")
local MAX_REWARD_COUNT = 6

function CompPublicProgressRewardItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeous_Item_Popup_AwardResource(uiNode)
  self.data = data
end

function CompPublicProgressRewardItem:OnEnterComponent()
  self:_InitRewardTitle()
  self:_InitBtnGet()
  self:_InitRewardList()
  self:_RefreshProgress()
end

function CompPublicProgressRewardItem:_InitRewardTitle()
  self:SetText(self.ui.Text_StarNumber, self.data.needStar)
  self:SetText(self.ui.Text_Custom_Title, self.data.awardTitle or "")
  self.ui.Text_Title:SetActive(not self.data.awardTitle or self.data.awardTitle == "")
  self.ui.Image_Star:SetActive(not self.data.hideStar)
end

function CompPublicProgressRewardItem:_InitBtnGet()
  self:AddButtonClickListener(self.ui.Button_Get, System.fn(self, self._OnClickGainReward))
  self:SetButtonState(self.ui.Button_Get, self.data.isAttach and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
  self:SetButtonText(self.ui.Button_Get, LT.Text("TaskModule_btn_reward"))
end

function CompPublicProgressRewardItem:_InitRewardList()
  local rewards = self.data.rewards or {}
  for i = 1, MAX_REWARD_COUNT do
    local obj = self.ui["UI_Dungeous_Item_Award_" .. i]
    local rewardInfo = rewards[i]
    obj:SetActive(nil ~= rewardInfo)
    if rewardInfo then
      local itemId = rewardInfo.tid
      local itemNum = rewardInfo.num
      
      local function clickFunc()
        ItemDataUtils.ShowItemDetailTips(self.binder, obj, nil, itemId, true)
      end
      
      local viewData = {
        itemTid = itemId,
        itemCount = itemNum,
        clickFunc = clickFunc
      }
      self:AddViewComponentOnce(obj, CompPublicIconItemType2, viewData)
    end
  end
end

function CompPublicProgressRewardItem:UpdateProgressState()
  self:_RefreshProgress()
end

function CompPublicProgressRewardItem:_RefreshProgress()
  self.ui.Text_Lost:SetActive(not self.data.isGet and not self.data.isAttach)
  self.ui.Image_Finish:SetActive(self.data.isGet)
  self.ui.Button_Get:SetActive(self.data.isAttach and self.data.isGet == false)
end

function CompPublicProgressRewardItem:_OnClickGainReward()
  if self.data.gainRewardFunc then
    self.data.gainRewardFunc()
    return
  end
end

function CompPublicProgressRewardItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompPublicProgressRewardItem
