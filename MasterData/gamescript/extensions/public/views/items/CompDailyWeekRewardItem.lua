local CompDailyWeekRewardItem, Super = NewViewComponent("CompDailyWeekRewardItem")

function CompDailyWeekRewardItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeous_Item_Popup_AwardResource(uiNode)
  self.info = data.info
  self.reqFunc = data.reqFunc
  self.redPointFunc = data.redPointFunc
  self.redPointRemoveFunc = data.redPointRemoveFunc
  self.textScoreTitle = data.textScoreTitle
end

function CompDailyWeekRewardItem:UpdateShow()
  self.ui.Text_Title:SetActive(false)
  self.ui.RootStar:SetActive(false)
  self.ui.RootScore:SetActive(true)
  self:SetText(self.ui.Title_Score, self.textScoreTitle)
  self:SetText(self.ui.Text_Score, self.info.score)
  self.ui.Text_Lost:SetActive(self.info.state == CommonDefine.RewardState.Unavailable)
  self.ui.Button_Get:SetActive(self.info.state == CommonDefine.RewardState.Available)
  self.ui.Image_Finish:SetActive(self.info.state == CommonDefine.RewardState.Received)
  if self.itemComs == nil then
    self.itemComs = {}
    local trans = self.ui.RootRewards.transform
    for i = 0, trans.childCount - 1 do
      local gameObject = trans:GetChild(i).gameObject
      local reward = self.info.rewards[i + 1]
      if reward then
        local com = self:AddViewComponentOnce(gameObject, CompPublicIconItemType2, {
          itemTid = reward.tid,
          itemCount = reward.count
        })
        self.itemComs[i] = com
        gameObject:SetActive(true)
      else
        gameObject:SetActive(false)
      end
    end
  end
end

function CompDailyWeekRewardItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:UpdateShow()
  binder:BindZ1Button(self.ui.Button_Get, function()
    self.reqFunc(self.info.idx, self.info.score, function()
      self:_CheckRemoveRedPoint()
      self:UpdateShow()
    end)
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "CommonReceive"
  end, function()
    do return end
    return self.redPointFunc, nil
  end)
end

function CompDailyWeekRewardItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function CompDailyWeekRewardItem:_CheckRemoveRedPoint()
  self.redPointRemoveFunc()
end

return CompDailyWeekRewardItem
