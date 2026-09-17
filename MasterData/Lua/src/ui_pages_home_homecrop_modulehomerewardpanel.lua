local this = class("moduleHomeRewardPanel", G_UIModuleBase)
local _HomeRanchTpl = L_GameTpl:getHomeRanchTpl()
local _homeBlockTpl = L_GameTpl:getHomeBlockTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()
local RewardTab = {
  CAN_REWARD = 1,
  EMPTY = 2,
  LOCK = 3
}

function this.bind()
  return {
    active_harvestBagBg = true,
    active_rewardNumBg = true,
    rect_btnFold = C_Vector2(-718.7, -17.1),
    rotate_btnFold = C_Vector3.zero,
    txt_rewardNum = "",
    group_reward = -1,
    active_rewardList = true,
    list_reward = {
      moduleName = "pages/home/homeRanch/cellHomeRanchHarvestBag"
    },
    isOn_autoReceiveSeedToggle = false,
    txt_homeExp = "",
    go_homeExp = false
  }
end

function this.methods()
  return {
    onClick_fold = function(self)
      if self.bind.active_harvestBagBg then
        self.bind.active_harvestBagBg = false
        self.bind.active_rewardList = false
        self.bind.rect_btnFold = C_Vector2(484.3, -17.1)
        self.bind.rotate_btnFold = C_Vector3(0, 0, 180)
      else
        self.bind.active_harvestBagBg = true
        self.bind.active_rewardList = true
        self.bind.rect_btnFold = C_Vector2(-718.7, -17.1)
        self.bind.rotate_btnFold = C_Vector3.zero
      end
    end,
    onClick_reward = function(self)
      if self._stationType == L_HomeConst.StationType.Ranch then
        local ranchData = C_HomeManager:GetHomeStore():GetRanchData(self._blockId)
        if not ranchData or ranchData.storeItems:Count() <= 0 then
          L_FlyMsgManager:showNormalMsgByKey("ui_pageHomeRanch_01")
          return
        end
        C_HomeManager:GetHomeStore():ReqRanchStoredRewards(self._blockId, function()
          self:refreshRanchData()
        end)
        return
      elseif self._stationType == L_HomeConst.StationType.Crop then
        local rewardCount = self._autoData.rewards.Count
        self:refreshRewardAnim(0 < rewardCount)
        if 0 < rewardCount then
          self._autoData:RequestGetHomeCrop(function()
            self:refreshCropData()
          end)
        end
      end
    end,
    onClick_addSeed = function(self)
      self:emit("onClick_addSeed")
      if self._stationType == L_HomeConst.StationType.Ranch then
        return
      end
      L_UI:open("pageHomeCropBox", {
        buildingGuid = self._guid
      })
    end,
    onValueChanged_autoReceiveSeedToggle = function(self, value)
      self:onAutoReceiveSeedToggleValueChanged(value)
    end
  }
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  local addModuleGeneric = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.ModuleRewardBox, CS.UnityEngine.GameObject)
  self.rewardBoxModule = addModule(self.parent.csharpPage, self.parent.csharpPage, self.bindComponents.rewardBoxModule.gameObject)
end

function this:open()
  self.csHomeStore = AzurWorld.HomeMgr:GetHomeStore()
  self.storeCropModule = self.csHomeStore.cropModule
  self.managerCropModule = AzurWorld.HomeMgr.CropModule
  self.bind.isOn_autoReceiveSeedToggle = self.storeCropModule:GetIsHomeCropSettingOn(C_EHomeCorpSetting.AUTO_HARVEST_SEED_TO_PLANT)
  
  function self._onHomeCropSettingRefresh()
    self:onHomeCropSettingRefresh()
  end
  
  self.onHomeRanchSync = handler(self, self.refreshRanchData)
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeCropSettingRefresh, self._onHomeCropSettingRefresh)
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeRanchSync, self.onHomeRanchSync)
end

function this:close()
  self.storeCropModule = nil
  self.managerCropModule = nil
  self.csHomeStore = nil
  self.rewardBoxModule = nil
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeCropSettingRefresh, self._onHomeCropSettingRefresh)
  self._onHomeCropSettingRefresh = nil
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeRanchSync, self.onHomeRanchSync)
  self._buildingData = nil
  self._autoData = nil
end

function this:initCropData(buildingGuid)
  self._stationType = L_HomeConst.StationType.Crop
  self._guid = buildingGuid
  self._buildingData = C_HomeUtil.GetBuildData(self._guid)
  self._autoData = self._buildingData.auto
  self:refreshCropData()
end

