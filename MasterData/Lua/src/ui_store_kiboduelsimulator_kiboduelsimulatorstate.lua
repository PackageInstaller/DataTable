local this = {}

function this:init()
  this.super.init(self)
  self:initData()
end

function this:initData()
  self.data = {
    isRing = false,
    kiboDuelId = 9001,
    sceneId = 2,
    behaviorName = "battleExampleTree_1",
    fsmName = "fsm_kibopve",
    summonList = {},
    playerInfo = {
      [1] = require(L_R.store .. "kiboDuelSimulator.data.kiboDuelSimulatorPlayerInfo").new(),
      [2] = require(L_R.store .. "kiboDuelSimulator.data.kiboDuelSimulatorPlayerInfo").new()
    }
  }
  self.data.playerInfo[1].playerEntityId = 199001
  self.data.playerInfo[2].playerEntityId = 104004
end

function this:dataToTable()
  local list = {}
  list.isRing = self.data.isRing
  list.kiboDuelId = self.data.kiboDuelId
  list.sceneId = self.data.sceneId
  list.behaviorName = self.data.behaviorName
  list.fsmName = self.data.fsmName
  list.summonList = self.data.summonList
  for i = 1, 2 do
    list["playerInfo" .. i] = {}
    list["playerInfo" .. i].playerEntityId = self.data.playerInfo[i].playerEntityId
    list["playerInfo" .. i].skillList = self.data.playerInfo[i].skillList
    list["playerInfo" .. i].kiboList = {}
    for j = 1, 8 do
      list["playerInfo" .. i].kiboList[j] = {}
      list["playerInfo" .. i].kiboList[j].kiboId = self.data.playerInfo[i].kiboList[j].kiboId
      list["playerInfo" .. i].kiboList[j].lv = self.data.playerInfo[i].kiboList[j].lv
    end
  end
  return list
end

function this:getSaveData(saveData)
  self:initData()
  self.data.isRing = saveData.isRing
  self.data.kiboDuelId = saveData.kiboDuelId
  self.data.sceneId = saveData.sceneId
  self.data.behaviorName = saveData.behaviorName
  self.data.fsmName = saveData.fsmName
  self.data.summonList = saveData.summonList
  for i = 1, 2 do
    self.data.playerInfo[i].playerEntityId = saveData["playerInfo" .. i].playerEntityId
    self.data.playerInfo[i].skillList = saveData["playerInfo" .. i].skillList
    for j = 1, 8 do
      self.data.playerInfo[i].kiboList[j].kiboId = saveData["playerInfo" .. i].kiboList[j].kiboId
      self.data.playerInfo[i].kiboList[j].lv = saveData["playerInfo" .. i].kiboList[j].lv
    end
  end
end

function this:getDefaultSummonItem()
  local defaultSummonValue = {
    [1] = 0,
    [2] = 9,
    [3] = 1,
    [4] = 500001,
    [5] = 1
  }
  return defaultSummonValue
end

return this
