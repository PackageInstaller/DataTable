local module = class("cellNewTagItem", G_UIModuleBase)
local Type2BgColor = {
  [0] = "#0000004C",
  [1] = "#A091BC",
  [2] = "#C1AB71",
  [3] = "#81A3BB"
}
local Type2BgName = {
  [0] = "UI/Atlas/PetBox/tex_petget_bg02_s",
  [1] = "UI/Atlas/PetBox/tex_petget_bg02_s",
  [2] = "UI/Atlas/PetBox/tex_petget_bg01_s",
  [3] = "UI/Atlas/PetBox/tex_petget_bg03_s"
}

function module.bind()
  return {label = "", imgBg = ""}
end

function module:show()
  if self.isBind then
    local imgName = Type2BgName[self.bind.type or 0]
    if imgName ~= nil then
      self.bind.imgBg = imgName
    end
  end
end

return module
