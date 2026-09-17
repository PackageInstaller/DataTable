local this = {}
local _timerOwner = {}
local _timerKey = "WhilePlaySoulEssenceTimeline"
local _timerKey2 = "WhilePlaySoulEssenceTimeline2"
local _hideSourceKey = "WhilePlaySoulEssenceTimeline"
local _cutinTimerOwner = {}
local _cutinTimerKey = "WhilePlaySoulEssenceCutin"
local _cutinCloseCheckTimerKey = "WhilePlaySoulEssenceCutinCloseCheck"
local _cutinCloseCheckInterval = 0.03
local _cutinMinDuration = 0.5
local _cutinOpenTime
local _soulEssenceTpl = L_GameTpl:getSoulessenceTpl()
local _isPlaying = false
local _isInputBlocked = false
local _avatarReadyRequest, _endCallback
local HideNodeList = CS.System.Collections.Generic.List(CS.System.String)()
HideNodeList:Add(L_Const.WorldNode.NPC)
HideNodeList:Add(L_Const.WorldNode.PLAYER)
HideNodeList:Add(L_Const.WorldNode.PLAYERPETNODE)
local timelinePrefabDic = {
  single = {
    "Assets/ResourcesAssets/Timeline/World/SoulEssenceCard/pre_soulessence_card_open_single_R.prefab",
    "Assets/ResourcesAssets/Timeline/World/SoulEssenceCard/pre_soulessence_card_open_single_SR.prefab",
    "Assets/ResourcesAssets/Timeline/World/SoulEssenceCard/pre_soulessence_card_open_single_SSR_0%d.prefab"
  },
  multi = {
    "Assets/ResourcesAssets/Timeline/World/SoulEssenceCard/pre_soulessence_card_open_multiple_R.prefab",
    "Assets/ResourcesAssets/Timeline/World/SoulEssenceCard/pre_soulessence_card_open_multiple_SR.prefab",
    "Assets/ResourcesAssets/Timeline/World/SoulEssenceCard/pre_soulessence_card_open_multiple_SSR_0%d.prefab"
  }
}

function this.isPlaying()
  return _isPlaying
end

local function setSceneActive(isActive)
  if AzurWorld.visbleMgr then
    C_UISceneManager.SetSceneActive(isActive)
  end
  if AzurWorld.HomeMgr then
    L_HomeManager:setHomeRootActive(isActive)
  end
  if AzurWorld.HUDMgr then
    AzurWorld.HUDMgr:SetAllVisible(isActive)
  end
end

local function setInputBlocked(isBlocked)
  if _isInputBlocked == isBlocked then
    return
  end
  _isInputBlocked = isBlocked
  if L_UIManager then
    L_UIManager:tmpPauseInput(isBlocked)
  end
end

local function waitCutinClosed(onClosed)
  if not onClosed then
    return
  end
  onClosed()
end

local function closeCutin(onClosed)
  if not _cutinOpenTime then
    waitCutinClosed(onClosed)
    return
  end
  local openTime = _cutinOpenTime
  
  local function close()
    if _cutinOpenTime ~= openTime then
      return
    end
    _cutinOpenTime = nil
    C_UIMgr.CloseCutin()
    waitCutinClosed(onClosed)
  end
  
  local currentTime = C_Time.time
  local remainDuration = _cutinMinDuration - (currentTime - openTime)
  if remainDuration <= 0 then
    close()
    return
  end
  L_TimerManager:newOrResetTimer(_cutinTimerOwner, _cutinTimerKey, close, remainDuration, 1, false)
end

local function cancelAvatarReadyRequest()
  if _avatarReadyRequest then
    _avatarReadyRequest:cancel()
    _avatarReadyRequest = nil
  end
end

local function cleanupEffect(timelineGo, sceneGo)
  L_TimerManager:clearTimer(_timerOwner)
  cancelAvatarReadyRequest()
  closeCutin()
  setInputBlocked(false)
  C_CameraManager.uiCamera.enabled = true
  setSceneActive(true)
  C_HomeUtil.ShowOrHideEntityNodeWithCustomNodeList(true, HideNodeList, _hideSourceKey)
  if timelineGo then
    C_PrefabManager:RecycleByLoader(timelineGo)
  end
  if sceneGo then
    C_PrefabManager:RecycleByLoader(sceneGo)
  end
  if _endCallback then
    _endCallback()
  end
  _isPlaying = false
end

