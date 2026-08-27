local UINFlappyGuide = class("UINFlappyGuide", UIBaseNode)
local base = UIBaseNode
local FlappyBirdAudioConfig = require("Game.TinyGames.FlappyBird.Config.FlappyBirdAudioConfig")
local cs_DoTween = CS.DG.Tweening.DOTween

function UINFlappyGuide:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.HideAndBack)
end

function UINFlappyGuide:InjectBackAction(backToStartAction)
  self.__backToStartAction = backToStartAction
end

function UINFlappyGuide:HideAndBack()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnClickButton)
  self:Hide()
  if self.__backToStartAction ~= nil then
    self.__backToStartAction()
  end
end

function UINFlappyGuide:OnShow()
  base.OnShow(self)
  self:__InitFlappyGuideTween()
end

function UINFlappyGuide:__InitFlappyGuideTween()
  if self.guideSeq ~= nil then
    self.guideSeq:Restart()
    return
  end
  local seq = cs_DoTween.Sequence()
  seq:Append(self.ui.rect_tubes:DOLocalMoveX(-1920, 0.6):From())
  seq:Join(self.ui.rect_birdRoot:DOLocalMoveX(0, 0.6):From())
  seq:Join(self.ui.rect_title:DOAnchorPosY(0, 0.6):From())
  seq:Append(self.ui.fade:DOFade(0, 0.6):From())
  seq:SetAutoKill(false)
  self.guideSeq = seq
end

function UINFlappyGuide:OnDelete()
  if self.guideSeq ~= nil then
    self.guideSeq:Kill()
    self.guideSeq = nil
  end
  base.OnDelete(self)
end

return UINFlappyGuide
