local this = class("cellChatEmotionTab", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    img_normalIcon = "",
    img_selectIcon = "",
    item_id = -1
  }
end

return this
