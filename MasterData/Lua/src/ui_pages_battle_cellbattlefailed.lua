local this = class("cellBattleFailed", G_UIModuleBase)

function this.bind()
  return {img_icon = "", txt_tip = ""}
end

function this.methods()
  return {
    onClick = function(self)
    end
  }
end

function this:refresh()
end

return this
