local this = class("cellHeroLevelUpItem", G_UIModuleBase)

function this.bind()
  return {
    imageIcon = "",
    imageColor = C_Color.white,
    textNum = "",
    imageIconColor = C_Color.white
  }
end

function this.methods()
  return {
    onClick = function(self)
      if not self._noTip then
        L_ItemTplManager:showInfoTip(self._itemType, self._itemId, self.bind.guid)
      end
    end,
    onLongPress = function(self)
      if (self._callback or self._selectMode) and not self._noTip then
        L_ItemTplManager:showInfoTip(self._itemType, self._itemId, self.bind.guid)
      end
    end
  }
end

function this:open()
  this.super.open(self)
  self:refreshView()
end

function this:refreshView()
  if not self.isBind then
    return
  end
  local itemType = self.bind.itemType
  if not itemType then
    return
  end
  self.bind.itemNum = self.bind.itemNum or 1
  self:setGeneralContent(itemType, self.bind.itemId, self.bind)
  if self._selectMode then
    self._selectedNum = 0
  end
end

function this:close()
end

function this:setGeneralContent(itemType, itemId, params)
  params = params or {}
  self._itemType = itemType
  self._itemId = itemId
  self.bind.itemNum = params.itemNum
  self.bind.textNum = tostring(params.itemNum)
  local conf = L_ItemTplManager:getItemConfig(itemType, itemId)
  self.bind.imageIcon = conf.icon
  local rarity = conf.quality
  local rarityTpl = L_RarityTpl:getTplById(rarity)
  local colorCfg = L_RarityTpl:getColorCircle(rarityTpl)
  local _, color = C_ColorUtility.TryParseHtmlString(colorCfg)
  if params.imageColorAlpha then
    color.a = params.imageColorAlpha
  end
  if params.imageIconColorAlpha then
    local imageIconColor = C_Color.white
    imageIconColor.a = params.imageIconColorAlpha
    self.bind.imageIconColor = imageIconColor
  end
  self.bind.imageColor = color
  self.bind.activeReduce = params.mutiSelect == true
  self._callback = params.callback
  self._selectCallback = params.selectCallback
  self._selectMode = params.selectMode or params.selectCallback ~= nil
  self._validateSelectFunc = params.validateSelectFunc
  self._noTip = params.noTip
end

function this:setDisable(state)
  self.bind.activeDisable = state
end

return this
