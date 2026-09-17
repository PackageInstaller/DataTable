local this = class("cellProductAccessory", G_UIModuleBase)
local offsetLine = 25
local _productsTpl = L_GameTpl:getProductsTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _accessorySetTpl = L_GameTpl:getAccessorySetTpl()
local _petLaborTrainExpTpl = L_GameTpl:getPetLaborTrainExpTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _petAccessoryRarityProductTpl = L_GameTpl:getPetAccessoryRarityProductTpl()
local _taskTypeTpl = L_GameTpl:getTaskTypeTpl()
local _taskTpl = L_GameTpl:getTaskTpl()
local CellWidth = 351
local CellHeight = 146
local CellSpaceWidth = 55
local CellSpaceHeight = 37
local CellColOffset = 10
this.CellWidth = CellWidth
this.CellHeight = CellHeight
this.CellSpaceWidth = CellSpaceWidth
this.CellSpaceHeight = CellSpaceHeight
this.CellColOffset = CellColOffset
local qualityDescColor = {
  [0] = "#c7c3b9",
  [1] = "#94d4b6",
  [2] = "#94b7d6",
  [3] = "#a5a2da",
  [4] = "#ecc169"
}

function this.bind()
  return {
    img_icon = "",
    txt_id = "",
    txt_set = "",
    active_setLine = true,
    img_qualityBg = "",
    color_quilityDesc = C_Color(1, 1, 1, 1),
    list_star = {},
    active_star = false,
    active_lock = false,
    active_lock_icon = true,
    active_lock_txtDetail = true,
    active_bg = true,
    pos_selfRect = C_Vector2.zero,
    active_selectCurr = false,
    active_lineRowLock = false,
    active_lineRowUnLock = false,
    active_lineColLock = false,
    active_lineColUnLock = false,
    active_pointLockStar = false,
    active_producible = false,
    active_unproducibleMask = false,
    active_img2 = true,
    active_canAddExp = false,
    active_cantAddExp = false,
    active_petGradeLimit = false,
    txt_petGradeLimit = "",
    txt_lockDetail = "",
    active_taskNode = false,
    img_taskType = ""
  }
end

function this.methods()
  return {
    onClickCell = function(self)
      self:clickProcess()
    end
  }
end

function this:clickProcess()
  if self.bind.curProductId <= 0 then
    return
  end
  local tpl_pro = _productsTpl:getTplById(self.bind.curProductId)
  local notRelease = _productsTpl:getNotReleased(tpl_pro)
  if notRelease == 1 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_system_notdo"))
    return
  end
  local blockClick
  local serverData = L_HomeStore:getHomeBuildingByGuid(self.bind.guid)
  local tpl_building = _homeBuildingTpl:getTplById(serverData.build_id)
  local level = _homeBuildingTpl:getLevel(tpl_building)
  local productTpl = _productsTpl:getTplById(self.bind.curProductId)
  local isSatisfy, conditionRess = L_ConditionManager:isComplete(_productsTpl:getUnlockCondition(productTpl))
  if not isSatisfy then
    blockClick = L_ConditionManager:getTipDesc(_productsTpl:getUnlockCondition(tpl_pro))
  end
  if blockClick == nil then
    if not self.havePet then
      local groupList = _productsTpl:getGroupList(productTpl)
      local groupType = groupList and groupList[1]
      local buildFunctionType = groupType and L_ProductManager:onGetHomeBuildFunctionType(groupType)
      if buildFunctionType == L_HomeConst.HomeBuildFunctionType.EQUIP then
        blockClick = L_WordsTpl:getTplById("ui_product_need_pet")
      end
    elseif not self.petGradeMatch then
      blockClick = L_WordsTpl:getTplById("notice_product_kibo_score_not_satisfied")
    end
  end
  if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, self.bind.curProductId) then
    L_ReddotManager:markNew(L_ReddotManager.DotDef.productionNew, self.bind.curProductId)
    if self.bindComponents.reddotNew then
      self.bindComponents.reddotNew.gameObject:SetActive(false)
    end
  end
  local pos = L_Vector3.getPos(self.gameObject.transform)
  self.bind.callback(self.bind.curProductId, pos, blockClick)
end

function this:open()
  local dataItem = self.bind
  self:setDynaPos(dataItem.curRow, dataItem.curCol)
  self:refreshInfo()
  self:refreshLine()
end

function this:refresh()
  self:refreshInfo()
end

function this:refreshBuildiCell(buildId)
  if self.bind.curProductId == buildId then
    self:clickProcess()
  end
end

