local this = class("systemUnlockTpl")

function this:init(config)
  self.data = config
  self.tabTplData = {}
  for i, tpl in pairs(config) do
    if not math.isEmpty(tpl.upOneLevel) then
      if not self.tabTplData[tpl.upOneLevel] then
        self.tabTplData[tpl.upOneLevel] = {}
      end
      if not math.isEmpty(tpl.param) and self.tabTplData[tpl.upOneLevel][tpl.param] ~= nil then
        errorf(string.format("%s子功能没有对应页签参数重复", tpl.id))
      end
      self.tabTplData[tpl.upOneLevel][tpl.param] = tpl
    end
  end
end

function this:getTplById(id)
  local res = self.data[id]
  if table.isEmpty(res) then
    errorf(string.format("%s系统没有配置", id))
  end
  return res
end

function this:getButtonShow(tpl)
  return tpl.buttonShow == 1
end

function this:getUnlockCondi(tpl)
  local result = {}
  for match in string.gmatch(tpl.unlockCondi, "[%d#]+") do
    local curCond = {}
    table.insert(result, curCond)
    for match1 in string.gmatch(match, "%d+") do
      table.insert(curCond, tonumber(match1))
    end
  end
  return result
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getLockTips(tpl)
  local tip = L_Config:provider(tpl.lockTips)
  if not string.isEmpty(tip) then
    return tip
  end
end

function this:getUnlockTips(tpl)
  local tip = tpl.unlockTips
  if not string.isEmpty(tip) then
    return tip
  end
end

function this:getNote(tpl)
  return tpl.note
end

function this:getId(tpl)
  return tpl.id
end

function this:getFuction(tpl)
  return tpl.fuction
end

function this:getIcon(tpl)
  local path = tpl.icon
  if not string.isEmpty(path) then
    return path
  end
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getTplByTab(systemId, tab)
  local res = self.tabTplData[systemId][tab]
  if table.isEmpty(res) then
    errorf(string.format("%s系统的%s页签id没有配置", systemId, tab))
  end
  return res
end

function this:getUpOneLevel(tpl)
  return tpl.upOneLevel
end

function this:getParam(tpl)
  return tpl.param
end

function this:getDungeon(tpl)
  return tpl.dungeon
end

function this:getResourceBar(tpl)
  return tpl.resourceBar
end

function this:isHelpButtonShow(tpl)
  return not math.isEmpty(tpl.helpButton)
end

function this:getFilterConfig(tpl)
  return tpl.filterConfig
end

function this:getTargetParam(tpl)
  return tpl.targetParam
end

function this:getGmCloseTips(tpl)
  return L_Config:provider(tpl.gmCloseTips)
end

return this
