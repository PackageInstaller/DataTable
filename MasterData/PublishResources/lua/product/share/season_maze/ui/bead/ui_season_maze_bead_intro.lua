_class("UISeasonMazeBeadIntro", UIController)
UISeasonMazeBeadIntro = UISeasonMazeBeadIntro

function UISeasonMazeBeadIntro:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeBeadIntro:OnShow(uiParams)
  self._data = {}
  self:InitWidget()
  self:_OnValue()
end

function UISeasonMazeBeadIntro:InitWidget()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
end

function UISeasonMazeBeadIntro:_OnValue()
  self:_InitData()
  self._content:SpawnObjects("UISeasonMazeBeadIntroItem", #self._data)
  self._widgets = self._content:GetAllSpawnList()
  for key, value in pairs(self._widgets) do
    value:SetData(self._data[key])
  end
end

function UISeasonMazeBeadIntro:_InitData()
  local titlePrefix = "str_season_maze_bead_intro_title_"
  local descPrefix = "str_season_maze_bead_intro_desc_"
  local index = 1
  while true do
    local valid = StringTable.Has(titlePrefix .. index)
    if valid then
      local t = {}
      t.title = StringTable.Get(titlePrefix .. index)
      t.desc = StringTable.Get(descPrefix .. index)
      table.insert(self._data, t)
      index = index + 1
    else
      break
    end
  end
end

function UISeasonMazeBeadIntro:CloseBtnOnClick(go)
  self:CloseDialog()
end