function this:setDynaPos(row, col)
  local posX = CellWidth / 2 + (col - 1) * (CellWidth + CellSpaceWidth) + 10
  local posY = -(row - 1) * (CellHeight + CellSpaceHeight)
  self.bind.pos_selfRect = C_Vector2(posX, posY)
end

function this:refreshLine()
  local curRow = self.bind.curRow
  local curCol = self.bind.curCol
  local lastRow = self.bind.lastRow
  local lastCol = self.bind.lastCol
  local curProductId = self.bind.curProductId
  local lastProductId = self.bind.lastProductId
  if curProductId <= 0 or lastProductId <= 0 then
    self.bind.active_star = false
    self.bind.active_pointLockStar = false
    self.bind.active_lineRowLock = false
    self.bind.active_lineRowUnLock = false
    self.bind.active_lineColLock = false
    self.bind.active_lineColUnLock = false
    self.bindComponents.rRect_star.anchoredPosition = C_Vector2(0, 0)
    return
  end
  local isUnLock = true
  if curRow == lastRow then
    self.bind.active_star = false
    self.bind.active_pointLockStar = false
    self.bind.active_lineRowLock = not isUnLock
    self.bind.active_lineRowUnLock = isUnLock
    self.bind.active_lineColLock = false
    self.bind.active_lineColUnLock = false
    local targetWidth = math.abs(curCol - lastCol) * (CellWidth + CellSpaceWidth) - CellWidth / 2
    if isUnLock then
      self.bindComponents.rRect_lineRowUnLock.sizeDelta = C_Vector2(targetWidth, 0)
    else
      self.bindComponents.rRect_lineRowLock.sizeDelta = C_Vector2(targetWidth, 0)
    end
  elseif curCol == lastCol then
    self.bind.active_star = false
    self.bind.active_pointLockStar = false
    self.bind.active_lineRowLock = false
    self.bind.active_lineRowUnLock = false
    self.bind.active_lineColLock = not isUnLock
    self.bind.active_lineColUnLock = isUnLock
    local targetHeight = math.abs(curRow - lastRow) * (CellHeight + CellSpaceHeight) - CellHeight / 2
    local targetPosY = 0 < curRow - lastRow and 0 or -targetHeight
    if isUnLock then
      self.bindComponents.rRect_lineColUnLock.sizeDelta = C_Vector2(0, targetHeight)
      self.bindComponents.rRect_lineColUnLock.anchoredPosition = C_Vector2(0, targetPosY)
    else
      self.bindComponents.rRect_lineColLock.sizeDelta = C_Vector2(0, targetHeight)
      self.bindComponents.rRect_lineColLock.anchoredPosition = C_Vector2(0, targetPosY)
    end
  else
    self.bind.active_star = isUnLock
    self.bind.active_pointLockStar = not isUnLock
    self.bind.active_lineRowLock = not isUnLock
    self.bind.active_lineRowUnLock = isUnLock
    self.bind.active_lineColLock = not isUnLock
    self.bind.active_lineColUnLock = isUnLock
    local targetWidth = math.abs(curCol - lastCol) * (CellWidth + CellSpaceWidth) - offsetLine
    local targetHeight = math.abs(curRow - lastRow) * (CellHeight + CellSpaceHeight) - CellHeight / 2 - offsetLine
    local targetPosY = 0 < curRow - lastRow and 0 or -targetHeight
    if isUnLock then
      self.bindComponents.rRect_lineRowUnLock.sizeDelta = C_Vector2(targetWidth, 0)
      self.bindComponents.rRect_lineColUnLock.sizeDelta = C_Vector2(0, targetHeight)
      self.bindComponents.rRect_lineColUnLock.anchoredPosition = C_Vector2(-(targetWidth + offsetLine), targetPosY + offsetLine)
      self.bindComponents.rRect_star.anchoredPosition = C_Vector2(-(targetWidth + offsetLine), 0)
    else
      self.bindComponents.rRect_lineRowLock.sizeDelta = C_Vector2(targetWidth, 0)
      self.bindComponents.rRect_lineColLock.sizeDelta = C_Vector2(0, targetHeight)
      self.bindComponents.rRect_lineColLock.anchoredPosition = C_Vector2(-(targetWidth + offsetLine), targetPosY + offsetLine)
      self.bindComponents.rRect_lockStar.anchoredPosition = C_Vector2(-(targetWidth + offsetLine), 0)
    end
  end
end

