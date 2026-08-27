local DormRoleBaseEntity = require("Game.Dorm.Character.Entity.DormRoleBaseEntity")
local DormCharacterEntity = class("DormCharacterEntity", DormRoleBaseEntity)
local DormUtil = require("Game.Dorm.DormUtil")
local DormCharacterAI = require("Game.Dorm.Character.AI.DormCharacterAI")
local DormEnum = require("Game.Dorm.DormEnum")
local DormChecker = require("Game.Dorm.DormChecker")
local cs_ResLoader = CS.ResLoader
local UnBindActiveTime = 30

function DormCharacterEntity:ctor(heroData, worldPos, roomCharCtrl, activeTime)
  self.__loaded = false
  self.heroData = heroData
  self.__initWorldPos = worldPos
  self.x = 0
  self.y = 0
  self.roomCharCtrl = roomCharCtrl
  self.roomData = roomCharCtrl.roomData
  self.roomEntity = roomCharCtrl.roomEntity
  self.isBind = activeTime < 0
  self.__activeTime = activeTime
  self.__isOperate = false
  self.__endUnBindTime = false
  self.__isReadyToInteract = true
  self.__curModleResName = nil
  local aiCfg = ConfigData.dorm_ai[self.heroData.heroCfg.dorm_ai]
  if aiCfg == nil then
    error("hero ai config is null,heroId:" .. tostring(self.heroData.dataId) .. " aiId:" .. tostring(self.heroData.heroCfg.dorm_ai))
    return
  end
  self.aiCtrl = DormCharacterAI.New(aiCfg, self, true)
  if ConfigData.dorm_hero_greet[self.heroData.skinId] ~= nil then
    self.__dormGreetCfg = ConfigData.dorm_hero_greet[self.heroData.skinId]
  else
    self.__dormGreetCfg = ConfigData.dorm_hero_greet[self.heroData.dataId]
  end
end

function DormCharacterEntity:LoadDormCharacter(charholder, action)
  if self.roomEntity == nil then
    return
  end
  self.__resloader = self.roomEntity:GetCharacterResLoader()
  if self.__resloader == nil then
    return
  end
  self.__resloader:LoadABAssetAsync(PathConsts:GetCharacterDormModelPath(self.heroData:GetResModelName()), function(prefab)
    if IsNull(prefab) then
      return
    end
    self.__curModleResName = self.heroData:GetResModelName()
    local go = prefab:Instantiate(charholder)
    self:__InitDormCharacterGo(go)
    if action ~= nil then
      action(self)
    end
  end)
end

function DormCharacterEntity:__InitDormCharacterGo(gameObject)
  self.__loaded = true
  self.gameObject = gameObject
  self.transform = gameObject.transform
  if self.__initWorldPos ~= nil then
    self.transform.position = self.__initWorldPos
  else
    self.transform.position = DormUtil.GetFntUnityCoord(self.x, self.y)
  end
  self.animator = self.gameObject:FindComponent(eUnityComponentID.Animator)
  self.astarCharcter = CS.DormAStarCharacter.Create(self.gameObject)
  self.astarCharcter.speed = self:GetDormMoveSpeed()
  self.astarCharcter:AddAStarComponents(false)
  if ConfigData.buildinConfig.DormStopCollideFeature then
    self.astarCharcter:SetNavMeshCutOnMoveStop(true)
    self.astarCharcter.rvoController.lockWhenNotMoving = true
    self.__OnStartFntInteract = BindCallback(self, self.__StartFntInteract)
    self.__OnStartExitInteract = BindCallback(self, self.__StartExitInteract)
    self.aiCtrl:AddListenerForDormAI(DormEnum.CharacterAIEventId.StartFntInteract, self.__OnStartFntInteract)
    self.aiCtrl:AddListenerForDormAI(DormEnum.CharacterAIEventId.ExitFntInteract, self.__OnStartExitInteract)
  end
  self:GenUnlockDormTalkList()
  self:StartAIBehavior()
end

function DormCharacterEntity:GetRoleName()
  return self.heroData:GetHeroName(true)
end

function DormCharacterEntity:GetDormRoleResName()
  return self.heroData:GetResModelName()
end

function DormCharacterEntity:GetCurModleResName()
  return self.__curModleResName
end

function DormCharacterEntity:IsHaveNewModleRes()
  return self.__curModleResName ~= self.heroData:GetResModelName()
end

