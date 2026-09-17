local cls = class("pagePetDuelEntrance", G_UIPageBase)
local _kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local _dungeonGroupTpl = L_GameTpl:getDungeonGroupTpl()

function cls.bind()
  return {
    table_selection = {
      moduleName = "pages/petDuelOutside/cellPetDuelLevel"
    },
    txt_battleName = "",
    txt_level = "",
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
    onClick_closeBtn = function()
      L_UI:close("pagePetDuelEntrance")
    end,
    onClick_prepareBattle = function(self)
      L_UI:open("pagePetDuelMain", {
        levelId = self.selectLevelId
      })
    end
  }
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  L_PetDuelStore:setCurChallengeGroupId(tonumber(options.groupId))
  self:loadVirtualCamera(options.npcEntity)
  self:initPage()
end

function cls:loadVirtualCamera(entity)
  C_CameraManager.ActivateTactics(C_ECameraType.NpcKiBoDuel, C_CinemachineBlendType.EaseIn, 1000)
  local cameraController = C_CameraManager.GetTactics(C_ECameraType.NpcKiBoDuel)
  cameraController:SetNpcKiBoDuelData(entity:GetTransform(), entity:GetUnitId())
  L_PlayerManager:showOrHideAllPlayer(false)
  AzurWorld.HUDMgr:SetAllVisible(false, "PagePetDuel")
  AzurWorldInstance:SetNodeVisible(L_Const.WorldNode.PLAYERPETNODE, false, L_Const.worldNodeHideType.LuaUIControlHide)
end

function cls:unloadVirtualCamera()
  L_PlayerManager:showOrHideAllPlayer(true)
  C_CameraManager.PlaySetBlend(C_CinemachineBlendType.Custom, 1000)
  C_CameraManager.DeactivateTactics(C_ECameraType.NpcKiBoDuel)
  AzurWorld.HUDMgr:SetAllVisible(true, "PagePetDuel")
  AzurWorldInstance:SetNodeVisible(L_Const.WorldNode.PLAYERPETNODE, true, L_Const.worldNodeHideType.LuaUIControlHide)
end

function cls:initPage()
  self:refreshLeftShow()
  self:refreshRightShow()
end

function cls:refreshLeftShow()
  local function onClick_select(cell)
    self.selectLevelId = cell.bind.levelId
    
    for i = 1, #self.bind.table_selection do
      if self.bind.table_selection[i].levelId == self.selectLevelId then
        self.bind.table_selection:change(i, {
          selectLevelId = self.selectLevelId
        })
      else
        self.bind.table_selection:change(i, {
          selectLevelId = self.selectLevelId
        })
      end
    end
    self:refreshRightShow()
  end
  
  self.selectLevelId = L_PetDuelStore:getDefaultSelectLevelId()
  local levelItems = {}
  for _, id in ipairs(L_PetDuelStore:getNPCLevelIds()) do
    table.insert(levelItems, {
      levelId = id,
      selectLevelId = self.selectLevelId,
      callback = onClick_select
    })
  end
  self.bind.table_selection:clear()
  self.bind.table_selection:insert_array(levelItems)
end

function cls:refreshRightShow()
  local curDungeonGroupCfg = _dungeonGroupTpl:getTplById(self.selectLevelId)
  self.bind.txt_battleName = _dungeonGroupTpl:getName(curDungeonGroupCfg)
  self.bind.txt_level = L_WordsTpl:getValue("ui_pagePetDuelEntrance_03") .. _dungeonGroupTpl:getDungeonGroupTag(curDungeonGroupCfg)
  self.bind.txt_finish = L_PetDuelStore:getIsSuccess(self.selectLevelId) and L_WordsTpl:getValue("ui_pagePetDuelEntrance_01") or L_WordsTpl:getValue("ui_pagePetDuelEntrance_02")
  self.bind.txt_recommend_level = tostring(_dungeonGroupTpl:getShowLevel(curDungeonGroupCfg))
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
  local curDungeonGroupCfg = _dungeonGroupTpl:getTplById(self.selectLevelId)
  local reward = _dungeonGroupTpl:getFirstLoot(curDungeonGroupCfg)
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

function cls:close(options)
  cls.super.close(self, options)
  self:unloadVirtualCamera()
end

return cls
