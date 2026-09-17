local this = class("moduleActivitySurvey", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _GameEventsKiboSurveyTpl = L_GameTpl:getGameEventsKiboSurveyTpl()
local _petTpl = L_GameTpl:getPetTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    textDate = "",
    textDesc = "",
    listReward = {
      moduleName = "pages/gameAct/cellActivitySurveyAward"
    },
    listTab = {
      moduleName = "pages/gameAct/cellActivitySurveyDay"
    },
    listKibo = {
      moduleName = "pages/gameAct/cellActivitySurveyKibo"
    },
    active_going = false,
    active_report = false,
    active_complete = false,
    active_extra = false,
    text_extra = ""
  }
end

function this.methods()
  return {
    onClick_help = function(self)
      if math.isEmpty(self.helpGroupId) then
        return
      end
      L_UI:open("pageCommonIntroduction", {
        groupId = self.helpGroupId
      })
    end,
    onClick_going = function(self)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_activity_kiboresearch_tips"))
    end,
    onClick_report = function(self)
    end,
    onClick_complete = function(self)
    end,
    listTab = {
      onClick_select = function(self, selectId)
        self.selectId = selectId
        self:refreshSelect()
      end
    }
  }
end

function this:setActId(id)
  self.actId = id
  self:init()
end

function this:closeFx()
end

function this:init()
  self.tpl = _GameEventTpl:getTplById(self.actId)
  self:initBg()
  self._data = L_GameEventStore:getGameEventData(self.actId)
  self.bind.textDesc = L_Lang:get(_GameEventTpl:getDesc(self.tpl))
  self.helpGroupId = _GameEventTpl:getHelp(self.tpl)
  self:initTabList()
  self.endTime = C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(self.tpl))
  self.bind.textDate = L_TimeUtil.getLeftTimeFormatString(self.endTime)
  local EndTime = self.endTime - L_TimeUtil.getServerTime()
  if EndTime <= 0 then
    self.timer = L_GameTimer.repeated(1, self.repeatShowTime, self)
  else
    self:disposeTimer()
  end
end

function this:initTabList()
  local systemId = _GameEventTpl:getSystemId(self.tpl)
  self.systemId = systemId
  self.groupData = _GameEventsKiboSurveyTpl:getGroupData(systemId)
  local curDay = self._data.curDay
  local tabData = {}
  for i, v in ipairs(self.groupData) do
    tabData[i] = {
      id = v.id,
      systemId = systemId,
      name = v.name,
      isLock = i > curDay,
      isFinish = self._data.finishList[v.id]
    }
  end
  self.bind.listTab:clear()
  self.bind.listTab:insert_array(tabData)
  local selectId = 0
  for i = 1, curDay do
    local id = self.groupData[i].id
    local gameEvent = self._data:getGameEvent()
    if gameEvent:getHasAward(id) then
      selectId = id
      break
    end
  end
  if selectId == 0 then
    for i = 1, curDay do
      local id = self.groupData[i].id
      local totalFinish = self._data.finishList[id] or false
      if not totalFinish then
        selectId = id
        break
      end
    end
  end
  if 0 < selectId then
    self.selectId = selectId
  else
    self.selectId = self.groupData[curDay].id
  end
  self:refreshSelect()
end

function this:refreshSelect()
  for i = 1, #self.bind.listTab do
    local cell = self.bind.listTab:getItemCls(i)
    cell:refreshSelect(self.selectId)
  end
  self:updateKiboList()
  self:updateRewards()
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.GameAct_Events_Survey_New, true)
  L_ReddotManager:markNew(L_ReddotManager.DotDef.GameAct_Events_Survey_New, self.selectId, true)
end

function this:updateKiboList()
  local surveyTpl = _GameEventsKiboSurveyTpl:getTplById(self.selectId)
  local kiboMission = _GameEventsKiboSurveyTpl:getKiboMission(surveyTpl)
  local kiboData = {}
  local totalFinish = self._data.finishList[self.selectId] or false
  local finishedCount = 0
  for i, v in ipairs(kiboMission) do
    local tpl = _petTpl:getTplById(v[2])
    local petCardPath = _petTpl:getKiboCardIcon(tpl, false)
    local curNum = totalFinish and v[3] or self._data.kiboList[v[2]] or 0
    local maxNum = v[3]
    local text = curNum .. "/" .. maxNum
    kiboData[i] = {
      id = v[2],
      image = petCardPath,
      text = text,
      isFinish = curNum >= maxNum or totalFinish,
      score = v[4]
    }
    if curNum >= maxNum or totalFinish then
      finishedCount = finishedCount + 1
    end
  end
  self.bind.listKibo:clear()
  self.bind.listKibo:insert_array(kiboData)
  local totalNum = #kiboMission
  local needNum = _GameEventsKiboSurveyTpl:getKiboMissionSelect(surveyTpl)
  if totalNum > needNum then
    self.bind.active_extra = true
    self.bind.text_extra = L_WordsTpl:getValue("ui_activity_kiboresearch_dailygoal", {
      [0] = needNum,
      [1] = finishedCount,
      [2] = needNum
    })
  else
    self.bind.active_extra = false
  end
  local isFinish = finishedCount >= needNum
  self.bind.active_going = not totalFinish and not isFinish
  self.bind.active_report = not totalFinish and isFinish
  self.bind.active_complete = totalFinish
end

function this:updateRewards()
  local surveyTpl = _GameEventsKiboSurveyTpl:getTplById(self.selectId)
  local dropId = _GameEventsKiboSurveyTpl:getDropId(surveyTpl)
  local dropTpl = L_GameTpl:getDropTpl()
  local dropGroup = dropTpl:getDropGroup(dropId)
  local rewardsData = {}
  local totalFinish = self._data.finishList[self.selectId] or false
  for _, v in pairs(dropGroup) do
    local itemId = dropTpl:getItemId(v)
    local itemType = dropTpl:getType(v)
    local rewardNum = dropTpl:getMinValue(v)
    table.insert(rewardsData, {
      itemType = itemType,
      itemId = itemId,
      itemNum = rewardNum,
      active_mask = totalFinish,
      active_finish = totalFinish
    })
  end
  self.bind.listReward:clear()
  self.bind.listReward:insert_array(rewardsData)
  self:registerReddot(self.bindComponents.reddotNormal, string.format(L_ReddotManager.DotDef.GameAct_Events_Survey_Award, self.selectId))
end

function this:initBg()
end

function this:initRedPoint()
end

function this:preOpen(options)
  self._data = {}
  self.timer = nil
  self.helpGroupId = 1
  self.isUnlock = false
end

function this:open()
end

function this:show()
end

function this:repeatShowTime()
  local isChange, str = L_TimeUtil.tryGetLeftTimeFormatString(self.endTime, 1)
  if isChange then
    self.bind.textDate = str
  end
end

function this:close()
  self:disposeTimer()
end

function this:disposeTimer()
  if self.timer ~= nil then
    self.timer:stop()
    Timer.remove(self.timer)
    self.timer = nil
  end
end

return this