function DormCharacterEntity:GetCharAStarComp()
  return self.astarCharcter
end

function DormCharacterEntity:GetBelongRoomEntity()
  return self.roomEntity
end

function DormCharacterEntity:GetDormMoveSpeed()
  return self.heroData:GetDormMoveSpeed()
end

function DormCharacterEntity:StartAIBehavior(fromDoor)
  if self.__getReady then
    self.aiCtrl:AIInterruptCurrState(false)
    if fromDoor then
      self.aiCtrl:RandToRoomOnePoint()
    else
      self.aiCtrl:RandNewAction()
    end
    if not self.isBind then
      self.unbindTimerId = TimerManager:StartTimer(self.__activeTime, self.EndUnBindCharacter, self, true)
    end
    if not self.roomCharCtrl.characterCtrl:IsDormCharacterActive() then
      self:HidePauseCharacter()
    end
  else
    self.__getReady = true
  end
end

function DormCharacterEntity:EndUnBindCharacter()
  self.__endUnBindTime = true
  self.unbindTimerId = nil
end

function DormCharacterEntity:IsDormUnBindTimeout()
  return self.__endUnBindTime
end

function DormCharacterEntity:StartExChangeUnBindChar()
  self.roomCharCtrl:ExchangeUnBindCharacter(self)
end

function DormCharacterEntity:ChangeOtherDormRoom()
  return self.roomCharCtrl:ChangeCharacterToOtherRoom(self)
end

function DormCharacterEntity:SetNewRoomCtrl(roomCharCtrl)
  self.roomCharCtrl = roomCharCtrl
  self.roomData = roomCharCtrl.roomData
  self.roomEntity = roomCharCtrl.roomEntity
end

function DormCharacterEntity:HidePauseCharacter()
  if not self.__loaded then
    return
  end
  self:GetCharAStarComp().isPause = true
  self:GetCharAStarComp().aiPath.enabled = false
  if self._roleConstraint ~= nil then
    self._roleConstraint.enabled = false
  end
  self.__position = self.transform.position
  self.transform.position = DormEnum.DormInvisiblePos
  self.animator.speed = 0
  if self.curTweener ~= nil then
    self.curTweener:Pause()
  end
  if self.operateTimerId ~= nil then
    TimerManager:PauseTimer(self.operateTimerId)
  end
  if self.unbindTimerId ~= nil then
    TimerManager:PauseTimer(self.unbindTimerId)
  end
end

function DormCharacterEntity:ShowResumeCharacter()
  if not self.__loaded then
    return
  end
  if self._roleConstraint ~= nil then
    self._roleConstraint.enabled = true
  end
  if self.__position ~= nil then
    self.transform.position = self.__position
  end
  self.animator.speed = 1
  self:GetCharAStarComp().isPause = false
  self:GetCharAStarComp().aiPath.enabled = true
  if self.curTweener ~= nil then
    self.curTweener:Play()
  end
  if self.operateTimerId ~= nil then
    TimerManager:ResumeTimer(self.operateTimerId)
  end
  if self.unbindTimerId ~= nil then
    TimerManager:ResumeTimer(self.unbindTimerId)
  end
end

function DormCharacterEntity:ResetToDoorCoord()
  local logicX, logicY = self.roomData:GetDoorCoord()
  self:SetLogicPos(logicX, logicY)
end

function DormCharacterEntity:SetCharacterOperateStart()
  self.__isOperate = true
  self:StopCheckAnimator()
  self:DormForceStopMove()
  TimerManager:StopTimer(self.operateTimerId)
  self.aiCtrl:AIInterruptCurrState(false)
  self:AnimatorFloat()
  self:GetCharAStarComp():SetNavMeshCutEnabled(false)
end

