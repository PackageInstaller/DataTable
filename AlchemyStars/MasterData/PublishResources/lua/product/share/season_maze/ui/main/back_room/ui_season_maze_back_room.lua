_class("UISeasonMazeBackRoom", UICustomWidget)
UISeasonMazeBackRoom = UISeasonMazeBackRoom

function UISeasonMazeBackRoom:InitWidget()
  self._go = self:GetGameObject("Go")
end

function UISeasonMazeBackRoom:OnShow()
  self:InitWidget()
  self:AttachEvent(GameEventType.OnTempCloseRoom, self.ShowBtn)
end

function UISeasonMazeBackRoom:SetData()
  self:ShowBtn(false)
end

function UISeasonMazeBackRoom:ShowBtn(active)
  self._go:SetActive(active)
end

function UISeasonMazeBackRoom:BtnOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTempCloseRoom, false)
  local nodeid = SMazeAdaptor.CurNodeID()
  GameGlobal.GetUIModule(SeasonMazeModule):ReturnTempRoom(nodeid)
end
