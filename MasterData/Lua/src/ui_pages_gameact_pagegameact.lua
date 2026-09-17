local this = class("pageGameAct", G_UIPageBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    Type2TextColor = {
      [L_Const.ActivityType.AT_DOUBLE_DROP] = "#fffefb",
      [L_Const.ActivityType.AT_SUBMIT_ITEM_TASK] = "#fff7f8",
      [L_Const.ActivityType.AT_KIBO_DUEL] = "#f9fdff",
      [L_Const.ActivityType.AT_Only_Show] = "#FFF7EC",
      [L_Const.ActivityType.AT_PARTY] = "#fffefb",
      [L_Const.ActivityType.AT_Companion] = "#fffefb",
      [L_Const.ActivityType.AT_NDAY] = "#fff7f8",
      [L_Const.ActivityType.AT_Level] = "#fffefb",
      [L_Const.ActivityType.AT_GROWUP] = "#fff7f8"
    },
    Type2TextOutlineColor = {
      [L_Const.ActivityType.AT_DOUBLE_DROP] = "#d2962cb3",
      [L_Const.ActivityType.AT_SUBMIT_ITEM_TASK] = "#b55b5b80",
      [L_Const.ActivityType.AT_KIBO_DUEL] = "#393c6b48",
      [L_Const.ActivityType.AT_Only_Show] = "#7B634F80",
      [L_Const.ActivityType.AT_PARTY] = "#505f8b80",
      [L_Const.ActivityType.AT_Companion] = "#505f8b80",
      [L_Const.ActivityType.AT_NDAY] = "#38554d7f",
      [L_Const.ActivityType.AT_Level] = "#2b68c3b2",
      [L_Const.ActivityType.AT_GROWUP] = "#b55b5b80"
    }
  }
end

function this.bind()
  return {
    activity_list = {
      moduleName = "pages/gameAct/cellGameActivityItem"
    },
    gameActModule = {
      type = "toggleModule",
      moduleAttendance = {
        assetName = "UI/Pages/GameAct/Modules/moduleAttendance",
        moduleName = "pages/gameAct/moduleAttendance"
      },
      moduleGameActivityTask = {
        assetName = "UI/Pages/GameAct/Modules/moduleGameActivityTask",
        moduleName = "pages/gameAct/moduleGameActivityTask"
      },
      moduleGameActivityCommit = {
        assetName = "UI/Pages/GameAct/Modules/moduleActivityCommit",
        moduleName = "pages/gameAct/moduleActivityCommit"
      },
      moduleGameActivityKiboBattle = {
        assetName = "UI/Pages/GameAct/Modules/moduleGameActivityKiboBattle",
        moduleName = "pages/gameAct/moduleGameActivityKiboBattle"
      },
      moduleGameActivityDoubleReward = {
        assetName = "UI/Pages/GameAct/Modules/moduleGameActivityDoubleReward",
        moduleName = "pages/gameAct/doubleDrop/moduleGameActivityDoubleReward"
      },
      moduleLimitedTimeActivity = {
        assetName = "UI/Pages/GameAct/Modules/moduleLimitedTimeActivity",
        moduleName = "pages/gameAct/limitedTimeActivity/moduleLimitedTimeActivity"
      },
      moduleGameActivitySpecialProbabilityBoost = {
        assetName = "UI/Pages/GameAct/Modules/moduleGameActivitySpecialProbabilityBoost",
        moduleName = "pages/gameAct/moduleGameActivitySpecialProbabilityBoost"
      },
      moduleGameActivityKiboTravel = {
        assetName = "UI/Pages/GameAct/Modules/moduleGameActivityKiboTravel",
        moduleName = "pages/gameAct/moduleGameActivityKiboTravel"
      },
      moduleXiaoYuActivityEntrance = {
        assetName = "UI/Pages/GameAct/Modules/moduleActivityEvent8001Entrance",
        moduleName = "pages/gameAct/moduleXiaoYuActivityEntrance"
      },
      moduleActivityParty = {
        assetName = "UI/Pages/GameAct/Modules/moduleActivityParty",
        moduleName = "pages/gameAct/moduleActivityParty"
      },
      moduleActivityScenario = {
        assetName = "UI/Pages/GameAct/Modules/moduleActivityScenario",
        moduleName = "pages/gameAct/moduleActivityScenario"
      },
      moduleActivityBondsMission = {
        assetName = "UI/Pages/GameAct/Modules/moduleActivityBondsMission",
        moduleName = "pages/gameAct/moduleActivityBondsMission"
      },
      moduleActivitySurvey = {
        assetName = "UI/Pages/GameAct/Modules/moduleActivitySurvey",
        moduleName = "pages/gameAct/moduleActivitySurvey"
      },
      moduleGameActivityRedungeon = {
        assetName = "UI/Pages/GameAct/Modules/moduleGameActivityRedungeon",
        moduleName = "pages/gameAct/moduleGameActivityRedungeon"
      },
      moduleGameActivityMainTaskReward = {
        assetName = "UI/Pages/GameAct/Modules/moduleGameActivityMainTaskReward",
        moduleName = "pages/gameAct/mainTaskReward/moduleGameActivityMainTaskReward"
      },
      moduleNDaysActivity = {
        assetName = "UI/Pages/GameAct/Modules/moduleNDaysActivity",
        moduleName = "pages/gameAct/nDaysActivity/moduleNDaysActivity"
      },
      moduleGameActivityStarLevel = {
        assetName = "UI/Pages/GameAct/Modules/moduleGameActivityStarLevel",
        moduleName = "pages/gameAct/ActivityStarLevel/moduleGameActivityStarLevel"
      },
      moduleActivityHeroTrial = {
        assetName = "UI/Pages/GameAct/Modules/moduleActivityHeroTrial",
        moduleName = "pages/gameAct/moduleActivityHeroTrial"
      },
      moduleActivityTravelLog = {
        assetName = "UI/Pages/GameAct/Modules/moduleActivityTravelLog",
        moduleName = "pages/gameAct/moduleActivityTravelLog"
      },
      moduleActivitySunSet = {
        assetName = "UI/Pages/GameAct/Modules/moduleActivitySunSet",
        moduleName = "pages/gameAct/moduleActivitySunSet"
      }
    },
    gameActModuleName = "",
    active_signBtn = false,
    text_signEventDate = "",
    active_modulePTShop = false,
    modulePTShop = {
      moduleName = "pages/gameAct/moduleActivityPTShopButton"
    }
  }
