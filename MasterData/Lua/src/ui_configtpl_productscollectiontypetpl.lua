local this = class("productsCollectionTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTypeName(tpl)
  return L_Config:provider(tpl.typeName)
end

function this:getId(tpl)
  return tpl.id
end

function this:getIsShowInOutPut(tpl)
  return tpl.isShowInOutput
end

function this:getNameInOutPut(tpl)
  return L_Config:provider(tpl.nameInOutput)
end

function this:getColor(tpl)
  if tpl.id == 4 then
    return C_Color(0.3843137, 0.8039216, 1)
  elseif tpl.id == 5 then
    return C_Color(0.854902, 0.4431373, 0.9960784)
  elseif tpl.id == 6 then
    return C_Color(1, 0.6901961, 0.3843137)
  end
  return C_Color.white
end

function this:getIcon(tpl)
  return tpl.icon and tpl.icon[1]
end

return this
