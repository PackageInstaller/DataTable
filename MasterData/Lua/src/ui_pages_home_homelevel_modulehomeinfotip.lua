local this = class("moduleHomeInfoTip", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _productsTpl = L_GameTpl:getProductsTpl()
local _homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _homeBlockTpl = L_GameTpl:getHomeBlockTpl()
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local _homeTechnologyTpl = L_GameTpl:getHomeTechnologyTpl()
local _homeTechnologyTreeTpl = L_GameTpl:getHomeTechnologyTreeTpl()
local _homeTechnologyTypeTpl = L_GameTpl:getHomeTechnologyTypeTpl()
local _homeTechnologyTabTpl = L_GameTpl:getHomeTechnologyTabTpl()
local _buildingTypeTpl = L_GameTpl:getHomeBuildingTypeTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _currencyTpl = L_GameTpl:getCurrencyTpl()
local _mountSaddleTpl = L_GameTpl:getMountSaddleTpl()
local _homeBuildingNumTpl = L_GameTpl:getHomeBuildingNumTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()

function this.bind()
  return {
    img_type = nil,
    go_buildingUnlockBg = false,
    go_buildingLockTag = false,
    go_singleIcon = false,
    img_singleIcon = nil,
    go_groupIcon = false,
    img_groupIcon = nil,
    img_groupBg = nil,
    go_itemIcon = false,
    img_itemIcon = nil,
    img_pageBg = nil,
    list_rarityStar = {},
    txt_name = nil,
    go_buildingTag = false,
    module_BuildingTag = {
      moduleName = "pages/home/homeBuilding/moduleBuildingTag"
    },
    go_technologyTag = false,
    txt_technologyType = nil,
    txt_technologyTab = nil,
    txt_desc = nil,
    go_specialInfo = false,
    list_specialInfo = L_Const.ModuleInfo.CellIconBag,
    txt_specialInfo = "",
    go_conditionNeed = false,
    list_conditionNeed = {
      moduleName = "pages/home/homeLevel/cellHomeTechnologyCondition"
    },
    go_imgLockSingleIcon = false,
    go_imgLockGroupIcon = false,
    go_imgLockItemIcon = false,
    go_buildingNumTextLayout = false,
    txt_buildingNumLeft = "",
    txt_buildingNumRight = "",
    go_scrollViewDesc = true,
    bgContentCanvasGroupAlpha = 1
  }
end

function this.methods()
  return {}
end

function this:Init(options)
  if options ~= nil and options.type ~= nil and options.id ~= nil then
    self:setData(options.type, options.id)
  end
end

function this:setData(type, id)
  self._id = id
  self._type = type
  self.bind.img_type = L_HomeConst.HomeLevelUnlockModuleRes[self._type].icon
  if self._type == L_HomeConst.HomeLevelUnlockModuleType.Building then
    self:setBuildingData()
  elseif self._type == L_HomeConst.HomeLevelUnlockModuleType.Technology then
    self:setTechnologyData()
  elseif self._type == L_HomeConst.HomeLevelUnlockModuleType.CommonItem then
    self:setCommonItemData()
  elseif self._type == L_HomeConst.HomeLevelUnlockModuleType.Currency then
    self:setCurrencyItemData()
  elseif self._type == L_HomeConst.HomeLevelUnlockModuleType.MountSaddle then
    self:setMountSaddleData()
  elseif self._type == L_HomeConst.HomeLevelUnlockModuleType.BuildingNum then
    self:setBuildingNumData()
  else
    self:setSingleData()
  end
  self:setDescContentHeight()
end

function this:setBuildingData()
  local tpl = _homeBuildingTpl:getTplById(self._id)
  self.bind.txt_name = _homeBuildingTpl:getName(tpl)
  self.bind.go_singleIcon = true
  self.bind.img_singleIcon = _homeBuildingTpl:getBuildIcon(tpl)
  self.bind.go_buildingTag = true
  local tpl_group = _homeBuildingGroupTpl:getTplById(_homeBuildingTpl:getGroupId(tpl))
  local tpl_type = _buildingTypeTpl:getTplById(_homeBuildingGroupTpl:getType(tpl_group))
  self.bind.txt_buildingTag = _buildingTypeTpl:getTypeName(tpl_type)
  local module_buildingTag = self.modules.module_BuildingTag
  module_buildingTag:setId(self._id)
  local unlockCondition = {}
  if not table.isEmpty(_homeBuildingTpl:getUpgradeCondition(tpl)) then
    unlockCondition = _homeBuildingTpl:getUpgradeCondition(tpl)
  else
    unlockCondition = _productsTpl:getHomeBuildingUnlockConditionByBuildingId(self._id)
  end
  local conditionNeedConfigList = {}
  local isUnlock = true
  for _, v in pairs(unlockCondition) do
    local isComplete = L_ConditionManager:singleIsComplete(v)
    local desc = L_ConditionManager:getSingleDesc(v)
    if not isComplete then
      isUnlock = false
    end
    table.insert(conditionNeedConfigList, {
      go_complete = isComplete,
      txt_name_complete = desc,
      go_notComplete = not isComplete,
      txt_name_notComplete = desc
    })
  end
  self.bind.go_conditionNeed = not isUnlock
  self.bind.go_imgLockSingleIcon = not isUnlock
  self.bind.go_imgLockGroupIcon = not isUnlock
  self.bind.list_conditionNeed:clear()
  self.bind.list_conditionNeed:insert_array(conditionNeedConfigList)
  self.bind.go_specialInfo = isUnlock
  self.bind.txt_specialInfo = L_WordsTpl:getValue("home_function_unlock_ui_02")
  local materialList = L_DataUtil.parseRewardConfig(not table.isEmpty(_homeBuildingTpl:getMaterial(tpl)) and _homeBuildingTpl:getMaterial(tpl) or _productsTpl:getHomeBuildingNeedMaterialByBuildingId(self._id))
  self.bind.list_specialInfo:clear()
  self.bind.list_specialInfo:insert_array(materialList)
  self.bind.go_buildingNumTextLayout = true
  local buildingGroupId = _homeBuildingTpl:getGroupId(tpl)
  local homeBuildingNumTpl = _homeBuildingNumTpl:getFirstUnlockBuildingTplByGroupId(buildingGroupId)
  self.bind.txt_buildingNumLeft = _homeBuildingNumTpl:getUnlockDesc(homeBuildingNumTpl)
  self.bind.txt_buildingNumRight = ""
  self.bind.go_buildingUnlockBg = false
  self.bind.go_buildingLockTag = true
  self.bind.go_itemIcon = false
  self:setDesc(_homeBuildingTpl:getDesc(tpl))
end

function this:setBuildingNumData()
  local homeBuildingNumtpl = _homeBuildingNumTpl:getTplById(self._id)
  local buildingGroupId = _homeBuildingNumTpl:getGroupId(homeBuildingNumtpl)
  local homeBuildingTpl = _homeBuildingTpl:getBuildingBaseTplByGroupId(buildingGroupId)
  self.bind.txt_name = _homeBuildingTpl:getName(homeBuildingTpl)
  self.bind.go_singleIcon = true
  self.bind.img_singleIcon = _homeBuildingTpl:getBuildIcon(homeBuildingTpl)
  self.bind.go_buildingNumTextLayout = true
  self.bind.txt_buildingNumLeft = _homeBuildingNumTpl:getUnlockDesc(homeBuildingNumtpl)
  self.bind.txt_buildingNumRight = "+" .. _homeBuildingNumTpl:getAddNum(homeBuildingNumtpl)
  self.bind.go_buildingTag = true
  local tpl_group = _homeBuildingGroupTpl:getTplById(_homeBuildingTpl:getGroupId(homeBuildingTpl))
  local tpl_type = _buildingTypeTpl:getTplById(_homeBuildingGroupTpl:getType(tpl_group))
  self.bind.txt_buildingTag = _buildingTypeTpl:getTypeName(tpl_type)
  local module_buildingTag = self.modules.module_BuildingTag
  local buildingId = _homeBuildingTpl:getId(homeBuildingTpl)
  module_buildingTag:setId(buildingId)
  local unlockCondition = _homeBuildingNumTpl:getUnlockCondition(homeBuildingNumtpl)
  local conditionNeedConfigList = {}
  local isUnlock = true
  for _, v in pairs(unlockCondition) do
    local isComplete = L_ConditionManager:singleIsComplete(v)
    local desc = L_ConditionManager:getSingleDesc(v)
    if not isComplete then
      isUnlock = false
    end
    table.insert(conditionNeedConfigList, {
      go_complete = isComplete,
      txt_name_complete = desc,
      go_notComplete = not isComplete,
      txt_name_notComplete = desc
    })
  end
  self.bind.go_conditionNeed = not isUnlock
  self.bind.go_imgLockSingleIcon = not isUnlock
  self.bind.go_imgLockGroupIcon = not isUnlock
  self.bind.list_conditionNeed:clear()
  self.bind.list_conditionNeed:insert_array(conditionNeedConfigList)
  self.bind.go_specialInfo = false
  self.bind.go_buildingUnlockBg = true
  self.bind.go_buildingLockTag = false
  self:setDesc(_homeBuildingTpl:getDesc(homeBuildingTpl))
end

function this:setTechnologyData()
  local tpl = _homeTechnologyTpl:getTplById(self._id)
  local tpl_tree = _homeTechnologyTreeTpl:getTplById(_homeTechnologyTpl:getType(tpl))
  self.bind.txt_name = string.format("%sLv.%s", _homeTechnologyTpl:getObjName(tpl), _homeTechnologyTpl:getLevel(tpl))
  self.bind.go_groupIcon = true
  self.bind.img_groupIcon = _homeTechnologyTreeTpl:getIcon(tpl_tree)
  self.bind.go_technologyTag = true
  self.bind.txt_technologyType = _homeTechnologyTypeTpl:getTechnologyName(_homeTechnologyTypeTpl:getTplById(_homeTechnologyTreeTpl:getCategory(tpl_tree)))
  self.bind.txt_technologyTab = _homeTechnologyTabTpl:getTabName(_homeTechnologyTabTpl:getTplById(_homeTechnologyTreeTpl:getType(tpl_tree)))
  local tmp = {}
  local unlockCondition = _homeTechnologyTpl:getUnlockCondi1(tpl)
  local isUnlock = true
  for i, v in pairs(unlockCondition) do
    local isComplete = L_ConditionManager:singleIsComplete(v)
    if not isComplete then
      isUnlock = false
    end
    local desc = L_ConditionManager:getSingleDesc(v)
    table.insert(tmp, {
      go_complete = isComplete,
      txt_name_complete = desc,
      go_notComplete = not isComplete,
      txt_name_notComplete = desc
    })
  end
  self.bind.go_conditionNeed = not isUnlock
  self.bind.go_imgLockSingleIcon = not isUnlock
  self.bind.go_imgLockGroupIcon = not isUnlock
  self.bind.list_conditionNeed:clear()
  self.bind.list_conditionNeed:insert_array(tmp)
  if self.bind.go_conditionNeed then
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_technologyTab)
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_technologyType)
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_technologyTag)
  end
  self:setDesc(_homeTechnologyTpl:getEffectDescription(tpl))
