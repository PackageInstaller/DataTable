local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_callback

function Start()
  SetHighlight(false)
  WU.BindButtonEvent(REF["$"], OnSlotClick)
end

function SetData(member)
  if member then
    local isMyself = member.playerId == this:GetData("playerId")
    local colorPrefix = fif(isMyself, "<font color=#0090ff>", "")
    local colorSuffix = fif(isMyself, "</font>", "")
    REF.LabelName.UIHtmlLabel.text = colorPrefix .. member.name .. colorSuffix
    REF.LabelLevel.UIHtmlLabel.text = colorPrefix .. member.level .. colorSuffix
    REF.LabelPosition.UIHtmlLabel.text = colorPrefix .. WU.GetString("Window_GuildMemberType_" .. member.type) .. colorSuffix
    REF.LabelStatus.UIHtmlLabel.text = colorPrefix .. fif(member.lastLogoutTime > 0, WU.RenderElpasedTime(CS.GameTime.serverUtc - member.lastLogoutTime), WU.GetString("Window_Online")) .. colorSuffix
  end
end

function SetClickCallback(callback)
  m_callback = callback
end

function SetHighlight(value)
  REF.SpriteHighlight.gameObject:SetActive(value)
end

function OnSlotClick()
  if m_callback then
    m_callback(REF["$gameObject"])
  end
end
