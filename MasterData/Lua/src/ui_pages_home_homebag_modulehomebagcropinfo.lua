local module = class("moduleHomeBagCropInfo", G_UIModuleBase)
local _homeSeedTpl = L_GameTpl:getHomeSeedsTpl()
local _dropTpl = L_GameTpl:getDropTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _homeFieldtypeTpl = L_GameTpl:getHomeFieldtypeTpl()

function module.bind()
  return {
    txt_num = "0",
    txt_name = "",
    img_icon = "",
    img_iconFilter = "",
    img_color = "",
    txt_time = "",
    txt_reward = "",
    txt_water = "",
    txt_rewardHave = "",
    list_star = {},
    active_startBtn = true,
    active_emptyBtn = false
  }
end

function module.methods()
  return {
    onClickPlant = function(self)
      local manager = AzurWorld.HomeMgr
      local guid = manager:GetCurrentInteractBuildGuid()
      local buildData = C_HomeUtil.GetBuildData(guid)
      local buildingEntity = manager:GetHomeBuild(guid)
      if buildData and (buildData:GetGroupConfig().type == L_Const.WorldMapBuildType.WMBT_FIELD_NEW or buildData:GetGroupConfig().type == L_Const.WorldMapBuildType.WMBT_FIELD_NEW2) and buildData.crop.seedId == 0 then
        local seedTpl = _homeSeedTpl:getSeedTplByItem(self._seedItemId)
        if not seedTpl then
          errorf("种子物品没有配置种子id" .. self._seedItemId)
          return
        end
        local condition = _homeSeedTpl:getCondition(seedTpl)
        if L_ConditionManager:isComplete(condition) then
          L_UI:close("pageHomeBag", nil, function()
            buildingEntity:InvokePlant(self._seedItemId)
          end)
        else
          L_FlyMsgManager:showNormalMsg(L_ConditionManager:getTipDesc(condition))
        end
        return
      end
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_moduleHomeBagCropInfo_04"))
    end,
    onClickEmptyBtn = function(self)
      self:onClickEmptyBtn()
    end
  }
end

function module:setSeedId(seedItemId, isIn, forceAni)
  self._seedItemId = seedItemId
  local conf = L_ItemTplManager:getCommonItem(seedItemId)
  local seedTpl = _homeSeedTpl:getTplBySeedItemId(seedItemId)
  if not seedTpl then
    errorf("种子物品没有配置种子id" .. seedItemId)
    return
  end
  local homeItemSize = _homeSeedTpl:getHomeItemSize(seedTpl)
  if #homeItemSize ~= 2 then
    errorf("home_seeds 配置 homeItemSize不对" .. seedItemId)
    return
  end
  local seedFieldTypeList = _homeSeedTpl:getFieldType(seedTpl)
  local currInteractBuildGuid = AzurWorld.HomeMgr.InteractModule.currInteractBuildGuid
  local baseHomeBuild = AzurWorld.HomeMgr:GetHomeBuild(currInteractBuildGuid)
  local homeBuildId = baseHomeBuild:GetHomeBuildId()
  local homeFieldtypeTpl = _homeFieldtypeTpl:getTplByBuildId(homeBuildId)
  local fieldTypeId = _homeFieldtypeTpl:getId(homeFieldtypeTpl)
  local isFieldTypeMatch = table.indexOf(seedFieldTypeList, fieldTypeId) ~= false
  if homeItemSize[1] ~= 2 or homeItemSize[2] ~= 2 or not isFieldTypeMatch then
    self.bind.active_startBtn = false
    self.bind.active_emptyBtn = true
  else
    self.bind.active_startBtn = true
    self.bind.active_emptyBtn = false
  end
  self.bind.txt_num = tostring(C_BagMgr:getItemNumByItemId(seedItemId))
  self.bind.txt_name = conf.name
  self.bind.img_icon = conf.icon
  self.bind.img_color = string.format("Altas/HomeBag/tex_homewarehouse_bg_seedquality%d.png", conf.quality)
  local commonItemTpl = _commonItemTpl:getTplById(seedItemId)
  self.bind.img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
  local num = L_ItemTplManager:getItemShowStarNum(L_Const.resType.commonItem, seedItemId)
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(stars)
  local buffCondition = L_HomeBuffManager:getCropCondition(_homeSeedTpl:getId(seedTpl))
  local growTime, preHarTime = L_HomeBuffManager:getCropGrowParam(_homeSeedTpl:getId(seedTpl), buffCondition)
  local totalTime = growTime + preHarTime
  self.bind.txt_time = L_TimeUtil.secondToString(totalTime, L_TimeUtil.secondToStringShowType.TWO_UNIT)
  self.bind.txt_reward = _homeSeedTpl:getNumShow(seedTpl)
  self.bind.txt_water = L_WordsTpl:getValue("ui_moduleHomeBagCropInfo_03", {
    [0] = _homeSeedTpl:getNeedWater(seedTpl)
  })
  local dropId = _homeSeedTpl:getHomeDropId(seedTpl)
  if dropId == nil or dropId[1] == nil then
    errorf("home_seeds 没有配置dropId" .. seedItemId)
    return
  end
  local dropTpl = _homeDropTpl:getTplById(dropId[1])
  if dropTpl == nil then
    errorf("找不到home_drop配置 dropId:" .. dropId[1])
    return
  end
  local rewardItemId = _homeDropTpl:getItemId(dropTpl)
  local rewardItemType = _homeDropTpl:getItemType(dropTpl)
  local rewardItemConf = L_ItemTplManager:getItemConfig(rewardItemType, rewardItemId[1])
  self.bind.txt_rewardHave = L_WordsTpl:getValue("ui_moduleHomeBagCropInfo_02", {
    [0] = rewardItemConf.name,
    [1] = C_BagMgr:getItemNumByItemId(rewardItemId[1])
  })
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.cropTag)
end

function module:onClickEmptyBtn()
  L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_canNot_plant_from_homeBag"))
end

return module
