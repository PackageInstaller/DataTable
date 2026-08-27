local base = require("Game.Dorm.Character.Entity.DormRoleBaseEntity")
local HallFairyEntity = class("DormCharacterEntity", base)
local HallFairyAI = require("Game.Fairy.AI.HallFairyAI")
local CS_ParticleSystem = CS.UnityEngine.ParticleSystem
local LevelUpAnimationName = "LevelUp"
local StandRunAnimationName = "StandRun"
local normalStateAniName = "Idle"
local EnterAniName = "Battle_leap"
local crossFadeTime = 0.25

function HallFairyEntity:ctor(fairyData, pos, hallCtrl)
  self.fairyData = fairyData
  self.__initWorldPos = pos
  self.hallCtrl = hallCtrl
  local aiCfg = fairyData:GetFairyAiCfg()
  if aiCfg == nil then
    error("fairy ai config is null,fairyId:" .. tostring(fairyData:GetFairyId()))
    return
  end
  self.aiCtrl = HallFairyAI.New(aiCfg, self, true)
end

function HallFairyEntity:GetCurrentPrefabPath(fairyPrefabPath)
  return self.currentPrefabPath
end

function HallFairyEntity:SetCurrentPrefabPath(fairyPrefabPath)
  self.currentPrefabPath = fairyPrefabPath
end

function HallFairyEntity:OnUpdate()
  if self.aiCtrl ~= nil then
    self.aiCtrl:OnUpdate()
  end
end

function HallFairyEntity:LoadFairy(fairyHolder, prefab, emojiPrefab, resloader, callback)
  self.resloader = resloader
  if IsNull(prefab) then
    return
  end
  local go = prefab:Instantiate(fairyHolder)
  local fairyName = go.transform:GetChild(0).name
  self.headRoot = go.transform:Find(string.format("%s/%s_root/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 Head", fairyName, fairyName))
  local emojiObj = emojiPrefab:Instantiate(self.headRoot)
  self:__InitHallFairyEntityGo(go, emojiObj)
  if callback ~= nil then
    callback(self)
  end
end

function HallFairyEntity:__InitHallFairyEntityGo(go, emojiObj)
  self.__loaded = true
  self.gameObject = go
  self.transform = go.transform
  self.animator = self.gameObject:FindComponent(eUnityComponentID.Animator)
  if self.__initWorldPos ~= nil then
    self.transform.position = self.__initWorldPos
  end
  self.emojiObj = emojiObj
  self.emojiObj.transform.localPosition = Vector3.New(-0.4, 0, 0)
  self.emojiObj.transform.localScale = Vector3.one * 0.3
  self.emojiParticle = emojiObj:FindComponent(eUnityComponentID.ParticleSystem)
  self.emojiSpriteParticleSystem = emojiObj.transform:GetChild(1):FindComponent(eUnityComponentID.ParticleSystem)
  self.astarCharcter = CS.DormAStarCharacter.Create(self.gameObject)
  self.astarCharcter.speed = 0.8
  self.astarCharcter:AddAStarComponents(false)
  self.astarCharcter.aiPath.endReachedDistance = 0.3
  self:StartAIBehavior()
end

function HallFairyEntity:GetFairyHeadTransform()
  return self.headRoot
end

function HallFairyEntity:StartAIBehavior()
  self.aiCtrl:AIInterruptCurrState(false)
  self.aiCtrl:RandNewAction()
end

function HallFairyEntity:GetCharAStarComp()
  return self.astarCharcter
end

function HallFairyEntity:EnterShowTime(showPos, vaCamera)
  if not self.__loaded then
    return
  end
  self:GetCharAStarComp().isPause = true
  self:GetCharAStarComp().aiPath.enabled = false
  self.transform.position = showPos
  self.transform.localEulerAngles = vaCamera.Follow.localEulerAngles
  self:AnimatorStand()
  self:SetMoveAniSpeed(0)
  self.animator.speed = 1
  self.gameObject:SetActive(true)
end

function HallFairyEntity:ExitShowTime()
  if not self.__loaded then
    return
  end
  self.__position = nil
  self:GetCharAStarComp().isPause = false
  self:GetCharAStarComp().aiPath.enabled = true
end

function HallFairyEntity:HidePauseFairy()
  if not self.__loaded then
    return
  end
  self:GetCharAStarComp().isPause = true
  self:GetCharAStarComp().aiPath.enabled = false
  if self.__position == nil then
    self.__position = self.transform.position
  end
  self.animator.speed = 0
  self.gameObject:SetActive(false)