end

function this.methods()
  return {
    onClick_sign = function(self)
      L_UI:open("pageActivityNDaySign", {
        gameEventType = L_Const.ActivityType.AT_DAILY_SIGN
      })
    end,
    activity_list = {
      onClick = function(self, data)
        print("当前活动id:", data.id)
        self.actId = data.id
        self.gameEventId = self.actId
        self:refreshActivityList(data.id, true)
        self:playSoundWhenShowDynamicModule()
      end
    }
  }
end

function this:check(options, callback)
  if AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    callback(false)
    return
  end
  if C_BattleManager.IsInBossBattle() then
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.gameAct)
  callback(result)
end

function this:preOpen(options)
  self.isShow = true
  options = options or {}
  if options.jumpParams then
    self.gameEventId = tonumber(options.jumpParams[1])
    if options.jumpParams[2] then
      self.gameEventParam = tonumber(options.jumpParams[2])
    end
  else
    self.gameEventId = options.gameEventId or 0
    self.gameEventParam = options.gameEventParam or nil
  end
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventSync, self.onUpdatePage, self)
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventReward, self.onUpdatePage, self)
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity, self)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.syncActAttrInfoComplete, self.onUpdatePtShopButton, self)
  self:initPage()
end

function this:hide()
  self.isShow = false
end

function this:show()
  self.isShow = true
  self:initPage(true)
  self:playSoundWhenShowDynamicModule()
  self.isFirstPlaySound = true
end

function this:close(options)
  self.isShow = false
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventSync, self.onUpdatePage)
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventReward, self.onUpdatePage)
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.syncActAttrInfoComplete, self.onUpdatePtShopButton)
  L_TimerManager:clearTimer(self)
end

function this:onUpdatePage()
  self:initPage(false)
  self:playSoundWhenShowDynamicModule()
end

