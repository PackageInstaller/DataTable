local this = class("cellLockCondition", G_UIModuleBase)

function this:created(...)
  this.super.created(self, ...)
end

function this.bind()
  return {txt_lockDesc = "", show_goto = false}
end

function this.methods()
  return {
    onClick = function(self)
      if not table.isEmpty(self.bind.lockParam) then
        L_JumpMgr:jumpTo(self.bind.lockParam[1])
      end
    end
  }
end

function this:open()
  if self.isBind then
    if table.isEmpty(self.bind.lockParam) then
      self:startDateTimer()
    end
    self.bind.show_goto = not table.isEmpty(self.bind.lockParam)
  end
end

function this:startDateTimer()
  self:disposeTimer()
  local endTime = L_TimeUtil.getNextDayTime(tonumber(L_GameConstTpl:getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int)))
  local nowTime = L_TimeUtil:getServerTime()
  local nextDayTime = endTime
  local gapTime = nextDayTime - nowTime
  self.bind.txt_lockDesc = L_WordsTpl:getValue("ui_cellLockCondition", {
    [0] = L_TimeUtil.secondToLangString(gapTime)
  })
  self.timer = Timer.repeated(1, function()
    if 0 < gapTime then
      gapTime = gapTime - 1
      self.bind.txt_lockDesc = L_WordsTpl:getValue("ui_cellLockCondition", {
        [0] = L_TimeUtil.secondToLangString(gapTime)
      })
    else
      self.bind.txt_lockDesc = ""
      self:disposeTimer()
    end
  end, self, self.gameObject)
end

function this:disposeTimer()
  if self.timer ~= nil then
    self.timer:stop()
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:close()
  self:disposeTimer()
end

function this:updateView(lockParam, txt_lockDesc)
  self.bind.lockParam = lockParam
  self.bind.txt_lockDesc = txt_lockDesc
  self:disposeTimer()
  self.bind.show_goto = true
end

return this
