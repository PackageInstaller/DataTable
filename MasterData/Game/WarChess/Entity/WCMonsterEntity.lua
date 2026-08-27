local WCMonsterEntity = class("WCMonsterEntity")
local cs_ResLoader = CS.ResLoader
local cs_GameObject = CS.UnityEngine.GameObject
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local rotae = WarChessHelper.rotateValue[eWarChessEnum.eGridToward.down]
local TEAM_MOVE_SPEED_PER_SECOND = 1.8
local ROTATE_COST_TIME = 0.2

function WCMonsterEntity:ctor(entityData)
  self.__parentGo = nil
  self.resloader = nil
  self.entityData = entityData
  self.monsterGo = nil
  self.animator = nil
end

function WCMonsterEntity:PreLoadModel(notWait, bind)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.monsterGo ~= nil then
    DestroyUnityObject(self.monsterGo)
    self.monsterGo = nil
  end
  if not IsNull(self.__parentGo) then
    DestroyUnityObject(self.__parentGo)
    self.__parentGo = nil
  end
  local go = cs_GameObject()
  self.__parentGo = go
  local creatLogicPos = self.entityData:GetEntityLogicPos()
  if creatLogicPos ~= nil then
    local pos = Vector3.New(creatLogicPos.x, 0, creatLogicPos.y)
    self:WCEntitySetPos(pos)
  end
  local resName, specSign = self.entityData:GetResModelName()
  local modelPath = PathConsts:GetCharacterModelPathEx(resName, specSign)
  self.resloader = cs_ResLoader.Create()
  if notWait then
    self.__prefab = self.resloader:LoadABAsset(modelPath)
    self:RealLoadModel(bind)
    return
  end
  local areaAwait = self.resloader:LoadABAssetAsyncAwait(modelPath, function(prefab)
    self.__prefab = prefab
  end)
  return areaAwait, BindCallback(self, self.RealLoadModel)
end

function WCMonsterEntity:RealLoadModel(bind)
  local creatLogicPos = self.entityData:GetEntityLogicPos()
  local parentName = "Entity:" .. tostring(creatLogicPos.x) .. "," .. tostring(creatLogicPos.y)
  if IsNull(self.__parentGo) then
    self.__parentGo = cs_GameObject()
  end
  self.__parentGo.name = parentName
  self.__parentGo.transform:SetParent(bind.entityRoot)
  self.__parentGo.transform:Rotate(rotae)
  if self.__prefab ~= nil then
    self.monsterGo = self.__prefab:Instantiate(self.__parentGo.transform)
    self:WCntitySetRotate(self.entityData:GetEntityRandonRotate())
    self.animator = self.monsterGo:FindComponent(eUnityComponentID.Animator)
    self.animator:SetBool("IsBattle", true)
    if creatLogicPos ~= nil then
      local pos = Vector3.New(creatLogicPos.x, 0, creatLogicPos.y)
      self:WCEntitySetPos(pos)
    end
    local haveOutLine, colorCfg, hdr, wider, scale = self.entityData:GetMonsterMatConfig()
    if haveOutLine then
      local mat = self.monsterGo:GetComponentInChildren(typeof(CS.UnityEngine.SkinnedMeshRenderer)).material
      local color = Color.New(colorCfg[1], colorCfg[2], colorCfg[3])
      color = color * (hdr / 100)
      mat:SetColor("_OutlineColor", color)
      mat:SetFloat("_OutlineWidth", wider / 100)
      mat:SetFloat("_OutlineScale", scale / 1000)
    end
  end
  self.__prefab = nil
  self.__realLoadModel = nil
end

function WCMonsterEntity:GetWCEntityMoverOverCallback(moveOverCallback)
  self.moveOverCallback = moveOverCallback
end

