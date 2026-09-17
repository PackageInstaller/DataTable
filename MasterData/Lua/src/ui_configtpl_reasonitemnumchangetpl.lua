local this = class("reasonItemnumChangeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getForm(tpl)
  return tpl.form
end

function this:getId(tpl)
  return tpl.id
end

function this:getItemSubtype(tpl)
  return tpl.itemSubtype
end

function this:getItemType(tpl)
  return tpl.itemType
end

function this:getFormType(src, itemType, subType)
  local tpl = self:getTplById(src)
  if tpl then
    local types = this:getItemType(tpl)
    local typeIndex
    for i, v in pairs(types) do
      if v == itemType then
        typeIndex = i
        break
      end
    end
    if typeIndex then
      if not subType then
        return this:getForm(tpl)
      end
      local subTypesList = this:getItemSubtype(tpl)
      local subTypes = subTypesList[typeIndex]
      if subTypes then
        local subTypeIndex
        for i, v in pairs(subTypes) do
          if v == subType then
            subTypeIndex = i
            break
          end
        end
        if subTypeIndex then
          return this:getForm(tpl)
        end
      end
    end
  end
  return nil
end

return this
