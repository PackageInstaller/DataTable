local this = class("moduleMeeting", G_UIModuleBase)

function this.bind()
  return {
    txt_curLine = L_WordsTpl:getValue("notice_line_01")
  }
end

function this.methods()
  return {
    onClick_switchLine = function(self)
      L_UI:open("pageMeetingLine")
    end
  }
end

function this:open(options)
  this.super.open(self, options)
  self:refreshCurLine()
end

function this:refreshCurLine()
end

function this:close(options)
  this.super.close(self, options)
end

return this
