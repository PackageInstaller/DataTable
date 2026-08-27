local UINActSGMiniGameEnd = class("UINActSGMiniGameEnd", UIBaseNode)
local base = UIBaseNode
local cs_Ease = CS.DG.Tweening.Ease
local ActSGMiniGameEnum = require("Game.ActivitySteinsGateMiniGame.Data.ActSGMiniGameEnum")

function UINActSGMiniGameEnd:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_PlayAgain, self, self.OnClickRePlay)
end

function UINActSGMiniGameEnd:InitActSGMiniGameEnd(gameType, gameData, reStartCallback)
  self.gameType = gameType
  self.gameData = gameData
  self.reStartCallback = reStartCallback
  self:InitSGMiniGameEndUI()
end

function UINActSGMiniGameEnd:InitSGMiniGameEndUI()
  if self.gameType == ActSGMiniGameEnum.GameType.MashDown then
    self.ui.tex_Title:SetIndex(0)
  else
    self.ui.tex_Title:SetIndex(1)
  end
  local isNew = self.gameData:GetNumIsNew()
  self.ui.img_New:SetActive(isNew)
  local nowScore = self.gameData:GetNowScore()
  self.ui.tex_Score.text = tostring(nowScore)
  self:PlayActSGMiniGameEndAnim()
end

function UINActSGMiniGameEnd:PlayActSGMiniGameEndAnim()
  self:__StopAnim()
  self.ui.tex_Title.transform:DOLocalMoveY(338, 0.4):From():SetDelay(0.05):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject)
  self.ui.canvas_Title:DOFade(0, 0.4):From():SetDelay(0.05):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject)
  self.ui.tex_Score.transform:DOLocalMoveY(155, 0.5):From():SetDelay(0.1):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject)
  self.ui.canvas_Score:DOFade(0, 0.5):From():SetDelay(0.1):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject)
  if self.gameData:GetNumIsNew() then
    self.ui.img_Bottom.transform:DOScaleX(0, 0.2):From():SetDelay(0.3):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject)
    self.ui.tex_New:DOFade(0, 0.05):From():SetDelay(0.3):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject)
    self.ui.tex_New.transform:DOScale(1.8, 0.3):From():SetDelay(0.3):SetEase(cs_Ease.OutElastic):SetLink(self.gameObject)
  end
  self.ui.canvas_PlayAgain:DOFade(0, 0.25):From():SetDelay(0.45):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject)
end

function UINActSGMiniGameEnd:__StopAnim()
  self.ui.tex_Title.transform:DOComplete()
  self.ui.canvas_Title:DOComplete()
  self.ui.tex_Score.transform:DOComplete()
  self.ui.canvas_Score:DOComplete()
  self.ui.img_Bottom.transform:DOComplete()
  self.ui.tex_New:DOComplete()
  self.ui.tex_New.transform:DOComplete()
  self.ui.canvas_PlayAgain:DOComplete()
end

function UINActSGMiniGameEnd:BackAction()
  self:Hide()
end

function UINActSGMiniGameEnd:OnClickRePlay()
  if self.reStartCallback then
    self.reStartCallback()
  end
end

function UINActSGMiniGameEnd:OnDelete()
  self:__StopAnim()
end

return UINActSGMiniGameEnd
