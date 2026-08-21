_class("UICommonLineMissionMainShare", UIController)
UICommonLineMissionMainShare = UICommonLineMissionMainShare

function UICommonLineMissionMainShare:Constructor()
end

function UICommonLineMissionMainShare:OnShow(uiParams)
  self._closeCallback = uiParams[1]
  self:Share()
end

function UICommonLineMissionMainShare:OnHide()
end

function UICommonLineMissionMainShare:Share()
  self:Lock("UICommonLineMissionMainShare")
  self:StartTask(function(TT)
    YIELD(TT)
    YIELD(TT)
    self:ShowDialog("UIShare", self:GetName(), ShareAnchorType.BottomRight, function()
      if self._closeCallback then
        self._closeCallback()
      end
      self:CloseDialog()
    end, nil, nil, nil, ShareSceneType.CampaignKV)
    self:UnLock("UICommonLineMissionMainShare")
  end, self)
end
