local this = class("cellCollectionOutput", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsCollectionTpl()
local _productsCollectionTypeTpl = L_GameTpl:getProductsCollectionTypeTpl()

function this.bind()
  return {
    go_item = false,
    cellIcon_reward = {
      moduleName = "modulePages/cellIconBag"
    },
    img_icon_fx = nil,
    go_rare = false,
    img_rare = nil
  }
end

function this.methods()
  return {}
end

function this:open()
  this.super.open(self)
  self:initCell()
end

function this:close()
  this.super.close(self)
  L_TimerManager:clearTimer(self)
end

function this:initCell()
  if not self.isBind then
    return
  end
  self:setItem(self.bind.reward, true, self.bind.index, true)
end

function this:setItem(reward, isNeedPlayAni, index, isInit)
  self.bind.reward = reward
  if table.isEmpty(reward) then
    self:setEmpty()
    return
  end
  self.bind.product_id = reward.product_id
  local tpl_pro = _productsTpl:getTplById(reward.product_id)
  local dropType = _productsTpl:getDropType(tpl_pro)
  local data = L_DataUtil.parseRewardConfigItem(_productsTpl:getDropShow(tpl_pro)[1])
  local tpl_dropType = _productsCollectionTypeTpl:getTplById(dropType)
  self.bind.go_item = true
  self.modules.cellIcon_reward:setGeneralContent(data.itemType, data.itemId, {
    itemNum = reward.collect_num
  })
  local configData = L_ItemTplManager:getItemConfig(data.itemType, data.itemId)
  self.bind.img_icon_fx = configData.icon
  local isRare = _productsCollectionTypeTpl:getIsShowInOutPut(tpl_dropType)
  self.bind.go_rare = isRare
  self.bind.img_rare = _productsCollectionTypeTpl:getIcon(tpl_dropType)
  if isNeedPlayAni then
    self:playAni(isRare, index, isInit)
  end
end

function this:setEmpty()
  if self.bind.go_item == false and self.bind.go_rare == false then
    return
  end
  self.bind.go_item = false
  self.bind.go_rare = false
end

function this:playAni(isRare, index, isInit)
  self.bindComponents.anim_cellIcon:Play("anim_cellicon_init")
  local initTime = isInit and 0.2 or 0
  local delayTime = (index - 1) * 0.033 + initTime
  L_TimerManager:newOrResetTimer(self, "delayAni", function()
    if isRare then
      self.bindComponents.anim_cellIcon:Play("anim_cellicon_Nget")
    else
      self.bindComponents.anim_cellIcon:Play("anim_cellicon_Nget")
    end
  end, delayTime)
end

return this
