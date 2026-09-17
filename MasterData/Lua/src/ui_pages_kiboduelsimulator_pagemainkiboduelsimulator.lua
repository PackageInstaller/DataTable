local this = class("pageMainKiboDuelSimulator", G_UIPageBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _worldSpawnTpl = L_GameTpl:getWorldSpawnerTpl()
local _skillTpl = L_GameTpl:getSkillTpl()
local _kiboDuelTpl = L_GameTpl:getKiboDuelTpl()

function this.bind()
  return {
    txt_inputBehaviourTree = "",
    txt_inputFsm = "",
    txt_sceneId = "",
    txt_playerId = "",
    txt_enemyId = "",
    txt_presetId = "",
    toggle_isRing = false
  }
end

function this.methods()
  return {
    onClick_scene = function(self)
      L_UI:open("pageTestSelectOne", {
        title = L_WordsTpl:getValue("residual_code_pagemainkiboduelsimulator_01"),
        list = self:getSceneList(),
        selectCallback = function(choice)
          L_KiboDuelSimulatorStore:getData().sceneId = choice
          self.bind.txt_sceneId = tostring(choice)
        end
      })
    end,
    onChanged_behaviourTree = function(self, text)
      L_KiboDuelSimulatorStore:getData().behaviorName = text
    end,
    onChanged_fsm = function(self, text)
      L_KiboDuelSimulatorStore:getData().fsmName = text
    end,
    onClick_selectPlayer = function(self)
      L_UI:open("pageTestSelectOne", {
        title = L_WordsTpl:getValue("residual_code_pagemainkiboduelsimulator_02"),
        list = self:getPlayerList(),
        selectCallback = function(choice)
          L_KiboDuelSimulatorStore:getData().playerInfo[1].playerEntityId = choice
          local tpl = _heroTpl:getTplById(choice)
          self.bind.txt_playerId = _heroTpl:getName(tpl)
        end
      })
    end,
    onClick_selectEnemy = function(self)
      L_UI:open("pageTestSelectOne", {
        title = L_WordsTpl:getValue("residual_code_pagemainkiboduelsimulator_03"),
        list = self:getEnemyList(),
        selectCallback = function(choice)
          L_KiboDuelSimulatorStore:getData().playerInfo[2].playerEntityId = choice
          local tpl = _worldSpawnTpl:getTplById(choice)
          self.bind.txt_enemyId = _worldSpawnTpl:getName(tpl)
        end
      })
    end,
    onClick_formationPlayer = function()
      L_UI:open("pageKDTestTeam", {side = 1})
    end,
    onClick_formationEnemy = function()
      L_UI:open("pageKDTestTeam", {side = 2})
    end,
    onClick_playerSkill = function(self)
      L_UI:open("pageTestSelectMuti", {
        title = L_WordsTpl:getValue("residual_code_pagemainkiboduelsimulator_04"),
        list = self:getEntitySkillList(),
        selectList = self:getPlayerSkillList(),
        maxNum = 2,
        selectCallback = function(choice)
          L_KiboDuelSimulatorStore:getData().playerInfo[1].skillList[1] = choice[1]
          L_KiboDuelSimulatorStore:getData().playerInfo[1].skillList[2] = choice[2]
        end
      })
    end,
    onClick_summon = function(self)
      L_UI:open("pageTestSummon")
    end,
    onClick_selectPreset = function(self)
      L_UI:open("pageTestSelectOne", {
        title = L_WordsTpl:getValue("residual_code_pagemainkiboduelsimulator_05"),
        list = self:getPresetList(),
        selectCallback = function(choice)
          L_KiboDuelSimulatorStore:updateDataByConfig(choice)
          self:initPage()
        end
      })
    end,
    onClick_save = function(self)
      L_UI:open("pageTestSelectOne", {
        title = L_WordsTpl:getValue("residual_code_pagemainkiboduelsimulator_06"),
        list = self:getSaveList(),
        renameFlag = true,
        selectCallback = function(choice)
          L_KiboDuelSimulatorStore:saveCurInfo(choice)
        end,
        closeCb = function(list)
          L_KiboDuelSimulatorStore:saveNameList(list)
        end
      })
    end,
    onClick_load = function(self)
      L_UI:open("pageTestSelectOne", {
        title = L_WordsTpl:getValue("residual_code_pagemainkiboduelsimulator_07"),
        list = self:getSaveList(),
        renameFlag = true,
        selectCallback = function(choice)
          L_KiboDuelSimulatorStore:resetLoadInfo(choice)
          self:initPage()
        end,
        closeCb = function(list)
          L_KiboDuelSimulatorStore:saveNameList(list)
        end
      })
    end,
    onClick_battle = function(self)
      if L_KiboDuelSimulatorStore:setCSharpData() then
        L_UI:close(self.pageName)
        L_FlyMsgManager:initialize()
        L_KiboDuelSimulatorStore:storeKiboInfo()
        C_KiboDuelSimulatorManager.instance:StartSimulatorBattle()
      end
    end,
    onClick_arena = function(self, flag)
      L_KiboDuelSimulatorStore:getData().isRing = flag
    end
  }
end

function this:ctor()
  this.super.ctor(self)
end

function this:open(options)
  this.super.open(self, options)
  self:initPage()
end

function this:initPage()
  self.bind.txt_inputBehaviourTree = L_KiboDuelSimulatorStore:getData().behaviorName
  self.bind.txt_inputFsm = L_KiboDuelSimulatorStore:getData().fsmName
  self.bind.txt_sceneId = tostring(L_KiboDuelSimulatorStore:getData().sceneId)
  self.bind.txt_playerId = tostring(_heroTpl:getName(_heroTpl:getTplById(L_KiboDuelSimulatorStore:getData().playerInfo[1].playerEntityId)))
  self.bind.txt_enemyId = tostring(_worldSpawnTpl:getName(_worldSpawnTpl:getTplById(L_KiboDuelSimulatorStore:getData().playerInfo[2].playerEntityId)))
  self.bind.txt_presetId = tostring(L_KiboDuelSimulatorStore:getData().kiboDuelId)
  self.bind.toggle_isRing = L_KiboDuelSimulatorStore:getData().isRing
end

function this:close(options)
  this.super.close(self, options)
end

function this:escHandle()
end

function this:getSceneList()
  local list = {}
  local cfgList = L_GameTpl:getKiboDuelMapTpl().data
  for i, v in pairs(cfgList) do
    list[i] = {
      id = v.id,
      name = v.id .. "_" .. v.prefabID
    }
  end
  return list
end

function this:getPlayerList()
  local list = {}
  local cfgList = _heroTpl.data
  for i, v in pairs(cfgList) do
    list[i] = {
      id = v.id,
      name = v.id .. "_" .. _heroTpl:getName(v)
    }
  end
  return list
end

function this:getEnemyList()
  local list = {}
  local cfgList = _worldSpawnTpl.data
  for i, v in pairs(cfgList) do
    list[i] = {
      id = v.id,
      name = v.id .. "_" .. _worldSpawnTpl:getName(v)
    }
  end
  return list
end

function this:getSaveList()
  local list = {}
  for i = 1, 5 do
    list[i] = {
      id = i,
      name = L_WordsTpl:getValue("residual_code_pagemainkiboduelsimulator_08") .. i
    }
  end
  return list
end

function this:getEntitySkillList()
  local gameConstTpl = L_GameTpl:getGameConstTpl()
  local list = {}
  local skillList = gameConstTpl:getData("KIBO_DUEL_HERO_SKILL", L_Const.GameTplType.list_int)
  for i, v in pairs(skillList) do
    local name = _skillTpl:getName(_skillTpl:getTplById(v))
    list[i] = {
      id = v,
      name = v .. "_" .. name
    }
  end
  return list
end

function this:getPlayerSkillList()
  local list = {}
  local data = L_KiboDuelSimulatorStore:getData().playerInfo[1].skillList
  for i, v in pairs(data) do
    local name = _skillTpl:getName(_skillTpl:getTplById(v))
    list[v] = {
      id = v,
      name = v .. "_" .. name
    }
  end
  return list
end

function this:getEnemySkillList()
  local list = {}
  local data = L_KiboDuelSimulatorStore:getData().playerInfo[2].skillList
  for i, v in pairs(data) do
    local name = _skillTpl:getName(_skillTpl:getTplById(v))
    list[v] = {
      id = v,
      name = v .. "_" .. name
    }
  end
  return list
end

function this:getPresetList()
  local list = {}
  local cfgList = _kiboDuelTpl.data
  for i, v in pairs(cfgList) do
    list[i] = {
      id = v.id,
      name = tostring(v.id)
    }
  end
  return list
end

function this:getSaveList()
  return L_KiboDuelSimulatorStore:getNameList()
end

return this