end

function this:setCommonItemData()
  local tpl = _commonItemTpl:getTplById(self._id)
  self.bind.go_itemIcon = true
  self.bind.go_singleIcon = false
  self.bind.img_itemIcon = _commonItemTpl:getIcon(tpl)
  self.bind.txt_name = _commonItemTpl:getName(tpl)
  local grade = _commonItemTpl:getItemGrade(tpl)
  local rarity = _commonItemTpl:getRarity(tpl)
  self.bind.img_pageBg = L_HomeConst.CommonItemRarity2PageBg[rarity]
  local rarityStarListConfig = {}
  for i = 0, grade - 1 do
    table.insert(rarityStarListConfig, {})
  end
  self.bind.list_rarityStar:clear()
  self.bind.list_rarityStar:insert_array(rarityStarListConfig)
  local conditionNeedConfigList = {}
  local isUnlock = true
  local productsTpl = _productsTpl:getTplByReward(L_Const.resType.commonItem, self._id)
  if not table.isEmpty(productsTpl) then
    local unlockCondition = _productsTpl:getUnlockCondition(productsTpl)
    for _, v in pairs(unlockCondition) do
      local isComplete = L_ConditionManager:singleIsComplete(v)
      if not isComplete then
        isUnlock = false
      end
      local desc = L_ConditionManager:getSingleDesc(v)
      table.insert(conditionNeedConfigList, {
        go_complete = isComplete,
        txt_name_complete = desc,
        go_notComplete = not isComplete,
        txt_name_notComplete = desc
      })
    end
  end
  self.bind.go_imgLockItemIcon = not isUnlock
  self.bind.go_conditionNeed = not isUnlock
  self.bind.list_conditionNeed:clear()
  self.bind.list_conditionNeed:insert_array(conditionNeedConfigList)
  self.bind.go_specialInfo = isUnlock
  self.bind.txt_specialInfo = L_WordsTpl:getValue("home_function_unlock_ui_03")
  local config = L_DataUtil.parseRewardConfig(_productsTpl:getRewardId(productsTpl))
  self.bind.list_specialInfo:clear()
  self.bind.list_specialInfo:insert_array(config)
  self:setDesc(_commonItemTpl:getDesc(tpl))
