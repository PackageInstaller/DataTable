local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local FH = require("Common/FightHelper")
local LU = require("Common/ListUtil")
local m_id = 0
local m_buffRowList

function SetData(mazeBuffId)
  m_id = mazeBuffId
  local info = PB.get("MazeBuff", m_id)
  if info then
    REF.Name.UILabel.text = WU.GetString(string.format("MazeBuffTitle_%d", m_id))
    local buffData = this:GetData("MazeBuff")
    local leftRound = 0
    if buffData and buffData[m_id] then
      leftRound = buffData[m_id].leftRound
    end
    if info.persistentType == PB.enum.MazeBuffPersistentType.MazeBuffPersistent_Battle then
      local strLeftRound = WU.GetString("LocalMaze_Tips15", leftRound)
      REF.Describe.UIHtmlLabel.text = WU.GetString(string.format("MazeBuffDesc_%d", m_id)) .. "," .. strLeftRound
    elseif info.persistentType == PB.enum.MazeBuffPersistentType.MazeBuffPersistent_Cell then
      local strLeftRound = WU.GetString("LocalMaze_Tips18", leftRound)
      REF.Describe.UIHtmlLabel.text = WU.GetString(string.format("MazeBuffDesc_%d", m_id)) .. "," .. strLeftRound
    elseif info.persistentType == PB.enum.MazeBuffPersistentType.MazeBuffPersistent_MapCell then
      local strLeftRound = WU.GetString("LocalMaze_Tips19")
      REF.Describe.UIHtmlLabel.text = WU.GetString(string.format("MazeBuffDesc_%d", m_id)) .. "," .. strLeftRound
    elseif info.persistentType == PB.enum.MazeBuffPersistentType.MazeBuffPersistent_MapBattle then
      local strLeftRound = WU.GetString("LocalMaze_Tips20")
      REF.Describe.UIHtmlLabel.text = WU.GetString(string.format("MazeBuffDesc_%d", m_id)) .. "," .. strLeftRound
    end
    REF.Icon.UISprite.spriteName = info.buffBigIcon
  end
end
