local this = class("optionDataClassTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getShowList(equip)
  local tab = {}
  equip = equip or L_DeviceTpl:getEquipment()
  for _, v in ipairs(self.data) do
    local filter = self:getDisplayFilters(v)
    if filter == 1 or filter == 2 and equip == L_Const.equipment.pc or filter == 3 and equip == L_Const.equipment.mobile or filter == 4 and equip == L_Const.equipment.gameConsole then
      table.insert(tab, v)
    end
  end
  return tab
end

function this:getOptionclassName(tpl)
  return L_Config:provider(tpl.optionclassName)
end

function this:getClientType(tpl)
  return tpl.clientType
end

function this:getId(tpl)
  return tpl.id
end

function this:getDisplayFilters(tpl)
  return tpl.displayFilters
end

function this:getDecoration(tpl)
  return tpl.englishDecorate
end

function this:getIcon(tpl)
  return tpl.icon
end

return this
