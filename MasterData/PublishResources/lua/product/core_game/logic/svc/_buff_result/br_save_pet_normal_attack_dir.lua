_class("BuffResultSavePetNormalAttackDir", BuffResultBase)
BuffResultSavePetNormalAttackDir = BuffResultSavePetNormalAttackDir

function BuffResultSavePetNormalAttackDir:Constructor(dirTable, dir, dirNum)
  self._dirTable = dirTable
  self._dir = dir
  self._dirNum = dirNum
end

function BuffResultSavePetNormalAttackDir:GetDir()
  return self._dir
end

function BuffResultSavePetNormalAttackDir:GetDirNum()
  return self._dirNum
end