function this:refreshInfo()
  local curProductId = self.bind.curProductId
  if curProductId <= 0 then
    self.bind.active_star = false
    self.bind.active_pointLockStar = false
    self.bind.active_lock = false
    self.bind.active_bg = false
    self.bind.active_selectCurr = false
    return
  end
  local tpl_pro = _productsTpl:getTplById(curProductId)
  local notRelease = _productsTpl:getNotReleased(tpl_pro)
  if not math.isEmpty(notRelease) then
    self.bind.active_lock = true
    self.bind.active_lock_icon = false
    self.bind.active_lock_txtDetail = false
  end
  local reward = _productsTpl:getRewardId(tpl_pro)
  local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
  local conf = L_ItemTplManager:getItemConfig(itemData.itemType, itemData.itemId)
  local isMaterialEnough = L_ProductManager:isAccessoryMaterialEnough(curProductId)
  self.bind.img_icon = conf.icon
  self.bind.txt_id = conf.name
  if itemData.itemType == L_Const.resType.accessory then
    local setID = _accessoryTpl:getSetId(_accessoryTpl:getTplById(itemData.itemId))
    if setID and setID ~= 0 and math.isEmpty(notRelease) then
      self.bind.txt_set = _accessorySetTpl:getName(_accessorySetTpl:getTplById(setID))
      self.bind.active_setLine = true
      self.bind.active_img2 = false
    else
      self.bind.txt_set = ""
      self.bind.active_setLine = false
      self.bind.active_img2 = true
    end
    self.provideLaborExp = _accessoryTpl:getProvideLaborExp(_accessoryTpl:getTplById(itemData.itemId))
  else
    self.bind.txt_set = ""
    self.bind.active_setLine = false
    self.bind.active_img2 = true
  end
  self.bind.img_qualityBg = string.format("UI/Atlas/BSCommon/tex_homecommontip_bg_quality_%s.png", conf.quality or 0)
  local _, descColor = C_ColorUtility.TryParseHtmlString(qualityDescColor[conf.quality or 0])
  self.bind.color_quilityDesc = descColor
  local starNum = L_ItemTplManager:getItemShowStarNum(itemData.itemType, itemData.itemId)
  local starTmp = {}
  for i = 1, starNum do
    table.insert(starTmp, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(starTmp)
  local serverData = L_HomeStore:getHomeBuildingByGuid(self.bind.guid)
  local tpl_building = _homeBuildingTpl:getTplById(serverData.build_id)
  local level = _homeBuildingTpl:getLevel(tpl_building)
  local productTpl = _productsTpl:getTplById(curProductId)
  local isSatisfy, conditionRes = L_ConditionManager:isComplete(_productsTpl:getUnlockCondition(tpl_pro))
  self.bind.active_lock = not isSatisfy
  local isShowReddot = not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, self.bind.curProductId) and not self.bind.active_lock and not self.bind.active_taskNode
  self.bindComponents.reddotNew.gameObject:SetActive(isShowReddot)
  self.havePet = not math.isEmpty(serverData.station_pet_guid)
  self.petGradeMatch = self:checkPetGradeMatch(serverData, conf.quality)
  if self.bind.active_lock then
    self:refreshLockInfo(tpl_pro)
    self.bind.active_canAddExp = false
    self.bind.active_cantAddExp = false
    self.bind.txt_set = ""
    self.bind.active_setLine = false
    self.bind.active_img2 = true
  else
    self:checkPetGradeLock(conf.quality)
  end
  if not isMaterialEnough and self.bind.active_lock == false then
    self:setGrayEffect(true)
  else
    self:setGrayEffect(false)
  end
end

function this:checkPetGradeLock(rarity)
  self.bind.active_petGradeLimit = not self.petGradeMatch
  self.bind.txt_petGradeLimit = tostring(self:calPetMatchGrade(rarity))
  self:refreshTrainExp(rarity)
end

function this:checkPetGradeMatch(serverData, rarity)
  local petGuid = serverData.station_pet_guid
  if math.isEmpty(petGuid) then
    return false
  end
  local buildProductionTpl = _homeBuildingProductionTpl:getTplById(serverData.build_id)
  local needLaborType = _homeBuildingProductionTpl:getLaborType(buildProductionTpl)
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  local C_PetData = C_PetStore:GetPet(petGuid)
  local C_LaborInfoList = C_PetData:GetLaborInfoList()
  for i = 0, C_LaborInfoList.Count - 1 do
    local C_LaborInfo = C_LaborInfoList[i]
    local laborId = C_LaborInfo.laborId
    local isMatch = false
    if type(needLaborType) == "table" then
      for _, needType in ipairs(needLaborType) do
        if needType == laborId then
          isMatch = true
          break
        end
      end
    else
      isMatch = laborId == needLaborType
    end
    if isMatch then
      local laborGrade = C_LaborInfo.laborGrade
      local qualityProb = _petAccessoryRarityProductTpl:getQualityProbByScoreAndRarity(laborGrade, rarity)
      return qualityProb ~= 0
    end
  end
  return false
