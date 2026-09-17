local this = {}
local guideGroupTpl = L_GameTpl:getGuideGroupTpl()
local _guide_kibo_special_guide_group_ids = L_GameTpl:getGameConstTpl():getData("GUIDE_KIBO_SPECIAL_GUIDE_GROUP_IDS", L_Const.GameTplType.list_int)
local _guide_kibo_special_distance = L_GameTpl:getGameConstTpl():getData("GUIDE_KIBO_SPECIAL_DISTANCE", L_Const.GameTplType.float)
local guide_hide_white_list = L_GameTpl:getGameConstTpl():getData("GUIDE_UI_HIDE_EFFECT", L_Const.GameTplType.list_string)

local function getWorldPauseOwnersText(owners)
  local result = {}
  for owner, _ in pairs(owners or {}) do
    table.insert(result, tostring(owner))
  end
  table.sort(result)
  return table.concat(result, "|")
end

function this:checkRangeEntities()
  if self.isRangeGuidesComplete then
    return false
  end
  if not L_PlayerStore:isPlayerLogin() then
    return false
  end
  local guides = _guide_kibo_special_guide_group_ids
  local isComplete = true
  for _, v in ipairs(guides) do
    if not L_GuideStore:isGuideComplete(v) then
      isComplete = false
      break
    end
  end
  self.isRangeGuidesComplete = isComplete
  if isComplete then
    self.c_specialTypeList = nil
    return false
  end
  local isHasInRange = false
  local count
  count, self.c_specialTypeList = C_LuaUtility.GetRangeMonsterSpecialTypeSet(_guide_kibo_special_distance, self.c_specialTypeList or {})
  isHasInRange = 0 < count
  if isHasInRange then
    for i = 0, count - 1 do
      local specialType = self.c_specialTypeList[i]
      local param = {
        guideParams = {
          {
            type = L_Const.triggerGuideType.rangeChecker,
            param = tostring(specialType)
          }
        }
      }
      C_MJLog.LogInfo("Trigger Special Kibo Guide, Group ID: " .. tostring(param.guideParams[1].type) .. ", Param: " .. param.guideParams[1].param, C_ELogModule.Guide)
      self:tryTriggerGuideByParams(param)
    end
  end
  return isHasInRange
end

function this:checkPageOpen(pageName)
  if not string.isEmpty(pageName) then
    local config = L_UI:getPageConfig(pageName)
    if not config then
      return false, "[guidManager checkPageOpen error] getPageConfig result is nil "
    end
    if config.group == CS.Azur.Gameplay.EUIGroup.Stack then
      local curPageName = L_UI:currentPage(L_UI.groupKeys.stack)
      if curPageName == nil then
        return false, "[guidManager checkPageOpen error] StackUI Current Page is nil"
      end
      if curPageName ~= pageName then
        return false, "[guidManager checkPageOpen error] StackUI Current Page is " .. curPageName
      end
    end
    local pageShown = L_UI:checkPageShown(pageName)
    if pageShown then
      return true
    else
      return false, "[guidManager checkPageOpen error] page not shown "
    end
  end
  return false, "[guidManager checkPageOpen error] pageName is empty "
end

function this:isPlayingEnterAnimation(page)
  return L_UI:checkPagePlayingAnim(page)
end

function this:isInputActionTriggered()
  return self.listenerEventDirty
end

function this:getLongInputActionMaxTime()
  local res = 0
  local v = self.listenerLongEventName
  local startTime = self.listenerLongEventStartTime[v]
  local endTime = self.listenerLongEventEndTime[v]
  if startTime ~= nil and endTime ~= nil then
    res = math.max(res, endTime - startTime)
  end
  return res
end

function this:clearInputAction()
  self.isListeneringEvents = false
  self.listenerEventNames = {}
  self.listenerEventDirty = false
  self.listenerLongEventName = ""
  self.listenerLongEventStartTime = {}
  self.listenerLongEventEndTime = {}
end

function this:registerInputAction(eventNames)
  self.isListeneringEvents = true
  self.listenerEventNames = eventNames
  self.listenerEventDirty = false
end

function this:registerLongInputAction(eventNames)
  self.isListeneringEvents = true
  self.listenerLongEventName = eventNames
  self.listenerLongEventStartTime = {}
  self.listenerLongEventEndTime = {}
end

