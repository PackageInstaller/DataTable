_class("UICampaignCenterDanTangIntro", UIController)
UICampaignCenterDanTangIntro = UICampaignCenterDanTangIntro

function UICampaignCenterDanTangIntro:OnShow(uiParams)
  self:InitWidget()
end

function UICampaignCenterDanTangIntro:InitWidget()
end

function UICampaignCenterDanTangIntro:CloseBtnOnClick(go)
  self:CloseDialog()
end