function DormCharacterEntity:SetCharacterOperateEnd(interPointEntity)
  self.__isOperate = false
  local isFntInter = false
  if interPointEntity ~= nil then
    local interPointData = interPointEntity:GetInterPointData()
    if interPointData:IsPointFntAniStateReady() then
      isFntInter = true
    else
      CS.MessageCommon.ShowMessageTipsWithErrorSound(interPointData:GetFntPointInteractTips())
    end
  end
  if isFntInter then
    self:ResetAnimatorTrigger()
    self.aiCtrl:StartFntInterPointState(interPointEntity:GetInterPointData(), true)
  else
    self.__isReadyToInteract = false
    local newX, newY = self.roomCharCtrl:FindActivePosNearby(self.x, self.y)
    if self.x ~= nil and self.x ~= nil then
      newX = self.x
      newY = self.y
    end
    local localDestPos = DormUtil.GetFntUnityCoord(newX, newY)
    local destPos = self.roomEntity.characterHolder:TransformPoint(localDestPos)
    if not DormUtil.IsPositionOnNavmesh(destPos) then
      destPos = DormUtil.FindNearestActivePoint(destPos)
    end
    self:SetUnityWorldPos(destPos)
    self.transform:SetLocalY(0)
    self:AnimatorStand()
    self:StartCheckAnimator(DormEnum.DormAnimatorNormalName, function()
      if self.__isOperate then
        return
      end
      self.aiCtrl:RandNewAction()
      self.__isReadyToInteract = true
    end)
  end
end

function DormCharacterEntity:IsDormCharacterReady()
  if self.__isOperate then
    return false
  end
  return self.__isReadyToInteract
end

function DormCharacterEntity:OnUpdate()
  if self.__isOperate then
    return
  end
  self.aiCtrl:OnUpdate()
end

function DormCharacterEntity:DoMoveLogic(pos, completeAction)
  local worldPos = self:DormLogicToWorld(pos)
  return self:DoMoveAStar(worldPos, completeAction)
end

function DormCharacterEntity:GenUnlockDormTalkList()
  self.__talkIdList = {}
  local talkCfg = ConfigData.dorm_hero_talk[self.heroData.dataId]
  if talkCfg == nil then
    return
  end
  self.__isAllTalked = true
  local talkedDic = {}
  local allDormData = ControllerManager:GetController(ControllerTypeId.Dorm).allDormData
  for talkIndex, unlockType in pairs(talkCfg.pre_type) do
    local unlockArg = talkCfg.pre_para[talkIndex]
    if DormChecker.CheckerTalkUnlock(self.heroData.dataId, unlockType, unlockArg) then
      local talkId = talkCfg.talk_list[talkIndex]
      table.insert(self.__talkIdList, talkId)
      if not allDormData:IsDormHeroTalked(self.heroData.dataId, talkIndex) then
        self.__isAllTalked = false
      else
        talkedDic[talkId] = true
      end
    end
  end
  if #self.__talkIdList == 0 then
    return
  end
  if self.__isAllTalked then
    return
  end
  local i = 1
  while i <= #self.__talkIdList do
    local talkId = self.__talkIdList[i]
    if talkedDic[talkId] then
      table.remove(self.__talkIdList, i)
    else
      i = i + 1
    end
  end
end

function DormCharacterEntity:GetUnlockDormTalkList()
  return self.__talkIdList
end

function DormCharacterEntity:IsAllTalked()
  return self.__isAllTalked
end

function DormCharacterEntity:GetDormGreetConfig()
  return self.__dormGreetCfg
end

function DormCharacterEntity:__StartFntInteract()
  self:SetStarAIPathActive(false)
  self:SetNavmeshCutActive(false)
end

function DormCharacterEntity:__StartExitInteract()
  self:SetNavmeshCutActive(true)
end

function DormCharacterEntity:HasVowedFx()
  if self.vowedHeadFxGo ~= nil then
    return true
  end
  return false
end

function DormCharacterEntity:AddVowedFx(prefab)
  if prefab == nil or self:HasVowedFx() then
    return
  end
  if not self.heroData:GetHeroIsVowed() then
    return
  end
  local go = prefab:Instantiate(self.transform)
  self.vowedHeadFxGo = go.transform:GetChild(0).gameObject
  self.vowedHeadFxGo:SetActive(false)
end

function DormCharacterEntity:ShowVowedFx(flag)
  if self.vowedHeadFxGo == nil then
    return
  end
  self.vowedHeadFxGo:SetActive(flag)
end

function DormCharacterEntity:OnDelete()
  DormRoleBaseEntity.OnDelete(self)
  if self.astarCharcter ~= nil then
    self.astarCharcter:ForceStopMove()
    self.astarCharcter = nil
  end
  if self.curTweener ~= nil then
    self.curTweener:Kill()
    self.curTweener = nil
  end
  self.vowedHeadFxGo = nil
  TimerManager:StopTimer(self.operateTimerId)
  TimerManager:StopTimer(self.unbindTimerId)
  DestroyUnityObject(self.gameObject)
  self.gameObject = nil
  self.transform = nil
end

return DormCharacterEntity
