local this = class("pageSelectFishingGear", G_UIPageBase)

function this.bind()
  return {
    txt_title = nil,
    list_gear = {
      moduleName = "pages/fishing/cellSelectFishingGear"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    list_gear = {
      onClick_select = function(self, bind)
        self._callback(bind.guid)
        L_UI:close(self.pageName)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._callback = options.callback
  self.bind.txt_title = options.txtTitle
  self.bind.list_gear:clear()
  self.bind.list_gear:insert_array(options.itemList)
  self:setListSelect(options.defaultSelectId)
end

function this:close(options)
  this.super.close(self, options)
end

function this:setListSelect(selectId)
  for i, v in pairs(self.modules.list_gear) do
    local cell = v
    cell:setSelect(selectId == cell.bind.guid)
  end
end

return this