end

function this:setCurrencyItemData()
  local tpl = _currencyTpl:getTplById(self._id)
  self.bind.go_itemIcon = true
  self.bind.go_singleIcon = false
  self.bind.img_itemIcon = _currencyTpl:getIcon(tpl)
  self.bind.txt_name = _currencyTpl:getName(tpl)
  local rarity = _currencyTpl:getQuality(tpl)
  self.bind.img_pageBg = L_HomeConst.CommonItemRarity2PageBg[rarity]
  local rarityStarListConfig = {}
  self.bind.list_rarityStar:clear()
  local conditionNeedConfigList = {}
  local isUnlock = true
  local productsTpl = _productsTpl:getTplByReward(L_Const.resType.currency, self._id)
  if not table.isEmpty(productsTpl) then
    local unlockCondition = _productsTpl:getUnlockCondition(productsTpl)
    for _, v in pairs(unlockCondition) do
      local isComplete = L_ConditionManager:singleIsComplete(v)
      if not isComplete then
        isUnlock = false
      end
      local desc = L_ConditionManager:getSingleDesc(v)
      table.insert(conditionNeedConfigList, {
        go_complete = isComplete,
        txt_name_complete = desc,
        go_notComplete = not isComplete,
        txt_name_notComplete = desc
      })
    end
  end
  self.bind.go_imgLockItemIcon = not isUnlock
  self.bind.go_conditionNeed = not isUnlock
  self.bind.list_conditionNeed:clear()
  self.bind.list_conditionNeed:insert_array(conditionNeedConfigList)
  self.bind.go_specialInfo = isUnlock
  self.bind.txt_specialInfo = L_WordsTpl:getValue("home_function_unlock_ui_03")
  local config = L_DataUtil.parseRewardConfig(_productsTpl:getRewardId(productsTpl))
  self.bind.list_specialInfo:clear()
  self.bind.list_specialInfo:insert_array(config)
  self:setDesc(_currencyTpl:getDesc(tpl))
