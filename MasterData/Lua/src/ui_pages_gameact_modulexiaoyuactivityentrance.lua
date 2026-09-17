local this = class("moduleXiaoYuActivityEntrance", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _GameEventStore = L_GameEventStore

function this.bind()
  return {
    txt_Copywriting = "",
    txt_Countdown = "",
    rewardList = {
      moduleName = "modulePages/cellIconBag"
    }
  }
end

function this.methods()
  return {
    onClick_View = function(self)
      self:openWebGame()
    end
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {id = 0}
end

function this:open()
  L_GameStore:listenCallFunc(L_GameStore.event.refreshDayChange, self.refreshEntranceReddot, self)
end

function this:close()
  L_GameStore:unListenCallFunc(L_GameStore.event.refreshDayChange, self.refreshEntranceReddot)
end

function this:setActId(id)
  self.data.id = id
  self:initData(id)
end

function this:initData(id)
  local gameEventData = _GameEventStore:getGameEventData(id)
  if not gameEventData then
    errorf("活动", "没有找到对应id的活动数据 id: " .. id)
    return
  end
  self._gameEvent = gameEventData:getGameEvent()
  local tpl = _GameEventTpl:getTplById(self.data.id)
  self.endTime = C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl))
  self:refreshCountdown(L_TimeUtil.getLeftTimeFormatString(self.endTime))
  self.timer = L_GameTimer.repeated(1, self.repeatShowTime, self)
  self:refreshView()
end

function this:refreshView()
  local tpl = _GameEventTpl:getTplById(self.data.id)
  if tpl == nil then
    return
  end
  self:refreshDesc(_GameEventTpl:getDesc(tpl))
  local rewards = _GameEventTpl:getRewardShow(tpl)
  local rewardsData = L_DataUtil.parseRewardConfig(rewards)
  local sortReward = self:sortRewardList(rewardsData)
  self:refreshRewardList(sortReward)
  self:refreshEntranceReddot()
end

function this:openWebGame()
  if math.isEmpty(self.data.id) then
    return
  end
  local gameEventData = _GameEventStore:getGameEventData(self.data.id)
  local gameEvent = gameEventData and gameEventData:getGameEvent() or nil
  print("[XiaoYuReddot] openWebGame, clearing reddot, dataId=", self.data.id, ", gameEvent=", gameEvent, ", hasClearFunc=", gameEvent and gameEvent.clearEntranceNewReddot ~= nil)
  if gameEvent and gameEvent.clearEntranceNewReddot then
    gameEvent:clearEntranceNewReddot()
  end
  self:refreshEntranceReddot()
  local webViewManager = CS.Lens.Gameplay.UI.WebView.WebViewManager()
  webViewManager:OpenWebGame(CS.Lens.Gameplay.UI.WebView.WebViewManager.WebGameType.Xiaoyu)
end

function this:refreshEntranceReddot()
  print("[XiaoYuReddot] refreshEntranceReddot called, isBind=", self.isBind, ", bindComponents=", self.bindComponents, ", reddotNew=", self.bindComponents and self.bindComponents.reddotNew)
  if not (self.isBind and self.bindComponents) or not self.bindComponents.reddotNew then
    print("[XiaoYuReddot] refreshEntranceReddot => early return, bindComponents not ready")
    return
  end
  local isShow = false
  local gameEventData = _GameEventStore:getGameEventData(self.data.id)
  local gameEvent = gameEventData and gameEventData:getGameEvent() or nil
  print("[XiaoYuReddot] refreshEntranceReddot, dataId=", self.data.id, ", gameEventData=", gameEventData, ", gameEvent=", gameEvent, ", hasSyncFunc=", gameEvent and gameEvent.syncEntranceNewReddot ~= nil)
  if gameEvent and gameEvent.syncEntranceNewReddot then
    isShow = gameEvent:syncEntranceNewReddot()
  end
  print("[XiaoYuReddot] refreshEntranceReddot => SetActive isShow=", isShow)
  self.bindComponents.reddotNew.gameObject:SetActive(isShow)
end

function this:sortRewardList(rewardsData)
  if rewardsData == nil then
    return {}
  end
  if #rewardsData <= 1 then
    return rewardsData
  end
  local result = {}
  for _, v in pairs(rewardsData) do
    local item = L_ItemTplManager:getItemConfig(v.itemType, v.itemId) or {}
    table.insert(result, {
      itemType = v.itemType,
      itemId = v.itemId,
      itemNum = v.itemNum,
      quality = item.quality or 0
    })
  end
  table.sort(result, function(a, b)
    if a.quality == b.quality then
      if a.itemType == b.itemType then
        return a.itemId < b.itemId
      else
        return a.itemType < b.itemType
      end
    else
      return a.quality > b.quality
    end
  end)
  return result
end

function this:refreshDate()
  local tpl = _GameEventTpl:getTplById(self.data.id)
  if tpl == nil then
    return
  end
  local startTime = L_TimeUtil.getDisplayTimeCustom(C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(tpl)), "!%m.%d")
  local endTime = L_TimeUtil.getDisplayTimeCustom(C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl)), "!%m.%d")
  local startMonth = startTime:sub(1, 2)
  local endMonth = endTime:sub(1, 2)
  local startDate = startTime:sub(4, 5)
  local endDate = endTime:sub(4, 5)
  local cleanStartMonth = startMonth:gsub("^0", "")
  local cleanEndMonth = endMonth:gsub("^0", "")
  self:refreshCountdown(cleanStartMonth .. "." .. startDate .. "-" .. cleanEndMonth .. "." .. endDate)
end

function this:refreshCountdown(content)
  self.bind.txt_Countdown = content or ""
end

function this:refreshDesc(desc)
  self.bind.txt_Copywriting = desc or ""
end

function this:refreshRewardList(rewardList)
  if rewardList ~= nil then
    self.bind.rewardList:clear()
    self.bind.rewardList:insert_array(rewardList)
  end
end

function this:repeatShowTime()
  local isChange, str = L_TimeUtil.tryGetLeftTimeFormatString(self.endTime, 1)
  if isChange then
    self:refreshCountdown(str)
  end
end

return this
