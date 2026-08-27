local UINChallengeTaskInfoItem = class("UINChallengeTaskInfoItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local TaskEnum = require("Game.Task.TaskEnum")

function UINChallengeTaskInfoItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItem)
  self.ui.uINBaseItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.infoItem, self, self.OnClickTaskPanel)
  self.__RefreshReddotState = BindCallback(self, self.RefreshReddotState)
  RedDotController:AddListener(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.WeeklyChallengeTask, self.__RefreshReddotState)
  self.__RefreshScoreInfo = BindCallback(self, self.RefreshScoreInfo)
  MsgCenter:AddListener(eMsgEventId.PeroidUpdate, self.__RefreshScoreInfo)
end

function UINChallengeTaskInfoItem:InitTaskInfoItem()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  local counterElem = PlayerDataCenter.allWeeklyChallengeData:GetCounterElem()
  if counterElem ~= nil then
    self.netxRefreshTimeStamp = counterElem.nextExpiredTm
    if self.netxRefreshTimeStamp ~= nil and self.netxRefreshTimeStamp > PlayerDataCenter.timestamp then
      self.timerId = TimerManager:StartTimer(1, self.CutdownTime, self, false, false, false)
      self:CutdownTime()
    end
  end
  self:RefreshScoreInfo()
  local ok, reddot = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.WeeklyChallengeTask)
  self:RefreshReddotState(reddot)
end

function UINChallengeTaskInfoItem:RefreshScoreInfo()
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  local peroidDatas = taskCtrl:GetDatas4Peroid(TaskEnum.eTaskPeriodType.WeeklyChallengeTask)
  local pointId = peroidDatas[1].stcData.activeId
  local currActiveNum = PlayerDataCenter:GetItemCount(pointId)
  local totalActiveNum = 0
  local selectPeroidData
  local isLimit = false
  for i, data in ipairs(peroidDatas) do
    totalActiveNum = data.stcData.activeNum
    if currActiveNum < totalActiveNum then
      selectPeroidData = data
      break
    elseif i == #peroidDatas then
      selectPeroidData = data
      isLimit = true
    end
  end
  self.ui.scoreText:SetIndex(0, tostring(currActiveNum), tostring(totalActiveNum))
  self.ui.obj_isLimit:SetActive(isLimit)
  self.ui.obj_isGetALL:SetActive(isLimit)
  self.ui.obj_rewardNode:SetActive(not isLimit)
  self.itemPool:HideAll()
  if isLimit then
    return
  end
  for i, itemId in ipairs(selectPeroidData.stcData.rewardIds) do
    local itemCount = selectPeroidData.stcData.rewardNums[i]
    local itemCfg = ConfigData.item[itemId]
    local item = self.itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount)
  end
end

function UINChallengeTaskInfoItem:OnClickTaskPanel()
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorTask, function(win)
    if win == nil then
      return
    end
    win:InitWeeklyChallengeTask()
  end)
end

function UINChallengeTaskInfoItem:CutdownTime()
  local remaindTime = math.max(math.floor(self.netxRefreshTimeStamp - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  local hStr = 10 <= h and tostring(h) or "0" .. tostring(h)
  local mStr = 10 <= m and tostring(m) or "0" .. tostring(m)
  local sStr = 10 <= s and tostring(s) or "0" .. tostring(s)
  if 0 < d then
    self.ui.tex_Timer:SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    self.ui.tex_Timer:SetIndex(1, hStr, mStr, sStr)
  end
  if remaindTime <= 0 and self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

function UINChallengeTaskInfoItem:RefreshReddotState(reddot)
  self.ui.redDot:SetActive(reddot ~= nil and reddot:GetRedDotCount() > 0)
end

function UINChallengeTaskInfoItem:OnHide()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  base.OnHide(self)
end

function UINChallengeTaskInfoItem:OnDelete()
  RedDotController:RemoveListener(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.WeeklyChallengeTask, self.__RefreshReddotState)
  MsgCenter:RemoveListener(eMsgEventId.PeroidUpdate, self.__RefreshScoreInfo)
  base.OnDelete(self)
end

return UINChallengeTaskInfoItem
