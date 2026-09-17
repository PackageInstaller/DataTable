local this = class("moduleGiftList", G_UIModuleBase)

function this:bind()
  return {
    giftList = {
      moduleName = "modulePages/cellSubmitItem"
    }
  }
end

function this:List()
  return {
    moduleScrollListBag = {
      moduleName = "modulePages/cellSubmitItem"
    }
  }
end

return this
