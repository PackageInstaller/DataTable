_class("UISeasonMazeRoomTest", UICustomWidget)
UISeasonMazeRoomTest = UISeasonMazeRoomTest

function UISeasonMazeRoomTest:InitWidget()
  self.inp1 = self:GetUIComponent("InputField", "InputField")
  self.inp2 = self:GetUIComponent("InputField", "InputField2")
  self._go = self:GetGameObject("Go")
  self._go:SetActive(false)
end

function UISeasonMazeRoomTest:OnShow()
  self:InitWidget()
  self._type2ui = {
    [SeasonMazeRoomType.SMRT_PVE] = "UISeasonMazeRoomStage",
    [SeasonMazeRoomType.SMRT_Altar] = "UISeasonMazeRoom_Altar",
    [SeasonMazeRoomType.SMRT_Camp] = "UISeasonMazeRoom_Campsites",
    [SeasonMazeRoomType.SMRT_Empty] = "UISeasonMazeRoomEmpty",
    [SeasonMazeRoomType.SMRT_Box] = "UISeasonMazeRoomBox",
    [SeasonMazeRoomType.SMRT_Market] = "UISeasonMazeRoomFlea",
    [SeasonMazeRoomType.SMRT_Round] = "UISeasonMazeRoomRound"
  }
end

function UISeasonMazeRoomTest:BtnOnClick(go)
  local inp1t = self.inp1.text
  local uiType
  if not string.isnullorempty(inp1t) then
    uiType = inp1t
  end
  uiType = tonumber(uiType)
  local inp2t = self.inp2.text
  local uiParams
  if not string.isnullorempty(inp2t) then
    uiParams = tonumber(inp2t)
  end
  if self._type2ui[uiType] then
    self:ShowDialog(self._type2ui[uiType], uiParams)
  end
end

function UISeasonMazeRoomTest:OnHide()
end
