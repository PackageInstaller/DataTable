local module = class("cellIconBuildTagTips", G_UIModuleBase)

function module.bind()
  return {img_icon = "", txt_name = ""}
end

function module:show()
  self.bind.img_icon = self.bind.icon
  self.bind.txt_name = self.bind.name
end

return module
