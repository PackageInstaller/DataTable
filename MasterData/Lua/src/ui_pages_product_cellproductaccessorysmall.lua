local this = class("cellProductAccessorySmall", G_UIModuleBase)
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
local CellWidth = 206
local CellHeight = 246
local CellSpaceWidth = 64
local CellSpaceHeight = 75
local CellColOffset = 10
this.CellWidth = CellWidth
this.CellHeight = CellHeight
this.CellSpaceWidth = CellSpaceWidth
this.CellSpaceHeight = CellSpaceHeight
this.CellColOffset = CellColOffset
local COLOR_SET_COLOR = {
  [0] = "#FFFFFF",
  [1] = "#FFFFFF",
  [2] = "#FFFFFF",
  [3] = "#C3AEDB",
  [4] = "#DDBE8E"
}

function this.bind()
  return {
    img_icon = "",
    img_qualityBg = "",
    txt_id = "",
    txt_set = "",
    color_txt_set = C_Color(1, 1, 1, 1),
    color_point_rarity = C_Color(1, 1, 1, 1),
    active_txt_set = false,
    active_txt_set_e = true,
    list_star = {},
    active_mask = false,
    active_lock = false,
    active_lock_icon = true,
    active_lock_txtDetail = true,
    txt_lockDetail = "",
    active_bg = true,
    pos_selfRect = C_Vector2.zero,
    active_selectCurr = false,
    active_canAddExp = false,
    active_cantAddExp = false,
    active_petGradeLimit = false,
    txt_petGradeLimit = "",
    active_taskNode = false,
    img_taskType = "",
    active_star = false,
    active_lineRowLock = false,
    active_lineRowUnLock = false,
    active_lineColLock = false,
    active_lineColUnLock = false,
    active_pointLockStar = false
  }
end

function this.methods()
  return {
    onClickCell = function(self)
      self:clickProcess()
    end
  }
end

function this:open()
  self:refreshInfo()
  self:setDynaPos()
  self:refreshLine()
end

function this:refresh()
  self:refreshInfo()
  self:setDynaPos()
  self:refreshLine()
end

function this:refreshBuildiCell(buildId)
  if self.bind.curProductId == buildId then
    self:clickProcess()
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
    self.isNotOpen = true
  else
    self.isNotOpen = false
  end
  local reward = _productsTpl:getRewardId(tpl_pro)
  local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
  local conf = L_ItemTplManager:getItemConfig(itemData.itemType, itemData.itemId)
  self.bind.img_icon = conf.icon
  self.bind.txt_id = conf.name
  if itemData.itemType == L_Const.resType.accessory then
    local setID = _accessoryTpl:getSetId(_accessoryTpl:getTplById(itemData.itemId))
    if setID and setID ~= 0 and not self.isNotOpen then
      self.bind.txt_set = _accessorySetTpl:getName(_accessorySetTpl:getTplById(setID))
      local _, color = C_ColorUtility.TryParseHtmlString(COLOR_SET_COLOR[conf.quality])
      self.bind.color_txt_set = color
      self.bind.color_point_rarity = color
      self.bind.active_txt_set_e = false
      self.bind.active_txt_set = true
    else
      self.bind.txt_set = ""
      self.bind.active_txt_set_e = true
      self.bind.active_txt_set = false
    end
    self.provideLaborExp = _accessoryTpl:getProvideLaborExp(_accessoryTpl:getTplById(itemData.itemId))
  else
    self.bind.txt_set = ""
    self.bind.active_txt_set_e = true
    self.bind.active_txt_set = false
  end
  self.bind.img_qualityBg = self:getQualityBgPrefix(conf.quality + 1 or 1)
  local starNum = L_ItemTplManager:getItemShowStarNum(itemData.itemType, itemData.itemId)
  local starTmp = {}
  for i = 1, starNum do
    table.insert(starTmp, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(starTmp)
  local serverData = L_HomeStore:getHomeBuildingByGuid(self.bind.guid)
  local isSatisfy, conditionRes = L_ConditionManager:isComplete(_productsTpl:getUnlockCondition(tpl_pro))
  self.isLock = not isSatisfy
  local showLock = not self.isNotOpen and self.isLock
  self.bind.active_lock = showLock
  local isShowReddot = not self.isNotOpen and not showLock and not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, self.bind.curProductId) and not self.bind.active_taskNode
  self.bindComponents.reddotNew.gameObject:SetActive(isShowReddot)
  self.havePet = not math.isEmpty(serverData.station_pet_guid)
  self.petGradeMatch = self:checkPetGradeMatch(serverData, conf.quality)
  if self.isNotOpen or showLock then
    self.bind.active_canAddExp = false
    self.bind.active_cantAddExp = false
    self.bind.active_petGradeLimit = false
    if showLock then
      self:refreshLockInfo(tpl_pro)
    end
  else
    self:checkPetGradeLock(conf.quality)
  end
  local isMaterialEnough = L_ProductManager:isAccessoryMaterialEnough(curProductId)
  self.notEnoughMaterial = not isMaterialEnough
  self:UpdateMask()
  self:UpdateQualityFlow(conf.quality)
