local this = class("moduleMainCitySkill", G_UIModuleBase)
local _petInfoTpl = L_GameTpl:getPetTpl()
local petPuzzleViewColors = {
  [L_Const.petPuzzleType.guang] = {
    ring = "#FFD274",
    press = "#EFC161",
    glow = "#EFC161"
  },
  [L_Const.petPuzzleType.di] = {
    ring = "#D0FFD1",
    press = "#FFE78F",
    glow = "#D7B44A"
  },
  [L_Const.petPuzzleType.huo] = {
    ring = "#FF9587",
    press = "#FF7963",
    glow = "#F34749"
  },
  [L_Const.petPuzzleType.shui] = {
    ring = "#83D8FF",
    press = "#4BC6FF",
    glow = "#40ABD8"
  },
  [L_Const.petPuzzleType.mu] = {
    ring = "#D0FFD1",
    press = "#82DB84",
    glow = "#59BE5C"
  }
}
local petPuzzleViewImgs = {
  [L_Const.petPuzzleType.guang] = "UI/Icon/BuffS/tex_battle_icon_guang.png",
  [L_Const.petPuzzleType.di] = "UI/Icon/BuffS/tex_battle_icon_di.png",
  [L_Const.petPuzzleType.huo] = "UI/Icon/BuffS/tex_battle_icon_huo.png",
  [L_Const.petPuzzleType.shui] = "UI/Icon/BuffS/tex_battle_icon_shui.png",
  [L_Const.petPuzzleType.mu] = "UI/Icon/BuffS/tex_battle_icon_mu.png"
}
local petStateType = {
  None = 0,
  Puzzle = 1,
  SkillOlny = 2
}

function this.bind()
  return {
    modulePetSkill = {
      moduleName = "pages/main/cellMainCitySkill"
    },
    modulePetSkillMove = {
      moduleName = "pages/main/cellMainCitySkill"
    },
    moveNode = L_Vector3.new(0, 0, 0),
    playAni = "",
    goContent = true
  }
end

function this.methods()
  return {
    modulePetSkill = {
      onClick_skill = function(self)
        self:tryPetPuzzle()
      end
    },
    modulePetSkillMove = {
      onClick_skill = function(self)
        self:tryPetPuzzle()
      end
    }
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open(...)
  this.super.open(self, ...)
  L_BattleManager:addListener(L_BattleManager.event.battleEnter, self.onEvent_BattleStart, self)
  self.onEvent_PlayerCommandHandle = self.onEvent_PlayerCommandHandle or handler(self, self.onEvent_PlayerCommand)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.onEvent_setMainControlHandle, self)
  self.spNodeDo = false
  self.petPuzzleMap = {}
  self.targetPuzzleData = nil
  self.curPuzzleData = nil
  self.yiEffectId = nil
  self.petPuzzleState = L_Const.petPuzzleState.None
  self.petPuzzleType = nil
  self.bind.goContent = true
  self.lastShowPuzzleEntity = nil
  self.lastActiveState = false
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "moduleMainCitySkill.update")
end

function this:show(...)
  this.super.show(self, ...)
end

function this:registerShortCut()
end

function this:onEvent_setMainControlHandle()
  self.csEntityEnter = false
end

function this:onEvent_PlayerCommand(eventType, param)
  if eventType ~= C_EBoardCastEventType.PlayerCommandSkillTake then
    return
  end
  self:usePetSkill()
  self.csEntityEnter = false
  local csEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  csEntity.handler.boardCastEventHandler:Remove(self.onEvent_PlayerCommandHandle)
end

function this:usePetSkill()
  if self.targetPuzzleData ~= nil then
  end
  local petCsEntity = AzurWorld.playerMgr.myPlayerData:GetPetEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex)
  if petCsEntity == nil then
    return
  end
  local petState = petCsEntity.data.petState
  if petState ~= petStateType.None then
    return
  end
  local success = self:tryPetPuzzle()
  if not success then
    petCsEntity.data:SetPetState(petStateType.SkillOlny)
  end
end

function this:tryPetPuzzle()
  if self.targetPuzzleData == nil then
    printf("petPuzzle", "tryPetPuzzle dont have targetPuzzleData")
    return false
  end
  if self.curPuzzleData ~= nil then
    printf("petPuzzle", "tryPetPuzzle have puzzledata：", self.curPuzzleData)
    return false
  end
  local petCanPuzzleSuccess = self:checkCurPetCanPuzzleSuccess()
  if not petCanPuzzleSuccess then
    return false
  end
  return true
end

