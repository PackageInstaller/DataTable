local this = {}
local _fishPondTpl = L_GameTpl:getFishPondTpl()
local _fishRodTpl = L_GameTpl:getFishRodTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local ROD_LOAD_TYPE = CS.Lens.Gameplay.Modules.BigWorld.EL2CType.AddWeapon
local moduleBattleEffectUpdateName = "fishingManager.update"
local Timeline_Design_Rotation = 183.527

function this:getFishingInteractiveEntity(pointId)
  local tpl = _fishPondTpl:getTplById(pointId)
  local worldObjId = _fishPondTpl:getInteractiveObject(tpl)
  local fishEntity = AzurWorld.WorldMapMgr:TryGetEntity(worldObjId)
  return fishEntity
end

function this:getFishPondEntity(pointId)
  local tpl = _fishPondTpl:getTplById(pointId)
  local worldObjId = _fishPondTpl:getWorldMapObjId(tpl)
  local fishEntity = AzurWorld.WorldMapMgr:TryGetEntity(worldObjId)
  return fishEntity
end

function this:reqFishing(isToFishing, pointId)
  if self.isCloseing == true and not isToFishing then
    return
  end
  self.isCloseing = not isToFishing
  self._pointId = pointId
  local callback = isToFishing and function()
    self:switchToFishingMode()
  end or function()
    self:switchOutFishingMode()
  end
  AzurWorld.fishingMgr:EnterOrLeaveFishing(isToFishing, callback)
end

function this:switchToFishingMode()
  self.runTimeData = require("ui.manager.fishing.fishingRuntimeData").new(self._pointId)
  
  local function endDo()
    self:resetPlayerPos()
    local mainControlEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
    local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), mainControlEntity.transform.gameObject)
    if biologyData then
      biologyData.CameraFade = 1
      self.tempBigWorldCameraFade = biologyData.CameraFade
    else
    end
    self:setPlayerLookAtFish(self.runTimeData.fishPointId, mainControlEntity)
    self:setFishingTimeline()
    self:loadRod()
    self:switchToFishingState(L_FishingConst.State.Idle)
    L_UI:open("pageFishing", {
      pointId = self.runTimeData.fishPointId
    })
  end
  
  local fishEntity = self:getFishingInteractiveEntity(self.runTimeData.fishPointId)
  self:setFishingInteractiveObjActive(false)
  AzurWorld.fishingMgr.fishingInteractiveEntityId = fishEntity.data.entityId
  AzurWorld.fishingMgr.heroConfigId = _heroTpl:getFishHero(L_FormationStore:getControl(L_FormationManager:getCurFormationType()))
  AzurWorld.fishingMgr:CreatePlayerUnitAdapter(endDo)
end

function this:switchOutFishingMode()
  if L_CommonUtil.isValid(self.runTimeData.loopAudio) then
    C_AudioManager.FreeSource(self.runTimeData.loopAudio)
    self.runTimeData.loopAudio = nil
  end
  self:setFishingInteractiveObjActive(true)
  self:exitFishing()
  L_UI:backToRoot()
  if L_CommonUtil.isValid(AzurWorld.playerMgr.myPlayerUnitAdapter) then
    AzurWorld.playerMgr.myPlayerUnitAdapter.pause = false
  end
  AzurWorld.fishingMgr:DisposePlayerUnitAdapter()
  if L_CommonUtil.isValid(AzurWorld.playerMgr.myPlayerUnitAdapter) then
    AzurWorld.playerMgr.myPlayerUnitAdapter:ResumePlayerUnit(nil, true)
  end
  local mainControlEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  local biologyData = mainControlEntity and L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), mainControlEntity.transform.gameObject)
  if biologyData then
    biologyData.CameraFade = self.tempBigWorldCameraFade and self.tempBigWorldCameraFade or 1
  else
  end
end

