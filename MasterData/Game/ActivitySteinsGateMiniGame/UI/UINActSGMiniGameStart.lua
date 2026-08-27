local UINActSGMiniGameStart = class("UINActSGMiniGameStart", UIBaseNode)
local base = UIBaseNode
local ActSGMiniGameEnum = require("Game.ActivitySteinsGateMiniGame.Data.ActSGMiniGameEnum")

function UINActSGMiniGameStart:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Start, self, self.OnClickStart)
end

function UINActSGMiniGameStart:InitActSGMiniGameStart(gameType, startCallBack)
  self.gameType = gameType
  self.startCallBack = startCallBack
  self:InitSGMiniGameStartUI()
end

function UINActSGMiniGameStart:InitSGMiniGameStartUI()
  if self.gameType == ActSGMiniGameEnum.GameType.MashDown then
    self.ui.tex_Title:SetIndex(0)
  else
    self.ui.tex_Title:SetIndex(1)
  end
end

function UINActSGMiniGameStart:BackAction()
  self:Hide()
end

function UINActSGMiniGameStart:OnClickStart()
  if self.startCallBack then
    self.startCallBack()
  end
end

function UINActSGMiniGameStart:OnDelete()
end

return UINActSGMiniGameStart
