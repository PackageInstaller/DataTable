local this = class("catalogStore", G_BaseStore)
this.event = {
  refreshCatalog = "catalogStore_refreshCatalog",
  updateCatalog = "catalogStore_updateCatalog",
  getCatalogReward = "catalogStore_getCatalogReward",
  setStarColor = "catalogStore_setStarColor"
}
this:importPartialClass(require(L_R.store .. "catalog.catalogAction"))
this:importPartialClass(require(L_R.store .. "catalog.catalogState"))

function this:setHasInitSync(bool)
  self.data.setHasInitSync = bool
end

function this:setCatalogHasInitSync(bool)
  self.data.setCatalogHasInitSync = bool
end

function this:calcPetAttr(petId)
  if self.data.petAttr[petId] then
    table.clear(self.data.petAttr[petId])
  end
  local petTpl = L_GameTpl:getPetTpl():getTplById(petId)
  local elementId = L_GameTpl:getPetTpl():getFirstElement(petTpl)
  if self.data.petElementAttr[elementId] then
    for attrId, _ in pairs(self.data.petElementAttr[elementId]) do
      if self.data.petElementAttr[elementId][attrId][petId] then
        self.data.petElementAttr[elementId][attrId][petId] = 0
      end
    end
  end
  local taskLevel = self.data.petCatalog[petId].lv
  local petAttr, eleAttr
  for lv = 1, taskLevel do
    local levelTpl = L_GameTpl:getIconographyLevelTpl():getTplByLvPetId(lv, petId)
    local rewardType = L_GameTpl:getIconographyLevelTpl():getType(levelTpl)
    for _, rId in pairs(rewardType) do
      local rewardTpl = L_GameTpl:getIconographyTypeTpl():getTplById(rId)
      for _, attr in pairs(rewardTpl.abilities) do
        local attrId = attr[1]
        local attrVal = attr[2]
        if rewardTpl.rewardtype and rewardTpl.rewardtype == 5009 then
          if not self.data.petAttr[petId] then
            self.data.petAttr[petId] = {}
          end
          if not self.data.petAttr[petId][attrId] then
            self.data.petAttr[petId][attrId] = 0
          end
          self.data.petAttr[petId][attrId] = self.data.petAttr[petId][attrId] + attrVal
        end
        if rewardTpl.rewardtype and rewardTpl.rewardtype == 5010 then
          if not self.data.petElementAttr[elementId] then
            self.data.petElementAttr[elementId] = {}
          end
          if not self.data.petElementAttr[elementId][attrId] then
            self.data.petElementAttr[elementId][attrId] = {}
          end
          if not self.data.petElementAttr[elementId][attrId][petId] then
            self.data.petElementAttr[elementId][attrId][petId] = 0
          end
          self.data.petElementAttr[elementId][attrId][petId] = self.data.petElementAttr[elementId][attrId][petId] + attrVal
        end
      end
    end
  end
end

function this:setNotNew(petId)
  local key = "petCatalogNew" .. tostring(petId)
  L_CommonUtil.setLocalValue(key, false)
  self.data.cachedPetCatalogNew[key] = false
end

function this:getReportRewardTimes(petId)
  local targetInfo = self.data.petCatalog[petId]
  if targetInfo then
    return targetInfo.reportRewardTimes
  end
  return 0
end

function this:getStarColorsByPetId(petId)
  local res
  local targetInfo = self.data.petCatalog[petId]
  if targetInfo then
    res = targetInfo.starColors
  end
  return res
end

function this:checkCanGetReward()
  return self.data.canGetReward
end

function this:setStarColor()
  self:call(self.event.setStarColor)
end

function this:tryGetReward()
  C_MJLog.LogInfo("[星临图志] 领取课题奖励", C_ELogModule.Home)
  if not self.data.canGetReward then
    C_MJLog.LogError("can not get reward !!!")
    return
  end
  L_Net:sendMessage(MsgGenCode.CSProtoPetHandbookRewardGet, {}, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      local lvInfo = {}
      for _, v in pairs(self.data.waitGetRewardInfo) do
        local targetLvInfo = {
          petId = v.petId,
          lv = v.lv,
          rewardedLv = v.rewardedLv
        }
        table.insert(lvInfo, targetLvInfo)
      end
      self.data.waitGetRewardInfo = {}
      self.data.canGetReward = false
      AzurWorld.RedDotMgr:MarkDirty(L_ReddotManager.DotDef.PetCatalog)
      L_ReddotManager:setDirty(L_ReddotManager.DotDef.PetCatalog, true)
      local rewardData = require("ui.manager.reward.rewardData").new()
      local data = L_DataUtil.parseRewardConfig(rspData.reward.rewards, true, true)
      rewardData:constructList(data)
      self:call(self.event.getCatalogReward)
      L_UI:open("PagePetCatalogueRewardReceive", {
        reward = rewardData.rewards,
        lvInfo = lvInfo
      })
    end
  end)
end

function this:setNotTask(petId)
  L_CommonUtil.setLocalValue("petCatalogTask" .. tostring(petId), false)
end

return this
