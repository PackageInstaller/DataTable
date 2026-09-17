local this = class("cellNDayTaskTab", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _GameEventStore = L_GameEventStore

function this.bind()
  return {
    txtDay = "",
    activeLock = false,
    enable_lockDark = true,
    color_lock = nil,
    activeComplete = false,
    reddot = false,
    uid = -1,
    color_txt = nil,
    color_txt_e = nil
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick_day", self.bind.uid, self.bindComponents.animation)
    end
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:open()
end

function this:refreshDayState(groupId)
  local a = false
  self.bind.enable_lockDark = true
  if self.bind.activeLock then
    a, self.bind.color_txt = C_ColorUtility.TryParseHtmlString("#FFFFFF4C")
    a, self.bind.color_txt_e = C_ColorUtility.TryParseHtmlString("#FFFFFF4C")
    a, self.bind.color_lock = C_ColorUtility.TryParseHtmlString("#D3D3D3")
  else
    a, self.bind.color_txt = C_ColorUtility.TryParseHtmlString("#FFFFFF")
    a, self.bind.color_txt_e = C_ColorUtility.TryParseHtmlString("#FFFFFF7F")
  end
  if groupId == self.bind.uid then
    if self.bind.activeLock then
      a, self.bind.color_txt = C_ColorUtility.TryParseHtmlString("#C1C0C4")
      a, self.bind.color_txt_e = C_ColorUtility.TryParseHtmlString("#C1C0C4")
      a, self.bind.color_lock = C_ColorUtility.TryParseHtmlString("#778086")
      self.bind.enable_lockDark = false
    else
      a, self.bind.color_txt = C_ColorUtility.TryParseHtmlString("#4F525D")
      a, self.bind.color_txt_e = C_ColorUtility.TryParseHtmlString("#52555F7F")
    end
  end
end

function this:close()
end

return this
