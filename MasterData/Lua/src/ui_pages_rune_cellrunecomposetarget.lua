local this = class("cellRuneComposeTarget", G_UIModuleBase)
local talentRuneComposeTpl = L_GameTpl:getTalentRuneComposeTpl()
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()
local commonItemTpl = L_GameTpl:getCommonItemTpl()
local originalSize = 8

function this.bind()
  return {
    itemIcon = "",
    sourceArrowActive = false,
    selectedBgActive = false,
    starList = {},
    img_pageBg = ""
  }
end

function this.methods()
  return {
    onClick_item = function(self)
      self:emit("onClick_item", {
        itemId = self.itemId,
        targetNum = self.targetNum,
        hadNum = self.bind.hadNum
      })
    end
  }
end

function this:open()
end

function this:refresh()
  if not self.isBind then
    return
  end
  self:initData(self.bind)
end

function this:initData(data)
  if not self.isBind or not data.itemId then
    return
  end
  self.itemId = data.itemId
  self.targetNum = data.targetNum or 1
  self.holdNum = data.holdNum
  local item = L_ItemTplManager:getCommonItem(data.itemId)
  self.bind.itemIcon = item.icon
  self.bind.selectedBgActive = data.isTarget == true
  local tpl = commonItemTpl:getTplById(self.itemId)
  local rarity = commonItemTpl:getRarity(tpl)
  self.bind.img_pageBg = L_HomeConst.CommonItemRarity2PageBg[rarity]
  self:setStars(L_ItemTplManager:getItemShowStarNum(L_Const.resType.commonItem, self.itemId))
  if data.showType == L_Const.runeComposeType.target then
    self:setTarget(data)
  elseif data.showType == L_Const.runeComposeType.targetList then
    self:setTargetList(data)
  elseif data.showType == L_Const.runeComposeType.compose then
    self:setCompose(data)
  end
  if data.needToPlay then
    self.bindComponents.showRuneComposeTarget:Stop()
    self.bindComponents.showRuneComposeTarget:Play("anim_rune_cell_target")
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

function this:setTarget(data)
  local runeTpl = talentRuneTpl:getTplByItemId(data.itemId)
  local composeTpl = talentRuneComposeTpl:getTplById(data.itemId)
  local items
  if composeTpl ~= nil then
    items = talentRuneComposeTpl:getItems(composeTpl)
  end
end

function this:setTargetList(data)
  self.bind.selectedBgActive = data.isTarget
  self.bind.sourceArrowActive = data.targetIndex > 1
end

function this:setCompose(data)
  if not data.listSize then
    return
  end
  local holdStr = string.format("%s/%s", data.holdNum, data.targetNum)
  if data.targetNum > data.holdNum then
    holdStr = L_GameUtil.fillColor(holdStr, L_Const.colorHtml.red01)
  end
end

function this:close()
end

return this
