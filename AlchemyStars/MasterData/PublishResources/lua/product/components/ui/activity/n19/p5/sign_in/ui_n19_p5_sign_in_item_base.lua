_class("UIN19P5SignInBase", UICustomWidget)
UIN19P5SignInBase = UIN19P5SignInBase

function UIN19P5SignInBase:OnShow()
  self:GetComponent()
end

function UIN19P5SignInBase:GetComponent()
  self.big = self:GetGameObject("big")
  self.smallUp = self:GetGameObject("smallUp")
  self.smallDown = self:GetGameObject("smallDown")
  self.bigDay = self:GetUIComponent("UILocalizationText", "bigDay")
  self.smallUpDay = self:GetUIComponent("UILocalizationText", "smallUpDay")
  self.smallDownDay = self:GetUIComponent("UILocalizationText", "smallDownDay")
  self.bigPool = self:GetUIComponent("UISelectObjectPath", "bigPool")
  self.smallUpPool = self:GetUIComponent("UISelectObjectPath", "smallUpPool")
  self.smallDownPool = self:GetUIComponent("UISelectObjectPath", "smallDownPool")
  self:AwardPos()
end

function UIN19P5SignInBase:Flush(idx, awards, status, type, callback)
  self.status = status
  self.type = type
  self._day = idx
  self._awards = awards or {}
  self:Refresh()
end

function UIN19P5SignInBase:Type()
  if self.type == UIN19P5SignInPosType.Current then
    self.big:SetActive(true)
    self.smallUp:SetActive(false)
    self.smallDown:SetActive(false)
  elseif self.type == UIN19P5SignInPosType.Down then
    self.big:SetActive(false)
    self.smallUp:SetActive(false)
    self.smallDown:SetActive(true)
  elseif self.type == UIN19P5SignInPosType.Up then
    self.big:SetActive(false)
    self.smallUp:SetActive(true)
    self.smallDown:SetActive(false)
  end
  self:Award()
  self:Day()
end

function UIN19P5SignInBase:RefreshType(type)
  self.type = type
  self:Type()
end

function UIN19P5SignInBase:RefreshStatus(status)
  self.status = status
  self:Refresh()
end

function UIN19P5SignInBase:Award()
  local pool, posIdx, widgetName
  local gray = self.status ~= UIN19P5SignInStatus.Get
  if self.type == UIN19P5SignInPosType.Up then
    pool = self.smallUpPool
    widgetName = "UIN19P5SignInItemAwardSmall"
    posIdx = 2
  elseif self.type == UIN19P5SignInPosType.Current then
    pool = self.bigPool
    widgetName = "UIN19P5SignInItemAwardBig"
    posIdx = 1
  elseif self.type == UIN19P5SignInPosType.Down then
    pool = self.smallDownPool
    widgetName = "UIN19P5SignInItemAwardSmall"
    posIdx = 2
  end
  pool:SpawnObjects(widgetName, #self._awards)
  local pools = pool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local award = self._awards[i]
    local pos = self.awardPos[posIdx][1][i]
    local countPos = self.awardPos[posIdx][2][i]
    item:SetData(i, award, nil, gray, pos, countPos)
  end
end

function UIN19P5SignInBase:AwardPos()
  self.awardPos = {
    [1] = {
      [1] = {
        [1] = Vector2(0, 0),
        [2] = Vector2(0, 40)
      },
      [2] = {
        [1] = Vector2(70, -40),
        [2] = Vector2(79, -60)
      }
    },
    [2] = {
      [1] = {
        [1] = Vector2(0, 0),
        [2] = Vector2(0, 30)
      },
      [2] = {
        [1] = Vector2(47, -26),
        [2] = Vector2(56, -41)
      }
    }
  }
end

function UIN19P5SignInBase:Day()
  local day
  if self.type == UIN19P5SignInPosType.Up then
    day = self.smallUpDay
  elseif self.type == UIN19P5SignInPosType.Current then
    day = self.bigDay
  elseif self.type == UIN19P5SignInPosType.Down then
    day = self.smallDownDay
  end
  day:SetText(self._day)
end

function UIN19P5SignInBase:Select(idx)
  if self.idx == idx then
    if self.isOpen then
    else
      self.small:SetActive(false)
      self.big:SetActive(true)
    end
  else
    if self.isOpen then
      self.small:SetActive(true)
      self.big:SetActive(false)
    else
    end
  end
end

function UIN19P5SignInBase:Refresh()
  self:Type()
end

_class("UIN19P5SignInLock", UIN19P5SignInBase)
UIN19P5SignInLock = UIN19P5SignInLock
_class("UIN19P5SignInGet", UIN19P5SignInBase)
UIN19P5SignInGet = UIN19P5SignInGet

function UIN19P5SignInGet:GetBtnOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIN19P5SignInGet, self._day)
end

_class("UIN19P5SignInFinish", UIN19P5SignInBase)
UIN19P5SignInFinish = UIN19P5SignInFinish
