local PB = require("Common/PbHelper")
local Combat = require("Logic/Combat")
local BevTree = require("Logic/BevTree/BevTree")
local BevSequence = require("Logic/BevTree/BevSequence")
local BevSelector = require("Logic/BevTree/BevSelector")
local BevActionEndRound = require("Logic/BevTree/BevActionEndRound")
local BevActionSetVar = require("Logic/BevTree/BevActionSetVar")
local BevActionGenRandom = require("Logic/BevTree/BevActionGenRandom")
local BevActionAddBuff = require("Logic/BevTree/BevActionAddBuff")
local BevActionPlayBestSkill = require("Logic/BevTree/BevActionPlayBestSkill")
local BevActionPlaySkill = require("Logic/BevTree/BevActionPlaySkill")
local BevActionPlayRandomSkill = require("Logic/BevTree/BevActionPlayRandomSkill")
local BevActionLog = require("Logic/BevTree/BevActionLog")
local BevActionSetBackgroundEffect = require("Logic/BevTree/BevActionSetBackgroundEffect")
local BevActionPlayPerformance = require("Logic/BevTree/BevActionPlayPerformance")
local BevConditionCheckRound = require("Logic/BevTree/BevConditionCheckRound")
local BevConditionCheckAliveActors = require("Logic/BevTree/BevConditionCheckAliveActors")
local BevConditionCheckActorIsAlive = require("Logic/BevTree/BevConditionCheckActorIsAlive")
local BevConditionCheckHp = require("Logic/BevTree/BevConditionCheckHp")
local BevConditionCheckVar = require("Logic/BevTree/BevConditionCheckVar")
local BevConditionCheckBuffTime = require("Logic/BevTree/BevConditionCheckBuffTime")
local BevConditionCheckBuffStack = require("Logic/BevTree/BevConditionCheckBuffStack")
local BevConditionCheckActorHasBuff = require("Logic/BevTree/BevConditionCheckActorHasBuff")
local BevConditionCheckRage = require("Logic/BevTree/BevConditionCheckRage")
local BevConditionCheckActor = require("Logic/BevTree/BevConditionCheckActor")
local BevConditionCheckSkillMp = require("Logic/BevTree/BevConditionCheckSkillMp")
local BevConditionCheckSkill = require("Logic/BevTree/BevConditionCheckSkill")
local BevData = require("Logic/BevTree/BevData")
local BevTreeManager = {}
local Calculator = require("Logic/BevTree/Calculator")
local m_bevTreeManagerInstance

function BevTreeManager.init(aiData)
  BevData.instance = aiData.BevData
  m_bevTreeManagerInstance = aiData.BevTreeManager
  if m_bevTreeManagerInstance.inited == nil then
    aiData.BevTreeManager = {}
    m_bevTreeManagerInstance = aiData.BevTreeManager
    m_bevTreeManagerInstance.inited = true
    m_bevTreeManagerInstance.bevtrees = {}
    aiData.BevData = {}
    BevData.instance = aiData.BevData
    BevData.instance.nodeseq = 0
    BevData.instance.vars = {}
  end
end

function BevTreeManager.findElementInArray(arr, ele)
  for i = 1, #arr do
    local e = arr[i]
    if e == ele then
      return true
    end
  end
  return false
end