end

function this:getQualityBgPrefix(qualityNum)
  return string.format("UI/Icon/ProductAccessory/tex_homeequipment_bg_item_0%s.png", qualityNum)
end

function this:UpdateQualityFlow(quality)
end

function this:checkPetGradeLock(rarity)
  self.bind.active_petGradeLimit = not self.petGradeMatch
  self.cachePetMatchGradeValue = self:calPetMatchGrade(rarity)
  self.bind.txt_petGradeLimit = tostring(self.cachePetMatchGradeValue)
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
  self.bind.active_canAddExp = exp ~= 0 and self.provideLaborExp and not self.isLock
  self.bind.active_cantAddExp = (exp == 0 or not self.provideLaborExp) and not self.isLock
end

function this:UpdateMask()
  local notOpen = self.isNotOpen
  local lock = self.isLock
  local notEnoughMaterial = self.notEnoughMaterial
  local notEnoughMaterialOnly = not notOpen and not lock and notEnoughMaterial
  local showMask = notOpen or lock or notEnoughMaterial
  self.bind.active_mask = showMask
  if showMask then
    local colorStr, alpha
    if notOpen then
      colorStr = "#413f3d"
      alpha = 0.3
    elseif lock then
      colorStr = "#413f3d"
      alpha = 0.7
    else
      colorStr = "#242627"
      alpha = 0.3
    end
    local color = C_LuaUtility.ParseHtmlStringColor(colorStr)
    color.a = alpha
    self.bindComponents.img_mask.color = color
  end
  if notEnoughMaterialOnly then
    self.bindComponents.img_icon.color = C_Color(0.5058823529411764, 0.5686274509803921, 0.6235294117647059, 0.6)
  else
    self.bindComponents.img_icon.color = C_Color(1, 1, 1, 1)
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
  local curState = self.bind.active_selectCurr
  self.bind.active_selectCurr = state
  if curState ~= state then
    self:playRefreshAnim(state)
  end
  self:CheckUpdateLine(selectId)
end

function this:playRefreshAnim(newState)
  if not self.bindComponents.animCell then
    return
  end
  self.bindComponents.animCell:Stop()
  local animName
  if newState then
    animName = "anim_accessorycell_selected"
  else
    animName = "anim_accessorycell_unselected"
  end
  self.bindComponents.animCell:Play(animName)
end

function this:clickProcess()
  if self.bind.curProductId <= 0 then
    return
  end
  if self.isNotOpen then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_system_notdo"))
    return
  end
  local tpl_pro = _productsTpl:getTplById(self.bind.curProductId)
  local blockClick
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
  local kiboExpInfos = {
    petGradeLimit = not self.petGradeMatch and self.cachePetMatchGradeValue,
    addExp = self.bind.active_canAddExp,
    noExp = self.bind.active_cantAddExp
  }
  local pos = L_Vector3.getPos(self.gameObject.transform)
  self.bind.callback(self.bind.curProductId, pos, blockClick, kiboExpInfos)
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

function this:setDynaPos()
  local posX = self.bind.posX
  local posY = self.bind.posY
  if posX and posY then
    self.bind.pos_selfRect = C_Vector2(posX, posY)
  end
end

