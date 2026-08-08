local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_closeMessage = "NoticeMessage"
local m_onDestoryCallback
local mEscapeMap = {}

function SetupWindow()
  WU.BindButtonEvent(REF.BtnOK, OnUIOK)
  WU.BindButtonEvent(REF.BtnYes, OnUIYes)
  WU.BindButtonEvent(REF.BtnNo, OnUINo)
  REF.ButtonClose["$SetCallback"](OnUIClose)
  REF.Black["$SetCallback"](OnUIClose)
  ConstructEscapeMap()
end

function InitWindow()
  this:RegisterGameEvent("OnLinkClick", OnClickLink)
end

function ConstructEscapeMap()
  mEscapeMap = {}
  table.insert(mEscapeMap, {pattern = "&quot;", rawValue = "\""})
  table.insert(mEscapeMap, {pattern = "&gt;", rawValue = ">"})
  table.insert(mEscapeMap, {pattern = "&lt;", rawValue = "<"})
end

function EscapeHTML(encodedContent)
  local res = encodedContent
  for k, v in pairs(mEscapeMap) do
    res = string.gsub(res, v.pattern, v.rawValue)
  end
  return res
end

function OnClickLink(url)
  if url:starts("http") then
    WU.OpenUrl(url)
  end
end

function ShowNotice(title, message)
  REF.LabelTitle.UIHtmlLabel.text = title
  REF.Message.UIHtmlLabel.text = EscapeHTML(message)
end

function SetDestoryCallback(callback)
  m_onDestoryCallback = callback
end

function OnClick(message)
  WU.RecycleWindow(this)
  if m_onDestoryCallback then
    m_onDestoryCallback()
  end
end

function OnUIOK()
  OnClick("OK")
end

function OnUIYes()
  OnClick("YES")
end

function OnUINo()
  OnClick("NO")
end

function OnUIClose()
  OnClick(m_closeMessage)
end
