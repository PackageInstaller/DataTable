local UINHomeBannerPicItem = class("UICarouselBanner", UIBaseNode)
local base = UIBaseNode
local HomeBannerManager = require("Game.Home.Banner.HomeBannerManager")
local JumpManager = require("Game.Jump.JumpManager")

function UINHomeBannerPicItem:OnInit()
  self.__OnOpenUrl = BindCallback(self, self.OnOpenUrl)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.button, self, self.__OnClick)
end

function UINHomeBannerPicItem:InitHomeBannerPicItem(bannerData)
  if self.bannerData == bannerData then
    return
  end
  self.bannerData = bannerData
  self:__UpdateBannerDurationTime()
  HomeBannerManager:GetBannerPicFromHTTP(bannerData:GetBannerPicUrl(), bannerData:GetBannerPicName(), function(texture)
    if IsNull(self.gameObject) then
      return
    end
    self.ui.img_advItem.texture = texture
  end)
end

function UINHomeBannerPicItem:__UpdateBannerDurationTime()
  if self.ui.tex_AdvContent == nil then
    return
  end
  self.ui.tex_AdvContent.gameObject:SetActive(true)
  local startTime, endTime = self.bannerData:GetStartAndEndTime()
  self.ui.tex_AdvContent:SetIndex(0, startTime, endTime)
end

function UINHomeBannerPicItem:__OnClick()
  if self.bannerData:GetBannerIsOpenURL() then
    CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.bannerJumpMention), ConfigData:GetTipContent(TipContent.commonConfirm), ConfigData:GetTipContent(TipContent.commonCancle), self.__OnOpenUrl, nil)
  elseif self.bannerData:GetBannerIsInnerJump() then
    JumpManager:Jump(self.bannerData.jumpTargetId, nil, nil, self.bannerData.jumpArgs)
  end
end

function UINHomeBannerPicItem:OnOpenUrl()
  CS.UnityEngine.Application.OpenURL(self.bannerData:GetWebURL())
end

function UINHomeBannerPicItem:OnDelete()
  base.OnDelete(self)
end

return UINHomeBannerPicItem
