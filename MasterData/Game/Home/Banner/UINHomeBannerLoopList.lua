local UINHomeBannerLoopList = class("UINHomeBannerLoopList", UIBaseNode)
local base = UIBaseNode
local CS_EventTriggerListener = CS.EventTriggerListener
local UINHomeBannerPicItem = require("Game.Home.Banner.UINHomeBannerPicItem")
local HomeBannerManager = require("Game.Home.Banner.HomeBannerManager")

function UINHomeBannerLoopList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__isAutoPlay = true
  self.__LoopListNum = 0
  self.__curIndex = nil
  self.couldRoll2Next = true
  self.interval = 3
  self.picItems = {
    befor = UINHomeBannerPicItem.New(),
    cur = UINHomeBannerPicItem.New(),
    next = UINHomeBannerPicItem.New()
  }
  self.picItems.befor:Init(self.ui.advItemArray[1])
  self.picItems.cur:Init(self.ui.advItemArray[2])
  self.picItems.next:Init(self.ui.advItemArray[3])
  UIUtil.AddButtonListener(self.picItems.befor.ui.button, self, self.__OnAdvItemClick)
  UIUtil.AddButtonListener(self.picItems.cur.ui.button, self, self.__OnAdvItemClick)
  UIUtil.AddButtonListener(self.picItems.next.ui.button, self, self.__OnAdvItemClick)
  local eventTrigger = CS_EventTriggerListener.Get(self.gameObject)
  eventTrigger:onBeginDrag("+", BindCallback(self, self.__OnBeginDrag))
  eventTrigger:onDrag("+", BindCallback(self, self.__OnDrag))
  eventTrigger:onEndDrag("+", BindCallback(self, self.__OnEndDrag))
  eventTrigger:onEnter("+", BindCallback(self, self.__OnPointerEnter))
  eventTrigger:onExit("+", BindCallback(self, self.__OnPointerExit))
  self.ui.scrollRect.onValueChanged:AddListener(BindCallback(self, self.__OnValueChanged))
  self.m_OnLateUpdate = BindCallback(self, self.OnLateUpdate)
  UpdateManager:AddLateUpdate(self.m_OnLateUpdate)
  TimerManager:StopTimer(self.__pointerExitDelayCheckTimerId)
  self.__pointerExitDelayCheckTimerId = TimerManager:StartTimer(1.5, function()
    if self.__isAutoPlay == false and (self.__PointerExitCheckerCondition == nil or self.__PointerExitCheckerCondition()) then
      self.__isAutoPlay = true
    end
    TimerManager:PauseTimer(self.__pointerExitDelayCheckTimerId)
  end, self)
  TimerManager:PauseTimer(self.__pointerExitDelayCheckTimerId)
  self.__onPointerStaty = false
end

function UINHomeBannerLoopList:SetLoopBannerDataList(bannerDataList, initIndex, onPageIndexChange)
  self.bannerDataList = bannerDataList
  self.onPageIndexChange = onPageIndexChange
  self.__LoopListNum = #bannerDataList
  if initIndex > #bannerDataList then
    initIndex = 1
  end
  if #bannerDataList == 1 then
    self.ui.scrollRect.horizontal = false
    self.__isAutoPlay = false
  else
    self.ui.scrollRect.horizontal = true
    self.__isAutoPlay = true
  end
  self.__curIndex = initIndex
  local beforIndex = initIndex - 1
  if beforIndex <= 0 then
    beforIndex = self.__LoopListNum
  end
  local nextIndex = 1 % self.__LoopListNum + 1
  self.picItems.befor:InitHomeBannerPicItem(bannerDataList[beforIndex])
  self.picItems.cur:InitHomeBannerPicItem(bannerDataList[initIndex])
  self.picItems.next:InitHomeBannerPicItem(bannerDataList[nextIndex])
  self.ui.scrollRect.horizontalNormalizedPosition = 0.5
  self:Roll2Pos(0.5)
  self:__OnPageIndexChange()
  self.autoStartTime = Time.time
end

function UINHomeBannerLoopList:__OnBeginDrag(go, eventData)
  if self.__LoopListNum <= 1 then
    return
  end
  self.__IsDraging = true
  self.__beginEventData = eventData
  self.__needRoll = false
  self.rollOverCallback = false
  self.couldRoll2Next = true
end

function UINHomeBannerLoopList:__OnDrag(go, eventData)
  self.__lastPointX = eventData.position.x
end

function UINHomeBannerLoopList:__OnEndDrag(go, eventData)
  if self.__LoopListNum <= 1 then
    return
  end
  self.autoStartTime = Time.time
  self.__IsDraging = false
  local lastPointChange = eventData.position.x - (self.__lastPointX or eventData.position.x)
  self.__lastPointX = nil
  if self.__notSwitch and math.abs(lastPointChange) > 0.1 / Time.deltaTime then
    if 0 < lastPointChange then
      self:Roll2Before()
      self.ui.scrollRect.horizontalNormalizedPosition = self.ui.scrollRect.horizontalNormalizedPosition + 0.5
    else
      self:Roll2Next()
      self.ui.scrollRect.horizontalNormalizedPosition = self.ui.scrollRect.horizontalNormalizedPosition - 0.5
    end
    self.couldRoll2Next = false
  end
  self:Roll2Pos(0.5)
end

function UINHomeBannerLoopList:__OnPointerEnter()
  self.__onPointerStaty = true
  self.__isAutoPlay = false
end

