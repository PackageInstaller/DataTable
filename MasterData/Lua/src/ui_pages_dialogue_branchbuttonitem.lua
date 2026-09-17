local item = class("branchButtonItem", G_UIModuleBase)

function item.bind()
  return {
    toggle_select = false,
    pos_buttonLine = C_Vector2(-148.3, -121.9),
    active_buttonBg = false,
    rect_line1 = C_Vector2(100, 53),
    rect_line2 = C_Vector2(100, 53),
    dialogButtonSelectText = "",
    dialogButtonUnSelectText = ""
  }
end

function item.methods()
  return {
    onClick = function(self)
    end,
    onPointEnter = function(self)
    end
  }
end

return item
