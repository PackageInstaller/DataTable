local Base = require("ui.widget.widget_folder_ex")
local M = Util.create_child_mt(Base)

function M:select_element(idx, subidx)
  if not idx then
    return
  end
  local element = self.v_elements[idx]
  if not element then
    return
  end
  if subidx then
    if element.subs then
      if subidx > #element.subs then
        return
      end
      if not element.is_opening then
        self:unfold_child(element)
      end
      element.is_opening = true
      self:on_select(idx, subidx)
      self:click_element(idx, subidx)
    end
  elseif element.subs and #element.subs > 0 then
    if element.is_opening then
      self:fold_child(element)
    else
      self:unfold_child(element)
    end
  end
  self.v_select_idx = idx
  self.v_select_subidx = subidx
end

return M
