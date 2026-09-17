local this = class("cellBagTag", G_UIModuleBase)

function this.bind()
  return {txt_tag = ""}
end

function this:setTagText(tagText)
  self.bind.txt_tag = tagText
end

return this
