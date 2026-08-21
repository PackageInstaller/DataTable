_class("UISeasonMazeRelicRdmCard", UIController)
UISeasonMazeRelicRdmCard = UISeasonMazeRelicRdmCard

function UISeasonMazeRelicRdmCard:OnShow(uiParams)
  self._closeCb = uiParams[1]
  self:InitWidget()
  self:OnValue()
end

function UISeasonMazeRelicRdmCard:OnHide()
  if self._closeCb then
    self._closeCb(self._point)
  end
  if self._timerList and next(self._timerList) then
    for k, v in pairs(self._timerList) do
      GameGlobal.Timer():CancelEvent(v)
    end
  end
end

function UISeasonMazeRelicRdmCard:InitWidget()
  self._pool = self:GetUIComponent("UISelectObjectPath", "cards")
  self._point1 = self:GetUIComponent("UILocalizationText", "pointTex1")
  self._point2 = self:GetUIComponent("UILocalizationText", "pointTex2")
end

function UISeasonMazeRelicRdmCard:OnValue()
  self._timerList = {}
  local obj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  local com = obj:GetMazeComponent()
  local ev = com._extra_hands_data
  local hands = ev.hands
  local point = 0
  if hands and next(hands) then
    self._pool:SpawnObjects("UISeasonMazeCardItem", #hands)
    local pools = self._pool:GetAllSpawnList()
    for i = 1, #hands do
      local hand = hands[i]
      point = point + hand.steps
      local widget = pools[i]
      widget:SetData(i, hand.id)
      widget:RootAlpha(0)
      local yieldTime = (i - 1) * 50
      if yieldTime and 0 < yieldTime then
        local timer = GameGlobal.Timer():AddEvent(yieldTime, function()
          widget:PlayAnim("uianim_UISeasonMazeCardItem_sum")
        end)
        self._timerList[#self._timerList + 1] = timer
      else
        widget:PlayAnim("uianim_UISeasonMazeCardItem_sum")
      end
    end
  end
  self._point1:SetText(point)
  self._point2:SetText(point)
  self._point = point
end

function UISeasonMazeRelicRdmCard:BtnOnClick(go)
  self:CloseDialog()
end
