local module = class("cellPetBoxRating", G_UIModuleBase)

function module.bind()
  return {txt_normal = ""}
end

function module:Init(grade)
  self.bind.txt_normal = tostring(grade)
end

return module
