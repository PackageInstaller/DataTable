local UINGameNoticeBannerItem = class("UINGameNoticeBannerItem", UIBaseNode)
local base = UIBaseNode

function UINGameNoticeBannerItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.button, self, self.__OnClick)
end

function UINGameNoticeBannerItem:UpdateGNBanner(gameNoticeData, onClickCallback)
  self.gameNoticeData = gameNoticeData
  self._onClickCallback = onClickCallback
  self:Show()
  self:LoadBannerTexture(gameNoticeData)
end

function UINGameNoticeBannerItem:LoadBannerTexture(gameNoticeData)
  self.ui.img_advItem.enabled = false
  self.ui.button.interactable = false
  local ctrl = ControllerManager:GetController(ControllerTypeId.GameNotice)
  ctrl:GetNoticPicFromHTTP(gameNoticeData.targetUrl, gameNoticeData.picName, function(texture)
    if IsNull(self.gameObject) then
      return
    end
    self.ui.img_advItem.texture = texture
    self.ui.img_advItem.enabled = true
    self.ui.button.interactable = true
  end)
end

function UINGameNoticeBannerItem:__OnClick()
  if self._onClickCallback ~= nil then
    self._onClickCallback(self.gameNoticeData)
  end
end

function UINGameNoticeBannerItem:OnDelete()
  DestroyUnityObject(self.ui.img_advItem.texture)
  base.OnDelete(self)
end

return UINGameNoticeBannerItem