function this:refreshLine(ignoreCheck)
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
  if self.isLock or self.isNotOpen then
    isUnLock = false
  end
  local parent = self.parent
  local curPosInfo = parent:getCellPosByRowCol(curRow, curCol)
  local lastPosInfo = parent:getCellPosByRowCol(lastRow, lastCol)
  if not curPosInfo or not lastPosInfo then
    return
  end
  local curX = curPosInfo.posX
  local curY = curPosInfo.posY
  local lastX = lastPosInfo.posX
  local lastY = lastPosInfo.posY
  local curWidth = curPosInfo.width
  local lastWidth = lastPosInfo.width
  if not ignoreCheck and self.isLastSelected then
    self.isLastSelected = parent:CheckTargetProductIsSelected()
  end
  local isLastTargetSelected = self.isLastSelected or false
  local extraWidth = isLastTargetSelected and 7 or 13
  local extraHeight = isLastTargetSelected and 7 or 13
  local targetWidth = math.abs(curX - lastX) + extraWidth - lastWidth / 2
  local targetHeight = math.abs(curY - lastY) + extraHeight - CellHeight / 2
  local targetPosY = curY < lastY and 0 or -targetHeight
  if curRow == lastRow then
    self.bind.active_star = false
    self.bind.active_pointLockStar = false
    self.bind.active_lineRowLock = not isUnLock
    self.bind.active_lineRowUnLock = isUnLock
    self.bind.active_lineColLock = false
    self.bind.active_lineColUnLock = false
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
    if isUnLock then
      self.bindComponents.rRect_lineColUnLock.sizeDelta = C_Vector2(targetHeight, 0)
      self.bindComponents.rRect_lineColUnLock.anchoredPosition = C_Vector2(0, targetPosY)
    else
      self.bindComponents.rRect_lineColLock.sizeDelta = C_Vector2(targetHeight, 0)
      self.bindComponents.rRect_lineColLock.anchoredPosition = C_Vector2(0, targetPosY)
    end
  else
    self.bind.active_star = isUnLock
    self.bind.active_pointLockStar = not isUnLock
    self.bind.active_lineRowLock = not isUnLock
    self.bind.active_lineRowUnLock = isUnLock
    self.bind.active_lineColLock = not isUnLock
    self.bind.active_lineColUnLock = isUnLock
    local targetWidthAdjusted = targetWidth + lastWidth / 2 - extraWidth
    local targetHeightAdjusted = targetHeight
    local targetPosYAdjusted = curY < lastY and 0 or -targetHeightAdjusted
    if isUnLock then
      self.bindComponents.rRect_lineRowUnLock.sizeDelta = C_Vector2(targetWidthAdjusted, 0)
      self.bindComponents.rRect_lineColUnLock.sizeDelta = C_Vector2(targetHeightAdjusted, 0)
      self.bindComponents.rRect_lineColUnLock.anchoredPosition = C_Vector2(-targetWidthAdjusted, targetPosYAdjusted)
      self.bindComponents.rRect_star.anchoredPosition = C_Vector2(-targetWidthAdjusted + 0.5, 0)
    else
      self.bindComponents.rRect_lineRowLock.sizeDelta = C_Vector2(targetWidthAdjusted, 0)
      self.bindComponents.rRect_lineColLock.sizeDelta = C_Vector2(targetHeightAdjusted, 0)
      self.bindComponents.rRect_lineColLock.anchoredPosition = C_Vector2(-targetWidthAdjusted, targetPosYAdjusted)
      self.bindComponents.rRect_lockStar.anchoredPosition = C_Vector2(-targetWidthAdjusted + 0.5, 0)
    end
  end
end

function this:CheckUpdateLine(curSelectId)
  local needRefresh = false
  local ignoreCheck = false
  if self.isLastSelected then
    if curSelectId ~= self.bind.lastProductId then
      needRefresh = true
    end
  elseif curSelectId == self.bind.lastProductId then
    self.isLastSelected = true
    needRefresh = true
    ignoreCheck = true
  end
  if needRefresh then
    self:refreshLine(ignoreCheck)
  end
end

function this:IsCurSelected()
  return self.bind and self.bind.active_selectCurr
end

return this
