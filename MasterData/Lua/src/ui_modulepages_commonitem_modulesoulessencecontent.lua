local this = class("moduleSoulEssenceContent", G_UIModuleBase)

function this.bind()
  return {
    img_soulessenceIcon = "",
    list_soulessenceStar = {}
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
  self.bind.img_soulessenceIcon = data.icon
  self.bind.go_normalStar = false
  self.bind.go_soulEssenceStar = true
  self.bind.go_goldSideAccessory = false
  local stars = {}
  for i = 1, data.star - 1 do
    table.insert(stars, {})
  end
  self.bind.list_soulessenceStar:clear()
  self.bind.list_soulessenceStar:insert_array(stars)
end

return this
