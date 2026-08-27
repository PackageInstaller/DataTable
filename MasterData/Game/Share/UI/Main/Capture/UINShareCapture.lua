local base = UIBaseNode
local UINShareCapture = class("UINShareCapture", base)
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")

function UINShareCapture:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._head = UINUserHead.New()
  self._head:Init(self.ui.UINUserHead)
end

function UINShareCapture:InitShareCapture(resLoader)
  local userInfoData = PlayerDataCenter.inforData
  self._head:SetLoadHeadSync()
  self._head:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), resLoader)
  self.ui.Tex_Lvl.text = tostring(userInfoData:GetUserLevel())
  self.ui.Tex_PlayerName.text = userInfoData:GetUserName()
  self.ui.Tex_PlayerID:SetIndex(0, tostring(userInfoData:GetUserUID()))
  self.ui.logo.texture = resLoader:LoadABAsset(PathConsts:GetResImagePath("NoAtlas/UI_ShareGameLogo.png"))
  self.ui.logo.enabled = not IsNull(self.ui.logo.texture)
  local channelId = CS.MicaSDKManager.Instance.channelId
  local qrCodeCfg = ConfigData.share_QRCode[channelId]
  if qrCodeCfg ~= nil and not string.IsNullOrEmpty(qrCodeCfg.code_picture) then
    self.ui.QRCode.enabled = true
    local path = PathConsts.ImagePath .. "NoAtlas/" .. qrCodeCfg.code_picture .. ".png"
    self.ui.QRCode.texture = resLoader:LoadABAsset(path)
  else
    self.ui.QRCode.enabled = false
  end
end

function UINShareCapture:OnDelete()
  self._head:Delete()
  base.OnDelete(self)
end

return UINShareCapture