function UINHomeBannerLoopList:__OnPointerExit()
  self.__onPointerStaty = false
  if self.__pointerExitDelayCheckTimerId ~= nil then
    TimerManager:ResetTimer(self.__pointerExitDelayCheckTimerId)
    TimerManager:ResumeTimer(self.__pointerExitDelayCheckTimerId)
  end
end

function UINHomeBannerLoopList:SetPointerExitSucChecker(condiotnCall)
  self.__PointerExitCheckerCondition = condiotnCall
end

function UINHomeBannerLoopList:__OnValueChanged(pos)
  if self.couldRoll2Next then
    local hnp = self.ui.scrollRect.horizontalNormalizedPosition
    if 0.8 <= hnp then
      self:Roll2Next()
      self.ui.scrollRect.horizontalNormalizedPosition = hnp - 0.5
      self.ui.scrollRect:OnBeginDrag(self.__beginEventData)
      self.__notSwitch = false
    elseif hnp <= 0.2 then
      self:Roll2Before()
      self.ui.scrollRect.horizontalNormalizedPosition = hnp + 0.5
      self.ui.scrollRect:OnBeginDrag(self.__beginEventData)
      self.__notSwitch = false
    else
      self.__notSwitch = true
    end
  end
end

function UINHomeBannerLoopList:OnLateUpdate()
  if self.__needRoll then
    if math.abs(self.ui.scrollRect.horizontalNormalizedPosition - self.__scrollNPos) < 0.01 then
      self.__needRoll = false
      self.ui.scrollRect.horizontalNormalizedPosition = self.__scrollNPos
      if self.rollOverCallback ~= nil then
        self.rollOverCallback()
        self.rollOverCallback = nil
      end
      return
    end
    self.passedTime = self.passedTime + Time.deltaTime
    self.ui.scrollRect.horizontalNormalizedPosition = Mathf.Lerp(self.__currNPos, self.__scrollNPos, self.passedTime / self.totalCostTime)
  end
  if self.__isAutoPlay then
    self:CheckTime(Time.time)
  end
end

function UINHomeBannerLoopList:Roll2Pos(pos, callback)
  self.rollOverCallback = callback
  self.__scrollNPos = pos
  self.__needRoll = true
  self.__currNPos = self.ui.scrollRect.horizontalNormalizedPosition
  self.totalCostTime = math.abs(self.__scrollNPos - self.__currNPos) / 3
  self.passedTime = 0
end

function UINHomeBannerLoopList:Roll2Next()
  local beforIndex = self.__curIndex
  local curIndex = self.__curIndex % self.__LoopListNum + 1
  local nextIndex = curIndex % self.__LoopListNum + 1
  self.picItems.befor.transform:SetAsLastSibling()
  self.picItems.befor:InitHomeBannerPicItem(self.bannerDataList[nextIndex])
  local oldCur = self.picItems.cur
  self.picItems.cur = self.picItems.next
  self.picItems.next = self.picItems.befor
  self.picItems.befor = oldCur
  self.__curIndex = curIndex
  self:__OnPageIndexChange()
end

function UINHomeBannerLoopList:Roll2Before()
  local nextIndex = self.__curIndex
  local curIndex = self.__curIndex - 1
  if curIndex <= 0 then
    curIndex = self.__LoopListNum
  end
  local beforIndex = curIndex - 1
  if beforIndex <= 0 then
    beforIndex = self.__LoopListNum
  end
  self.picItems.next.transform:SetAsFirstSibling()
  self.picItems.next:InitHomeBannerPicItem(self.bannerDataList[beforIndex])
  local oldCur = self.picItems.cur
  self.picItems.cur = self.picItems.befor
  self.picItems.befor = self.picItems.next
  self.picItems.next = oldCur
  self.__curIndex = curIndex
  self:__OnPageIndexChange()
end

function UINHomeBannerLoopList:__OnPageIndexChange()
  if self.onPageIndexChange ~= nil then
    self.onPageIndexChange(self.__curIndex)
  end
end

function UINHomeBannerLoopList:SetInterval(interval)
  self.interval = interval
end

function UINHomeBannerLoopList:__OnAdvItemClick()
  self:__OnPointerExit()
end

function UINHomeBannerLoopList:CheckTime(time)
  if self.__IsDraging or not self.autoStartTime then
    return
  end
  if time - self.autoStartTime >= self.interval then
    self:AutoPlay2Next()
    self.autoStartTime = time
  end
end

function UINHomeBannerLoopList:AutoPlay2Next()
  self.couldRoll2Next = false
  self:Roll2Pos(1, function()
    self.ui.scrollRect.horizontalNormalizedPosition = self.ui.scrollRect.horizontalNormalizedPosition - 0.5
    self:Roll2Next()
    self:Roll2Pos(0.5, function()
      self.couldRoll2Next = true
    end)
  end)
end

function UINHomeBannerLoopList:OnHide()
  local eventTrigger = CS_EventTriggerListener.Get(self.gameObject)
  eventTrigger:onBeginDrag("-", BindCallback(self, self.__OnBeginDrag))
  eventTrigger:onEndDrag("-", BindCallback(self, self.__OnEndDrag))
  UpdateManager:RemoveLateUpdate(self.m_OnLateUpdate)
end

function UINHomeBannerLoopList:OnDelete()
  TimerManager:StopTimer(self.__pointerExitDelayCheckTimerId)
  HomeBannerManager:TryDeleteOutOfDataImg(table.emptytable)
  self.__pointerExitDelayCheckTimerId = nil
  base.OnDelete(self)
end

return UINHomeBannerLoopList
