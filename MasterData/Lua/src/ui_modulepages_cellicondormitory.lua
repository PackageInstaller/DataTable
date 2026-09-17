local this = class("cellIconDormitory", G_UIModuleBase)

function this.bind()
  return {
    rect_hero = false,
    img_texIconHero = nil,
    rect_addHero = false,
    rect_lock = false,
    txt_id = "",
    txt_name = "",
    img_outside = false,
    img_doom = false
  }
end

function this.methods()
  return {
    onClick_addHero = function(self)
    end,
    onClick_switch = function(self)
    end,
    onClick_visit = function(self)
    end,
    onClick_Hero = function(self)
    end
  }
end

function this:open()
  this.super.open(self)
end

function this:refresh()
  self:refreshView()
end

function this:close()
end

function this:refreshView()
end

return this