function this:switchToFishingState(state, callback)
  local isDelayAni = false
  if state == L_FishingConst.State.Idle then
    self:setFishShadowActive(true)
    self:unLoadFishWire()
    self:resetPlayerPos()
    self:resetEffectRoot()
  elseif state == L_FishingConst.State.Start then
    L_TimerManager:newOrResetTimer(self, "start_fish_wire", function()
      self:loadOrOpenFishingEffect(L_FishingConst.EffectName.FloatIntoWater)
      self:loadFishWire()
      self:setFishShadowActive(false)
    end, 0.9)
  elseif state == L_FishingConst.State.Wait then
    self:loadOrOpenFishingEffect(L_FishingConst.EffectName.Float)
    self:playFloatAni(L_FishingConst.FloatAniName.Idle)
    self:loadOrOpenFishingEffect(L_FishingConst.EffectName.Wait)
  elseif state == L_FishingConst.State.Loop then
    isDelayAni = true
    self:closeFishingEffect(L_FishingConst.EffectName.Wait)
    self:loadOrOpenFishingEffect(L_FishingConst.EffectName.Bite)
    L_TimerManager:newOrResetTimer(self, L_FishingConst.EffectName.Bite, function()
      self:playFishingAni(L_FishingConst.StateAniName[state], callback)
      self:openSlideFishWire(true)
      self:loadOrOpenFishingEffect(L_FishingConst.EffectName.Game)
      self:playFloatAni(L_FishingConst.FloatAniName.Game)
      self.runTimeData.loopAudio = C_AudioManager.Play("Play_SFX_System_Fishing_Pulling")
    end, 1)
  elseif state == L_FishingConst.State.Cancel then
    self:unLoadFishWire()
    self:loadOrOpenFishingEffect(L_FishingConst.EffectName.FloatIntoWaterCancel)
    self:closeFishingEffect(L_FishingConst.EffectName.Wait)
    self:playFloatAni(L_FishingConst.FloatAniName.FloatIntoWaterCancel)
    L_TimerManager:newOrResetTimer(self, "reset_float_ani", function()
      self:closeFishingEffect(L_FishingConst.EffectName.Float)
    end, 0.25)
  elseif state == L_FishingConst.State.Lost then
    self:unLoadFishWire()
    self:closeFishingEffect(L_FishingConst.EffectName.Game)
    self:closeFishingEffect(L_FishingConst.EffectName.Float)
  end
  if not string.isEmpty(L_FishingConst.StateAniName[state]) and not isDelayAni then
    self:playFishingAni(L_FishingConst.StateAniName[state], callback)
  end
  if not string.isEmpty(L_FishingConst.StateSoundName[state]) then
    C_AudioManager.Play(L_FishingConst.StateSoundName[state])
  end
end

function this:exitFishing()
  L_TimerManager:clearTimer(self)
  self:unLoadFishWire()
  if self.runTimeData then
    if self.runTimeData.timeLineObj then
      self.runTimeData.timeLineObj:dispose()
      self.runTimeData.timeLineObj = nil
    end
    if self.runTimeData.pondEffectRoot then
      Unity.GameObject.DestroyImmediate(self.runTimeData.pondEffectRoot)
    end
  end
  self:setFishingInteractiveObjActive(true)
  self:exitFishingTimeline()
  self.runTimeData = nil
end

function this:changeGameDir(dir)
  self.runTimeData.fishDirection = dir
  self.runTimeData.curFishStartPoint = L_Vector3.getPos(self.runTimeData.pondEffectRoot.transform)
  self.runTimeData.fishMoveTimeFrame = 0
  if L_CommonUtil.isValid(self.runTimeData.loopAudio) then
    C_AudioManager.FreeSource(self.runTimeData.loopAudio)
    self.runTimeData.loopAudio = nil
  end
  self.runTimeData.loopAudio = C_AudioManager.Play("Play_SFX_System_Fishing_Pulling")
  self:playFishingAni(L_FishingConst.FishMoveAniName[dir], nil, 0.3)
end

function this:playFishingAni(aniName, callback, durTime, speed)
  durTime = durTime or 0.1
  speed = speed or 1
  local heroEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  local animator = heroEntity.entity.data.animator
  heroEntity.entity:CrossFade(aniName, durTime)
  heroEntity.entity.data.animator.speed = speed
  if callback then
    local aniState = animator:GetState(aniName)
    L_TimerManager:newOrResetTimer(self, "fish_ani_callback", callback, aniState.length / speed)
  end
end

function this:replaceRodMod()
  if not self.runTimeData or not self.runTimeData.fishPointId then
    return
  end
  local fishRodId = L_FishingStore:getCurRodId()
  local item = L_ItemManager:parseCommonItem(fishRodId)
  local newWeaponId = _fishRodTpl:getWeaponId(_fishRodTpl:getTplById(item.subId))
  if newWeaponId ~= self.runTimeData.rodId then
    self:unloadRod()
    self:loadRod()
  end
end

