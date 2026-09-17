local this = class("cellProductAccessoryQueue", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsTpl()
local quality_color = L_Const.accessoryQualityColor
local CellMode = {
  NORMAL = 1,
  NONE = 2,
  LOCK = 3
}

function this.bind()
  return {
    tab_mode = -1,
    color_qualityBg = C_Color(1, 1, 1, 1),
    img_product = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  local isUnlock = self.bind.isUnlock
  local unlockLevel = self.bind.unlockLevel
  local csHomeBuildProductData = self.bind.csHomeBuildProductData
  local isEmpty = self.bind.isEmpty
  self._csHomeBuildProductData = csHomeBuildProductData
  if not isUnlock then
    self.bind.tab_mode = CellMode.LOCK
  elseif isEmpty then
    self.bind.tab_mode = CellMode.NONE
  else
    self.bind.tab_mode = CellMode.NORMAL
    local productId = csHomeBuildProductData.productId
    local tpl = _productsTpl:getTplById(productId)
    local reward = _productsTpl:getRewardId(tpl)
    local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
    local conf = L_ItemTplManager:getItemConfig(itemData.itemType, itemData.itemId)
    local _, color = C_ColorUtility.TryParseHtmlString(quality_color[conf.quality])
    self.bind.color_qualityBg = color
    self.bind.img_product = conf.icon
  end
end

return this
