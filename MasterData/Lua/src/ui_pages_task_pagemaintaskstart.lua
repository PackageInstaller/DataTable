local this = class("pageMainTaskStart", G_UIPageBase)
local _plotStartPerformanceTpl = L_GameTpl:getPlotStartPerformanceTpl()
local _defDuration = 1

function this.bind()
  return {
    img_taskIcon = "",
    txt_taskStage = "",
    txt_taskName = "",
    toggle_finishState = false
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  self.performanceId = options.performanceId
  self.duration = options.duration and options.duration > 0 and options.duration or _defDuration
  self.closeCB = options.closeCB
  local tpl = _plotStartPerformanceTpl:getTplById(self.performanceId)
  if tpl then
    self.bind.img_taskIcon = _plotStartPerformanceTpl:getIcon(tpl)
    self.bind.txt_taskStage = string.format("%s %s", _plotStartPerformanceTpl:getVolName(tpl), _plotStartPerformanceTpl:getChapterNum(tpl))
    self.bind.txt_taskName = _plotStartPerformanceTpl:getChapterName(tpl)
    self.bind.toggle_finishState = _plotStartPerformanceTpl:getType(tpl) == 2
  else
    errorf("Can't get plotStartPerformanceTpl by " .. self.performanceId)
  end
end

function this:destroy()
  if self.closeCB then
    self.closeCB()
    self.closeCB = nil
  end
end

return this
