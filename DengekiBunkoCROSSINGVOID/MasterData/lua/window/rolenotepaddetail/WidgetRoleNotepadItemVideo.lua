local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_data1, m_data2, m_unlockedInfo

function GetLockedTipNum(chapterId, dungeonID)
  local chapterNum = 0
  local stageNum = 0
  if chapterId == 0 or dungeonID == 0 then
    error("RoleNotepad", "\232\175\183\231\173\150\229\136\146\233\133\141\231\189\174cartoonconfig\231\154\132chapterId \229\146\140 dungeonID")
    return chapterNum, stageNum
  end
  local dungeonInfo = PB.get("DungeonReward", dungeonID)
  if dungeonInfo == nil then
    error("RoleNotepad", "Cannot find entry in DungeonReward by dungeonID: " .. dungeonID)
    return chapterNum, stageNum
  end
  local preDungeonId = dungeonInfo.preDungeonId
  local chapterInfos = PB.all("ChapterInfo")
  if chapterInfos then
    local stage = {}
    for _, chapter in ipairs(chapterInfos) do
      if _ENV["!"](chapter.dungeonId):find(function(k, v)
        return v == preDungeonId
      end) then
        chapterNum = chapter.chapterId
        stage = chapter.dungeonId
        break
      end
    end
    for i = 1, #stage do
      if stage[i] == preDungeonId then
        stageNum = i
        break
      end
    end
  end
  return chapterNum, stageNum
end

function Start()
  local key1 = "ItemNoteVideo1"
  local key2 = "ItemNoteVideo2"
  WU.BindButtonEvent(_ENV["$"](REF[key1]).BgIconVideoSnapshot, function()
    if m_data1 ~= nil and m_unlockedInfo[m_data1.id] then
      this:SetData("RoleNotePadDetail/ToggleIndex", 3)
      WU.EnterCartoonLevel(m_data1.id, "RoleNotepad, RoleNotepadDetail")
    elseif m_data1.chapterId == 0 or m_data1.dungeonId == 0 then
      WU.ShowHintText(WU.GetString("Notepad_CartoonLocked2"))
    else
      local chapterNum, stageNum = GetLockedTipNum(m_data1.chapterId, m_data1.dungeonId)
      WU.ShowHintText(WU.GetString("Notepad_CartoonLocked", chapterNum, stageNum))
    end
  end)
  WU.BindButtonEvent(_ENV["$"](REF[key2]).BgIconVideoSnapshot, function()
    if m_data2 ~= nil and m_unlockedInfo[m_data2.id] then
      this:SetData("RoleNotePadDetail/ToggleIndex", 3)
      WU.EnterCartoonLevel(m_data2.id, "RoleNotepad, RoleNotepadDetail")
    elseif m_data2.chapterId == 0 or m_data2.dungeonId == 0 then
      WU.ShowHintText(WU.GetString("Notepad_CartoonLocked2"))
    else
      local chapterNum, stageNum = GetLockedTipNum(m_data2.chapterId, m_data2.dungeonId)
      WU.ShowHintText(WU.GetString("Notepad_CartoonLocked", chapterNum, stageNum))
    end
  end)
end

function SetData(itemMovieDataCouple)
  m_unlockedInfo = this:GetData("CartoonConfig/UnlockedInfo")
  local prefix = "ItemNoteVideo"
  for i = 1, 2 do
    local data = itemMovieDataCouple[i]
    if i == 1 then
      m_data1 = data
    else
      m_data2 = data
    end
    local key = prefix .. i
    if data ~= nil then
      REF[key].gameObject:SetActive(true)
      if data.chapterId == 0 or data.dungeonId == 0 then
        _ENV["$"](REF[key]).LabelVideoSrcNum.UILabel.text = ""
      else
        local chapterNum, stageNum = GetLockedTipNum(data.chapterId, data.dungeonId)
        _ENV["$"](REF[key]).LabelVideoSrcNum.UILabel.text = "(" .. chapterNum .. "-" .. stageNum .. ")"
      end
      _ENV["$"](REF[key]).LabelVideoDesc.UILabel.text = WU.GetString("CartoonName_" .. data.id)
      if m_unlockedInfo[data.id] then
        _ENV["$"](REF[key]).IconVideoSnapshot.UITexture.mainTexturePath = "Texture/JouneyVideo/" .. data.movieIcon
        _ENV["$"](REF[key]).IconVideoSnapshot.gameObject:SetActive(true)
      else
        _ENV["$"](REF[key]).IconVideoSnapshot.gameObject:SetActive(false)
      end
    else
      REF[key].gameObject:SetActive(false)
    end
  end
end