function WCMonsterEntity:WCEntitySetPos(pos, playAnim, oldLogicPos, logicPos)
  if not playAnim then
    self.__parentGo.transform.position = pos
    if self.moveOverCallback ~= nil then
      self.moveOverCallback()
      self.moveOverCallback = nil
    end
  else
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    local startGrid = wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, oldLogicPos)
    local gridData = wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, logicPos)
    local isOK, pathList = WarChessHelper.AStrarPathFind(wcCtrl.mapCtrl, startGrid, gridData, true, self.entityData)
    if not isOK then
      self.__parentGo.transform.position = pos
      if self.moveOverCallback ~= nil then
        self.moveOverCallback()
        self.moveOverCallback = nil
      end
      return
    end
    self.animator:SetBool("BattleRun", true)
    local index = #pathList
    local targetRotate
    local rotatePassedTime = 0
    local needCalRotate = true
    
    local function MoveEntity_Update()
      local deltaTime = Time.deltaTime
      local maxMoveDis = TEAM_MOVE_SPEED_PER_SECOND * deltaTime
      local targeGrid = pathList[index]
      local targeShowPos = targeGrid:GetGridShowPos()
      local entityCurPos = self:WCEntityGetShowPos()
      if IsNull(self.__parentGo) then
        wcCtrl.wcCamCtrl:WcCamCustomFollow(nil)
        if self.moveOverCallback ~= nil then
          self.moveOverCallback()
          self.moveOverCallback = nil
        end
        return true
      end
      local pos = WarChessHelper.Vector3MoveToward(entityCurPos, targeShowPos, maxMoveDis)
      self.__parentGo.transform.position = pos
      if needCalRotate then
        local moveToward = Vector3.Normalize(targeShowPos - entityCurPos)
        if self:WCEntityGetForward() ~= moveToward then
          local mag = moveToward:Magnitude()
          if 0 < mag then
            local newRotate = Quaternion.LookRotation(moveToward, Vector3.up)
            targetRotate = newRotate
          end
          rotatePassedTime = 0
        end
        needCalRotate = false
      end
      if targetRotate ~= nil then
        rotatePassedTime = rotatePassedTime + deltaTime
        local rate = rotatePassedTime / ROTATE_COST_TIME
        local curRotate = self:WCEntityGetRotate()
        local rotate = Quaternion.Slerp(curRotate, targetRotate, rate)
        self:WCntitySetRotate(rotate)
        if 1 <= rate then
          targetRotate = nil
        end
      end
      MsgCenter:Broadcast(eMsgEventId.WC_EntityInfoUpdate, self.entityData)
      if pos == targeShowPos then
        index = index - 1
        needCalRotate = true
      end
      if index == 0 then
        wcCtrl.wcCamCtrl:WcCamCustomFollow(nil)
        self.animator:SetBool("BattleRun", false)
        if self.moveOverCallback ~= nil then
          self.moveOverCallback()
          self.moveOverCallback = nil
        end
        return true
      end
      return false
    end
    
    if wcCtrl.state == eWarChessEnum.eWarChessState.play then
      do
        local entityId = self.entityData:GetEntityUnitId()
        wcCtrl.curState:WCAddMonsterMove(entityId, MoveEntity_Update)
      end
    end
  end
end

function WCMonsterEntity:WCEntityGetParentGO()
  return self.__parentGo
end

function WCMonsterEntity:WCEntityGetShowPos()
  if IsNull(self.__parentGo) then
    error("enity not load or not exist")
    return nil
  end
  return self.__parentGo.transform.position
end

function WCMonsterEntity:WCEntityGetForward()
  local forward = self.__parentGo.transform.forward
  return Vector3.New(forward.x, forward.y, forward.z)
end

function WCMonsterEntity:WCEntityGetRotate()
  return self.__parentGo.transform.localRotation
end

function WCMonsterEntity:WCntitySetRotate(rotate)
  if rotate == nil then
    return
  end
  self.__parentGo.transform.localRotation = rotate
end

function WCMonsterEntity:PlayWCMonsterAnimation(animaId, trigger, callback)
  if animaId == -1 and not IsNull(self.monsterGo) then
    self.animator:SetTrigger("BattleDie")
    self.monsterGo.transform:DOLocalMoveY(-1, 1):SetDelay(0.5):OnComplete(function()
      if callback ~= nil then
        callback()
      end
      self:Delete()
    end):SetLink(self.monsterGo)
  end
end

function WCMonsterEntity:PlayAttackAnimation(targetPos, playSpeedRate)
  self.monsterGo.transform:DOLookAt(targetPos, 0.1):SetLink(self.monsterGo)
  self.__oldSpeed = self.animator.speed
  self.animator.speed = playSpeedRate
  self.animator:CrossFadeInFixedTime("battle_skill_attack1", 0.1)
end

function WCMonsterEntity:EndPlayAttackAnimation()
  self.animator.speed = self.__oldSpeed
end

function WCMonsterEntity:GetGameObject()
  return self.monsterGo
end

function WCMonsterEntity:Show()
  self.__parentGo:SetActive(true)
end

function WCMonsterEntity:Hide()
  self.__parentGo:SetActive(false)
end

function WCMonsterEntity:EntityOnSceneUnload()
end

function WCMonsterEntity:Delete()
  self:EntityOnSceneUnload()
  DestroyUnityObject(self.__parentGo)
  self.__parentGo = nil
  self.monsterGo = nil
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return WCMonsterEntity
