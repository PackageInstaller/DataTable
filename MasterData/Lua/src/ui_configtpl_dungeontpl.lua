local this = class("dungeonTpl")

function this:init(config)
  self.data = config
  self.doorData = {}
  for i, v in pairs(config) do
    if not math.isEmpty(v.doorId) then
      if not self.doorData[v.doorId] then
        self.doorData[v.doorId] = {}
      end
      if not self.doorData[v.doorId][v.groupId] then
        self.doorData[v.doorId][v.groupId] = {}
      end
      table.insert(self.doorData[v.doorId][v.groupId], v)
    end
  end
  self.kiboArenaPvpData = {}
  for i, v in pairs(config) do
    if not math.isEmpty(v.dungeonType) and v.dungeonType == L_DungeonConst.DungeonType.KiboArenaPvp then
      self.kiboArenaPvpData[v.id] = v
    end
  end
end

function this:getValue()
  return self.data
end

function this:getTplById(id)
  if not self.data[id] then
    error("找不到id为" .. id .. "的dungeon")
  end
  return self.data[id]
end

function this:getType(tpl)
  return tpl.type
end

function this:getShowLevel(tpl)
  return tpl.showLevel
end

function this:getId(tpl)
  return tpl.id
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getUserExp(tpl)
  return tpl.userExp
end

function this:getVictoryCondition(tpl)
  return tpl.victoryCondition
end

function this:getDungeonType(tpl)
  return tpl.dungeonType
end

function this:getDungeonSystemType(tpl)
  return tpl.dungeonSystemType
end

function this:getSoldierExp(tpl)
  return tpl.soldierExp
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getGroupName(tpl)
  return L_Config:provider(tpl.dungeonGroupName)
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.description)
end

function this:getNeedPower(tpl)
  return tpl.needPower
end

function this:getChallenge(tpl)
  return tpl.challenge
end

function this:getChallengeReward(tpl)
  return tpl.challengeReward
end

function this:getFirstLoot(tpl)
  return L_DataUtil.parseRewardConfig(tpl.firstLoot)
end

function this:getLoot(tpl)
  return tpl.loot
end

function this:getLootShowing(tpl)
  return tpl.lootShowing
end

function this:getEnemy(tpl)
  return tpl.enemy
end

function this:getChallengeDes(tpl)
  local des = tpl.challengeDes
  local res = {}
  for i, v in ipairs(des) do
    table.insert(res, L_Config:provider(v))
  end
  return res
end

function this:getPosition(tpl)
  local p = tpl.position
  return {
    x = p[1],
    y = p[2],
    z = p[3]
  }
end

function this:getRotation(tpl)
  local p = tpl.position
  return {
    x = p[4],
    y = p[5],
    z = p[6]
  }
end

function this:getTimeScale(tpl)
  return tpl.timePassAvailable
end

function this:defaultSecond(tpl)
  return tpl.defaultTime / L_Const.weatherSecondRate
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getOpenType(tpl)
  return tpl.openType
end

function this:getOpenTypeParam(tpl)
  return tpl.openTypeParam
end

function this:getOpenTimeTxt(tpl)
  if tpl.openType == 2 then
    local str = L_WordsTpl:getValue("ui_period_01")
    for i, v in pairs(tpl.openTypeParam) do
      str = string.concat(str, v, " ")
    end
    return string.concat(str, L_WordsTpl:getValue("ui_period_02"))
  end
  if tpl.openType == 3 then
    local str = L_WordsTpl:getValue("ui_period_03")
    for i, v in pairs(tpl.openTypeParam) do
      str = string.concat(str, v, " ")
    end
    return string.concat(str, L_WordsTpl:getValue("ui_period_02"))
  end
end

function this:getIsInOpenTime(tpl)
  if tpl.openType == 1 then
    return true
  end
  if tpl.openType == 2 then
    for i, v in pairs(tpl.openTypeParam) do
      if L_TimeUtil.getDateInfo(L_TimeUtil.getServerTime()).wday - 1 == v then
        return true
      end
    end
  end
  if tpl.openType == 3 then
    for i, v in pairs(tpl.openTypeParam) do
      if L_TimeUtil.getDateInfo(L_TimeUtil.getServerTime()).day == v then
        return true
      end
    end
  end
  if tpl.openType == 4 then
  end
  return false
end

function this:getUpDuration(tpl)
  return tpl.upDuration
end

function this:getUpTime(tpl)
  return tpl.upTime
end

function this:getDiffType(tpl)
  return tpl.diffType
end

function this:getIsInUpDuration(tpl)
  local today = L_TimeUtil.getDateInfo(L_TimeUtil.getServerTime()).wday - 1
  for i, v in pairs(tpl.upDuration) do
    if today == v then
      return true
    end
  end
  return false
end

function this:getUpLoot(tpl)
  return tpl.upLoot
end

function this:getIsRandomDungeon(tpl)
  return tpl.dungeonRandomAvailable == 1
end

function this:getDungeonGroupTag(tpl)
  return L_Config:provider(tpl.dungeonGroupTag)
end

function this:getDungeonGroupOrder(tpl)
  return tpl.dungeonGroupOrder
end

function this:getCameraDistance(tpl)
  return tpl.cameraDistance
end

function this:getCameraVerticalAngle(tpl)
  return tpl.cameraVerticalAngle
end

function this:getCameraHorizontalAngle(tpl)
  return tpl.cameraHorizontalAngle
end

function this:getEnterBattle(tpl)
  return tpl.enterBattle
end

function this:getDoorId(tpl)
  return tpl.doorId
end

function this:getTplListByDoorId(doorId)
  return self.doorData[doorId]
end

function this:getTplListByDoorIdAndGroupId(doorId, groupId)
  return self.doorData[doorId][groupId]
end

function this:getKiboArenaPvpDungeonData()
  return self.kiboArenaPvpData
end

function this:getgameplayID(tpl)
  return tpl.gameplayID
end

function this:getDifficultyIconPath(tpl, isSelect)
  return string.format("UI/Atlas/DungeonNum/tex_dungeon_dec_num%s%d.png", isSelect and "A" or "B", tpl.dungeonGroupOrder)
end

return this