function this:refreshCropData()
  if self._stationType ~= L_HomeConst.StationType.Crop then
    return
  end
  self.bind.active_rewardNumBg = false
  local rewardList = self._autoData.rewards
  self.bind.group_reward = rewardList.Count > 0 and RewardTab.CAN_REWARD or RewardTab.EMPTY
  self.homeExp = self._autoData.HomeExp
  local rewardBoxNum = rewardList.Count
  local data = {}
  local reward_map = {}
  local isHadReward = false
  for i = 0, rewardBoxNum - 1 do
    local item = rewardList[i]
    if 0 < item.itemNum then
      isHadReward = true
    end
    local uid = (item.itemType << 32) + item.itemId
    local reward = reward_map[uid]
    if reward then
      reward.itemNum = reward.itemNum + item.itemNum
    else
      reward = {
        itemType = item.itemType,
        itemId = item.itemId,
        itemNum = item.itemNum
      }
      reward_map[uid] = reward
    end
  end
  for id, reward in pairs(reward_map) do
    table.insert(data, reward)
  end
  local indexedData = {}
  for i, v in ipairs(data) do
    table.insert(indexedData, {
      value = v,
      index = i,
      isSurprise = _homeDropTpl:getIsSurpriseHarvest(v.itemId)
    })
  end
  table.sort(indexedData, function(a, b)
    if a.isSurprise ~= b.isSurprise then
      return a.isSurprise
    else
      return a.index < b.index
    end
  end)
  local sortedData = {}
  for i, v in ipairs(indexedData) do
    sortedData[i] = v.value
  end
  if 0 < rewardBoxNum and rewardBoxNum ~= #self.bind.list_reward then
    self.bind.list_reward:clear()
    self.bind.list_reward:insert_array(sortedData)
  end
  self:refreshExp(self.homeExp, isHadReward)
end

function this:refreshExp(homeExp, isHadReward)
  if homeExp == nil then
    homeExp = 0
  end
  self.bind.txt_homeExp = tostring(homeExp)
  self.bind.go_homeExp = 0 < homeExp
  self.rewardBoxModule:SetReward(isHadReward)
end

function this:refreshRewardAnim(isHadReward)
  if isHadReward then
  else
    self.rewardBoxModule:Shake()
  end
end

function this:initRanchData(blockId)
  self._stationType = L_HomeConst.StationType.Ranch
  self._blockId = blockId
  self:refreshRanchData()
end

function this:refreshRanchData()
  if self._stationType ~= L_HomeConst.StationType.Ranch then
    return
  end
  self.bind.active_rewardNumBg = true
  local ranchData = C_HomeManager:GetHomeStore():GetRanchData(self._blockId)
  local lv = ranchData and ranchData.lv or 1
  local ranchTpl = _HomeRanchTpl:getTplById(lv)
  local stores = ranchData and ranchData.storeItems or {}
  local listDatas = {}
  for i = 0, stores.Count - 1 do
    local store = stores[i]
    local stackNums = L_DataUtil.getItemStacks(store.itemType, store.itemId, store.itemNum)
    for _, num in ipairs(stackNums) do
      table.insert(listDatas, {
        itemType = store.itemType,
        itemId = store.itemId,
        itemNum = num
      })
    end
  end
  listDatas = self:sortRewardData(listDatas)
  self.bind.group_reward = #listDatas ~= 0 and RewardTab.CAN_REWARD or math.isEmpty(ranchData.harvest_pet) and RewardTab.LOCK or RewardTab.EMPTY
  local rewardBoxNum = #listDatas
  if #self.modules.list_reward ~= rewardBoxNum then
    self.bind.list_reward:clear()
    self.bind.list_reward:insert_array(listDatas)
  end
  self.bind.txt_rewardNum = string.format("<color=#4b5a2c>%s</color>/%s", #listDatas, _HomeRanchTpl:getStorageLimit(ranchTpl))
end

function this:sortRewardData(dataList)
  local sortList = {}
  local result = {}
  for k, v in pairs(dataList) do
    table.insert(sortList, {
      [1] = v.itemType,
      [2] = v.itemId,
      [3] = v.itemNum
    })
  end
  local data = L_DataUtil.parseRewardConfig(sortList, false, true)
  return data
end

function this:onHomeCropSettingRefresh()
  local isAutoReceiveSeedOpen = self.storeCropModule:GetIsHomeCropSettingOn(C_EHomeCorpSetting.AUTO_HARVEST_SEED_TO_PLANT)
  if isAutoReceiveSeedOpen ~= self.bind.isOn_autoReceiveSeedToggle then
    self.bind.isOn_autoReceiveSeedToggle = isAutoReceiveSeedOpen
  end
end

function this:onAutoReceiveSeedToggleValueChanged(value)
  AzurWorld.HomeMgr.CropModule:PlayAutoReceiveSeedAudio()
  self.managerCropModule:ReqSetHomeCropOptionSettingStatus(C_EHomeCorpSetting.AUTO_HARVEST_SEED_TO_PLANT, value)
end

return this
