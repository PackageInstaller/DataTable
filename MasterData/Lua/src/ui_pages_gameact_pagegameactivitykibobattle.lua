local this = class("pageGameActivitykiboBattle", G_UIPageBase)
local _GameEventKiboDuleTpl = L_GameTpl:getGameEventsKiboDuelTpl()
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this:ctor(...)
  self.data = {
    common_bg = {
      position = L_Vector3.new(-11, -84),
      scale = L_Vector3.new(1.17, 1.17)
    },
    right_bg = {
      position = L_Vector3.new(-389.3, -59.8),
      scale = L_Vector3.new(1.1, 1.1)
    },
    defaultItemPosPC = C_Vector2(135.6, 0),
    defaultItemPosMobile = C_Vector2(186.3, 0),
    contentROrderPosPC = {
      [1] = C_Vector2(135.6, 0),
      [2] = C_Vector2(150.1, 0),
      [3] = C_Vector2(161.5, 0),
      [4] = C_Vector2(161.5, 0),
      [5] = C_Vector2(154.3, 0),
      [6] = C_Vector2(165.7, 0),
      [7] = C_Vector2(177.5, 0)
    },
    contentROrderPosMobile = {
      [1] = C_Vector2(186.3, 0),
      [2] = C_Vector2(199.2, 0),
      [3] = C_Vector2(210.6, 0),
      [4] = C_Vector2(211.1, 0),
      [5] = C_Vector2(203.4, 0),
      [6] = C_Vector2(213.7, 0),
      [7] = C_Vector2(226.6, 0)
    },
    LevelIcon = "UI/Atlas/Page/ActivityKiboBattle/tex_game_events_kiboduel_word_level_%02d.png"
  }
end

function this.bind()
  return {
    bg = true,
    bg_N = false,
    txt_activity_name = "",
    txt_desc = "",
    txt_battle = "",
    go_btn_start = nil,
    go_btn_lock = nil,
    battle_item_list = {
      moduleName = "pages/gameAct/cellActivityBattleItem"
    },
    txt_lock = "",
    txt_recommend = "",
    select_id = 0,
    reward = {
      moduleName = "pages/gameAct/moduleGameActivityReward"
    },
    content_right = false,
    img_order = "",
    anchoredPosition_order = nil,
    list_condition = {
      moduleName = "pages/gameAct/cellRewardCondition"
    },
    scrollview_velocity = Unity.Vector2(0, 0)
  }
end

function this.methods()
  return {
    onClick_enter = function(self)
      local tpl = _GameEventKiboDuleTpl:getTplById(self.kiboDuelId)
      local levelID = _GameEventKiboDuleTpl:getKiboDuelId(tpl)
      L_UI:open("pagePetDuelMain", {
        levelId = levelID,
        isRestore = true,
        pageName = "pageGameActivitykiboBattle"
      })
    end,
    onClick_clear = function(self)
      if self.bind.content_right == false then
        return
      end
      self.bind.content_right = false
      L_AudioUtil.playSound("Play_SFX_System_UI_EnTrust_Championship_UnChoose")
      if L_DeviceTpl:getIsPc() then
        self:playRootAnim("anim_act_kibobattle_level_unselected")
      else
        self:playRootAnim("anim_act_kibobattle_level_unselected_mobile")
      end
      self:playContentAnim("anim_act_kibobattle_level_content_out")
      self.bindComponents.tabGroup:DeselectAll()
      for _, v in pairs(self.modules.battle_item_list) do
        v:refreshSelectState()
      end
    end,
    onClick_clear_N = function(self)
      if self.bind.content_right == false then
        return
      end
      self.bind.content_right = false
      L_AudioUtil.playSound("Play_SFX_System_UI_EnTrust_Championship_UnChoose")
      if L_DeviceTpl:getIsPc() then
        self:playRootAnim("anim_act_kibobattle_level_unselected")
      else
        self:playRootAnim("anim_act_kibobattle_level_unselected_mobile")
      end
      self:playContentAnim("anim_act_kibobattle_level_content_out")
      self.bindComponents.tabGroup:DeselectAll()
      for _, v in pairs(self.modules.battle_item_list) do
        v:refreshSelectState()
      end
    end
  }