end

function HallFairyEntity:ShowResumeFairy()
  if not self.__loaded then
    return
  end
  self:GetCharAStarComp().isPause = false
  self:GetCharAStarComp().aiPath.enabled = true
  if self.__position ~= nil then
    self.transform.position = self.__position
    self.__position = nil
  end
  self.animator.speed = 1
  self.gameObject:SetActive(true)
end

function HallFairyEntity:GetRandomOtherFairyPos()
  local otherFairyEntity = self.hallCtrl:GetRandomOtherFairyEntity(self)
  if otherFairyEntity == nil or IsNull(otherFairyEntity.transform) then
    return false
  end
  self.greettingFairyEntity = otherFairyEntity
  otherFairyEntity:Begreeted(self)
  local scale = 0.5
  local pointPos = otherFairyEntity.transform.position + (self.transform.position - otherFairyEntity.transform.position).normalized * scale
  return true, pointPos
end

function HallFairyEntity:Begreeted(greettingFairyEntity)
  self.aiCtrl:AIInterruptCurrState(false)
  self.greettingFairyEntity = greettingFairyEntity
  self.aiCtrl:SetCurState(5)
end

function HallFairyEntity:GetGreettingFairyEntity()
  return self.greettingFairyEntity
end

function HallFairyEntity:GetDistanceWithGreettingFairy()
  local greettingFairyEntity = self:GetGreettingFairyEntity()
  if greettingFairyEntity == nil or IsNull(greettingFairyEntity.transform) then
    return 0
  end
  if IsNull(self.transform) then
    return 0
  end
  local selfPos = self.transform.position
  local greettingPos = greettingFairyEntity.transform.position
  local distance = Vector3.Distance(selfPos, greettingPos)
  return distance
end

function HallFairyEntity:ClearGreettingFairy()
  self.greettingFairyEntity = nil
end

function HallFairyEntity:PlayLevelUpAnimation()
  self:PlayAnimationByName(LevelUpAnimationName)
end

function HallFairyEntity:PlayEnterAnimation()
  self:PlayAnimationByName(EnterAniName)
end

function HallFairyEntity:PlayIdleAnimation()
  local stateInfo = self.animator:GetCurrentAnimatorStateInfo(0)
  local isPlaying = stateInfo:IsName(normalStateAniName) or self.animator:IsInTransition(0)
  if not isPlaying then
    self:PlayAnimationByName(normalStateAniName, true)
  end
end

function HallFairyEntity:ReSetAnimation()
  if not IsNull(self.animator) then
    self.animator:Play(StandRunAnimationName, 0, 0)
  end
end

function HallFairyEntity:PlayAnimationByName(name, isCrossFade)
  if not IsNull(self.animator) then
    if not isCrossFade then
      self.animator:Play(name)
    else
      self.animator:CrossFade(name, crossFadeTime)
    end
  end
end

function HallFairyEntity:ShowRandomEmoji(emojiIdList)
  if emojiIdList == nil then
    return
  end
  local emojiId = emojiIdList[math.random(#emojiIdList)]
  self:ShowEmoji(emojiId)
end

function HallFairyEntity:ShowEmoji(emojiId)
  if IsNull(self.emojiObj) then
    return
  end
  if self.emojiObj.activeInHierarchy then
    return
  end
  local textureSheetAnimation = self.emojiSpriteParticleSystem.textureSheetAnimation
  local minMaxCurve = CS_ParticleSystem.MinMaxCurve()
  minMaxCurve.constant = emojiId / 64
  textureSheetAnimation.frameOverTime = minMaxCurve
  self.emojiObj:SetActive(true)
  self.emojiParticle:Play(true)
end

function HallFairyEntity:HideEmoji()
  self.emojiObj:SetActive(true)
end

function HallFairyEntity:Destoty()
  base.OnDelete(self)
  if self.astarCharcter ~= nil then
    self.astarCharcter:ForceStopMove()
    self.astarCharcter = nil
  end
  if self.__resloader ~= nil then
    self.__resloader:Put2Pool()
    self.__resloader = nil
  end
  DestroyUnityObject(self.gameObject)
  self.gameObject = nil
  self.transform = nil
  self.emojiObj = nil
  self.emojiParticle = nil
  self.emojiSpriteParticleSystem = nil
end

return HallFairyEntity
