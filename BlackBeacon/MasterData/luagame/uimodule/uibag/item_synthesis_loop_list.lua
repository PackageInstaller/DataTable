local Base = require("ui.widget.infinite_loop_list")
local M = Util.create_child_mt(Base)

function M:_update_scrollview_cell(item, index, src_idx)
  index = index + 1
  src_idx = src_idx + 1
  local item_ui
  if index == src_idx then
    if self.v_items[index] == nil then
      item_ui = self.ItemClass:ui_wrap(self.v_parent_ui, item, true)
      self.v_items[index] = item_ui
    else
      item_ui = self.v_items[index]
    end
  else
    item_ui = self.v_items[src_idx]
    if nil == item_ui then
      Log.Error("没有找到序号scr_idx=", src_idx, "的ui对象！")
    end
    self.v_items[index] = item_ui
    self.v_items[src_idx] = nil
  end
  if index > #self.v_data then
    item:SetActiveEx(false)
    return
  end
  item_ui:set_data(self.v_data[index])
end

function M:refresh_data(item_exchange)
  Base.refresh_data(self, item_exchange)
end

function M:select_first_item()
  if self.v_items[1] then
    self.v_items[1]:on_click_item(true)
  end
end

function M:set_select_exchange_item(exchange_id)
  for index, data in pairs(self.v_data) do
    if data.targetInfo.Id == exchange_id then
      self:scroll_to_item(index - 1)
      self.v_parent_ui:on_click_item(data, true)
      return true
    end
  end
end

return M
