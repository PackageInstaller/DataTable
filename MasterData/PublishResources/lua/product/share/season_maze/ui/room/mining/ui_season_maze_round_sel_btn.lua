_class("UISeasonMazeRoundSelBtn", UICustomWidget)
UISeasonMazeRoundSelBtn = UISeasonMazeRoundSelBtn

function UISeasonMazeRoundSelBtn:OnShow()
  self._selectGo = self:GetGameObject("select")
  self._unSelectGo = self:GetGameObject("txtUnSel")
  self._txtUnsel = self:GetUIComponent("UILocalizationText", "txtUnSel")
  self._txtSel = self:GetUIComponent("UILocalizationText", "txtSel")
end

function UISeasonMazeRoundSelBtn:GetRoundNum()
  return self._roundNum
end

function UISeasonMazeRoundSelBtn:SetData(roundNum, click)
  self._click = click
  self._roundNum = roundNum
  local strText = StringTable.Get("str_season_maze_ore_room_tips_round", roundNum)
  self._txtUnsel:SetText(strText)
  self._txtSel:SetText(strText)
  self:SetSelect(false)
end

function UISeasonMazeRoundSelBtn:SetSelect(bSelect)
  self._selectGo:SetActive(bSelect)
  self._unSelectGo:SetActive(not bSelect)
end

function UISeasonMazeRoundSelBtn:BGOnClick()
  if self._click then
    self._click(self._roundNum)
  end
end
