local cls = class("modulePetDuelLevelInfo", G_UIModuleBase)
local _kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local _dungeonGroupTpl = L_GameTpl:getDungeonGroupTpl()
local _kiboDuelGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()

function cls.bind()
  return {
    txt_battleName = "",
    txt_levelOrder = "",
    txt_finish = "",
    table_enemyPet = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntrance"
    },
    table_reward = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelReward"
    },
    txt_recommend_level = "",
    table_condition = {
      moduleName = "pages/petDuelOutside/cellPetDuelCondition"
    }
  }
end

function cls.methods()
  return {
    onClick_prepareBattle = function(self)
      L_UI:open("pagePetDuelMain", {
        levelId = self.selectLevelId,
        levelMode = L_PetConst.PetDuelChallengeMode.ChapterLevel
      })
    end
  }
end

function cls:initModulePetDuelLevelInfo(levelId)
  self.selectLevelId = levelId
  local kiBoDuelGroupCfg = _kiboDuelGroupTpl:getTplById(self.selectLevelId)
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.selectLevelId)
  self.bind.txt_battleName = _kiboDuelGroupTpl:getLevelName(kiBoDuelGroupCfg)
  self.bind.txt_finish = L_PetDuelStore:getIsSuccess(self.selectLevelId) and L_WordsTpl:getValue("ui_pagePetDuelEntrance_01") or L_WordsTpl:getValue("ui_pagePetDuelEntrance_02")
  self.bind.txt_recommend_level = tostring(_kiBoDuelTpl:getRecommendLevel(kiBoDuelCfg))
  self.bind.txt_levelOrder = _kiboDuelGroupTpl:getLevelNum(_kiboDuelGroupTpl:getTplById(self.selectLevelId))
  self:refreshConditionShow()
  self:refreshMonsterShow()
  self:refreshRewardShow()
end

function cls:refreshConditionShow()
  local starData = L_PetDuelStore:getKiBoDuelStar(self.selectLevelId)
  local tpl = _kiBoDuelTpl:getTplById(self.selectLevelId)
  local challengeTask = _kiBoDuelTpl:getChallenge(tpl)
  local conditionItem = {}
  if challengeTask then
    for i = 1, #challengeTask do
      table.insert(conditionItem, {
        conditionId = challengeTask[i][1],
        conditionParma = challengeTask[i][2],
        finished = starData[i]
      })
    end
  end
  local reward = _kiBoDuelTpl:getChallengeRewardShow(tpl)
  for i = 1, #reward do
    local item = L_ItemTplManager:getItemConfig(reward[i].itemType, reward[i].itemId)
    if conditionItem[i] then
      conditionItem[i].rewardIcon = item.icon
      conditionItem[i].rewardNum = reward[i].itemNum
    end
  end
  self.bind.table_condition:clear()
  self.bind.table_condition:insert_array(conditionItem)
end

function cls:refreshMonsterShow()
  local curKiBoDuelCfg = _kiBoDuelTpl:getTplById(self.selectLevelId)
  local monsterItems = {}
  for k, v in pairs(_kiBoDuelTpl:getEnemy(curKiBoDuelCfg)) do
    table.insert(monsterItems, {
      petCfgId = k,
      petLv = v,
      cellMode = L_PetConst.PetDuelEntranceCellMode.Entrance
    })
  end
  table.sort(monsterItems, function(a, b)
    return a.petCfgId < b.petCfgId
  end)
  self.bind.table_enemyPet:clear()
  self.bind.table_enemyPet:insert_array(monsterItems)
end

function cls:refreshRewardShow()
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.selectLevelId)
  local reward = _kiBoDuelTpl:getFirstLoot(kiBoDuelCfg)
  local rewardItems = {}
  for i = 1, #reward do
    local item = L_ItemTplManager:getItemConfig(reward[i].itemType, reward[i].itemId)
    table.insert(rewardItems, {
      itemType = item.itemType,
      itemId = item.itemId,
      selectLevelId = self.selectLevelId,
      num = reward[i].itemNum
    })
  end
  self.bind.table_reward:clear()
  self.bind.table_reward:insert_array(rewardItems)
end

return cls