end

function this:setMountSaddleData()
  local tpl = _mountSaddleTpl:getTplById(self._id)
  self.bind.go_itemIcon = true
  self.bind.img_itemIcon = _mountSaddleTpl:getIcon(tpl)
  self.bind.txt_name = _mountSaddleTpl:getName(tpl)
  local rarity = _mountSaddleTpl:getRarity(tpl)
  self.bind.img_pageBg = L_HomeConst.CommonItemRarity2PageBg[rarity]
  local rarityStarListConfig = {}
  self.bind.list_rarityStar:clear()
  local conditionNeedConfigList = {}
  local isUnlock = true
  local productsTpl = _productsTpl:getTplByReward(L_Const.resType.mountSaddle, self._id)
  if not table.isEmpty(productsTpl) then
    local unlockCondition = _productsTpl:getUnlockCondition(productsTpl)
    for _, v in pairs(unlockCondition) do
      local isComplete = L_ConditionManager:singleIsComplete(v)
      if not isComplete then
        isUnlock = false
      end
      local desc = L_ConditionManager:getSingleDesc(v)
      table.insert(conditionNeedConfigList, {
        go_complete = isComplete,
        txt_name_complete = desc,
        go_notComplete = not isComplete,
        txt_name_notComplete = desc
      })
    end
  end
  self.bind.go_imgLockItemIcon = not isUnlock
  self.bind.go_conditionNeed = not isUnlock
  self.bind.list_conditionNeed:clear()
  self.bind.list_conditionNeed:insert_array(conditionNeedConfigList)
  self.bind.go_specialInfo = isUnlock
  self.bind.txt_specialInfo = L_WordsTpl:getValue("home_function_unlock_ui_03")
  local config = L_DataUtil.parseRewardConfig(_productsTpl:getRewardId(productsTpl))
  self.bind.list_specialInfo:clear()
  self.bind.list_specialInfo:insert_array(config)
  self:setDesc(_mountSaddleTpl:getDesc(tpl))
