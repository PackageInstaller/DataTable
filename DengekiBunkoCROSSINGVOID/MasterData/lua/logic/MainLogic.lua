local CO = require("Common/Coroutine")
local m_fightActiveData = {
  roundIndex = 0,
  useCardResult = 0,
  roundState = 0,
  useCardTeam = 0,
  time = 0,
  teamList = {},
  roundStart = false,
  init = false,
  activeTeam = 0,
  activePlayerID = "",
  supportMode = 0,
  curSupportActor = 0,
  loadList = {},
  guideType = 0,
  stageID = 0,
  initSeed = 0,
  fightSeed = 0,
  team1Seed = 0,
  team2Seed = 0,
  winTeam = 0,
  dungeonType = 0,
  gameRound = 0,
  gameStart = false,
  playerCount = 0,
  sequenceActor = 0,
  sequenceList = {},
  activeActorList = {}
}
local m_aiData = {
  BevTreeManager = {},
  BevData = {}
}
local hurtLogic = require("Logic/HurtCalculate")
local useCardLogic = require("Logic/UseCardLogic")
local initGameLogic = require("Logic/InitGameLogic")
local loadGameLogic = require("Logic/LoadGameLogic")
local requestCardLogic = require("Logic/RequestCardLogic")
local roundEndLogic = require("Logic/RoundEndLogic")
local bevtreeEntry = require("Logic/BevTree/BevTreeEntry")
local FH = require("Logic/HelpLogic")

local function setContext(fightActiveData, aiData)
  if fightActiveData ~= nil then
    m_fightActiveData = fightActiveData
  end
  if aiData ~= nil then
    m_aiData = aiData
  end
  FH.initGlobalSeed()
  FH.setGlobalSeed(m_fightActiveData.fightSeed, m_fightActiveData.team1Seed, m_fightActiveData.team2Seed)
end

function useCard(param, callback, fightActiveData)
  setContext(fightActiveData)
  return CO.coroutine_call(useCardLogic, this)(param, callback, m_fightActiveData)
end

function requestCard(param, fightActiveData)
  setContext(fightActiveData)
  local result = requestCardLogic(param, m_fightActiveData)
  FH.getGlobalSeed(m_fightActiveData)
  return result
end

function initGame(param, fightActiveData)
  setContext(fightActiveData)
  local result = initGameLogic(param, m_fightActiveData)
  FH.getGlobalSeed(m_fightActiveData)
  return result
end

function loadGame(param, fightActiveData)
  setContext(fightActiveData)
  local result = loadGameLogic(param, m_fightActiveData)
  FH.getGlobalSeed(m_fightActiveData)
  return result
end

function roundEnd(param, fightActiveData)
  setContext(fightActiveData)
  local result = roundEndLogic(param, m_fightActiveData)
  FH.getGlobalSeed(m_fightActiveData)
  return result
end

function hurtCalculate(param, fightActiveData)
  setContext(fightActiveData)
  local result = hurtLogic(param)
  FH.getGlobalSeed(m_fightActiveData)
  return result
end

function bevtreeInit(team, xmlbytes, fightActiveData, aiData)
  setContext(fightActiveData, aiData)
  local result = bevtreeEntry[1](team, xmlbytes, m_fightActiveData, m_aiData)
  FH.getGlobalSeed(m_fightActiveData)
  return result
end

function bevtreeUpdate(param, fightActiveData, aiData)
  setContext(fightActiveData, aiData)
  local result = bevtreeEntry[2](param, m_fightActiveData, m_aiData)
  FH.getGlobalSeed(m_fightActiveData)
  return result
end

function fightActiveData()
  return m_fightActiveData
end

function SyncFightActiveData(data)
  m_fightActiveData = data
end

return {
  initGame,
  loadGame,
  roundEnd,
  requestCard,
  useCard,
  hurtCalculate,
  bevtreeInit,
  bevtreeUpdate
}