end

function this:check(options, callback)
  local data = L_GameEventStore:getGameEventData(20001)
  local res = false
  if data ~= nil then
    res = data:isValid()
  end
  C_MJLog.LogInfo(string.format("活动是否解锁 活动id20001"), C_ELogModule.FormationUI)
  callback(res)
end

function this:open()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity, self)
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventReward, self.refreshByData, self)
  self.eventID = 20001
  self.idList = {}
  local id_list = _GameEventKiboDuleTpl:getData()
  self.currentTime = L_TimeUtil:getServerTime()
  for i, v in pairs(id_list) do
    if v.groupId == self.eventID then
      local isTimeLock, levelStartTime = self:isLockByTime(v.id)
      table.insert(self.idList, {
        id = v.id,
        startTime = levelStartTime,
        isStart = levelStartTime <= self.currentTime,
        action = function(id)
          for index, v in ipairs(self.idList) do
            if id == v.id then
              self:refreshContent(id, index)
            end
          end
        end
      })
    end
  end
  table.sort(self.idList, function(a, b)
    return a.id < b.id
  end)
  L_AudioUtil.playSound("Play_SFX_System_UI_EnTrust_Championship_Open")
  local lastUnlockIndex = 1
  for i, v in ipairs(self.idList) do
    table.merge(v, {
      LevelIconMap = string.format(self.data.LevelIcon, i),
      index_cell = i
    })
    local isTimeLock, lockTime, endTime = self:isLockByTime(v.id)
    local isLevelPass = self:isLockByLevel(v.id)
    if isLevelPass and not isTimeLock then
      lastUnlockIndex = i
    end
  end
  self:refreshItemList(self.idList)
  self:resetListPos(lastUnlockIndex)
  self._timer = L_GameTimer.repeated(1, self.repeatCountDown, self)
  local gameEventsTpl = L_GameTpl:getGameEventsTpl()
  local tpl = gameEventsTpl:getTplById(self.eventID)
  if tpl ~= nil then
    self.bind.txt_activity_name = L_Lang:get(gameEventsTpl:getName(tpl))
  end
  self.modules.reward:initRewardData(self.eventID)
  if L_DeviceTpl:getIsPc() then
    self:playRootAnim("anim_act_kibobattle_level_in")
  else
    self:playRootAnim("anim_act_kibobattle_level_in_mobile")
  end
end

function this:close()
  if self._timer then
    L_GameTimer.remove(self._timer)
    self._timer = nil
  end
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity)
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventReward, self.refreshByData)
end

