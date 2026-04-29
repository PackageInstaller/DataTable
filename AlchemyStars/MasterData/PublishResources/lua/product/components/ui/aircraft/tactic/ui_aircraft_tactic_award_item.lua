_class("UIAircraftTacticAwardItem", UICustomWidget)
UIAircraftTacticAwardItem = UIAircraftTacticAwardItem

function UIAircraftTacticAwardItem:OnShow(uiParams)
  self:InitWidget()
end

function UIAircraftTacticAwardItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.count = self:GetUIComponent("UILocalizationText", "count")
  self.phase = self:GetUIComponent("UILocalizationText", "phase")
  self._canCollect = self:GetGameObject("canCollect")
  self._collected = self:GetGameObject("collected")
  self._dot = self:GetUIComponent("Image", "dot")
  self._bg1 = self:GetUIComponent("Image", "bg1")
  self._bg2 = self:GetUIComponent("Image", "bg2")
  self._atlas = self:GetAsset("UIAircraftTactic.spriteatlas", LoadType.SpriteAtlas)
end

function UIAircraftTacticAwardItem:SetData(idx, count, itemID, itemCount)
  self._idx = idx
  self.icon:LoadImage(Cfg.cfg_item[itemID].Icon)
  self.count:SetText(itemCount)
  self.phase:SetText(count)
  self._module = self:GetModule(AircraftModule)
  self._tacticRoom = self._module:GetRoomByRoomType(AirRoomType.TacticRoom)
  self._awardCount = count
  self._state = {}
  self._state.canCollect = 1
  self._state.collected = 2
  self._state.unCollect = 3
  self._curState = self._state.canCollect
  self:refreshState()
end

function UIAircraftTacticAwardItem:refreshState()
  local times = self._tacticRoom:GetWeeklyPassTimes()
  if times < self._awardCount then
    self._canCollect:SetActive(false)
    self._collected:SetActive(false)
    self._bg1.sprite = self._atlas:GetSprite("n8_simulator_gift_bg3")
    self._bg2.sprite = self._atlas:GetSprite("n8_simulator_gift_bg4")
    self.phase.color = Color.white
    self._curState = self._state.unCollect
  elseif self._tacticRoom:IsReceived(self._awardCount) then
    self._canCollect:SetActive(false)
    self._collected:SetActive(true)
    self._bg1.sprite = self._atlas:GetSprite("n8_simulator_gift_bg1")
    self._bg2.sprite = self._atlas:GetSprite("n8_simulator_gift_bg2")
    self.phase.color = Color.black
    self._curState = self._state.collected
  else
    self._canCollect:SetActive(true)
    self._collected:SetActive(false)
    self._bg1.sprite = self._atlas:GetSprite("n8_simulator_gift_bg1")
    self._bg2.sprite = self._atlas:GetSprite("n8_simulator_gift_bg2")
    self.phase.color = Color.black
    self._curState = self._state.canCollect
  end
  if self._idx == 1 then
    self._dot.gameObject:SetActive(false)
  elseif times >= self._awardCount then
    self._dot.gameObject:SetActive(true)
    self._dot.sprite = self._atlas:GetSprite("n8_simulator_gift_point2")
  else
    self._dot.gameObject:SetActive(true)
    self._dot.sprite = self._atlas:GetSprite("n8_simulator_gift_point1")
  end
end

function UIAircraftTacticAwardItem:iconOnClick(go)
  if self._curState == self._state.canCollect then
    self:StartTask(self.reqCollectAward, self)
  end
end

function UIAircraftTacticAwardItem:reqCollectAward(TT)
  self:Lock(self:GetName())
  local ack, awards = self._module:RequestTakeWeeklyAward(TT, self._awardCount)
  self:UnLock(self:GetName())
  if ack:GetSucc() then
    self:ShowDialog("UIGetItemController", awards.award_list)
    self:refreshState()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshRoomUI, self._tacticRoom:SpaceId())
  else
    ToastManager.ShowToast(self._module:GetErrorMsg(ack:GetResult()))
  end
end
