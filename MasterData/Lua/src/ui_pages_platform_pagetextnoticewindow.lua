local this = class("pageTextNoticeWindow", G_UIPageBase)

function this.bind()
  return {
    txt_content = "",
    module_commonTipLarge = L_Const.ModuleInfo.ModuleCommonTip
  }
end

function this.methods()
  return {
    module_commonTipLarge = {
      onClick_close = function(self)
        if self._params.closeCallbackTemp then
          self._params.closeCallbackTemp()
        end
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        if self._params.cancelCallback then
          self._params.cancelCallback()
        end
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        if self._params.confirmCallback then
          self._params.confirmCallback()
        end
        if C_InputManager.IsEnableGamePad then
          return
        end
        L_UI:close(self.pageName)
      end,
      onClick_bg = function(self)
        if self._params.closeCallbackTemp then
          self._params.closeCallbackTemp()
        end
        L_UI:close(self.pageName)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:refreshPage(options)
end

function this:refreshPage(params)
  self._params = params or {}
  self.modules.module_commonTipLarge:initModule(params)
  self.bind.txt_content = params.txtContent
end

function this:close()
  this.super.close(self)
  if self._params.pageClosedCallback then
    self._params.pageClosedCallback()
  end
end

function this:escHandle()
  if self._params.closeCallback then
    self._params.closeCallback()
  end
  L_UI:close(self.pageName)
end

return this
