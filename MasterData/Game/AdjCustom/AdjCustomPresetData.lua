local AdjCustomPresetData = class("AdjCustomPresetData")

function AdjCustomPresetData:InitPresetData(teamId)
  self._teamId = teamId
  self._heroList = {}
end

function AdjCustomPresetData:UpdatePresetMsg(msg)
  self._msg = msg
  self._useL2d = msg.useL2D
  self._bgId = msg.bgId
  self._teamName = msg.name
  if self._useL2d and msg.mainHero ~= nil then
    local mainHeroId = msg.mainHero.heroId
    local mainHeroSkinId = msg.mainHero.skinId
    if mainHeroSkinId == 0 then
      mainHeroSkinId = ConfigData.hero_data[mainHeroId].default_skin
    end
    self._useL2d = 0 < PlayerDataCenter.skinData:GetSkinLive2dLevel(mainHeroSkinId)
  end
  self._heroDic = {}
  table.removeall(self._heroList)
  if msg.mainHero ~= nil then
    table.insert(self._heroList, msg.mainHero.heroId)
    self:__RecordData(msg.mainHero, true)
  end
  if msg.minorHero ~= nil then
    table.insert(self._heroList, msg.minorHero.heroId)
    self:__RecordData(msg.minorHero, false)
  end
end

function AdjCustomPresetData:__RecordData(single, isMain)
  if self._heroDic[single.heroId] == nil then
    self._heroDic[single.heroId] = {}
  end
  local data = self._heroDic[single.heroId]
  data.dataId = single.heroId
  data.skinId = single.skinId
  if single.posX ~= 0 or single.posY ~= 0 then
    data.pos = {
      single.posX / 1000,
      single.posY / 1000
    }
  else
    data.pos = nil
  end
  if 0 < single.heroSize then
    data.size = single.heroSize / 1000
  else
    data.size = nil
  end
  data.isMain = isMain
  data.isL2d = isMain and self._useL2d
end

function AdjCustomPresetData:SetAdjPresetName(name)
  self._teamName = name
end

function AdjCustomPresetData:GetAdjPresetTeamId()
  return self._teamId
end

function AdjCustomPresetData:GetAdjPresetUseL2d()
  return self._useL2d
end

function AdjCustomPresetData:GetAdjPresetBgId()
  return self._bgId
end

function AdjCustomPresetData:GetAdjPresetElemData(heroId)
  return self._heroDic[heroId]
end

function AdjCustomPresetData:GetAdjPresetElemMain()
  return self._heroDic[self._heroList[1]]
end

function AdjCustomPresetData:GetAdjPresetHeroList()
  return self._heroList
end

function AdjCustomPresetData:GetAdjPresetName()
  return self._teamName
end

function AdjCustomPresetData:GetAdjMainHeroSkinId()
  return self._msg.mainHero and self._msg.mainHero.skinId
end

function AdjCustomPresetData:GetAdjMinorHeroSkinId()
  return self._msg.minorHero and self._msg.minorHero.skinId
end

function AdjCustomPresetData:TryGetAdjSkinUpgradeMsg()
  self._msg.useL2D = true
  if self._msg.mainHero ~= nil then
    self._msg.mainHero.posX = 0
    self._msg.mainHero.posY = 0
  end
  return self._msg
end

function AdjCustomPresetData:GetAdjSkinMsgCheckL2d()
  local msg = self._msg
  if msg.mainHero then
    local mainHeroId = msg.mainHero.heroId
    local mainHeroSkinId = msg.mainHero.skinId
    if mainHeroSkinId == 0 then
      mainHeroSkinId = ConfigData.hero_data[mainHeroId].default_skin
    end
    self._msg.useL2D = 0 < PlayerDataCenter.skinData:GetSkinLive2dLevel(mainHeroSkinId)
  end
  return self._msg
end

function AdjCustomPresetData:GetAdjPresetMsg()
  return self._msg
end

return AdjCustomPresetData