function this:loadRod()
  local fishRodId = L_FishingStore:getCurRodId()
  local item = L_ItemManager:parseCommonItem(fishRodId)
  self.runTimeData.rodId = _fishRodTpl:getWeaponId(_fishRodTpl:getTplById(item.subId))
  local args = CS.Lens.Gameplay.Modules.BigWorld.WeaponSwitchArgs()
  args.weaponId = self.runTimeData.rodId
  args.add = true
  
  function args.callback(mod)
    self.runTimeData.rodObj = mod.transform.gameObject
    self.runTimeData.fishWireNode = mod:GetTransByName("FishingLine_R")
  end
  
  AzurWorld.playerMgr.myPlayerUnit:DispatchEventL2C(ROD_LOAD_TYPE, args)
end

function this:unloadRod()
  local args = CS.Lens.Gameplay.Modules.BigWorld.WeaponSwitchArgs()
  args.weaponId = self.runTimeData.rodId
  args.add = false
  AzurWorld.playerMgr.myPlayerUnit:DispatchEventL2C(ROD_LOAD_TYPE, args)
end

function this:loadFishWire()
  self:unLoadFishWire()
  local path = "Program/Fishing/pre_fishing_wire.prefab"
  self.runTimeData.fishWireObj = L_ResPool:syncGameObject(path)
  if self.runTimeData.fishWireObj == nil then
    printf("fishing", "load fish wire failed")
    return
  end
  self.runTimeData.fishWireObj.transform:SetParent(self.runTimeData.fishWireNode.transform)
  self.runTimeData.fishWireLineRender = self.runTimeData.fishWireObj:PickComponent(typeof(Unity.LineRenderer))
  self.runTimeData.fishWireLineRender.startWidth = 0.007
  self.runTimeData.fishWireLineRender.endWidth = 0.005
  L_Vector3.setLocalPos(self.runTimeData.fishWireObj.transform, L_Vector3.zero)
  self:openSlideFishWire(false)
end

function this:unLoadFishWire()
  if not self.runTimeData.fishWireObj then
    return
  end
  if self.runTimeData.fishWireUpdateHandler then
    C_UpdateSource.RemoveUpdateEventHandler(self.runTimeData.fishWireUpdateHandler)
    self.runTimeData.fishWireUpdateHandler = nil
  end
  Unity.GameObject.DestroyImmediate(self.runTimeData.fishWireObj)
  self.runTimeData.fishWireObj = nil
  self.runTimeData.fishWireLineRender = nil
end

function this:openSlideFishWire(isFishingLoop)
  self.runTimeData.isFishingLoop = isFishingLoop
  if self.runTimeData.fishWireUpdateHandler then
    return
  end
  self.runTimeData.curFishStartPoint = self.runTimeData.fishDirectionPoint[self.runTimeData.fishDirection]
  
  function self.runTimeData.fishWireUpdateHandler()
    if not self.runTimeData.fishWireNode then
      return
    end
    local pos = C_Vector3.Lerp(self.runTimeData.curFishStartPoint, self.runTimeData.fishDirectionPoint[self.runTimeData.fishDirection], self.runTimeData.fishMoveTimeFrame / 6)
    self.runTimeData.fishMoveTimeFrame = self.runTimeData.fishMoveTimeFrame + 1
    L_Vector3.setPos(self.runTimeData.pondEffectRoot.transform, pos)
    self.runTimeData.fishWireLineRender = self.runTimeData.fishWireLineRender or self.fishWireObj:PickComponent(typeof(Unity.LineRenderer))
    self.runTimeData.fishWireLineRender:SetPosition(0, L_Vector3.getPos(self.runTimeData.fishWireNode.transform))
    self.runTimeData.fishWireLineRender:SetPosition(1, pos)
  end
  
  C_UpdateSource.AddUpdateEventHandler(self.runTimeData.fishWireUpdateHandler, moduleBattleEffectUpdateName)
end

function this:setPlayerLookAtFish(pointId, heroEntity)
  local fishEntity = self:getFishPondEntity(pointId)
  local transform = heroEntity.transform:GetRawTransform()
  local target = fishEntity.transform
  local dir = target.transform.position - transform.position
  local lookRot = C_Quaternion.LookRotation(dir, CS.UnityEngine.Vector3.up)
  local currentEuler = target.eulerAngles
  local newEuler = CS.UnityEngine.Vector3(currentEuler.x, lookRot.eulerAngles.y, lookRot.eulerAngles.z)
  transform.rotation = C_Quaternion.Euler(newEuler)
end

function this:getFishPondRotation()
  local fishEntity = self:getFishPondEntity(self.runTimeData.fishPointId)
  local pos = fishEntity.transform:GetRawTransform().position
  local heroPos = L_PlayerManager:getMainControlEntityPos()
  local direction = pos - heroPos
  local angle = C_Quaternion.LookRotation(direction).eulerAngles
  return angle