function this:refreshContent(id, index)
  if id == 0 then
    error("奇波活动" .. "关卡id为0")
    return
  end
  self.kiboDuelId = id
  self.bind.select_id = id
  local tpl = _GameEventKiboDuleTpl:getTplById(id)
  local name = _GameEventKiboDuleTpl:getName(tpl)
  local status = self.bind.content_right
  self.bind.content_right = true
  if status == false and self.bind.content_right == true then
    if L_DeviceTpl:getIsPc() then
      self:playRootAnim("anim_act_kibobattle_level_selected")
    else
      self:playRootAnim("anim_act_kibobattle_level_selected_mobile")
    end
  end
  if status == true and self.bind.content_right == true then
    self:playContentAnim("anim_act_kibobattle_level_content_change")
  end
  self.bind.txt_activity_name = name
  local desc = _GameEventKiboDuleTpl:getDesc(tpl)
  self:refreshDesc(desc)
  local battle = _GameEventKiboDuleTpl:getBuffDesc(tpl)
  self:refreshBattle(battle)
  local refreshRecommend = _GameEventKiboDuleTpl:getLevel(tpl)
  self:refreshRecommend(refreshRecommend)
  local isTimeLock, lockTime, endTime = self:isLockByTime(id)
  local isLevelPass = self:isLockByLevel(id)
  self:refreshLockContent(isTimeLock, lockTime, isLevelPass, endTime)
  local levelID = _GameEventKiboDuleTpl:getKiboDuelId(_GameEventKiboDuleTpl:getTplById(self.kiboDuelId))
  self:refreshCondition(levelID)
  self:refreshConditionStar(id)
  self:refreshLockState(isTimeLock or not isLevelPass)
  for i, v in pairs(self.modules.battle_item_list) do
    if v.bind.item_id == id then
      local index = v:GetCellIndex()
      self.bind.img_order = string.format(self.data.LevelIcon, index)
      if L_DeviceTpl:getIsPc() then
        self.bind.anchoredPosition_order = self.data.contentROrderPosPC[index] or self.data.defaultItemPosPC
      else
        self.bind.anchoredPosition_order = self.data.contentROrderPosMobile[index] or self.data.defaultItemPosMobile
      end
      self.bindComponents.rightOrderImage:SetNativeSize()
    end
    v:refreshSelectState()
  end
  if not isTimeLock then
    L_ReddotManager:markNew(L_ReddotManager.DotDef.GameAct_Events_Battle, id)
  end
  self:scrollToIndex(index, 0.8)
end

function this:scrollToIndex(index, time)
  local maxX = (index - 1) * 414.667
  local minX = maxX - 950
  local pos = self.bindComponents.contentRect.anchoredPosition
  if maxX < -pos.x then
    self.bindComponents.contentRect:DOKill()
    self.bindComponents.contentRect:DOAnchorPosX(-maxX, time):SetEase(Tweening.Ease.OutQuart)
  elseif minX > -pos.x then
    self.bindComponents.contentRect:DOKill()
    self.bindComponents.contentRect:DOAnchorPosX(-minX, time):SetEase(Tweening.Ease.OutQuart)
  end
end

function this:isLockByLevel(kiboDuelId)
  local tpl = _GameEventKiboDuleTpl:getTplById(kiboDuelId)
  local ex_id = _GameEventKiboDuleTpl:getExId(tpl)
  local ex_level_pass = false
  if ex_id == nil or ex_id == 0 then
    ex_level_pass = true
  else
    ex_level_pass = L_GameEventStore:getGameEventData(self.eventID):getGameEvent():getLevelPass(ex_id)
  end
  return ex_level_pass
end

function this:isLockByTime(kiboDuelId)
  local tpl = _GameEventKiboDuleTpl:getTplById(kiboDuelId)
  local event_id = _GameEventKiboDuleTpl:getGroupId(tpl)
  local event_tpl = _GameEventTpl:getTplById(event_id)
  local start_time = C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(event_tpl))
  local end_time = C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(event_tpl))
  local unlock_day = _GameEventKiboDuleTpl:getUnlockTime(tpl)
  local level_start_time = start_time
  if unlock_day - 1 >= 0 then
    level_start_time = start_time + (unlock_day - 1) * 86400
  end
  local isLock = level_start_time < L_TimeUtil:getServerTime() and end_time > L_TimeUtil:getServerTime()
  return not isLock, level_start_time, end_time
end

function this:refreshLockContent(isLock, level_start_time, ex_level_pass, endTime)
  if isLock then
    local diff = level_start_time - L_TimeUtil:getServerTime()
    if 0 < diff then
      local str = L_WordsTpl:getValue("ui_game_events_day_attendance_time") .. L_TimeUtil.getLeftTimeFormatString(level_start_time)
      self:refreshLockText(str)
    end
    return
  end
  if not ex_level_pass then
    self:refreshLockText(L_WordsTpl:getValue("residual_code_pagegameactivitykibobattle_01"))
    return
  end
end

function this:repeatCountDown()
  for i, v in pairs(self.idList) do
    if v.isStart == false then
      if self.currentTime >= v.startTime then
        v.isStart = true
        local isTimeLock, lockTime = self:isLockByTime(self.bind.select_id)
        local isLevelPass = self:isLockByLevel(self.bind.select_id)
        self:refreshLockContent(isTimeLock, lockTime, isLevelPass)
      end
      break
    end
  end
  self.currentTime = self.currentTime + 1