function this:initPage(isUpdatePage)
  if self.isShow == false then
    return
  end
  local act_data = L_GameEventStore:getAllGameEventDatas()
  self.actData = {}
  for i, v in pairs(act_data) do
    if v:isShow() then
      local tpl = _GameEventTpl:getTplById(v.id)
      local name = L_Lang:get(_GameEventTpl:getName(tpl))
      local isShowInList = _GameEventTpl:getShow(tpl) == 1
      local eType = _GameEventTpl:getType(tpl)
      local _, txtColor = C_ColorUtility.TryParseHtmlString(self.data.Type2TextColor[eType] and self.data.Type2TextColor[eType] or "#FFF7EC")
      local _, txtOutlineColor = C_ColorUtility.TryParseHtmlString(self.data.Type2TextOutlineColor[eType] and self.data.Type2TextOutlineColor[eType] or "#7B634F80")
      local isComplete = false
      if L_GameEventStore:getGameEventData(v.id):getGameEvent() then
        isComplete = L_GameEventStore:getGameEventData(v.id):getGameEvent():isActivityCompleted()
        if L_GameEventStore:getGameEventData(v.id):getGameEvent().isActivityCompletedNeedEnd then
          isShowInList = not L_GameEventStore:getGameEventData(v.id):getGameEvent():isActivityCompletedNeedEnd()
        end
      end
      if isShowInList then
        table.insert(self.actData, {
          id = v.id,
          act_name = name,
          act_name_selected = name,
          reddotName = string.format(L_ReddotManager.DotDef.GameAct_New, v.id),
          sort = _GameEventTpl:getSort(tpl),
          img_type = _GameEventTpl:getTypeIcon(tpl),
          img_choose_head = _GameEventTpl:getTypeHead(tpl),
          img_choose_bg = _GameEventTpl:getTabBg(tpl),
          txt_color = txtColor,
          txt_outlineColor = txtOutlineColor,
          completed = isComplete,
          isChoose = v.id == self.actId
        })
      end
    end
  end
  table.sort(self.actData, function(a, b)
    if a.completed ~= b.completed then
      return b.completed
    else
      return a.sort < b.sort
    end
  end)
  self.bind.activity_list:clear()
  if #self.actData > 0 then
    self.bind.activity_list:insert_array(self.actData)
    if not isUpdatePage then
      self.actId = not math.isEmpty(self.gameEventId) and self.gameEventId or self.actData[1].id
    end
  end
  self.isFirstPlaySound = false
  self:refreshActivityList(self.actId, not self.isFirstPlaySound and true)
  self.bind.active_signBtn = false
  local sevenDaySignGameEventData = L_GameEventStore:getDataByType(L_Const.ActivityType.AT_DAILY_SIGN)
  if sevenDaySignGameEventData and sevenDaySignGameEventData:canParticipateIn() then
    self.bind.active_signBtn = true
    local sevenDaySignGameEventId = sevenDaySignGameEventData:getActivityId()
    local startTime = L_TimeUtil.getDisplayTimeCustom(sevenDaySignGameEventData:getStartTime(), "!%m.%d")
    local endTime = L_TimeUtil.getDisplayTimeCustom(sevenDaySignGameEventData:getEndTime(), "!%m.%d")
    self.bind.text_signEventDate = L_WordsTpl:getValue("ui_game_events_end_time")
    self:registerReddot(self.bindComponents.trans_signEventRedDot, string.format(L_ReddotManager.DotDef.GameAct_EventsInCenter, sevenDaySignGameEventId))
  end
end

function this:addFackActiveData()
  local id = _GameEventTpl:getFackId()
  local tpl = _GameEventTpl:getTplById(id)
  local name = L_Lang:get(_GameEventTpl:getName(tpl))
  local isShowInList = _GameEventTpl:getShow(tpl) == 1
  local eType = _GameEventTpl:getType(tpl)
  local _, txtColor = C_ColorUtility.TryParseHtmlString(self.data.Type2TextColor[eType] and self.data.Type2TextColor[eType] or "#FFF7EC")
  local _, txtOutlineColor = C_ColorUtility.TryParseHtmlString(self.data.Type2TextOutlineColor[eType] and self.data.Type2TextOutlineColor[eType] or "#7B634F80")
  table.insert(self.actData, {
    id = _GameEventTpl:getFackId(),
    act_name = name,
    act_name_selected = name,
    reddotName = string.format(L_ReddotManager.DotDef.GameAct_New, id),
    sort = _GameEventTpl:getSort(tpl),
    img_type = _GameEventTpl:getTypeIcon(tpl),
    img_choose_head = _GameEventTpl:getTypeHead(tpl),
    img_choose_bg = _GameEventTpl:getTabBg(tpl),
    txt_color = txtColor,
    txt_outlineColor = txtOutlineColor,
    isChoose = _GameEventTpl:getFackId() == self.actId
  })
end

