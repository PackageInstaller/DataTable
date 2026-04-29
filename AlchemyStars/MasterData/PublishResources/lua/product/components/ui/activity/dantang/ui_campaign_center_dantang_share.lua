_class("UICampaignCenterDanTangShare", UIController)
UICampaignCenterDanTangShare = UICampaignCenterDanTangShare

function UICampaignCenterDanTangShare:Constructor()
end

function UICampaignCenterDanTangShare:OnShow(uiParams)
  local firstShare = uiParams[1]
  if firstShare then
    self._tipsTex = StringTable.Get("str_activity_dantang_share_award_2")
  else
    self._tipsTex = nil
  end
  self:Share()
end

function UICampaignCenterDanTangShare:OnHide()
end

function UICampaignCenterDanTangShare:Share(go)
  self:Lock("UICampaignCenterDanTangShare")
  self:StartTask(function(TT)
    YIELD(TT)
    YIELD(TT)
    self:ShowDialog("UIShare", self:GetName(), ShareAnchorType.BottomRight, function()
      self:CloseDialog()
    end, nil, nil, nil, ShareSceneType.CampaignKV, nil, self._tipsTex)
    self:UnLock("UICampaignCenterDanTangShare")
  end, self)
end