end

function this:getFishPondRotationOffset()
  local angel = self:getFishPondRotation().y - Timeline_Design_Rotation
  return angel
end

function this:resetPlayerPos()
  local interEntity = self:getFishingInteractiveEntity(self.runTimeData.fishPointId)
  local pos = interEntity.transform:GetRawTransform().position
  local heroEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  heroEntity.entity:SafeSetPosition(pos)
  self:setPlayerLookAtFish(self.runTimeData.fishPointId, heroEntity)
end

function this:setFishingInteractiveObjActive(active)
  local fishEntity = self:getFishingInteractiveEntity(self.runTimeData.fishPointId)
  if fishEntity ~= nil then
    fishEntity.transform.gameObject:ActiveTrans(active)
  end
end

function this:setFishShadowActive(active)
  if not self.runTimeData.fishShadowObj then
    local fishEntity = self:getFishPondEntity(self.runTimeData.fishPointId)
    self.runTimeData.fishShadowObj = L_GameUtil.findTranByName(fishEntity.transform.gameObject, "Low").gameObject
  end
  self.runTimeData.fishShadowObj:ActiveTrans(active)
end

function this:setFishingSuccessTimeline(endDo, callback)
  self:closeFishingEffect(L_FishingConst.EffectName.Game)
  self:closeFishingEffect(L_FishingConst.EffectName.Float)
  if self.runTimeData.timeLineObj ~= nil then
    return
  end
  local _, sizeType = _heroTpl:getFishHero(L_FormationStore:getControl(L_FormationManager:getCurFormationType()))
  if self.runTimeData.timeLineObj == nil then
    self.runTimeData.timeLineObj = require("ui.manager.timeline.commonTimelinePrefabHandle").new()
    
    function self.runTimeData.timeLineObj.getRealActorEntityHandle(remarkName, actorName)
    end
    
    function self.runTimeData.timeLineObj.timelineLoadedHandle()
      self.runTimeData.timeLineObj:setPosition(L_PlayerManager:getMainControlEntityPos())
      self.runTimeData.timeLineObj:setRotation(L_Vector3.new(0, self:getFishPondRotationOffset(), 0))
      local assetPath = string.format("Fishing/pre_fishing_success_%s", sizeType)
      self.runTimeData.timeLineObj:playTimelineAsset(assetPath)
      local floatLocNode = self.runTimeData.timeLineObj:getTimelineActor("float_loc")
      if floatLocNode ~= nil then
        local fishEntity = self:getFishPondEntity(self.runTimeData.fishPointId)
        local pos = fishEntity.transform:GetRawTransform().position
        L_Vector3.setRelativePos(floatLocNode.parent, pos)
      end
    end
    
    function self.runTimeData.timeLineObj.timelinePlayedHandle()
    end
    
    function self.runTimeData.timeLineObj.timelineStopHandle()
      self.runTimeData.timeLineObj:dispose()
      self.runTimeData.timeLineObj = nil
      if callback then
        callback()
      end
      self:resetRod()
    end
    
    function self.runTimeData.timeLineObj.timelineCustomEventHandle()
      endDo()
    end
  end
  local prefabPath = string.format("Fishing/pre_fishing_success_%s", sizeType)
  self.runTimeData.timeLineObj:loadTimelinePrefab(prefabPath)
  self:playFishingAni(L_FishingConst.StateAniName[L_FishingConst.State.Success], nil, 0.1, 1)
end

function this:setFishingTimeline()
  if self.runTimeData.startTimeLineObj ~= nil then
    return
  end
  local _, sizeType = _heroTpl:getFishHero(L_FormationStore:getControl(L_FormationManager:getCurFormationType()))
  if self.runTimeData.startTimeLineObj == nil then
    self.runTimeData.startTimeLineObj = require("ui.manager.timeline.commonTimelinePrefabHandle").new()
    
    function self.runTimeData.startTimeLineObj.getRealActorEntityHandle(remarkName, actorName)
    end
    
    function self.runTimeData.startTimeLineObj.timelineLoadedHandle()
      self.runTimeData.startTimeLineObj:setPosition(L_PlayerManager:getMainControlEntityPos())
      self.runTimeData.startTimeLineObj:setRotation(L_Vector3.new(0, self:getFishPondRotationOffset(), 0))
      local assetPath = string.format("FishingCam/pre_fishing_success_cam_%s", sizeType)
      self.runTimeData.startTimeLineObj:playTimelineAsset(assetPath)
    end
    
    function self.runTimeData.startTimeLineObj.timelinePlayedHandle()
    end
    
    function self.runTimeData.startTimeLineObj.timelineStopHandle()
      self.runTimeData.startTimeLineObj:dispose()
      self.runTimeData.startTimeLineObj = nil
    end
    
    function self.runTimeData.startTimeLineObj.timelineCustomEventHandle()
    end
  end
  local prefabPath = string.format("FishingCam/pre_fishing_success_cam_%s", sizeType, sizeType)
  self.runTimeData.startTimeLineObj:loadTimelinePrefab(prefabPath)
  self:playFishingAni(L_FishingConst.StateAniName[L_FishingConst.State.Success], nil, 0.1, 1)