end

function this:setSingleData()
  self.bind.go_groupIcon = true
  self.bind.img_groupBg = L_HomeConst.HomeLevelUnlockModuleRes[self._type].bg
  local unlockCondition = {}
  if self._type == L_HomeConst.HomeLevelUnlockModuleType.Block then
    local tpl = _homeBlockTpl:getTplById(self._id)
    self.bind.txt_name = _homeBlockTpl:getName(tpl)
    self:setDesc(_homeBlockTpl:getDesc(tpl))
    self.bind.img_groupIcon = _homeBlockTpl:getIcon(tpl)
    unlockCondition[1] = _homeBlockTpl:getUnlockCondi(tpl)
  elseif self._type == L_HomeConst.HomeLevelUnlockModuleType.System then
    local tpl = _systemUnlockTpl:getTplById(self._id)
    self.bind.txt_name = _systemUnlockTpl:getName(tpl)
    self.bind.img_groupIcon = _systemUnlockTpl:getIcon(tpl)
    self:setDesc(_systemUnlockTpl:getDesc(tpl))
    unlockCondition = _systemUnlockTpl:getUnlockCondi(tpl)
  end
  local conditionNeedConfigList = {}
  local isUnlock = true
  for _, v in pairs(unlockCondition) do
    local isComplete = L_ConditionManager:singleIsComplete(v)
    local desc = L_ConditionManager:getSingleDesc(v)
    if not isComplete then
      isUnlock = false
    end
    table.insert(conditionNeedConfigList, {
      go_complete = isComplete,
      txt_name_complete = desc,
      go_notComplete = not isComplete,
      txt_name_notComplete = desc
    })
  end
  self.bind.go_conditionNeed = not isUnlock
  self.bind.go_imgLockSingleIcon = not isUnlock
  self.bind.go_imgLockGroupIcon = not isUnlock
  self.bind.list_conditionNeed:clear()
  self.bind.list_conditionNeed:insert_array(conditionNeedConfigList)
end

function this:setDesc(txt)
  self.bind.txt_desc = txt or ""
end

function this:setDescContentHeight()
  self.bind.bgContentCanvasGroupAlpha = 0
  self.taskId = FrameScheduler.add(function()
    local prefferedHeight = self.bindComponents.text_desc.preferredHeight + 5 < 185 and self.bindComponents.text_desc.preferredHeight + 5 or 185
    self.bindComponents.rect_scrollViewDesc.sizeDelta = C_Vector2(386.5883, prefferedHeight)
    self.bindComponents.scrollView_desc.enabled = prefferedHeight == 185
    self.bind.bgContentCanvasGroupAlpha = 1
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_bgContent)
  end, 1)
end

function this:reset()
  self.bind.go_singleIcon = false
  self.bind.go_groupIcon = false
  self.bind.go_itemIcon = false
  self.bind.go_buildingTag = false
  self.bind.go_technologyTag = false
  self.bind.go_specialInfo = false
  self.bind.go_conditionNeed = false
  self.bind.go_buildingUnlockBg = false
  self.bind.go_buildingLockTag = false
  self.bind.go_imgLockSingleIcon = false
  self.bind.go_imgLockGroupIcon = false
  self.bind.go_imgLockItemIcon = false
  self.bind.go_buildingNumTextLayout = false
end

function this:close()
  this.super.close(self)
  if self.taskId then
    FrameScheduler.remove(self.taskId)
  end
end

return this
