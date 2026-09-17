local this = class("pageCommonSwitchTip", G_UIPageBase)

function this.bind()
  return {
    module_commonTipSmall = L_Const.ModuleInfo.ModuleCommonTip,
    tips = "",
    beforeItem = L_Const.ModuleInfo.CellIconBag,
    afterItem = L_Const.ModuleInfo.CellIconBag,
    beforeItemActive = true,
    emptyTips = "",
    emptyActive = false
  }
end

function this.methods()
  return {
    module_commonTipSmall = {
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
  self.modules.module_commonTipSmall:initModule(params)
  self.bind.tips = params.tips
  if params.beforeItem then
    self.bind.beforeItemActive = true
    if not math.isEmpty(params.beforeItem.guid) then
      self.modules.beforeItem:setDataContent(params.beforeItem.itemType, params.beforeItem.guid, params.beforeItem.params)
    else
      self.modules.beforeItem:setGeneralContent(params.beforeItem.itemType, params.beforeItem.itemId, params.beforeItem.params)
    end
  else
    self.bind.beforeItemActive = false
  end
  self.bind.emptyActive = not self.bind.beforeItemActive
  self.bind.emptyTips = params.emptyTips or ""
  if params.afterItem then
    if not math.isEmpty(params.afterItem.guid) then
      self.modules.afterItem:setDataContent(params.afterItem.itemType, params.afterItem.guid, params.afterItem.params)
    else
      self.modules.afterItem:setGeneralContent(params.afterItem.itemType, params.afterItem.itemId, params.afterItem.params)
    end
  end
end

function this:close()
  this.super.close(self)
  if self._params.pageClosedCallback then
    self._params.pageClosedCallback()
  end
end

function this:escHandle()
  if self._params.closeCallbackTemp then
    self._params.closeCallbackTemp()
  end
  L_UI:close(self.pageName)
end

return this
