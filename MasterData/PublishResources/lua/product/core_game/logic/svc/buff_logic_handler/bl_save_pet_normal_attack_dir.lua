BuffLogicSaveNormalAttackDirEnum = {
  Up = 1,
  RightTop = 2,
  Right = 3,
  RightBottom = 4,
  Down = 5,
  LeftBottom = 6,
  Left = 7,
  LeftTop = 8
}
_enum("BuffLogicSaveNormalAttackDirEnum", BuffLogicSaveNormalAttackDirEnum)
require("buff_logic_base")
_class("BuffLogicSaveNormalAttackDir", BuffLogicBase)
BuffLogicSaveNormalAttackDir = BuffLogicSaveNormalAttackDir

function BuffLogicSaveNormalAttackDir:DoLogic(notify)
  if not self._entity:HasPetPstID() then
    return
  end
  local cPetPstID = self._entity:PetPstID()
  local curRound = self._world:BattleStat():GetGameRoundCount()
  local attackPos = notify:GetAttackPos()
  local damagePos = notify:GetTargetPos()
  local dir = damagePos - attackPos
  local dirNum = 0
  if dir.x == 0 and 0 < dir.y then
    dirNum = BuffLogicSaveNormalAttackDirEnum.Up
  elseif 0 < dir.x and 0 < dir.y then
    dirNum = BuffLogicSaveNormalAttackDirEnum.RightTop
  elseif 0 < dir.x and dir.y == 0 then
    dirNum = BuffLogicSaveNormalAttackDirEnum.Right
  elseif 0 < dir.x and 0 > dir.y then
    dirNum = BuffLogicSaveNormalAttackDirEnum.RightBottom
  elseif dir.x == 0 and 0 > dir.y then
    dirNum = BuffLogicSaveNormalAttackDirEnum.Down
  elseif 0 > dir.x and 0 > dir.y then
    dirNum = BuffLogicSaveNormalAttackDirEnum.LeftBottom
  elseif 0 > dir.x and dir.y == 0 then
    dirNum = BuffLogicSaveNormalAttackDirEnum.Left
  elseif 0 > dir.x and 0 < dir.y then
    dirNum = BuffLogicSaveNormalAttackDirEnum.LeftTop
  end
  cPetPstID:SetRoundNormalAttackDir(curRound, dirNum)
  local dirTable = cPetPstID:GetRoundNormalAttackDirTable(curRound)
  local result = BuffResultSavePetNormalAttackDir:New(dirTable, dir, dirNum)
  result.__notify_entity = notify:GetNotifyEntity()
  result.__notify_attackPos = notify:GetAttackPos()
  result.__notify_beAttackPos = notify:GetTargetPos()
  return result
end

_class("BuffLogicClearPetNormalAttackDirInCurrentRound", BuffLogicBase)
BuffLogicClearPetNormalAttackDirInCurrentRound = BuffLogicClearPetNormalAttackDirInCurrentRound

function BuffLogicClearPetNormalAttackDirInCurrentRound:DoLogic(notify)
  if not self._entity:HasPetPstID() then
    return
  end
  local cPetPstID = self._entity:PetPstID()
  local curRound = self._world:BattleStat():GetGameRoundCount()
  cPetPstID:ClearRoundNormalAttackDir(curRound)
  return BuffResultClearPetNormalAttackDir:New()
end
