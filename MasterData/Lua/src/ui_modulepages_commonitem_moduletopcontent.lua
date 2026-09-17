local this = class("moduleTopContent", G_UIModuleBase)

function this.bind()
  return {
    img_foodBuff = "",
    active_rarity = false,
    img_rarity = "",
    active_elementEffect = false,
    img_elementEffect = ""
  }
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:refreshView(data)
  if data.img_foodBuff then
    self.bind.img_foodBuff = data.img_foodBuff
  end
  if data.specialRarity and data.specialRarity ~= "" then
    self.bind.active_rarity = true
    self.bind.img_rarity = data.img_rarity
  else
    self.bind.active_rarity = false
  end
  if data.elementEffect then
    self.bind.active_elementEffect = true
    self.bind.img_elementEffect = data.elementEffect
  else
    self.bind.active_elementEffect = false
  end
end

function this:refreshEleEffect(data)
  if data.elementEffect and data.elementEffect ~= 0 then
    self.bind.active_elementEffect = true
    if data.elementEffect == 1 then
      self.bind.img_elementEffect = "UI/Page/Common/CommonArt/tex_common_icon_tisheng"
    elseif data.elementEffect == 2 then
      self.bind.img_elementEffect = "UI/Page/Common/CommonArt/tex_common_icon_xiajiang"
    end
  else
    self.bind.active_elementEffect = false
  end
end

return this
