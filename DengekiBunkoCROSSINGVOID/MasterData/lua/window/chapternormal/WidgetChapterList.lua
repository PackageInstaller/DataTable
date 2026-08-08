local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")
local m_chapters
local m_dunType = 2

function SetupWindow()
  local t = REF.WrapContent
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateChapterList
  })
  WU.BindButtonEvent(REF.BtnClose, function()
    WU.RecordButtonClick(129011)
    WU.RecycleWindow(this)
  end)
end

function InitWindow()
  m_chapters = PB.all("ChapterInfo"):where(function(_, p)
    return p.type == m_dunType
  end):toarray()
  table.sort(m_chapters, function(a, b)
    return a.chapterIndex < b.chapterIndex
  end)
  LU.Set(REF.WrapContent, #m_chapters)
end

function UpdateChapterList(rowRef, wrapIndex, realIndex)
  if m_chapters and realIndex ~= nil and realIndex < #m_chapters then
    local index = realIndex + 1
    local chapterInfo = m_chapters[index]
    rowRef.WidgetChapterItem["$SetData"]({
      chapterId = chapterInfo.chapterId
    })
  end
end

function Focus(on)
  WU.RecordWindowFocus(100129, on)
end
