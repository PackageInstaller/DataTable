local this = class("cellReputationItem", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _productsTpl = L_GameTpl:getProductsTpl()
local _moduleHomeLevelInfoTipPrefab = "UI/Pages/Home/HomeLevel/moduleHomeLevelInfoTip.prefab"
local _moduleHomeLevelInfoTip = "ui.pages.home.homeLevel.moduleHomeInfoTip"

function this.bind()
  return {
    txt_name = nil,
    go_singleIcon = false,
    img_singleIcon = nil,
    go_groupIcon = false,
    img_groupBg = nil,
    img_groupIcon = nil,
    go_itemIcon = false,
    img_itemIcon = nil,
    img_pageBg = nil,
    list_rarityStar = {},
    color_type = nil,
    img_type = nil,
    go_select = false,
    go_imgLockIcon = false
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      self:onClickSelect()
    end
  }
end

function this:open()
  this.super.open(self)
  self:initCell()
end

function this:initCell()
  if not self.isBind then
    return
  end
  local unlockCondition = {}
  if self.bind.type == L_HomeConst.HomeLevelUnlockModuleType.Building then
    local tpl = _homeBuildingTpl:getTplById(self.bind.id)
    self.bind.txt_name = _homeBuildingTpl:getName(tpl)
    self.bind.go_singleIcon = true
    self.bind.img_singleIcon = _homeBuildingTpl:getBuildIcon(tpl)
    if not table.isEmpty(_homeBuildingTpl:getUpgradeCondition(tpl)) then
      unlockCondition = _homeBuildingTpl:getUpgradeCondition(tpl)
    else
      unlockCondition = _productsTpl:getHomeBuildingUnlockConditionByBuildingId(self.bind.id)
    end
  elseif self.bind.type == L_HomeConst.HomeLevelUnlockModuleType.CommonItem then
    local tpl = _commonItemTpl:getTplById(self.bind.id)
    self.bind.txt_name = _commonItemTpl:getName(tpl)
    self.bind.go_itemIcon = true
    self.bind.img_itemIcon = _commonItemTpl:getIcon(tpl)
    local rarity = _commonItemTpl:getRarity(tpl)
    self.bind.img_pageBg = L_HomeConst.CommonItemRarity2PageBg[rarity]
    self.bind.list_rarityStar:clear()
    local productsTpl = _productsTpl:getTplByReward(L_Const.resType.commonItem, self.bind.id)
    if not table.isEmpty(productsTpl) then
      unlockCondition = _productsTpl:getUnlockCondition(productsTpl)
    end
  end
  local isUnlock = true
  for _, v in pairs(unlockCondition) do
    local isComplete = L_ConditionManager:singleIsComplete(v)
    if not isComplete then
      isUnlock = false
      break
    end
  end
  self.bind.go_imgLockIcon = not isUnlock
  self.bind.color_type = L_HomeConst.HomeLevelUnlockModuleRes[self.bind.type].color
  self.bind.img_type = L_HomeConst.HomeLevelUnlockModuleRes[self.bind.type].icon
end

function this:onClickSelect()
  self.bind.go_select = true
  self:emit("onClick_select", self.bind, self.bindComponents.rect_cellReputationItem.position)
  if self.bind.callback ~= nil then
    self.bind.callback(self)
  end
end

function this:setSelected(isSelected)
  self.bind.go_select = isSelected
end

return this
