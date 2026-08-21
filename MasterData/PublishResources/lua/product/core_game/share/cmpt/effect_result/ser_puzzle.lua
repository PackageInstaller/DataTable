require("skill_effect_result_base")
_class("SkillEffectPuzzleResult", SkillEffectResultBase)
SkillEffectPuzzleResult = SkillEffectPuzzleResult

function SkillEffectPuzzleResult:Constructor()
  self._convertInfo = nil
  self._exchangePieceTypeList = {}
  self._notifyConvertArray = {}
end

function SkillEffectPuzzleResult:GetEffectType()
  return SkillEffectType.Puzzle
end

function SkillEffectPuzzleResult:AddExchangePieceType(oldPos, oldPieceType, newPos, newPieceType)
  table.insert(self._exchangePieceTypeList, {
    oldPos,
    oldPieceType,
    newPos,
    newPieceType
  })
end

function SkillEffectPuzzleResult:GetExchangePieceTypeList()
  return self._exchangePieceTypeList
end

function SkillEffectPuzzleResult:AddConvertInfo(convertPos, beforePieceType, convertPieceType)
  self._convertInfo = {
    convertPos,
    beforePieceType,
    convertPieceType
  }
end

function SkillEffectPuzzleResult:GetConvertInfo()
  return self._convertInfo
end

function SkillEffectPuzzleResult:SetNotifyConvertArray(convertArray)
  self._notifyConvertArray = convertArray
end

function SkillEffectPuzzleResult:GetNotifyConvertArray()
  return self._notifyConvertArray
end