function this:checkCurPetCanPuzzleSuccess()
  local petCanPuzzleSuccess = false
  if self.targetPuzzleData == nil then
    return false
  end
  local hero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if not hero then
    return false
  end
  local petItem = L_PetStore:getPetItem(L_HeroStore:getHeroPetGuid(L_HeroStore:getHero(hero.data.UUID)))
  local petId = petItem and petItem.id or nil
  if petId then
    local tpl = _petInfoTpl:getTplById(petId)
    if tpl then
      local puzzleType = _petInfoTpl:getPuzzleType(tpl)
      if puzzleType then
        for i, v in pairs(self.targetPuzzleData.puzzleAttrs or {}) do
          for ai, av in pairs(puzzleType) do
            if av == v then
              petCanPuzzleSuccess = true
              break
            end
          end
        end
      end
    end
  end
  return petCanPuzzleSuccess
end

function this:refreshBtnState(curState, nextState)
  L_TimerManager:stopTimer(self, "puzzleAni")
  if nextState == L_Const.petPuzzleState.None then
    if curState == L_Const.petPuzzleState.Puzzling then
      L_TimerManager:newOrResetTimer(self, "puzzleAni", function()
      end, 0.767)
    elseif curState == L_Const.petPuzzleState.WaitPuzzle then
      L_TimerManager:newOrResetTimer(self, "puzzleAni", function()
      end, 0.267)
    end
  elseif nextState == L_Const.petPuzzleState.Puzzling then
    if curState == L_Const.petPuzzleState.None then
    end
  elseif nextState ~= L_Const.petPuzzleState.WaitPuzzle or curState == L_Const.petPuzzleState.None then
  elseif curState == L_Const.petPuzzleState.Puzzling then
  end
end

function this:getEntityCanPuzzle(entityId)
  local data = self.petPuzzleMap[entityId]
  if data == nil then
    return false
  end
  return data.canPuzzle
end

function this:getPetPuzzleData(entityId)
  return self.petPuzzleMap[entityId]
end

function this:updatePetPuzzleDataByPriority()
  local oldId = self.targetPuzzleData and self.targetPuzzleData.entityId
  if self.petPuzzleMap[oldId] and self.petPuzzleMap[oldId].canPuzzle then
    return oldId
  end
  local newId
  for i, v in pairs(self.petPuzzleMap) do
    if v.canPuzzle then
      newId = i
      break
    end
  end
  self.targetPuzzleData = self.petPuzzleMap[newId]
  return newId
end

function this:onEvent_BattleStart()
  if AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true) == nil then
    return
  end
  local petCsEntity = AzurWorld.playerMgr.myPlayerData:GetPetEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex)
  if petCsEntity == nil then
    return
  end
  petCsEntity.data:SetPuzzleTargetId(petStateType.None, 0)
end

function this:close()
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  self.curPuzzleData = nil
  self.targetPuzzleData = nil
  self.petPuzzleState = L_Const.petPuzzleState.None
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.onEvent_setMainControlHandle, self)
  L_BattleManager:removeListener(L_BattleManager.event.battleEnter, self.onEvent_BattleStart, self)
end

function this:initPetPuzzleType(puzzleType)
  if self.petPuzzleType == puzzleType then
    return
  end
  self.petPuzzleType = puzzleType
  local colors = petPuzzleViewColors[puzzleType]
  self.modules.modulePetSkill:setImgPet(petPuzzleViewImgs[puzzleType])
  self.modules.modulePetSkillMove:setImgPet(petPuzzleViewImgs[puzzleType])
  if colors then
    self.modules.modulePetSkill:setColorPress(C_LuaUtility.ParseHtmlStringColor(colors.press))
    self.modules.modulePetSkillMove:setColorPress(C_LuaUtility.ParseHtmlStringColor(colors.press))
    local materials = self.bindComponents.MaterialHolder.sharedMaterials
    local ringColor = C_LuaUtility.ParseHtmlStringColor(colors.ring)
    ringColor.a = materials[0]:GetColor("_MainColor").a
    materials[0]:SetColor("_MainColor", ringColor)
    for i = 1, 5 do
      local glowColor = C_LuaUtility.ParseHtmlStringColor(colors.glow)
      glowColor.a = materials[i]:GetColor("_MainColor").a
      materials[i]:SetColor("_MainColor", glowColor)
    end
  end
end

function this:update()
  local mainControlType = AzurWorld.playerMgr.myPlayerData.mainControlType
  if mainControlType == C_EPlayerMainControlType.None then
    return
  end
  if mainControlType ~= C_EPlayerMainControlType.Formation then
    return
  end
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
