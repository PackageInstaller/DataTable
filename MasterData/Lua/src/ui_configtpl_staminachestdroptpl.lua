local this = class("staminaChestDropTpl")

function this:init(config)
  self.data = config
  self.worldFilterData = {}
  for i, v in pairs(config) do
    if not table.isEmpty(v.worldFilter) then
      local type, id, level = table.unpack(v.worldFilter)
      self.worldFilterData[type] = self.worldFilterData[type] or {}
      if type == L_Const.StaminaBoxSystemType.SBST_WORLD_ENEMY then
        self.worldFilterData[type][id] = self.worldFilterData[type][id] or {}
        self.worldFilterData[type][id][level] = v
      else
        self.worldFilterData[type][id] = v
      end
    end
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getNeed(tpl)
  return tpl.need
end

function this:getRewardDisplay(tpl)
  return tpl.rewardDisplay
end

function this:getRewardDisplayUp(tpl)
  return tpl.rewardDisplay
end

function this:getDesc(tpl)
  return tpl.desc
end

function this:getDrop(tpl)
  return tpl.drop
end

function this:getRewardChance(tpl)
  return tpl.rewardChance
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getId(tpl)
  return tpl.id
end

function this:getUpDuration(tpl)
  return tpl.upDuration
end

function this:getWorldFilter(tpl)
  return tpl.worldFilter
end

function this:getTplByWorldFilter(type, id)
  return self.worldFilterData[type][id]
end

function this:getStaminaChestId(type, id)
  local tpl = self.worldFilterData[type][id]
  return self:getId(tpl)
end

function this:isDuringUp(tpl)
  local today = L_TimeUtil.getDateInfo(L_TimeUtil.getServerTime()).wday - 1
  for i, v in pairs(tpl.upDuration) do
    if today == v then
      return true
    end
  end
  return false
end

function this:getWorldMapId(tpl)
  return tpl.worldmapid
end

function this:getSpawnerId(tpl)
  return tpl.spawnerid
end

function this:getRewardChanceUp(tpl)
  return tpl.rewardChanceUp
end

function this:getTime(tpl)
  return tpl.time
end

return this
