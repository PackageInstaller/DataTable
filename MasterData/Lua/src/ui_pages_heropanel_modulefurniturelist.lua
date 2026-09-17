local this = class("moduleFurnitureList", G_UIModuleBase)

function this:bind()
  return {
    moduleScrollListBag = {
      moduleName = "modulePages/cellSubmitItem"
    }
  }
end

return this
