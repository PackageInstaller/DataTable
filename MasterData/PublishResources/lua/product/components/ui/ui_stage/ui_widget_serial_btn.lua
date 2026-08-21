_class("UIWidgetSerialButton", UICustomWidget)
UIWidgetSerialButton = UIWidgetSerialButton

function UIWidgetSerialButton:Constructor()
  self._state = OpenUISerialFightInfoState.OutGame
end

function UIWidgetSerialButton:OnShow()
  local mdSerialFight = GameGlobal.GetModule(SerialAutoFightModule)
  local matchType = mdSerialFight:GetMatchType()
  local isTower = matchType == MatchType.MT_Tower
  self:GetGameObject("_normal"):SetActive(not isTower)
  self:GetGameObject("_tower"):SetActive(isTower)
  if not isTower then
    local fightCnt = mdSerialFight:GetFightCount() + 1
    local totalCnt = mdSerialFight:GetTotalCount()
    if fightCnt > totalCnt then
      fightCnt = totalCnt
    end
    local str = string.format("%d<color=#deb681>/%d</color>", fightCnt, totalCnt)
    UIWidgetHelper.SetLocalizationText(self, "num", str)
  end
end

function UIWidgetSerialButton:SetData(state)
  self._state = state
end

function UIWidgetSerialButton:btnSerialAutoFightOnClick()
  self:ShowDialog("UISerialAutoFightInfo", self._state)
end
