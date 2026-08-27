local base = UIBaseWindow
local UIDormFightVS = class("UIDormFightVS", base)
local UIDormFightVSFighterListNode = require("Game.DormFight.UI.UIDormFightVSFighterListNode")
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease

function UIDormFightVS:OnInit()
  self.selfVSFighterListNode = UIDormFightVSFighterListNode.New()
  self.selfVSFighterListNode:Init(self.ui.selfVSFighterListNode)
  self.otherVSFighterListNode = UIDormFightVSFighterListNode.New()
  self.otherVSFighterListNode:Init(self.ui.otherVSFighterListNode)
end

function UIDormFightVS:InitDormFightVS(dormFightCtrl, resLoader, callback)
  local selfUserData = dormFightCtrl:GetSelfUserData()
  local otherUserData = dormFightCtrl:GetOtherUserData()
  local selfFighterList = dormFightCtrl:GetSelfFighterList()
  local otherFighterList = dormFightCtrl:GetOtherFighterList()
  self.selfVSFighterListNode:InitDormFightVSFighterListNode(selfUserData, resLoader, selfFighterList)
  self.otherVSFighterListNode:InitDormFightVSFighterListNode(otherUserData, resLoader, otherFighterList)
  self:PlayInitTween()
  AudioManager:PlayAudioById(ConfigData.dorm_fight_config.fightStartAudioId)
  self.endCallback = callback
  TimerManager:StartTimer(3, self.OnTweenEnd, self, true)
end

function UIDormFightVS:PlayInitTween()
  local obj_down = self.ui.alpha_down.gameObject
  local obj_mapbg = self.ui.alpha_mapbg.gameObject
  local __initSeq = cs_DoTween.Sequence():Append(self.ui.obj_selfHeroNode.transform:DOLocalMoveX(-300, 0.6):From():SetEase(cs_Ease.OutQuart)):Join(self.ui.obj_otherHeroNode.transform:DOLocalMoveX(300, 0.6):From():SetEase(cs_Ease.OutQuart)):Join(self.ui.selfVSFighterListNode.transform:DOLocalMoveX(-700, 0.6):From():SetEase(cs_Ease.OutQuart):SetDelay(0.05):SetRelative(true)):Join(self.ui.otherVSFighterListNode.transform:DOLocalMoveX(700, 0.6):From():SetEase(cs_Ease.OutQuart):SetDelay(0.05):SetRelative(true)):Join(self.ui.alpha_selfList:DOFade(0, 0.4):From():SetDelay(0.05)):Join(self.ui.alpha_ohterList:DOFade(0, 0.4):From():SetDelay(0.05)):Join(self.ui.alpha_down:DOFade(0, 0.3):From()):Join(obj_down.transform:DOLocalMoveY(obj_down.transform.localPosition.y - 20, 0.3):From():SetEase(cs_Ease.OutQuart)):Join(self.ui.alpha_mapbg:DOFade(0, 0.3):From()):Join(obj_mapbg.transform:DOLocalMoveY(obj_mapbg.transform.localPosition.y - 20, 0.3):From():SetEase(cs_Ease.OutQuart):SetRelative(true)):SetDelay(0.5)
  self.tweenSeq = __initSeq
end

function UIDormFightVS:__ClearTween()
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill()
    self.tweenSeq = nil
  end
end

function UIDormFightVS:OnTweenEnd()
  self:__ClearTween()
  self:Delete()
  if self.endCallback ~= nil then
    self.endCallback()
  end
end

function UIDormFightVS:OnDelete()
  self:__ClearTween()
  self.selfVSFighterListNode:Delete()
  self.selfVSFighterListNode = nil
  self.otherVSFighterListNode:Delete()
  self.otherVSFighterListNode = nil
  base.OnDelete(self)
end

return UIDormFightVS
