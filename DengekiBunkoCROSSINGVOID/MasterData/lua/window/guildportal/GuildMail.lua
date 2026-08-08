local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local GU = require("Common/GuildUtil")
local DBH = require("Manager/DataBindingHandler")
local m_guildId
local m_titleLimit = 7
local m_contentLimit = 64

function SetupWindow()
  ManageButtonEvents()
end

function SetContent(id)
  m_guildId = id
  m_titleLimit = PB.all("Misc"):first().guildMailTitleLimit
  m_contentLimit = PB.all("Misc"):first().guildMailContentLimit
  REF.InputMailTitle.UIInput.defaultText = WU.GetString("Window_GuildMailTitleDefault")
  REF.InputMailContent.UIInput.defaultText = WU.GetString("Window_GuildMailContentDefault")
end

function ManageButtonEvents()
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    local param = {
      title = REF.InputMailTitle.UIInput.value,
      content = REF.InputMailContent.UIInput.value,
      guildId = m_guildId
    }
    if ValidateContent(param.content, m_contentLimit, true) then
      return
    end
    if ValidateContent(param.title, m_titleLimit, false) then
      return
    end
    this:GameRequest("fci/guild-mail/"):Post(param, function(result)
      if result == nil then
        WU.RecycleWindow(this)
        return
      end
      if not result.forbidden then
        WU.ShowHintText(WU.GetString("Window_GuildMailPass"))
      else
        WU.ShowHintText(WU.GetString("Window_GuildForbidden"))
      end
      WU.RecycleWindow(this)
    end)
  end)
end

function ValidateContent(content, length, canbeNull)
  content = content or ""
  if not canbeNull and (content == "" or content == nil) then
    WU.ShowHintText(WU.GetString("Window_GuildMailTitleEmpty"))
    return true
  end
  if length < WU.CharacterLength(content) then
    WU.ShowHintText(WU.GetString("Window_GuildMailLimit"))
    return true
  end
  return false
end