function BevTreeManager.initTeamMembers(fightData)
  BevData.instance.teamIds = {}
  BevData.instance.teamMembers = {}
  BevData.instance.teamLinks = {}
  for i = 1, #fightData.teamList do
    local teamInfo = fightData.teamList[i]
    BevData.instance.teamIds[i] = teamInfo.team
    BevData.instance.teamMembers[teamInfo.team] = {}
    local members = BevData.instance.teamMembers[teamInfo.team]
    local plist = teamInfo.playerList
    for j = 1, #plist do
      local actorCount = #plist[j].actorList
      for ai = 1, #plist[j].actorList do
        local actor = plist[j].actorList[ai]
        members[actor.baseSeat] = actor.actorInfo.id
      end
    end
  end
  for ti = 1, #BevData.instance.teamIds do
    local teamId = BevData.instance.teamIds[ti]
    local teamMembers = BevData.instance.teamMembers[teamId]
    BevData.instance.teamLinks[teamId] = {}
    local teamLinks = BevData.instance.teamLinks[teamId]
    local linkdata = PB.all("ActorLink")
    for i = 1, #linkdata do
      local actorLinkItem = linkdata[i]
      if Combat.IsTimeOpen(actorLinkItem.openTime) then
        local linkID = actorLinkItem.linkID
        local linkCount = #actorLinkItem.link
        local allfound = true
        for j = 1, linkCount do
          local linkActorItem = actorLinkItem.link[j]
          local found = BevTreeManager.findElementInArray(teamMembers, linkActorItem.actorID)
          if not found then
            allfound = false
            break
          end
        end
        if allfound then
          local links = {}
          for j = 1, linkCount do
            local linkActorItem = actorLinkItem.link[j]
            links[#links + 1] = linkActorItem.actorID
          end
          teamLinks[linkID] = links
        end
      end
    end
  end
end

function BevTreeManager.createBevTreeFromJson(team, bytes, fightData)
  print("BevTree", "BevTreeManager createBevTreeFromJson start")
  BevTreeManager.initTeamMembers(fightData)
  local bt = BevTree.new()
  local jsonobj = JsonD(bytes)
  BevTreeManager.createBevTreeNode(jsonobj[1], bt)
  m_bevTreeManagerInstance.bevtrees[team] = bt
  BevData.instance.vars[team] = {}
end

function BevTreeManager.createBevTreeNode(jsonNode, parentBevTreeNode)
  for i = 1, #jsonNode.children do
    local childNode = jsonNode.children[i]
    local btNode = BevTreeManager.createBevTreeNodeImpl(childNode)
    if btNode ~= nil then
      btNode.displayName = jsonNode.name
      parentBevTreeNode:addChild(btNode)
      BevTreeManager.createBevTreeNode(childNode, btNode)
    end
  end
end

function BevTreeManager.createBevTreeNodeImpl(jsonNode)
  if jsonNode.type == "Selector" then
    return BevSelector.new()
  elseif jsonNode.type == "Sequence" then
    return BevSequence.new()
  elseif jsonNode.type == "ActionEndRound" then
    return BevActionEndRound.new()
  else
    local func = BevTreeManager["create" .. jsonNode.type]
    if func ~= nil then
      return func(jsonNode)
    else
      error("BevTree", "no create" .. jsonNode.type .. " function was defined.")
    end
  end
end

function BevTreeManager.string_split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  local i = 1
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

function BevTreeManager.createActionPlayBestSkill(jsonNode)
  local node = BevActionPlayBestSkill.new()
  node.canUseSuperSkill = tonumber(jsonNode.prop.canUseSuperSkill) == 1
  node.canUseLink = tonumber(jsonNode.prop.canUseLink) == 1
  node.canUseAssistSkill = tonumber(jsonNode.prop.canUseAssistSkill) == 1
  node.canUseSkill2 = tonumber(jsonNode.prop.canUseSkill2) == 1
  node.canUseSkill1 = tonumber(jsonNode.prop.canUseSkill1) == 1
  node.returnFailIfFailToPlayDueToLock = tonumber(jsonNode.prop.returnFailIfFailToPlayDueToLock) == 1
  node.canUseSkill3_9 = tonumber(jsonNode.prop.canUseSkill3_9) == 1
  return node
end

function BevTreeManager.createActionPlaySkill(jsonNode)
  local node = BevActionPlaySkill.new()
  node.target = tonumber(jsonNode.prop.target)
  node.skillType = tonumber(jsonNode.prop.skillType)
  node.cardNum = tonumber(jsonNode.prop.cardNum)
  node.fallbackSkillType = tonumber(jsonNode.prop.fallbackSkillType)
  node.returnFailIfFailToPlayDueToLock = tonumber(jsonNode.prop.returnFailIfFailToPlayDueToLock) == 1
  return node
end

function BevTreeManager.createActionPlayRandomSkill(jsonNode)
  local node = BevActionPlayRandomSkill.new()
  node.canUseSuperSkill = tonumber(jsonNode.prop.canUseSuperSkill) == 1
  node.canUseLink = tonumber(jsonNode.prop.canUseLink) == 1
  node.canUseAssistSkill = tonumber(jsonNode.prop.canUseAssistSkill) == 1
  node.canUseSkill2 = tonumber(jsonNode.prop.canUseSkill2) == 1
  node.canUseSkill1 = tonumber(jsonNode.prop.canUseSkill1) == 1
  node.returnFailIfFailToPlayDueToLock = tonumber(jsonNode.prop.returnFailIfFailToPlayDueToLock) == 1
  return node
end

function BevTreeManager.createActionLog(jsonNode)
  local node = BevActionLog.new()
  node.log = jsonNode.prop.log
  return node
end

function BevTreeManager.createActionSetBackgroundEffect(jsonNode)
  local node = BevActionSetBackgroundEffect.new()
  node.effectName = jsonNode.prop.effectName
  return node
end

function BevTreeManager.createActionPlayPerformance(jsonNode)
  local node = BevActionPlayPerformance.new()
  node.targetTeam = tonumber(jsonNode.prop.targetTeam)
  node.target = tonumber(jsonNode.prop.target)
  node.actionName = jsonNode.prop.actionName
  node.textDisplayDelayTime = tonumber(jsonNode.prop.textDisplayDelayTime)
  node.textContent = jsonNode.prop.textContent
  node.textStyle = tonumber(jsonNode.prop.textStyle)
  node.performanceDuration = tonumber(jsonNode.prop.performanceDuration)
  node.newIdlePose = jsonNode.prop.newIdlePose
  node.actionTiming = tonumber(jsonNode.prop.actionTiming)
  return node
end

function BevTreeManager.createConditionCheckRound(jsonNode)
  local node = BevConditionCheckRound.new()
  node.compareOperation = tonumber(jsonNode.prop.compareOperation)
  node.valueExp = jsonNode.prop.valueExp
  return node
end

function BevTreeManager.createConditionCheckAliveActors(jsonNode)
  local node = BevConditionCheckAliveActors.new()
  node.team = tonumber(jsonNode.prop.team)
  node.compareOperation = tonumber(jsonNode.prop.compareOperation)
  node.valueExp = jsonNode.prop.valueExp
  return node
end

function BevTreeManager.createConditionCheckActorIsAlive(jsonNode)
  local node = BevConditionCheckActorIsAlive.new()
  node.team = tonumber(jsonNode.prop.team)
  node.target = tonumber(jsonNode.prop.target)
  node.alive = tonumber(jsonNode.prop.alive) == 1
  return node
end

function BevTreeManager.createConditionCheckHp(jsonNode)
  local node = BevConditionCheckHp.new()
  node.targetTeam = tonumber(jsonNode.prop.targetTeam)
  node.target = tonumber(jsonNode.prop.target)
  node.compareOperation = tonumber(jsonNode.prop.compareOperation)
  node.valueType = tonumber(jsonNode.prop.valueType)
  node.value = tonumber(jsonNode.prop.value)
  node.expression = jsonNode.prop.expression
  return node
end

function BevTreeManager.createActionSetVar(jsonNode)
  local node = BevActionSetVar.new()
  node.varname = jsonNode.prop.varname
  node.value = jsonNode.prop.value
  return node
end

function BevTreeManager.createActionGenRandom(jsonNode)
  local node = BevActionGenRandom.new()
  node.varname = jsonNode.prop.varname
  node.rangeLower = jsonNode.prop.rangeLower
  node.rangeUpper = jsonNode.prop.rangeUpper
  return node
end

function BevTreeManager.createActionAddBuff(jsonNode)
  local node = BevActionAddBuff.new()
  node.targetTeam = tonumber(jsonNode.prop.targetTeam)
  node.target = tonumber(jsonNode.prop.target)
  node.buffIndexExp = jsonNode.prop.buffIndexExp
  node.buffLevelExp = jsonNode.prop.buffLevelExp
  return node
end

function BevTreeManager.createConditionCheckVar(jsonNode)
  local node = BevConditionCheckVar.new()
  node.varname = jsonNode.prop.varname
  node.compareOperation = tonumber(jsonNode.prop.compareOperation)
  node.expression = jsonNode.prop.expression
  return node
end

function BevTreeManager.createConditionCheckBuffTime(jsonNode)
  local node = BevConditionCheckBuffTime.new()
  node.targetTeam = tonumber(jsonNode.prop.targetTeam)
  node.target = tonumber(jsonNode.prop.target)
  node.buffIdExp = jsonNode.prop.buffIdExp
  node.compareOperation = tonumber(jsonNode.prop.compareOperation)
  node.remainRoundExp = jsonNode.prop.remainRoundExp
  return node
end

function BevTreeManager.createConditionCheckBuffStack(jsonNode)
  local node = BevConditionCheckBuffStack.new()
  node.targetTeam = tonumber(jsonNode.prop.team)
  node.target = tonumber(jsonNode.prop.target)
  node.buffIdExp = jsonNode.prop.buffIdExp
  node.compareOperation = tonumber(jsonNode.prop.compareOperation)
  node.stackCountExp = jsonNode.prop.stackCountExp
  return node
end

function BevTreeManager.createConditionCheckActorHasBuff(jsonNode)
  local node = BevConditionCheckActorHasBuff.new()
  node.targetTeam = tonumber(jsonNode.prop.targetTeam)
  node.target = tonumber(jsonNode.prop.target)
  node.keyType = tonumber(jsonNode.prop.keyType)
  node.buffKeyExp = jsonNode.prop.buffKeyExp
  return node
end

function BevTreeManager.createConditionCheckRage(jsonNode)
  local node = BevConditionCheckRage.new()
  node.targetTeam = tonumber(jsonNode.prop.targetTeam)
  node.compareOperation = tonumber(jsonNode.prop.compareOperation)
  node.valueRatio = jsonNode.prop.valueRatio
  return node
end

function BevTreeManager.createConditionCheckActor(jsonNode)
  local node = BevConditionCheckActor.new()
  node.actorPosition = tonumber(jsonNode.prop.actorPosition)
  return node
end

function BevTreeManager.createConditionCheckSkillMp(jsonNode)
  local node = BevConditionCheckSkillMp.new()
  node.skillType = tonumber(jsonNode.prop.skillType)
  node.compareOperation = tonumber(jsonNode.prop.compareOperation)
  node.costValueExp = jsonNode.prop.costValueExp
  return node
end

function BevTreeManager.createConditionCheckSkill(jsonNode)
  local node = BevConditionCheckSkill.new()
  node.skillType = tonumber(jsonNode.prop.skillType)
  node.isAttackOrSupport = tonumber(jsonNode.prop.isAttackOrSupport) == 1
  node.compareOperation = tonumber(jsonNode.prop.compareOperation)
  node.attackTargetsCountExp = jsonNode.prop.attackTargetsCountExp
  return node
end

function BevTreeManager.updateAi(param, fightActiveData, aiData)
  BevData.instance = aiData.BevData
  m_bevTreeManagerInstance = aiData.BevTreeManager
  local team = param.team
  BevData.instance.fightActiveData = fightActiveData
  BevData.instance.currentTeam = team
  BevData.instance.cardsPlayed = {}
  BevData.instance.skillType = 0
  BevData.instance.superSkillType = 0
  BevData.instance.linkId = 0
  BevData.instance.buffList = {}
  BevData.instance.backgroundEffectName = ""
  BevData.instance.performanceInfoList = {}
  local bt = m_bevTreeManagerInstance.bevtrees[team]
  if bt ~= nil then
    bt:reset()
    bt:run()
  else
    error("BevTree", "bevtree is nil")
  end
  local result = {}
  result.cardSend = {}
  for i = 1, #BevData.instance.cardsPlayed do
    local card = BevData.instance.cardsPlayed[i]
    table.insert(result.cardSend, card)
  end
  result.skillType = BevData.instance.skillType
  result.superSkillType = BevData.instance.superSkillType
  result.linkId = BevData.instance.linkId
  result.buffList = {}
  for bi = 1, #BevData.instance.buffList do
    local buffInfo = BevData.instance.buffList[bi]
    local buff = {}
    buff.target = {
      team = buffInfo.target.team,
      seat = buffInfo.target.seat
    }
    buff.infoList = {}
    for infoListIndex = 1, #buffInfo.infoList do
      local useInfo = {}
      useInfo.index = buffInfo.infoList[infoListIndex].index
      useInfo.level = buffInfo.infoList[infoListIndex].level
      useInfo.attack = {
        team = buffInfo.infoList[infoListIndex].attack.team,
        seat = buffInfo.infoList[infoListIndex].attack.seat
      }
      table.insert(buff.infoList, useInfo)
    end
    table.insert(result.buffList, buff)
  end
  result.backgroundEffectName = BevData.instance.backgroundEffectName
  result.performanceInfoList = {}
  for i = 1, #BevData.instance.performanceInfoList do
    local performanceInfo = BevData.instance.performanceInfoList[i]
    table.insert(result.performanceInfoList, performanceInfo)
  end
  return result
end

return BevTreeManager
