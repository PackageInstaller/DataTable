local this = class("conditionNode_13046", require(L_R.condition .. "conditionNode"))
local _dungeonEntrustDifficultyTpl = L_GameTpl:getDungeonEntrustDifficultyTpl()

function this.checkFunc(condition)
  local curStarNum = L_EntrustStore:getEntrustStarNumByDifficulty(L_Const.EntrustTypeEnum.AreaEntrust, condition[2])
  return curStarNum >= condition[3]
end

function this.descFunc(key, codData)
  local cfg = _dungeonEntrustDifficultyTpl:getTplById(codData[2])
  return L_Lang:get(key, {
    name = _dungeonEntrustDifficultyTpl:getName(cfg),
    index = tostring(codData[3])
  })
end

return this
