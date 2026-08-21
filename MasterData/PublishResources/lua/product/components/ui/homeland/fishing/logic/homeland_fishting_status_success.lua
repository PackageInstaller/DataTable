_class("HomelandFishingStatusSuccess", HomelandFishingStatus)
HomelandFishingStatusSuccess = HomelandFishingStatusSuccess

function HomelandFishingStatusSuccess:OnEnter()
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._character = self._homelandModule:GetUIModule():GetClient():CharacterManager():MainCharacterController()
  GameGlobal.TaskManager():StartTask(self.FishingSuccessCoror, self)
end

function HomelandFishingStatusSuccess:FishingSuccessCoror(TT)
  self:LockUI("HomelandFishingStatusSuccess_FishingSuccessCoror")
  local ret, rewards = self:SendMessage(TT)
  if not ret then
    self:SwitchStatus(FishgingStatus.Finish)
    self:UnLockUI("HomelandFishingStatusSuccess_FishingSuccessCoror")
    return
  end
  local anim = HomelandFishingConst.GetAnimationCfg(FishgingAnimation.FishSuccess)
  self:PlayAnimation(anim.name)
  self:PlayFishRodAnimation(anim.rodname)
  YIELD(TT, 200)
  local isMatch = self._character:GetIsFishMach()
  if not isMatch then
    local fish = HomelandFishingConst.GetBiteFish()
    self._cameraEff = ResourceManager:GetInstance():SyncLoadAsset("eff_jy_fish_camera.prefab", LoadType.GameObject)
    self._fishModelEff = nil
    self._lineModelEff = nil
    if not self._cameraEff or not self._cameraEff.Obj then
      Log.fatal("加载特效失败")
    else
      local go = self._cameraEff.Obj
      go:SetActive(true)
      local fishModel = fish:GetModel()
      self._fishModelEff = ResourceManager:GetInstance():SyncLoadAsset(fishModel, LoadType.GameObject)
      local fishGo = self._fishModelEff.Obj
      fishGo:SetActive(true)
      local parent = go.transform:Find("camera (2)/fish_mash")
      fishGo.transform:SetParent(parent)
      fishGo.transform.localPosition = Vector3(0, 0, 0)
      fishGo.transform.localRotation = Quaternion.identity
      parent.gameObject:SetActive(true)
      local fishAnim = fishGo:GetComponentInChildren(typeof(UnityEngine.Animation))
      fishAnim:Play("ashore")
      self._lineModelEff = ResourceManager:GetInstance():SyncLoadAsset("eff_jy_fish_line_mouth.prefab", LoadType.GameObject)
      local lineGo = self._lineModelEff.Obj
      lineGo:SetActive(true)
      local parent = self:FindNode(fishGo.transform, "mouth")
      lineGo.transform:SetParent(parent)
      lineGo.transform.localPosition = Vector3(0, 0, 0)
      lineGo.transform.localRotation = Quaternion.identity
    end
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioFishingSuccess)
    YIELD(TT, 420)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FishMatchScore)
  end
  
  local function callback()
    if self._lineModelEff then
      self._lineModelEff:Dispose()
      self._lineModelEff = nil
    end
    if self._fishModelEff then
      self._fishModelEff:Dispose()
      self._fishModelEff = nil
    end
    if self._cameraEff then
      self._cameraEff:Dispose()
      self._cameraEff = nil
    end
  end
  
  self:ShowDialog("UIHomeShowAwards", rewards, function()
    callback()
    self:CheckPlayBubble(rewards)
    self:SwitchStatus(FishgingStatus.Finish)
  end, true, StringTable.Get("str_homeland_fishing_result_title"))
  self:UnLockUI("HomelandFishingStatusSuccess_FishingSuccessCoror")
end

function HomelandFishingStatusSuccess:CheckPlayBubble(rewards)
  local uiHomeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = uiHomeLandModule:GetClient()
  local followList = homelandClient:PetManager():GetFollowPets()
  if not followList then
    return
  end
  local followPetIDs = {}
  for k, pet in pairs(followList) do
    table.insert(followPetIDs, pet:TemplateID())
  end
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local result = homelandModule:GetFollowFishingID(followPetIDs)
  if result <= 0 then
    return
  end
  local cfgs = Cfg.cfg_homeland_follow_fishing({})
  if not cfgs then
    return
  end
  local isFind = false
  local follwFishingCfg
  for i = 1, #rewards do
    local assetid = rewards[i].assetid
    for _, cfg in pairs(cfgs) do
      local fishIds = cfg.FishID
      for _, fishId in pairs(fishIds) do
        if fishId == assetid then
          isFind = true
          follwFishingCfg = cfg
          break
        end
      end
      if isFind then
        break
      end
    end
    if isFind then
      break
    end
  end
  if not isFind then
    return
  end
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local followList = homelandClient:PetManager():GetFollowPets()
  if not followList then
    return
  end
  for i = 1, #followList do
    if 0 < follwFishingCfg.BubblePetCount and i > follwFishingCfg.BubblePetCount then
      break
    end
    local pet = followList[i]
    local behaviourMgr = pet:GetPetBehavior()
    local behaviour = behaviourMgr:GetCurBehavior()
    local bubbleCmp = behaviour:GetComponent(HomelandPetComponentType.Bubble)
    if bubbleCmp then
      local bubbleId = follwFishingCfg.BubbleId
      if bubbleId then
        bubbleCmp:ShowBubble(bubbleId)
      end
    end
  end
end

function HomelandFishingStatusSuccess:SendMessage(TT)
  local rewards = {}
  local ret = false
  local fish = HomelandFishingConst.GetBiteFish()
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  if self:IsRiverFishing() then
    local result = homelandModule:ApplyConfirmFishingSuccess(TT, FishingEntryType.FET_Normal)
    if result:GetSucc() then
      local roleAsset = RoleAsset:New()
      rewards[#rewards + 1] = roleAsset
      roleAsset.assetid = fish:GetItemId()
      roleAsset.count = 1
      homelandModule:ApplyFishPostionData(TT)
      HomelandFishingConst.SetWishingCoinPositionId()
      local isMatch = self._character:GetIsFishMach()
      if not isMatch then
        self._homelandFishing:RefreshFishingPosition()
      end
      ret = true
    else
      ret = false
      Log.error("钓鱼失败")
    end
  else
    local result = homelandModule:ApplyTakeOutFish(TT, HomelandFishingConst.GetBiteFish():GetItemId())
    if result:GetSucc() then
      local roleAsset = RoleAsset:New()
      rewards[#rewards + 1] = roleAsset
      roleAsset.assetid = fish:GetItemId()
      roleAsset.count = 1
      homelandModule:ApplyFishPostionData(TT)
      self._homelandFishing:RefreshFishingPosition()
      local info = HomelandFishingConst.GetWishingFishInfo()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.WishingRemoveFish, info.InstanceId)
      HomelandWishingConst.UnRaiseFish(info.ID, info.InstanceId)
      ret = true
    else
      Log.error("钓鱼失败")
      ret = false
    end
  end
  return ret, rewards
end

function HomelandFishingStatusSuccess:FindNode(tran, name)
  if tran == nil then
    return nil
  end
  local result = tran:Find(name)
  if result then
    return result
  end
  for i = 0, tran.childCount - 1 do
    local child = tran:GetChild(i)
    result = self:FindNode(child, name)
    if result then
      return result
    end
  end
  return nil
end

function HomelandFishingStatusSuccess:OnExit()
end

function HomelandFishingStatusSuccess:FishingStatus()
  return FishgingStatus.FishSuccess
end

function HomelandFishingStatusSuccess:OnDestroy()
end