end

function this:exitFishingTimeline()
  if self.runTimeData.startTimeLineObj == nil then
    return
  end
  self.runTimeData.startTimeLineObj:dispose()
  self.runTimeData.startTimeLineObj = nil
end

function this:loadOrOpenFishingEffect(name)
  local fishEntity = self:getFishPondEntity(self.runTimeData.fishPointId)
  if not self.runTimeData.pondEffectRoot then
    self.runTimeData.pondEffectRoot = C_GameObject("effectRoot")
    self.runTimeData.pondEffectRoot.transform:SetParent(fishEntity.transform:GetRawTransform())
    L_Vector3.setLocalPos(self.runTimeData.pondEffectRoot.transform, L_Vector3.zero)
    L_Vector3.setLocalRot(self.runTimeData.pondEffectRoot.transform, L_Vector3.zero)
    self:setFishMoveDirPoint()
  end
  local effectGo = self.runTimeData.pondEffectMap[name]
  if effectGo then
    L_Vector3.setLocalPos(effectGo.transform, L_Vector3.zero)
    effectGo:ActiveTrans(false)
    effectGo:ActiveTrans(true)
  else
    local path = string.format("Effect/World/%s.prefab", name)
    local go = L_ResPool:syncGameObject(path)
    go.transform:SetParent(self.runTimeData.pondEffectRoot.transform)
    L_Vector3.setLocalPos(go.transform, L_Vector3.zero)
    self.runTimeData.pondEffectMap[name] = go
  end
end

function this:closeFishingEffect(name)
  local effectGo = self.runTimeData.pondEffectMap[name]
  if effectGo then
    effectGo:ActiveTrans(false)
  end
end

function this:playFloatAni(name)
  if not self.runTimeData.floatAnimator then
    local floatEffectObj = self.runTimeData.pondEffectMap[L_FishingConst.EffectName.Float]
    self.runTimeData.floatAnimator = floatEffectObj:GetComponent(typeof(C_CsAnimator))
  end
  self.runTimeData.floatAnimator:Play(name)
end

function this:resetRod()
  self.runTimeData.rodObj:ActiveTrans(false)
  self.runTimeData.rodObj:ActiveTrans(true)
end

function this:resetEffectRoot()
  if self.runTimeData.pondEffectRoot then
    L_Vector3.setLocalPos(self.runTimeData.pondEffectRoot.transform, L_Vector3.zero)
    self.runTimeData.fishDirection = L_FishingConst.FishMoveDir.Center
    self.runTimeData.curFishStartPoint = L_Vector3.getPos(self.runTimeData.pondEffectRoot.transform)
    self.runTimeData.fishMoveTimeFrame = 0
  end
end

function this:setFishMoveDirPoint()
  local fishEntity = self:getFishPondEntity(self.runTimeData.fishPointId)
  local fishPos = L_Vector3.getPos(fishEntity.transform:GetRawTransform())
  local heroEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  local heroTrans = heroEntity.transform:GetRawTransform()
  self.runTimeData.fishDirectionPoint[L_FishingConst.FishMoveDir.Center] = fishPos
  self.runTimeData.fishDirectionPoint[L_FishingConst.FishMoveDir.Front] = fishPos + L_Vector3.getForward(heroTrans) * 0.5
  self.runTimeData.fishDirectionPoint[L_FishingConst.FishMoveDir.Back] = fishPos + L_Vector3.getForward(heroTrans) * -0.5
  self.runTimeData.fishDirectionPoint[L_FishingConst.FishMoveDir.Right] = fishPos + L_Vector3.getRight(heroTrans) * -0.5
  self.runTimeData.fishDirectionPoint[L_FishingConst.FishMoveDir.Left] = fishPos + L_Vector3.getRight(heroTrans) * 0.5
end

return this
