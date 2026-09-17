local this = class("conditionNode_50001", require(L_R.condition .. "conditionNode"))

function this.checkFunc(condition)
  return false
end

function this.descFunc(key, codData)
  return L_Lang:get(key, {
    time = codData[2]
  })
end

return this