function this:refreshActivityList(id, withSound)
  self:initModulePage(id)
  for i = 1, #self.bind.activity_list do
    if self.bind.activity_list:getValue(i, "id") == id then
      self.bind.activity_list:change(i, {isChoose = true})
      local singleEventRedDot = false
      local gameEvent = L_GameEventStore:getGameEventData(id):getGameEvent()
      if gameEvent ~= nil then
        singleEventRedDot = gameEvent:getRedState()
      end
      if not singleEventRedDot and gameEvent then
        singleEventRedDot = gameEvent:getPtShopRedState()
      end
      if not singleEventRedDot and not string.isEmpty(string.format(L_ReddotManager.DotDef.GameAct_New, id)) then
        L_ReddotManager:clearNew(L_ReddotManager.DotDef.GameAct_New, id)
      end
    else
      self.bind.activity_list:change(i, {isChoose = false})
    end
  end
  if withSound == true then
  end
  if id then
    local tpl = _GameEventTpl:getTplById(id)
    local eType = _GameEventTpl:getType(tpl)
    local eventData = {activity_type = eType, activity_id = id}
    L_GameUtil.logEvent(L_Const.logEventName.activity_page_center_click, eventData)
  end
end

function this:initModulePage(id)
  if id then
    local tpl = _GameEventTpl:getTplById(id)
    local eType = _GameEventTpl:getType(tpl)
    if self.bind.gameActModuleName == L_GameEventStore.GameEventModules[L_Const.ActivityType.AT_SUBMIT_ITEM_TASK] then
      self.modules.gameActModule[L_GameEventStore.GameEventModules[L_Const.ActivityType.AT_SUBMIT_ITEM_TASK]]:closeFx(id)
    end
    self.bind.gameActModuleName = L_GameEventStore.GameEventModules[eType]
    local module = self.modules.gameActModule[L_GameEventStore.GameEventModules[eType]]
    module:setActId(id)
    if self.gameEventParam ~= nil and type(module.setActParam) == "function" then
      module:setActParam(self.gameEventParam)
      self.gameEventParam = nil
    end
    local tpl = _GameEventTpl:getTplById(self.actId)
    local ptShopId = _GameEventTpl:getPtShopId(tpl)
    local currencyId = _GameEventTpl:getPtCurrencyId(tpl)
    local currencyMax = _GameEventTpl:getPtCurrencyMax(tpl)
    if 0 < ptShopId and 0 < currencyId then
      if module.setPtShopButton then
        self.bind.active_modulePTShop = false
        module:setPtShopButton(ptShopId, currencyId, currencyMax)
      else
        self.bind.active_modulePTShop = true
        self.modules.modulePTShop:setActData(self.actId, ptShopId, currencyId, currencyMax)
      end
    else
      self.bind.active_modulePTShop = false
    end
  else
    self.bind.gameActModuleName = ""
    self.bind.active_modulePTShop = false
  end
end

function this:endActivity(activityId)
  if activityId == L_Const.ActivityType.AT_Kibo_Tour_Group then
    L_UI:close("PageGameActkiboDispatchSet")
  end
  self:initPage()
end

function this:playSoundWhenShowDynamicModule()
  if self.bind.gameActModuleName == L_GameEventStore.GameEventModules[L_Const.ActivityType.AT_SUBMIT_ITEM_TASK] then
    L_AudioUtil.playSound("Play_SFX_System_UI_Activity_BigPlan")
  elseif self.bind.gameActModuleName == L_GameEventStore.GameEventModules[L_Const.ActivityType.AT_DOUBLE_DROP] then
    L_AudioUtil.playSound("Play_SFX_System_UI_Activity_DoubleReward")
  elseif self.bind.gameActModuleName == L_GameEventStore.GameEventModules[L_Const.ActivityType.AT_KIBO_DUEL] then
    L_AudioUtil.playSound("Play_SFX_System_UI_Activity_Championship")
  elseif self.bind.gameActModuleName == L_GameEventStore.GameEventModules[L_Const.ActivityType.AT_Only_Show] then
    L_AudioUtil.playSound("Play_SFX_System_UI_Activity_ChanceUP")
  elseif self.bind.gameActModuleName == L_GameEventStore.GameEventModules[L_Const.ActivityType.AT_Companion] then
    L_AudioUtil.playSound("Play_SFX_System_UI_Activity_DoubleReward")
  elseif self.bind.gameActModuleName == L_GameEventStore.GameEventModules[L_Const.ActivityType.AT_JADEGAME_WEB] then
    L_AudioUtil.playSound("Play_SFX_System_UI_Activity_TuShanXiaoYu")
  end
end

function this:onUpdatePtShopButton()
  if self.actId and self.actId > 0 then
    local tpl = _GameEventTpl:getTplById(self.actId)
    local ptShopId = _GameEventTpl:getPtShopId(tpl)
    local currencyId = _GameEventTpl:getPtCurrencyId(tpl)
    local currencyMax = _GameEventTpl:getPtCurrencyMax(tpl)
    if 0 < ptShopId and 0 < currencyId then
      self.modules.modulePTShop:setActData(self.actId, ptShopId, currencyId, currencyMax)
    end
  end
end

return this