end

function this:calPetMatchGrade(rarity)
  local minScore
  for id, tpl in pairs(_petAccessoryRarityProductTpl.data) do
    local laborScore = _petAccessoryRarityProductTpl:getLaborScore(tpl)
    if laborScore and #laborScore == 2 then
      local rarity_all = _petAccessoryRarityProductTpl:getRarityAll(tpl)
      if rarity_all and rarity_all[rarity] and rarity_all[rarity] ~= 0 and (not minScore or minScore > laborScore[1]) then
        minScore = laborScore[1]
      end
    end
  end
  if minScore then
    return minScore
  else
    return 0
  end
end

function this:refreshLockInfo(tpl_pro)
  local desc = L_ConditionManager:getDescs(_productsTpl:getUnlockCondition(tpl_pro))
  self.bind.txt_lockDetail = desc[1]
end

function this:refreshTrainExp(rarity)
  local laborGrade = -1
  local serverData = L_HomeStore:getHomeBuildingByGuid(self.bind.guid)
  local petGuid = serverData.station_pet_guid
  if math.isEmpty(petGuid) then
    self.bind.active_canAddExp = false
    self.bind.active_cantAddExp = false
    return
  end
  local buildProductionTpl = _homeBuildingProductionTpl:getTplById(serverData.build_id)
  local needLaborType = _homeBuildingProductionTpl:getLaborType(buildProductionTpl)
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  local C_PetData = C_PetStore:GetPet(petGuid)
  local C_LaborInfoList = C_PetData:GetLaborInfoList()
  for i = 0, C_LaborInfoList.Count - 1 do
    local C_LaborInfo = C_LaborInfoList[i]
    local laborId = C_LaborInfo.laborId
    local isMatch = false
    if type(needLaborType) == "table" then
      for _, needType in ipairs(needLaborType) do
        if needType == laborId then
          isMatch = true
          break
        end
      end
    else
      isMatch = laborId == needLaborType
    end
    if isMatch then
      laborGrade = C_LaborInfo.laborGrade
    end
  end
  local exp = _petLaborTrainExpTpl:getExpByScoreAndRarity(laborGrade, rarity)
  self.bind.active_canAddExp = exp ~= 0 and self.provideLaborExp and not self.bind.active_lock
  self.bind.active_cantAddExp = (exp == 0 or not self.provideLaborExp) and not self.bind.active_lock
end

function this:setGrayEffect(isGray)
  if isGray then
    self.bind.active_producible = false
    self.bind.active_unproducibleMask = true
    self.bindComponents.img_icon.color = C_Color(0.5058823529411764, 0.5686274509803921, 0.6235294117647059, 0.6)
  else
    self.bind.active_producible = self.petGradeMatch
    self.bind.active_unproducibleMask = false
    self.bindComponents.img_icon.color = C_Color(1, 1, 1, 0.85)
  end
end

function this:refreshSelect(selectId)
  local state = selectId == self.bind.curProductId
  if not state then
    local tpl_pro = _productsTpl:getTplById(self.bind.curProductId)
    local reward = _productsTpl:getRewardId(tpl_pro)
    local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
    state = selectId == itemData.itemId
  end
  self.bind.active_selectCurr = state
end

function this:checkNeedShowTraceTaskNodeByTraceProductId(traceProductId)
  if self.bind.curProductId then
    if self.bind.curProductId == traceProductId then
      return true
    end
  elseif self.bind.productIdList then
    for _, productId in ipairs(self.bind.productIdList) do
      if productId == traceProductId then
        return true
      end
    end
  end
  return false
end

function this:refreshTraceTaskNode(traceTaskId)
  local taskTpl = _taskTpl:getTplById(traceTaskId)
  if taskTpl ~= nil then
    self.bind.active_taskNode = true
    local tabType = _taskTpl:getTabType(taskTpl)
    local taskTypeTpl = _taskTypeTpl:getTplById(tabType)
    self.bind.img_taskType = _taskTypeTpl:getMapIcon(taskTypeTpl)
    if self.isBind then
      self.bindComponents.reddotNew.gameObject:SetActive(false)
    end
  else
    self.bind.active_taskNode = false
  end
end

function this:hideTraceTaskNode()
  self.bind.active_taskNode = false
end

return this
