_class("UISeasonMazeRoom_DirectionalRecruitChooseColor", UICustomWidget)
UISeasonMazeRoom_DirectionalRecruitChooseColor = UISeasonMazeRoom_DirectionalRecruitChooseColor

function UISeasonMazeRoom_DirectionalRecruitChooseColor:InitWidget()
  self._grid = self:GetUIComponent("UISelectObjectPath", "Grid")
  self._colors = {
    ElementType.ElementType_Blue,
    ElementType.ElementType_Red,
    ElementType.ElementType_Green,
    ElementType.ElementType_Yellow
  }
  self._curIndex = 0
end

function UISeasonMazeRoom_DirectionalRecruitChooseColor:OnShow()
  self:InitWidget()
end

function UISeasonMazeRoom_DirectionalRecruitChooseColor:SetData(backCb, chooseCb, exitCb)
  local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  local seasonMazeObj = seasonMazeModule:CurSeasonObj()
  self._com = seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._backCb = backCb
  self._chooseCb = chooseCb
  self._exitCb = exitCb
  self:InitCells()
  self:PlayChooseCardsShowInAnim()
end

function UISeasonMazeRoom_DirectionalRecruitChooseColor:OnHide()
end

function UISeasonMazeRoom_DirectionalRecruitChooseColor:BackBtnOnClick(go)
  if self._backCb then
    self._backCb()
  end
end

function UISeasonMazeRoom_DirectionalRecruitChooseColor:ConfirmBtnOnClick(go)
  if self._curIndex ~= 0 and self._chooseCb then
    self._chooseCb(self._curIndex)
  end
end

function UISeasonMazeRoom_DirectionalRecruitChooseColor:InitCells()
  self._grid:SpawnObjects("UISeasonMazeRoom_DirectionalRecruitColorCell", #self._colors)
  local pools = self._grid:GetAllSpawnList()
  self._cellWidgets = pools
  for i = 1, #self._colors do
    local color = self._colors[i]
    local widget = pools[i]
    widget:SetData(i, color, function(idx)
      self:OnCellClick(idx)
    end)
  end
end

function UISeasonMazeRoom_DirectionalRecruitChooseColor:OnCellClick(idx)
  self._curIndex = idx
  for i = 1, #self._cellWidgets do
    local widget = self._cellWidgets[i]
    widget:Select(self._curIndex)
  end
end

function UISeasonMazeRoom_DirectionalRecruitChooseColor:BagBtnOnClick(go)
  self:ShowDialog("UISeasonMazeBackPackController", 1)
end

function UISeasonMazeRoom_DirectionalRecruitChooseColor:ExitBtnOnClick(go)
  if self._exitCb then
    self._exitCb()
  end
end

function UISeasonMazeRoom_DirectionalRecruitChooseColor:PlayChooseCardsShowInAnim()
  local lockName = "UISeasonMazeRoom_DirectionalRecruitChooseColor:PlayChooseCardsShowInAnim"
  self:StartTask(function(TT)
    self:Lock(lockName)
    local eachDelay = 100
    local lockTime = 900
    local maxDelayMs = 0
    if self._cellWidgets then
      for index, widget in ipairs(self._cellWidgets) do
        local delayMs = (index - 1) * eachDelay
        widget:PlayShowInAnim(delayMs)
        maxDelayMs = delayMs
      end
    end
    lockTime = lockTime + maxDelayMs
    YIELD(TT, lockTime)
    self:UnLock(lockName)
  end)
end
