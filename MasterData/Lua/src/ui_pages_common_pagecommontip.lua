local this = class("pageCommonTip", G_UIPageBase)

function this.bind()
  return {
    module_commonTipSmall = L_Const.ModuleInfo.ModuleCommonTip,
    go_content = false,
    txt_content = "",
    go_subContent = false,
    txt_subContent = "",
    go_bottomSubContent = false,
    txt_bottomSubContent = "",
    go_showNoMoreOption = false,
    txt_showNoMoreOption = "",
    go_showNoMore = false,
    sortingOrder_page = nil,
    go_listItem = false,
    list_item = L_Const.ModuleInfo.CellIconBag
  }
end

function this.methods()
  return {
    onClick_noMoreShow = function(self)
      self.bind.go_showNoMore = not self.bind.go_showNoMore
    end,
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
        local hasNoMoreType = not math.isEmpty(self._params.showNoMoreType)
        if hasNoMoreType then
        end
        if self.noClose then
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

function this:show(options)
  this.super.show(self, options)
  if options ~= self._params then
    self:refreshPage(options)
  end
end

function this:refreshPage(params)
  params = params or {}
  self._params = params
  self.modules.module_commonTipSmall:initModule(params)
  self.bind.go_content = not string.isEmpty(params.txtContent)
  self.bind.txt_content = params.txtContent
  self.bind.go_subContent = not string.isEmpty(params.txtSubContent)
  self.bind.txt_subContent = params.txtSubContent
  self.bind.go_normalLayout = not params.isChest
  self.bind.go_chestLayout = params.isChest
  self.bind.txt_tips = params.txtTips
  self.noClose = params.noClose
  local hasNoMoreOption = not math.isEmpty(params.showNoMoreType)
  self.bind.go_showNoMoreOption = hasNoMoreOption
  if hasNoMoreOption then
    self.bind.go_showNoMore = params.showNoMoreDefaultValue == true
    if params.showNoMoreType == L_Const.ShowNoMoreType.curLogin then
      self.bind.txt_showNoMoreOption = L_WordsTpl:getValue("ui_plot_skip_noprompts")
    elseif params.showNoMoreType == L_Const.ShowNoMoreType.today then
      self.bind.txt_showNoMoreOption = L_WordsTpl:getValue("ui_systemMessage_07")
    end
  end
  if not math.isEmpty(params.overrideSortingOrder) and params.overrideSortingOrder > 0 then
    self.bind.sortingOrder_page = params.overrideSortingOrder
  end
  local hasItemList = not math.isEmpty(params.itemList)
  self.bind.go_listItem = hasItemList
  if hasItemList then
    self.bind.list_item:clear()
    self.bind.list_item:insert_array(params.itemList)
  end
  local hasChestItemList = not math.isEmpty(params.chestItemList)
  if hasChestItemList then
    self.bind.list_chestItem:clear()
    self.bind.list_chestItem:insert_array(params.chestItemList)
  end
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.tsf_content)
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
