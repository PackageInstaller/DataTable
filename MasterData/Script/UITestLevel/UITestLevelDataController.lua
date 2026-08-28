local DataModel = require("UITestLevel/UITestLevelDataModel")
local UIController = require("UITestLevel/UITestLevelUIController")
local CardManager, BattleControlManager, BattleTestManager, recordDamageCallback, recordCardDmanageOverCallback, recordCostUseCallback

local function ResetDataModelStatistics(clearPerFrameDmgList)
  DataModel.totalDamage = 0
  DataModel.onceDamageMax = 0
  DataModel.curSkillDamage = 0
  DataModel.largestRecordedSkillDamage = 0
  DataModel.usedCost = 0
  DataModel.usedCards = 0
  DataModel.sum_perFrameDamageList = 0
  DataModel.perFrameDamage = 0
  DataModel.perFrameDamageList = {}
  if clearPerFrameDmgList ~= true then
    for i = 1, DataModel.perFrameDamageListCount do
      table.insert(DataModel.perFrameDamageList, 0)
    end
  end
end

local module = {}

function module.Deserialize()
  DataModel.maxCost = false
  DataModel.refreshCardNoDelay = false
  DataModel.unlimitedLeaderCondition = false
  BattleTestManager = CBus:GetManager(CS.ManagerName.BattleTestManager)
  BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
  BattleTestManager:InitLuaDelegate()
  recordDamageCallback = BattleTestManager:StartRecordDamage()
  recordCardDmanageOverCallback = BattleTestManager:StartRecordCardDamageOver()
  recordCostUseCallback = BattleTestManager:StartRecordCostUse()
  DataModel.InitData()
  ResetDataModelStatistics()
end

function module.OnDestroy()
  BattleTestManager:RemoveEventListener(Enum_Event.Record_Damage, recordDamageCallback)
  BattleTestManager:RemoveEventListener(Enum_Event.Record_CardDamageOver, recordCardDmanageOverCallback)
  BattleTestManager:RemoveEventListener(Enum_Event.Record_CostUse, recordCostUseCallback)
  recordDamageCallback = nil
  recordCardDmanageOverCallback = nil
  recordCostUseCallback = nil
  BattleTestManager = nil
  BattleControlManager = nil
  DataModel.isInitialized = false
  ResetDataModelStatistics(true)
end

function module.RecordDamage(finalDmg, cardId, uniqueId)
  if DataModel.isInitialized ~= true then
    return
  end
  if 0 < cardId then
    if DataModel.cardUniqueIds[uniqueId] == nil then
      DataModel.cardUniqueIds[uniqueId] = {curDamage = 0}
    end
    local buffData = DataModel.cardUniqueIds[uniqueId]
    buffData.cardId = cardId
    buffData.curDamage = buffData.curDamage + finalDmg
    DataModel.curSkillDamage = buffData.curDamage
    if buffData.curDamage > DataModel.largestRecordedSkillDamage then
      DataModel.largestRecordedSkillDamage = buffData.curDamage
    end
  end
  if finalDmg < 0 then
    finalDmg = finalDmg + 4294967296
  end
  DataModel.perFrameDamage = DataModel.perFrameDamage + finalDmg
  local totalDamage = DataModel.totalDamage + finalDmg
  DataModel.totalDamage = totalDamage
  if finalDmg > DataModel.onceDamageMax then
    DataModel.onceDamageMax = finalDmg
  end
  DataModel.RecordDetail.onceDamageMax = DataModel.onceDamageMax
  DataModel.RecordDetail.damageTotal = DataModel.totalDamage
  DataModel.RecordDetail.healTotal = 0
  DataModel.RecordDetail.skillDamageNow = DataModel.curSkillDamage
  DataModel.RecordDetail.skillDamageMax = DataModel.largestRecordedSkillDamage
  DataModel.RecordDetail.damageTotalAt10s = DataModel.sum_perFrameDamageList
  DataModel.RecordDetail.usedCards = DataModel.usedCards
  DataModel.RecordDetail.usedCost = DataModel.usedCost
  UIController.RefreshUIDamage()
end

function module.RecordCardDamageOver(uniqueId)
  DataModel.cardUniqueIds[uniqueId] = nil
end

function module.RecordCostUse(cost)
  DataModel.usedCost = DataModel.usedCost + cost
  DataModel.usedCards = DataModel.usedCards + 1
  DataModel.RecordDetail.usedCards = DataModel.usedCards
  DataModel.RecordDetail.usedCost = DataModel.usedCost
  UIController.RefreshUICost()
  UIController.RefreshUICard()
end

function module.CaculateDamageList(perFrameDmg)
  DataModel.sum_perFrameDamageList = DataModel.sum_perFrameDamageList - DataModel.perFrameDamageList[1] + perFrameDmg
  table.remove(DataModel.perFrameDamageList, 1)
  table.insert(DataModel.perFrameDamageList, perFrameDmg)
  UIController.RefreshUITensDamange()
end

function module.ClearLeaderCardCondition()
  BattleTestManager:ClearLeaderCardCondition()
end

function module.SetLeaderCardCondition()
  BattleTestManager:SetLeaderCardCondition()
end

function module.LeaderCardConditionFinishCheck()
  BattleTestManager:LeaderCardConditionFinishCheck()
end

function module.MaxCost()
  BattleControlManager:MaxCost()
end

function module.ResetCardsInterverl()
  BattleControlManager:ResetCardsInterverl()
end

function module.ResetStatistics()
  ResetDataModelStatistics()
  UIController.RefreshUIDamage()
  UIController.RefreshUICost()
  UIController.RefreshUICard()
  local info = BattleControlManager.currentPlayerTeamData.battleData.BattleResult
  if info ~= nil then
    info:Clear()
  end
  DataModel.InitData()
  DataModel.RecordDetail.duration = BattleControlManager:GetBattleFrame()
end

return module
