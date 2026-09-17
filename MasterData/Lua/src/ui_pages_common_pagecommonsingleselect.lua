local this = class("pageCommonSingleSelect", G_UIPageBase)

function this.bind()
  return {
    txt_content = "",
    scrollList_item = {
      moduleName = "modulePages/cellIcon"
    },
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip
  }
end

function this.methods()
  return {
    moduleCommonTipMedium = {
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
          self._params.confirmCallback(self._selectId)
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

function this:check(options, callback)
  local data = options or {}
  callback(not table.isEmpty(data.itemList))
end

function this:preOpen(options)
  self._params = options or {}
  self.modules.module_commonTipSmall:initModule(self._params)
  self.bind.go_content = not string.isEmpty(self._params.txtContent)
  self.bind.txt_content = self._params.txtContent
  self._itemList = data.itemList
  self:initItemList(data.itemList)
  self._selectId = not math.isEmpty(data.defaultSelectId) and data.defaultSelectId or #self.modules.scrollList_item > 0 and self.modules.scrollList_item[1].bind.itemId
  self:setItemListActive()
end

function this:initItemList(list)
  local tmp = {}
  for i, v in pairs(list) do
    local cell = {}
    table.merge(cell, v)
    
    function cell.callback()
      self._selectId = v.itemId
      self:setItemListActive()
    end
    
    table.insert(tmp, cell)
  end
  self.bind.scrollList_item:clear()
  self.bind.scrollList_item:insert_array(tmp)
end

function this:setItemListActive()
  for i, module in ipairs(self.modules.scrollList_item) do
    module:setSelectState(module.bind.itemId == self._selectId)
  end
end

return this
