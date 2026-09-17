local this = class("conditionNode_2009", require(L_R.condition .. "conditionNode"))

function this.checkFunc(condition)
  return L_WorldLevelStore:getTaskMaxLevel() >= condition[2]
end

function this.descFunc(key, codData)
  return L_Lang:get(key, {
    worlddifficulty = codData[2]
  })
end

return this
