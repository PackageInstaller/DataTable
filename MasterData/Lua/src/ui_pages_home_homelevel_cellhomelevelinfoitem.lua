local this = class("cellHomeLevelInfoItem", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _homeBlockTpl = L_GameTpl:getHomeBlockTpl()
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _homeTechnologyTpl = L_GameTpl:getHomeTechnologyTpl()
local _homeTechnologyTreeTpl = L_GameTpl:getHomeTechnologyTreeTpl()
local _productsTpl = L_GameTpl:getProductsTpl()
local _homeBuildingNumTpl = L_GameTpl:getHomeBuildingNumTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _mountSaddleTpl = L_GameTpl:getMountSaddleTpl()

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
    if tpl == nil then
      C_MJLog.LogError(string.format("homeBuildingId:%d 没有homeBuildingTpl配置", self.bind.id))
      return
    end
    self.bind.txt_name = _homeBuildingTpl:getName(tpl)
    self.bind.go_singleIcon = true
    self.bind.img_singleIcon = _homeBuildingTpl:getBuildIcon(tpl)
    if not table.isEmpty(_homeBuildingTpl:getUpgradeCondition(tpl)) then
      unlockCondition = _homeBuildingTpl:getUpgradeCondition(tpl)
    else
      unlockCondition = _productsTpl:getHomeBuildingUnlockConditionByBuildingId(self.bind.id)
    end
  elseif self.bind.type == L_HomeConst.HomeLevelUnlockModuleType.System then
    local tpl = _systemUnlockTpl:getTplById(self.bind.id)
    if tpl == nil then
      C_MJLog.LogError(string.format("systemUnlockTplId:%d 没有systemUnlockTpl配置", self.bind.id))
      return
    end
    self.bind.txt_name = _systemUnlockTpl:getName(tpl)
    self.bind.go_groupIcon = true
    self.bind.img_groupBg = L_HomeConst.HomeLevelUnlockModuleRes[L_HomeConst.HomeLevelUnlockModuleType.System].bg
    self.bind.img_groupIcon = _systemUnlockTpl:getIcon(tpl)
    unlockCondition = _systemUnlockTpl:getUnlockCondi(tpl)
  elseif self.bind.type == L_HomeConst.HomeLevelUnlockModuleType.Block then
    local tpl = _homeBlockTpl:getTplById(self.bind.id)
    if tpl == nil then
      C_MJLog.LogError(string.format("homeBlockTplId:%d 没有homeBlockTpl配置", self.bind.id))
      return
    end
    self.bind.txt_name = _homeBlockTpl:getName(tpl)
    self.bind.go_groupIcon = true
    self.bind.img_groupBg = L_HomeConst.HomeLevelUnlockModuleRes[L_HomeConst.HomeLevelUnlockModuleType.Block].bg
    self.bind.img_groupIcon = _homeBlockTpl:getIcon(tpl)
    unlockCondition[1] = _homeBlockTpl:getUnlockCondi(tpl)
  elseif self.bind.type == L_HomeConst.HomeLevelUnlockModuleType.Technology then
    local tpl = _homeTechnologyTpl:getTplById(self.bind.id)
    if tpl == nil then
      C_MJLog.LogError(string.format("homeTechnologyTplId:%d 没有homeTechnologyTpl配置", self.bind.id))
      return
    end
    self.bind.txt_name = string.format("%sLv.%s", _homeTechnologyTpl:getObjName(tpl), _homeTechnologyTpl:getLevel(tpl))
    self.bind.go_groupIcon = true
    self.bind.img_groupBg = L_HomeConst.HomeLevelUnlockModuleRes[L_HomeConst.HomeLevelUnlockModuleType.Technology].bg
    local tpl_tree = _homeTechnologyTreeTpl:getTplById(_homeTechnologyTpl:getType(tpl))
    self.bind.img_groupIcon = _homeTechnologyTreeTpl:getIcon(tpl_tree)
    unlockCondition = _homeTechnologyTpl:getUnlockCondi1(tpl)
  elseif self.bind.type == L_HomeConst.HomeLevelUnlockModuleType.CommonItem then
    local tpl = _commonItemTpl:getTplById(self.bind.id)
    if tpl == nil then
      C_MJLog.LogError(string.format("CommonItemId:%d 没有配置", self.bind.id))
      return
    end
    self.bind.txt_name = _commonItemTpl:getName(tpl)
    self.bind.go_itemIcon = true
    self.bind.img_itemIcon = _commonItemTpl:getIcon(tpl)
    local rarity = _commonItemTpl:getRarity(tpl)
    self.bind.img_pageBg = L_HomeConst.CommonItemRarity2PageBg[rarity]
    local rarityStarListConfig = {}
    for i = 0, rarity do
      table.insert(rarityStarListConfig, {})
    end
    self.bind.list_rarityStar:clear()
    self.bind.list_rarityStar:insert_array(rarityStarListConfig)
    local productsTpl = _productsTpl:getTplByReward(L_Const.resType.commonItem, self.bind.id)
    if not table.isEmpty(productsTpl) then
      unlockCondition = _productsTpl:getUnlockCondition(productsTpl)
    end
  elseif self.bind.type == L_HomeConst.HomeLevelUnlockModuleType.MountSaddle then
    local tpl = _mountSaddleTpl:getTplById(self.bind.id)
    if tpl == nil then
      C_MJLog.LogError(string.format("mountSaddleId:%d 没有mount_saddle配置", self.bind.id))
      return
    end
    self.bind.txt_name = _mountSaddleTpl:getName(tpl)
    self.bind.go_itemIcon = true
    self.bind.img_itemIcon = _mountSaddleTpl:getIcon(tpl)
    local rarity = _mountSaddleTpl:getRarity(tpl)
    self.bind.img_pageBg = L_HomeConst.CommonItemRarity2PageBg[rarity]
    local rarityStarListConfig = {}
    for i = 0, rarity do
      table.insert(rarityStarListConfig, {})
    end
    self.bind.list_rarityStar:clear()
    self.bind.list_rarityStar:insert_array(rarityStarListConfig)
    local productsTpl = _productsTpl:getTplByReward(L_Const.resType.mountSaddle, self.bind.id)
    if not table.isEmpty(productsTpl) then
      unlockCondition = _productsTpl:getUnlockCondition(productsTpl)
    end
  elseif self.bind.type == L_HomeConst.HomeLevelUnlockModuleType.BuildingNum then
    local homeBuildingNumtpl = _homeBuildingNumTpl:getTplById(self.bind.id)
    if homeBuildingNumtpl == nil then
      C_MJLog.LogError(string.format("homeBuildingNumId:%d 没有home_building_num配置", self.bind.id))
      return
    end
    local buildingGroupId = _homeBuildingNumTpl:getGroupId(homeBuildingNumtpl)
    local homeBuildingTpl = _homeBuildingTpl:getBuildingBaseTplByGroupId(buildingGroupId)
    local homeBuildingGroupTpl = _homeBuildingGroupTpl:getTplById(buildingGroupId)
    local buildingName = _homeBuildingGroupTpl:getName(homeBuildingGroupTpl)
    
    local function getNameStrList(inputstr)
      if not inputstr or type(inputstr) ~= "string" or #inputstr <= 0 then
        return nil
      end
      local i = 1
      local strList = {}
      while true do
        local curByte = string.byte(inputstr, i)
        local byteCount = 1
        if 239 < curByte then
          byteCount = 4
        elseif 223 < curByte then
          byteCount = 3
        elseif 128 < curByte then
          byteCount = 2
        else
          byteCount = 1
        end
        local char = string.sub(inputstr, i, i + byteCount - 1)
        table.insert(strList, char)
        i = i + byteCount
        if i > #inputstr then
          break
        end
      end
      return strList
    end
    
    local nameStrList = getNameStrList(buildingName)
    if 7 < #nameStrList then
      local tmpList = {}
      for i = 1, 6 do
        tmpList[i] = nameStrList[i]
      end
      tmpList[7] = "..."
      nameStrList = tmpList
    end
    buildingName = ""
    for i = 1, #nameStrList do
      buildingName = buildingName .. nameStrList[i]
    end
    self.bind.txt_name = buildingName .. "+" .. _homeBuildingNumTpl:getAddNum(homeBuildingNumtpl)
    self.bind.go_singleIcon = true
    self.bind.img_singleIcon = _homeBuildingTpl:getBuildIcon(homeBuildingTpl)
    unlockCondition = _homeBuildingNumTpl:getUnlockCondition(homeBuildingNumtpl)
  end
  self.bind.color_type = L_HomeConst.HomeLevelUnlockModuleRes[self.bind.type].color
  self.bind.img_type = L_HomeConst.HomeLevelUnlockModuleRes[self.bind.type].icon
  self.bindComponents.ani_cellHomeLevelInfoItem:Play("anim_homeLeve_cell_Item_resetUnlock")
  if not self.bind.isFatherLock then
    local isUnlock = true
    for _, v in pairs(unlockCondition) do
      local isComplete = L_ConditionManager:singleIsComplete(v)
      if not isComplete then
        isUnlock = false
      end
    end
    self.isPlayItemUnLockAnim = C_PlayerPrefsUtility.GetBool(L_PlayerStore:getPlayerId() .. self.bind.id, false)
    if isUnlock then
      self.bindComponents.ani_cellHomeLevelInfoItem:Stop()
      if self.bind.isPlayUnLockAnim then
        if not self.isPlayItemUnLockAnim then
          self:onSaveItemPlayUnLockAnim(true)
          self.bindComponents.ani_cellHomeLevelInfoItem:Play("anim_homeLeve_cell_Item_unlock")
        else
          self.bind.go_imgLockIcon = false
        end
      else
        self:onSaveItemPlayUnLockAnim(false)
      end
    else
      self.bind.go_imgLockIcon = true
    end
  else
    self.bind.go_imgLockIcon = false
  end
end

function this:onSaveItemPlayUnLockAnim(lockActive)
  self.bind.go_imgLockIcon = lockActive
  self.isPlayItemUnLockAnim = true
  C_PlayerPrefsUtility.SetBool(L_PlayerStore:getPlayerId() .. self.bind.id, true)
end

function this:onClickSelect()
  self.bind.go_select = true
  self:emit("onClick_select", self.bind, self.bindComponents.rect_cellHomeLevelInfoItem.position)
end

function this:setSelect(select)
  self.bind.go_select = select
end

return this
