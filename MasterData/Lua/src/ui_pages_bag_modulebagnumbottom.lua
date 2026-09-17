local this = class("moduleBagNumBottom", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local NumLimit = {
  [L_BagConst.bagTag.soulEssence] = L_GameConstTpl:getData("BAG_LIMIT_SOULESSENCE", L_Const.GameTplType.int),
  [L_BagConst.bagTag.accessory] = L_GameConstTpl:getData("BAG_LIMIT_ACCESSORY", L_Const.GameTplType.int),
  [L_BagConst.bagTag.petEgg] = L_GameConstTpl:getData("PET_EGG_LIMITS", L_Const.GameTplType.int)
}

function this.bind()
  return {
    isOn_numLimit = false,
    txt_numLimit = "",
    txt_numLimitMax = "",
    go_smelt = false
  }
end

function this.methods()
  return {
    onClick_Smelting = function()
      L_UI:open("pageAccessorySmelting")
    end
  }
end

function this:open()
end

function this:close()
end

function this:refreshLimit(data)
  self.bind.isOn_numLimit = data.needShowNumLimit
  self.bind.go_smelt = data.showSmelt
  if data.needShowNumLimit then
    if data.hasNum < data.numLimit then
      self.bind.txt_numLimit = tostring(data.hasNum)
      self.bind.txt_numLimitMax = string.concat("/", data.numLimit)
    else
      self.bind.txt_numLimit = L_GameUtil.fillColor(data.hasNum, L_Const.colorHtml.red001)
      self.bind.txt_numLimitMax = string.concat("/", data.numLimit)
    end
  end
end

return this