local function waitAvatarLoaded(timelineGo, onLoaded)
  local actorNode = L_CommonUtil.findTranByName("pre_1_01_700119", timelineGo.transform)
  local biologyData = actorNode and actorNode:GetComponent(typeof(C_BiologyAvatar))
  if not biologyData then
    onLoaded()
    return
  end
  cancelAvatarReadyRequest()
  _avatarReadyRequest = L_GameUtil.waitAllAvatarPartsLoaded(biologyData, function()
    if not _isPlaying then
      return
    end
    onLoaded()
  end)
end

local function onSceneAndTimelineLoaded(timelineGo, sceneGo, rewards)
  local sequenceNode = L_CommonUtil.findTranByName("[sequence]", timelineGo.transform)
  if not sequenceNode then
    closeCutin()
    L_RewardManager:ShowReward(rewards)
    cleanupEffect(timelineGo, sceneGo)
    return
  end
  L_TimerManager:clearTimer(_timerOwner)
  local sequencePlayableDirector = sequenceNode:GetComponent(typeof(CS.UnityEngine.Playables.PlayableDirector))
  sequencePlayableDirector:Pause()
  waitAvatarLoaded(timelineGo, function()
    closeCutin(function()
      if not _isPlaying then
        return
      end
      C_CameraManager.uiCamera.enabled = false
      sequencePlayableDirector:Play()
      local timelinePlayDuration = sequencePlayableDirector.duration - 0.3
      L_TimerManager:newOrResetTimer(_timerOwner, _timerKey, function()
        L_TimerManager:newOrResetTimer(_timerOwner, _timerKey2, function()
          cleanupEffect(timelineGo, sceneGo)
        end, 0.3, 1, false)
        L_RewardManager:ShowReward(rewards)
      end, timelinePlayDuration, 1, false)
    end)
  end)
end

function this.show(rewards, endCallback)
  if _isPlaying then
    return false
  end
  _isPlaying = true
  _endCallback = endCallback
  L_TimerManager:clearTimer(_cutinTimerOwner)
  _cutinOpenTime = C_Time.time
  C_UIMgr.OpenCutin(1, false)
  setInputBlocked(true)
  C_UIMgr.PreloadPage("pageSoulEssenceInfo", 30)
  C_UIMgr.PreloadPage("pageReward", 30)
  local itemList = rewards.rewards
  local maxRarity = 2
  local count = 0
  for _, item in pairs(itemList) do
    local tpl = _soulEssenceTpl:getTplById(item.itemid)
    local rarity = _soulEssenceTpl:getRarity(tpl)
    if maxRarity < rarity then
      maxRarity = rarity
    end
    count = count + 1
  end
  C_HomeUtil.ShowOrHideEntityNodeWithCustomNodeList(false, HideNodeList, _hideSourceKey)
  local sex = L_PlayerStore:getSex()
  local sexIdx = sex == L_Const.sexType.male and 2 or 1
  local soulEssenceTimelinePrefabPath
  if 1 < count then
    soulEssenceTimelinePrefabPath = string.format(timelinePrefabDic.multi[maxRarity - 1], sexIdx)
  else
    soulEssenceTimelinePrefabPath = string.format(timelinePrefabDic.single[maxRarity - 1], sexIdx)
  end
  local scenePrefabPath = "Assets/ResourcesAssets/Program/UIScene/Soulessence/pre_soulessence_card_open_ui_01.prefab"
  scenePrefabPath = L_CommonUtil.getMultiPlatformScenePath(scenePrefabPath)
  local rootNode = C_LuaUtility.GetRootNode()
  local sceneGo, timelineGo
  setSceneActive(false)
  C_UIMgr.uiLoader:SpawnAsync(scenePrefabPath, function(id, _sceneGo)
    if not _isPlaying then
      C_PrefabManager:RecycleByLoader(_sceneGo)
      closeCutin()
      cleanupEffect()
      return
    end
    sceneGo = _sceneGo
    sceneGo.transform.position = C_Vector3(400, 0, 400)
    C_UIMgr.uiLoader:SpawnAsync(soulEssenceTimelinePrefabPath, function(id, _timelineGo)
      if not _isPlaying then
        C_PrefabManager:RecycleByLoader(sceneGo)
        C_PrefabManager:RecycleByLoader(_timelineGo)
        closeCutin()
        cleanupEffect()
        return
      end
      timelineGo = _timelineGo
      timelineGo.transform.position = C_Vector3(400, 0, 400)
      onSceneAndTimelineLoaded(timelineGo, sceneGo, rewards)
    end, rootNode, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
  end, rootNode, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
  return true
end

function this.stop()
  cleanupEffect(nil, nil)
end

return this
