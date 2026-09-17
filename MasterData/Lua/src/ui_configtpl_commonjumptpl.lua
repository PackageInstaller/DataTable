local this = class("commonJumpTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getType(tpl)
  return tpl.type
end

function this:getCondition(tpl)
  return tpl.condition
end

function this:getPageName(tpl)
  return tpl.page
end

function this:getParam(tpl)
  if table.isEmpty(tpl.param) then
    return nil
  end
  return tpl.param
end

function this:getNeedBackToRoot(tpl)
  return not math.isEmpty(tpl.main)
end

function this:getHomeText(tpl)
  return tpl.text
end

function this:getUnlockTips(tpl, index)
  index = index or 1
  return L_Config:provider(tpl.lockTips[index])
end

return this
