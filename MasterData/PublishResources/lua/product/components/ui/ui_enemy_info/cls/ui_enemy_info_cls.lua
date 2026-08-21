_class("Enemy", Object)
Enemy = Enemy

function Enemy:Constructor()
  self.id = 0
  self.alias = ""
  self.aliasEn = ""
  self.name = ""
  self.nameEn = ""
  self.desc = ""
  self.icon = ""
  self.staticBody = ""
  self._power = ""
  self.prop = {}
  self.area = 0
  self.canMove = true
  self.step = 0
  self.isBoss = false
  self.isElite = false
  self.eliteDesc = ""
  self._elementMap = {
    [1] = "bing_color",
    [2] = "huo_color",
    [3] = "sen_color",
    [4] = "lei_color"
  }
end

function Enemy:Init(id)
  self.id = id
  local monsterConfig = Cfg.cfg_monster[id]
  if not monsterConfig then
    Log.fatal("cfg_monster " .. id .. " not exist.")
    return
  end
  local monsterClassConfig = Cfg.cfg_monster_class[monsterConfig.ClassID]
  if not monsterClassConfig then
    Log.fatal("cfg_monster_class " .. monsterConfig.ClassID .. " not exist.")
    return
  end
  self.alias = StringTable.Get(monsterClassConfig.Alias)
  self.aliasEn = StringTable.Get(monsterClassConfig.Alias .. "_en")
  self.name = StringTable.Get(monsterClassConfig.Name)
  self.nameEn = StringTable.Get(monsterClassConfig.Name .. "_en")
  self.desc = StringTable.Get(monsterClassConfig.Desc)
  self.area = #monsterClassConfig.Area
  self.step = monsterClassConfig.Step
  self.power = StringTable.Get(monsterClassConfig.Ability)
  self.canMove = monsterClassConfig.CanMove
  self.icon = monsterClassConfig.CardResPath
  self.head = monsterClassConfig.HeadIcon
  self.staticBody = monsterClassConfig.StaticBody
  local nElementType = monsterConfig.ElementType
  local elementType = "str_discovery_enemy_element_" .. nElementType
  local val = StringTable.Get(elementType)
  self.prop = {
    name = val,
    icon = self._elementMap[nElementType]
  }
  self.isBoss = monsterClassConfig.MonsterType == 2
  if monsterConfig.EliteID and table.count(monsterConfig.EliteID) then
    self.isElite = true
    local len = table.count(monsterConfig.EliteID)
    local strElite = StringTable.Get("str_discovery_enemy_elite")
    for i, v in ipairs(monsterConfig.EliteID) do
      local cfgElite = Cfg.cfg_monster_elite[v]
      if cfgElite then
        self.eliteDesc = self.eliteDesc .. strElite .. StringTable.Get("str_discovery_enemy_bracket", StringTable.Get(cfgElite.Name)) .. StringTable.Get(cfgElite.Desc)
        if i < len then
          self.eliteDesc = self.eliteDesc .. "\n"
        end
      else
        Log.warn("### no elite in cfg_monster_elite. ", v)
      end
    end
  end
end
