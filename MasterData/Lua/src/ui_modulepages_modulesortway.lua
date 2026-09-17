local this = class("moduleSortWay", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    scrollList_sortWay = {
      moduleName = "modulePages/cellSortWay"
    }
  }
end

function this.methods()
  return {
    onClick_filter = function(self)
      if self._filterCallback then
        self._filterCallback()
      end
    end,
    scrollList_sortWay = {
      onClick_select = function(self, bind)
        self._sortCallback(bind.type, bind.order)
        self._selectSortType = bind.type
        self:setSortWayListActive()
      end,
      onClick_order = function(self, bind)
        self._sortCallback(bind.type, bind.order)
      end
    }
  }
end

function this:initModule(list, sortCallback, filterCallBack, defaultSort)
  self._sortCallback = sortCallback
  self._filterCallback = filterCallBack
  local tmp = {}
  self._selectSortType = list[1]
  for i, v in pairs(list) do
    table.insert(tmp, {
      type = v,
      order = L_Const.sortOrder.DESC,
      txt_normal = L_WordsTpl:getValue(L_Const.sortWayTxt[v]),
      txt_active = L_WordsTpl:getValue(L_Const.sortWayTxt[v]),
      go_normal = false,
      go_active = false
    })
  end
  self.bind.scrollList_sortWay:clear()
  self.bind.scrollList_sortWay:insert_array(tmp)
  self:setSortWayListActive()
end

function this:setSortWayListActive()
  for i = 1, #self.bind.scrollList_sortWay do
    local active = false
    local active_normal = true
    if self.bind.scrollList_sortWay:getValue(i, "type") == self._selectSortType then
      active = true
      active_normal = false
    end
    self.bind.scrollList_sortWay:change(i, {go_active = active, go_normal = active_normal})
  end
end

return this
