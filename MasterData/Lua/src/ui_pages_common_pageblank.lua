local this = class("pageBlank", G_UIPageBase)

function this.bind()
  return {}
end

function this.methods()
  return {
    onClick = function(self)
      if self._cantClose then
        return
      end
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  self._cantClose = options.cantClose
  self._callback = options.callback or L_Const.emptyFunction
  if options.timeClose then
    self._cantClose = true
    L_TimerManager:newOrResetTimer(self, "time", function()
      L_UI:close(self.pageName)
    end, options.timeClose)
  end
end

function this:escHandle()
end

function this:close()
  if self._callback() then
    self._callback()
  end
  L_TimerManager:clearTimer(self)
end

return this