end

function this:endActivity(eventID)
  if eventID == self.eventID then
    L_UI:close("pageGameActivitykiboBattle")
  end
end

function this:playRootAnim(name)
  if self.bindComponents.rootAnim ~= nil then
    self.bindComponents.rootAnim:Play(name)
  end
end

function this:playContentAnim(name)
  if self.bindComponents.content_right ~= nil then
    self.bindComponents.content_right:Play(name)
  end
end

function this:refreshTitle(title)
  self.bind.txt_title = title
end

function this:refreshDesc(desc)
  self.bind.txt_desc = desc
end

function this:refreshBattle(battle)
  self.bind.txt_battle = "       " .. battle
end

function this:refreshLockState(isLock)
  self.bind.go_btn_start = not isLock
  self.bind.go_btn_lock = isLock
end

function this:refreshLockText(lockText)
  self.bind.txt_lock = lockText
end

function this:refreshRecommend(recommend)
  local result = L_GameTpl:getWordsTpl():getTplById("ui_gameevents_kiboduel_recommendedlevel", {
    [1] = recommend
  })
  self.bind.txt_recommend = tostring(result)
end

function this:refreshItemList(itemList)
  if itemList ~= nil then
    self.bind.battle_item_list:insert_array(itemList)
    for i = 7, #itemList do
      local ref = self.bind.battle_item_list:getItemCls(i - 6).gameObject.transform
      local modify = self.bind.battle_item_list:getItemCls(i).gameObject.transform
      modify.anchorMin = Unity.Vector2(0, 0)
      modify.anchorMax = Unity.Vector2(0, 0)
      modify.anchoredPosition = ref.anchoredPosition + Unity.Vector2(2488, 0)
    end
    local rect = self.bindComponents.contentRect.rect
    self.bindComponents.contentRect.sizeDelta = Unity.Vector2(#itemList * 414.667 + 1036, rect.height)
  end
end

function this:resetListPos(index)
  local maxX = (index - 3) * 414.667
  local minX = maxX - 950
  self.bindComponents.content.anchoredPosition = Unity.Vector2(0 < minX and -minX or 0, 0)
end

function this:refreshCondition(levelId)
  local kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
  local commonConditionTpl = L_GameTpl:getCommonConditionTpl()
  local tpl = kiBoDuelTpl:getTplById(levelId)
  local challengeList = kiBoDuelTpl:getChallenge(tpl)
  local tmp = {}
  for i = 1, #challengeList do
    local tpl_commonCondition = commonConditionTpl:getTplById(challengeList[i][1])
    local time = challengeList[i][2]
    local descShow = commonConditionTpl:getDescShowKey(tpl_commonCondition)
    table.insert(tmp, {
      time = time,
      txt_condition_lock = string.gsub(descShow, "{time}", tostring(time)),
      txt_condition = string.gsub(descShow, "{time}", tostring(time))
    })
  end
  self.bind.list_condition:clear()
  self.bind.list_condition:insert_array(tmp)
end

function this:refreshConditionStar(id)
  local tpl = _GameEventKiboDuleTpl:getTplById(id)
  local level_id = _GameEventKiboDuleTpl:getKiboDuelId(tpl)
  local starData = L_PetDuelStore:getKiBoDuelStar(level_id)
  local starNum = 0
  if starData ~= nil then
    for i, v in pairs(starData) do
      if v then
        starNum = starNum + 1
      end
    end
  end
  local i = 0
  for _, v in pairs(self.modules.list_condition) do
    if starNum <= i then
      break
    end
    v:refreshSuccess(true)
    i = i + 1
  end
end

function this:refreshBg()
  if self.bind.content_right == false then
  end
end

function this:refreshByData()
  self.modules.reward:initRewardData(self.eventID)
end

return this