function this:onEventInputActionHandle(param)
  C_MJLog.LogDebug("total inputontrol" .. tostring(param.inputEventType), C_ELogModule.Guide)
  if self.isListeneringEvents == nil or not self.isListeneringEvents then
    return
  end
  C_MJLog.LogInfo("GuideManager onEventInputActionHandle", C_ELogModule.Guide)
  if self.inSimpleReconnecting ~= nil and self.inSimpleReconnecting == true then
    C_MJLog.LogInfo("GuideManager onEventInputActionHandle return. Reason: inSimpleReconnecting", C_ELogModule.Guide)
    return
  end
  C_MJLog.LogInfo("inputontrol" .. tostring(param.inputEventType), C_ELogModule.Guide)
  if self.listenerEventNames then
    C_MJLog.LogInfo("@guide Number of events：" .. tostring(#self.listenerEventNames), C_ELogModule.Guide)
    if #self.listenerEventNames == 1 and self.listenerEventNames[1] == "guide_all" then
      self.listenerEventDirty = true
    end
    if not (param.isPress == nil or not param.isPress and C_InputManager.IfRequireActionIsPressed(param.inputEventType)) or param.axis ~= nil and param.axis ~= C_Vector2.zero or param.singleAxis ~= nil and param.singleAxis ~= 0 then
      for k, v in pairs(self.listenerEventNames) do
        C_MJLog.LogInfo("@guide 监听的事件" .. tostring(v), C_ELogModule.Guide)
        if param.inputEventType == v then
          self.listenerEventDirty = true
        end
      end
    end
  end
  if self.listenerLongEventName then
    local v = self.listenerLongEventName
    if v == param.inputEventType and param.isPress ~= nil then
      if param.isPress then
        self.listenerLongEventStartTime[v] = C_Time.time
        self.listenerLongEventEndTime[v] = 0
        C_MJLog.LogInfo("@guide 开始监听时间" .. tostring(C_Time.time), C_ELogModule.Guide)
      elseif self.listenerLongEventEndTime[v] == nil or self.listenerLongEventEndTime[v] == 0 then
        self.listenerLongEventEndTime[v] = C_Time.time
        C_MJLog.LogInfo("@guide 结束监听时间" .. tostring(C_Time.time), C_ELogModule.Guide)
      end
    end
  end
end

function this:checkCurrentAllPages(validPages)
  if L_UI:checkPageOpen("pagePetDuelExitFull") then
    L_UI:close("pagePetDuelExitFull")
  end
  validPages = validPages or {}
  local isShow = true
  for _, pageType in pairs(L_UI.groupKeys) do
    local pages = L_UI:getAllPages(pageType)
    isShow = self:checkAllPages(pages, validPages)
    if not isShow then
      return isShow
    end
  end
  return isShow
end

function this:checkAllPages(pages, validPages)
  local targetPageName = validPages[#validPages]
  local isShow = true
  for _, page in pairs(pages) do
    if not table.containsValue(validPages, page.pageName) and L_UI:checkPageOpen(page.pageName) and not self:isPageCanShowGuide(page.pageName) and C_UIMgr.CheckPageOcclusion(targetPageName, page.pageName) then
      C_MJLog.LogInfo("目标界面 " .. targetPageName .. " 被遮挡了，请检查 " .. page.pageName, C_ELogModule.Guide)
      isShow = false
      break
    end
  end
  return isShow
end

function this:isPageCanShowGuide(pageName)
  return table.containsValue(guide_hide_white_list, pageName)
end

function this:setWorldPause(isPause, owner)
  owner = tostring(owner or "legacy")
  local ownerWasActive = self._guideWorldPauseOwners[owner] == true
  if isPause then
    self._guideWorldPauseOwners[owner] = true
  else
    self._guideWorldPauseOwners[owner] = nil
  end
  local effectivePause = next(self._guideWorldPauseOwners) ~= nil
  local stateChanged = self._isGuideWorldPaused ~= effectivePause
  self._isGuideWorldPaused = effectivePause
  local log = string.format("[GuideWorldPause] request owner=%s pause=%s ownerWasActive=%s effectivePause=%s stateChanged=%s owners=%s", owner, tostring(isPause), tostring(ownerWasActive), tostring(effectivePause), tostring(stateChanged), getWorldPauseOwnersText(self._guideWorldPauseOwners))
  C_MJLog.LogInfo(log, C_ELogModule.Guide)
  if not stateChanged then
    return
  end
  if effectivePause then
    AzurWorld.WorldElapseMgr:PauseWorld(C_ETimePauseTypeFlag.Guild)
  else
    AzurWorld.WorldElapseMgr:ResumeWorld(C_ETimePauseTypeFlag.Guild)
  end
end

function this:clearWorldPause(reason)
  local owners = getWorldPauseOwnersText(self._guideWorldPauseOwners)
  local stateChanged = self._isGuideWorldPaused == true
  self._guideWorldPauseOwners = {}
  self._isGuideWorldPaused = false
  C_MJLog.LogInfo(string.format("[GuideWorldPause] clear reason=%s stateChanged=%s ownersBefore=%s", tostring(reason), tostring(stateChanged), owners), C_ELogModule.Guide)
  AzurWorld.WorldElapseMgr:ResumeWorld(C_ETimePauseTypeFlag.Guild)
end

function this:isPlayableSatisfy(guideId)
  local runningPlayableIDList = AzurWorld.PlayableUnitMgr.runningPlayableIds
  local groupTd = guideGroupTpl:getTplById(guideId)
  local playableIdGroups = {}
  if groupTd ~= nil and groupTd.playableId ~= nil then
    playableIdGroups = groupTd.playableId
  end
  if not self.playableCheckType then
    self.playableCheckType = {}
    local tempPlayableCheckTypeStr = L_GameTpl:getGameConstTpl():getData("GUIDE_PLAYABLE", L_Const.GameTplType.list_int)
    self.playableCheckType = tempPlayableCheckTypeStr
  end
  local isPlayableGuide = 0 < #playableIdGroups
  if 0 < runningPlayableIDList.Count then
    for i = 0, runningPlayableIDList.Count - 1 do
      local runningPlayableID = runningPlayableIDList[i]
      local tdPlayableTable = C_TDPlayableTable.GetData(runningPlayableID)
      if isPlayableGuide and not table.containsValue(playableIdGroups, tdPlayableTable.type) then
        C_MJLog.LogInfo("@guide The guidance cannot be activated outside the target gameplay mode." .. tostring(tdPlayableTable.type) .. "guideid:" .. tostring(guideId), C_ELogModule.Guide)
        return false
      end
      if not isPlayableGuide and table.containsValue(self.playableCheckType, tdPlayableTable.type) then
        C_MJLog.LogInfo("@guide Regular guidance cannot be enabled in gameplay activities.:" .. "guideid:" .. tostring(guideId), C_ELogModule.Guide)
        return false
      end
    end
  elseif isPlayableGuide then
    C_MJLog.LogInfo("@guide The gameplay-related guidance will only be activated within the gameplay itself:" .. tostring(playableIdGroups), C_ELogModule.Guide)
    return false
  end
  return true
end

function this:triggerScene(guideId)
  local tpl = guideGroupTpl:getTplById(guideId)
  local triggerScenes = guideGroupTpl:getTriggerScene(tpl)
  if table.isEmpty(triggerScenes) then
    return true
  end
  for _, id in ipairs(triggerScenes) do
    if self:checkTriggerSceneId(id, guideId) then
      return true
    end
  end
  return false
end

function this:checkTriggerSceneId(triggerId, guideId)
  local curModule = L_WorldManager:getCurModule()
  if triggerId == L_Const.guideTriggerScene.any then
    return true
  elseif triggerId == L_Const.guideTriggerScene.world then
    if curModule == L_Const.worldModule.main or curModule == L_Const.worldModule.interim then
      return true
    end
    C_MJLog.LogInfo(string.format("触发失败 gudieId: %s 仅在大世界中触发，当前类型id" .. tostring(curModule), guideId), C_ELogModule.Guide)
  elseif triggerId == L_Const.guideTriggerScene.home then
    if C_HomeUtil.IsInHome() then
      return true
    end
    C_MJLog.LogInfo(string.format("触发失败 gudieId: %s 仅在家园中触发，当前类型id" .. tostring(curModule), guideId), C_ELogModule.Guide)
  elseif triggerId == L_Const.guideTriggerScene.dungeon then
    if curModule == L_Const.worldModule.dungeon or curModule == L_Const.worldModule.multiDungeon then
      return true
    end
    C_MJLog.LogInfo(string.format("触发失败 gudieId: %s 仅在副本中触发，当前类型id" .. tostring(curModule), guideId), C_ELogModule.Guide)
  elseif triggerId == L_Const.guideTriggerScene.kiBoDuel then
    if C_KiBoDuelLuaWrapper:IsInKiBoDuel() then
      return true
    end
    C_MJLog.LogInfo(string.format("触发失败 gudieId: %s 仅在奇波对战中触发，当前类型id" .. tostring(curModule), guideId), C_ELogModule.Guide)
  elseif triggerId == L_Const.guideTriggerScene.metting then
    if curModule == L_Const.worldModule.meeting then
      return true
    end
    C_MJLog.LogInfo(string.format("触发失败 gudieId: %s 仅在metting中触发，当前类型id" .. tostring(curModule), guideId), C_ELogModule.Guide)
  elseif triggerId == L_Const.guideTriggerScene.prologue then
    if curModule == L_Const.worldModule.prologue then
      return true
    end
    C_MJLog.LogInfo(string.format("触发失败 gudieId: %s 仅在prologue中触发，当前类型id" .. tostring(curModule), guideId), C_ELogModule.Guide)
  elseif triggerId == L_Const.guideTriggerScene.homeDorm then
    if curModule == L_Const.worldModule.homeDorm then
      return true
    end
    C_MJLog.LogInfo(string.format("触发失败 gudieId: %s 仅在homeDorm中触发，当前类型id" .. tostring(curModule), guideId), C_ELogModule.Guide)
  elseif triggerId == L_Const.guideTriggerScene.culMain then
    if curModule == L_Const.worldModule.culMain then
      return true
    end
    C_MJLog.LogInfo(string.format("触发失败 gudieId: %s 仅在culMain(小玉场景)中触发，当前类型id" .. tostring(curModule), guideId), C_ELogModule.Guide)
  end
  return false
end

return this
