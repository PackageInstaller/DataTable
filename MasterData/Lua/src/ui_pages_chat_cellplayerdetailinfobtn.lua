local this = class("cellPlayerDetailInfoBtn", G_UIModuleBase)

function this.bind()
  return {
    img_icon = "",
    txt_name = "",
    active_topLine = false,
    active_leftLine = false
  }
end

function this.methods()
  return {
    onClick = function()
      self.bind.callback()
    end
  }
end

function this:preOpen(options)
end

return this
