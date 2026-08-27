local base = UIBaseNode
local UINSignInLiveStreamChatLog = class("UINSignInLiveStreamChatLog", base)

function UINSignInLiveStreamChatLog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINSignInLiveStreamChatLog:RefreshSILSChatLog(content)
  self.ui.tex_ChatLog.text = content
end

function UINSignInLiveStreamChatLog:OnDelete()
  base.OnDelete(self)
end

return UINSignInLiveStreamChatLog
