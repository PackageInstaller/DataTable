_class("UIN25IdolApEvent", UICustomWidget)
UIN25IdolApEvent = UIN25IdolApEvent

function UIN25IdolApEvent:Constructor()
end

function UIN25IdolApEvent:OnShow(uiParams)
  self:GetComponents()
end

function UIN25IdolApEvent:SetData(component)
  self.component = component
  self:OnValue()
end

function UIN25IdolApEvent:OnHide()
end

function UIN25IdolApEvent:GetComponents()
  self.nextBtnGo = self:GetGameObject("NextBtn")
  self.eventPool = self:GetUIComponent("UISelectObjectPath", "eventPool")
end

function UIN25IdolApEvent:OnValue()
  self.datas = self.component:UI_GetWeekApEvent()
  local info = self.component:GetComponentInfo()
  local breakInfo = info.break_info
  self.finishList = breakInfo.agree_events
  self.currentTurn = breakInfo.round_index
  self._pageUnitCount = 3
  self._pageCount = math.ceil(#self.datas / self._pageUnitCount - 0.1)
  self._curIdx = 1
  if #self.datas > 3 then
    local checkData = self.datas[3]
    if checkData.round < self.currentTurn then
      self._curIdx = 2
    else
      self._curIdx = 1
    end
  end
  self:RefreshShowData()
  self:ApEvent()
  self.nextBtnGo:SetActive(self._pageCount > 1)
end

function UIN25IdolApEvent:NextBtnOnClick(go)
  if self._pageCount > 1 then
    if self._curIdx == 1 then
      self._curIdx = self._pageCount
    else
      self._curIdx = 1
    end
    self:RefreshShowData()
    self:ApEvent()
  end
end

function UIN25IdolApEvent:RefreshShowData()
  self._showDatas = {}
  for i, v in ipairs(self.datas) do
    if i <= self._curIdx * self._pageUnitCount and i > (self._curIdx - 1) * self._pageUnitCount then
      table.insert(self._showDatas, v)
    end
  end
end

function UIN25IdolApEvent:ApEvent()
  self.eventPool:SpawnObjects("UIN25IdolApEventItem", #self._showDatas)
  self.eventItems = self.eventPool:GetAllSpawnList()
  for i = 1, #self._showDatas do
    local data = self._showDatas[i]
    local item = self.eventItems[i]
    local eventid = data.eventid
    local finish = data.finish
    local round = data.round
    local weekIdx, weekDay = self.component:UI_Calc_WeekDay(round)
    local roomid = data.roomid
    local status
    if finish then
      status = UIIdolApEventStatus.Finish
    elseif round >= self.currentTurn then
      status = UIIdolApEventStatus.Ready
    else
      status = UIIdolApEventStatus.Pass
    end
    local light = self:GetLight(eventid)
    item:SetData(eventid, status, weekDay, roomid, light)
    item:PlayIn()
  end
end

function UIN25IdolApEvent:GetLight(eventid)
  local cfgs_end = Cfg.cfg_component_idol_ending({})
  if not cfgs_end then
    Log.error("###[UIN25IdolApEvent] cfgs_end is nil !")
  end
  local cfg = Cfg.cfg_component_idol_event({EventId = eventid})[1]
  if cfg then
    local petid = cfg.PetId
    for key, value in pairs(cfgs_end) do
      local end_petid = value.PetId
      if end_petid and petid == end_petid then
        return true
      end
    end
  else
    Log.error("###[UIN25IdolApEvent] cfg is nil ! id --> ", eventid)
  end
  return false
end

function UIN25IdolApEvent:CloseAnim(TT)
  self.eventItems = self.eventPool:GetAllSpawnList()
  for i = 1, #self._showDatas do
    local item = self.eventItems[i]
    item:PlayOut()
  end
  YIELD(TT, 167)
end
