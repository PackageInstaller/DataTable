_class("UITopRankItem", UICustomWidget)
UITopRankItem = UITopRankItem

function UITopRankItem:OnShow(uiParams)
  self._lvSize = {
    [1] = 100,
    [2] = 90,
    [3] = 70,
    [4] = 60
  }
  self:GetComponents()
  self:AttachEvent(GameEventType.OnTopRankGetAward, self.OnTopRankGetAward)
end

function UITopRankItem:GetComponents()
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._getBtnGo = self:GetGameObject("getBtn")
  self._doingGo = self:GetGameObject("doing")
  self._gotGo = self:GetGameObject("got")
  self._lvGo = self:GetGameObject("lvGo")
  self._bg = self:GetUIComponent("Image", "bg")
end

function UITopRankItem:Award()
  local awards = self._awards
  self._itemPool:SpawnObjects("UITopRankAward", #awards)
  local items = self._itemPool:GetAllSpawnList()
  for i = 1, #items do
    local item = items[i]
    local award = Award:New()
    award:InitWithCount(awards[i][1], awards[i][2])
    item:SetData(award, function(id, pos)
      if self._callback then
        self._callback(id, pos)
      end
    end)
  end
end

function UITopRankItem:Name()
  local size = 60
  if self._lv < 100 then
    size = self._lvSize[1]
  elseif self._lv < 1000 then
    size = self._lvSize[2]
  elseif self._lv < 10000 then
    size = self._lvSize[3]
  elseif self._lv < 100000 then
    size = self._lvSize[4]
  end
  self._name:SetText("<size=" .. size .. ">" .. self._lv .. "</size>")
end

function UITopRankItem:State()
  local state
  if self._got then
    state = UITopRankAwardGotState.GOT
  elseif self._lv > self._currentLv then
    state = UITopRankAwardGotState.DOING
  else
    state = UITopRankAwardGotState.GET
  end
  self._getBtnGo:SetActive(state == UITopRankAwardGotState.GET)
  self._doingGo:SetActive(state == UITopRankAwardGotState.DOING)
  self._gotGo:SetActive(state == UITopRankAwardGotState.GOT)
  self._lvGo:SetActive(state ~= UITopRankAwardGotState.GOT)
  if state == UITopRankAwardGotState.GOT then
    self._bg.sprite = self._sp2
  else
    self._bg.sprite = self._sp1
  end
end

function UITopRankItem:SetData(idx, lv, currentLv, got, awards, sp1, sp2, getCallBack, callback)
  self._idx = idx
  self._lv = lv
  self._currentLv = currentLv
  self._got = got
  self._awards = awards
  self._getCallBack = getCallBack
  self._callback = callback
  self._sp1 = sp1
  self._sp2 = sp2
  self:Award()
  self:State()
  self:Name()
end

function UITopRankItem:getBtnOnClick(go)
  if self._getCallBack then
    self._getCallBack(self._lv)
  end
end

function UITopRankItem:OnTopRankGetAward(getLvList)
  if getLvList and 0 < #getLvList then
    for i = 1, #getLvList do
      local _lv = getLvList[i]
      if _lv == self._lv then
        self._got = true
        self:State()
        return
      end
    end
  end
end
