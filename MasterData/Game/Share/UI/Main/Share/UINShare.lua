local base = UIBaseNode
local UINShare = class("UINShare", base)
local UINShareChannelBtn = require("Game.Share.UI.Main.Share.UINShareChannelBtn")
local eShare = require("Game.Share.eShare")

function UINShare:ctor(shareRoot)
  self._shareRoot = shareRoot
end

function UINShare:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._OnClickShareChannelFunc = BindCallback(self, self._OnClickShareChannel)
  self._shareBtnPool = UIItemPool.New(UINShareChannelBtn, self.ui.Btn_Share, false)
end

function UINShare:InitShareNode(shareTexture)
  self:_InitShareBtn()
  self.ui.ScreenShot.texture = shareTexture
  local size = self.ui.ScreenShot.transform.sizeDelta
  size.x = self.ui.ScreenShot.transform.rect.height * shareTexture.width / shareTexture.height
  self.ui.ScreenShot.transform.sizeDelta = size
end

function UINShare:_InitShareBtn()
  self._shareBtnPool:HideAll()
  local shareChannelList
  if Consts.GameChannelType.IsInland() then
    shareChannelList = eShare.InlandChannelList
  else
    error("Unsurported share channel:" .. tostring(CS.MicaSDKManager.Instance.channelId))
    return
  end
  for k, channel in ipairs(shareChannelList) do
    local btn = self._shareBtnPool:GetOne()
    btn:InitShareChannelBtn(channel, self._OnClickShareChannelFunc)
  end
end

function UINShare:_OnClickShareChannel(shareChannelId)
  self._shareRoot:ShareImgChannel(shareChannelId)
end

function UINShare:OnDelete()
  self._shareBtnPool:DeleteAll()
  base.OnDelete(self)
end

return UINShare
