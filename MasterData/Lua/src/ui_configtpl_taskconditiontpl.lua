local this = class("taskConditionTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getParam(tpl)
  return tpl.param
end

function this:getId(tpl)
  return tpl.id
end

function this:getDesc(tpl)
  return tpl.desc
end

function this:getGuideParam(tpl)
  return tpl.guideParam
end

function this:getGuideCondition(tpl)
  return tpl.guideCondition
end

function this:getCondition(tpl)
  return tpl.condition
end

function this:getGuideDesc(tpl, idx)
  if idx then
    return L_Config:provider(tpl.guideDesc[idx])
  end
  local res = {}
  for i = 1, #tpl.guideDesc do
    res[i] = L_Config:provider(tpl.guideDesc[i])
  end
  return res
end

function this:getFormulaId(tpl)
  return tpl.formulaId
end

return this
