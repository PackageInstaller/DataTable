require("skill_damage_effect_param")
require("skill_effect_param_base")
local EnumSkillEffectParam_Teleport = {
  PickUp = 0,
  User = 1,
  CrossFarest = 2,
  Forward = 3,
  UserPointArray = 4,
  SkillRange_Far = 5,
  SkillRange_Near = 6,
  SkillScopePos = 7,
  TeleportTargetToCasterPos = 8,
  TeleportTargetToPickPos = 9,
  TeleportTargetToSquareRing = 10,
  TeleportExitBoard = 11,
  CurPosBeforeSkillRangeNearest = 12,
  SkillScopePosFirst = 13,
  TargetPos = 14,
  UseTeleportAndSummonTrapLastResult = 15,
  SkillScopeRandPos = 16,
  RoninKenshiStep = 17,
  NingKingJump = 18,
  TeleportMountForward = 19,
  UseMountTeleportExtraPos = 20,
  CasterGridDirectionForward = 21,
  TeleportPosByTargetPos = 22,
  TeleportTargetToCasterPosValid = 23,
  Boss2904001 = 24,
  TeleportTargetToFirstPickPos = 25,
  TargetAroundNearestCaster = 26,
  TargetPosWithCasterBody = 27,
  PickUpWithPath = 28,
  TargetAroundTrap = 29,
  TargetAroundCalcCurBodyAreaAndDirCanDiffusion = 30,
  TrunToTargetOnSite = 31,
  TeleportWithScopeAndTrunToTarget = 32,
  FourHorsemenApproachPlayer = 33,
  FourHorsemenAvoidPlayer = 34,
  BossDriller = 35,
  HostOriginalPosSquareRing = 36,
  NightKingTeleportRecordCalcState = 37,
  NightKingDoubleCrossTeleport = 38,
  NightKingTeleportWithPath = 39,
  TargetTeleportSelectPos = 40,
  PickUpAndSetDir = 41,
  Boss2905701Move = 42,
  Boss2905701BackToPos = 43,
  Boss2905701MovePlayerToTrap = 44,
  SkillRange_FarAndDir = 45,
  SkillRangeFixed4 = 46,
  CasterGridDirectionForward2 = 47,
  JumpBack = 48,
  Monster2003801 = 49,
  Boss2906201 = 50,
  AlignTargetX = 51,
  AlignTargetY = 52,
  MultiJumpBack = 53,
  AngleFreeLineThroughTeamToEdge = 54,
  JumpToAppointDir = 55,
  ThroughTarget = 56,
  SkillRangeFarNoBlock = 57,
  AntiClockWiseOnBoardEdge = 58,
  ScopeNearestSelectPos = 59
}
_enum("EnumSkillEffectParam_Teleport", EnumSkillEffectParam_Teleport)
_class("SkillEffectParam_Teleport", SkillEffectParamBase)
SkillEffectParam_Teleport = SkillEffectParam_Teleport

function SkillEffectParam_Teleport:Constructor(t)
  self.m_nTeleportType = t.teleport or t.Teleport
  self.m_posUser = t.userPoint
  self.m_dirUser = t.userDir
  self.m_resetDirection = tonumber(t.resetDirection) == 1
  self._trapID = t.trapID or 0
  self._boss2904001CrossMaxLength = t.boss2904001CrossMaxLength
  self._boss2904001RotatedCrossMaxLength = t.boss2904001RotatedCrossMaxLength
  self._horsemenMonsterClassID = t.horsemenMonsterClassID
  self._bossNightKingPathTrapID = t.bossNightKingPathTrapID
  self._checkBlock = t.checkBlock or 0
  self._boss2905701MoveTrapID = t.boss2905701MoveTrapID
  self._boss2905701BackToPosX = t.boss2905701BackToPosX
  self._boss2905701BackToPosY = t.boss2905701BackToPosY
  self._boss2905701MovePlayerToTrapIDArray = t.boss2905701MovePlayerToTrapIDArray
  self._forwardDis = t.forwardDis or 1
  self._monster2003801CheckSkillID = t.monster2003801CheckSkillID
end

function SkillEffectParam_Teleport:GetForwardDis()
  return self._forwardDis
end

function SkillEffectParam_Teleport:GetEffectType()
  return SkillEffectType.Teleport
end

function SkillEffectParam_Teleport:GetTeleportType()
  return self.m_nTeleportType
end

function SkillEffectParam_Teleport:GetUserPoint()
  return self.m_posUser
end

function SkillEffectParam_Teleport:GetUserDir()
  return self.m_dirUser
end

function SkillEffectParam_Teleport:IsResetDirection()
  return self.m_resetDirection
end

function SkillEffectParam_Teleport:GetTrapID()
  return self._trapID
end

function SkillEffectParam_Teleport:GetBoss2904001CrossMaxLength()
  return self._boss2904001CrossMaxLength
end

function SkillEffectParam_Teleport:GetBoss2904001RotatedCrossMaxLength()
  return self._boss2904001RotatedCrossMaxLength
end

function SkillEffectParam_Teleport:GetHorsemenMonsterClassID()
  return self._horsemenMonsterClassID
end

function SkillEffectParam_Teleport:GetBossNightKingPathTrapID()
  return self._bossNightKingPathTrapID
end

function SkillEffectParam_Teleport:GetCheckBlock()
  return self._checkBlock
end

function SkillEffectParam_Teleport:GetBoss2905701MoveTrapID()
  return self._boss2905701MoveTrapID
end

function SkillEffectParam_Teleport:GetBoss2905701BackToPos()
  return Vector2.New(self._boss2905701BackToPosX, self._boss2905701BackToPosY)
end

function SkillEffectParam_Teleport:GetBoss2905701MovePlayerToTrapIDArray()
  return self._boss2905701MovePlayerToTrapIDArray
end

function SkillEffectParam_Teleport:GetMonster2003801CheckSkillID()
  return self._monster2003801CheckSkillID
end
