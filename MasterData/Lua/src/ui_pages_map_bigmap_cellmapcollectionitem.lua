local this = class("cellMapCollectionItem", G_UIModuleBase)
local descImgColorMap = {
  [0] = "#b8b5acb2",
  [1] = "#5bc493b2",
  [2] = "#78a8d3b2",
  [3] = "#8886c3b2",
  [4] = "#e9b549b2"
}

function this.bind()
  return {
    toggleUnlock = false,
    color_descImg = nil,
    img_icon = "",
    img_journeyTarget = "",
    starList = {},
    itemName = "",
    select = false,
    iconBg = nil,
    active_iconHasTrack = false,
    active_iconJourneyTarget = false,
    go_selectUnlock = false,
    img_icon_outline = ""
  }
end

function this.methods()
  return {
    onClick_unlock = function(self)
      self:emit("onClick_unlock", self.bind)
    end,
    onClick_lock = function(self)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_collect_tips_01"))
    end
  }
end

function this:toBind(uiBinding)
  this.super.toBind(self, uiBinding)
end

function this:refresh()
  self._itemType = self._itemType or self.bind.itemType
  self._itemId = self._itemId or self.bind.itemId
  self._itemNumTxt = self._itemNumTxt or self.bind.itemNumTxt
  
  function self.bind.callback()
    self.methods.onClick_unlock(self)
  end
  
  if not self._itemType then
    self.bind.toggleUnlock = false
    return
  end
  local conf = L_ItemTplManager:getItemConfig(self._itemType, self._itemId)
  self:refreshCellOfCommon(conf)
  local allCollectionUnlock = L_MapStore:getMapCollectionDict()
  self.bind.toggleUnlock = allCollectionUnlock[self.bind.collectionId] and true or false
end

function this:refreshCellOfCommon(conf)
  self:refreshTraceIcon()
  self.bind.img_icon = conf.icon
  self.bind.img_icon_outline = conf.icon
  self.quality = conf.quality or 0
  self:setStars(L_ItemTplManager:getItemShowStarNum(self._itemType, self._itemId))
  self.bind.itemName = conf.name
  self.bind.iconBg = string.format("UI/Atlas/BSCommon/tex_homecommontip_bg_quality_%s.png", conf.quality)
  local _, color = C_ColorUtility.TryParseHtmlString(descImgColorMap[conf.quality])
  self.bind.color_descImg = color
end

function this:refreshTraceIcon()
  if L_MapStore:getCurTraceCollectionId() == self.bind.collectionId then
    self.bind.active_iconHasTrack = true
  end
end

function this:setStars(num)
  if not self.isBind then
    return
  end
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.starList:clear()
  self.bind.starList:insert_array(stars)
end

function this:setIsJourneyJump(isTarget)
  self.bind.active_iconJourneyTarget = isTarget
  self.bind.active_iconHasTrack = false
end

return this
