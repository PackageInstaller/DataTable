local this = class("modulePetAttributeInfo", G_UIModuleBase)
local _petLearingEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local _petFeedItemTpl = L_GameTpl:getPetFeedItemTpl()

function this.bind()
  return {
    list_cellPetAttributeInfo = {
      moduleName = "pages/pet/cellPetAttributeInfo"
    }
  }
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  this.super.open(self)
end

function this:setShowPetGuid(petGuid)
  self.petGuid = petGuid
end

function this:refreshUI()
  if self.petGuid == nil then
    errorf("modulePetAttributeInfo 未设置需要展示的宠物Guid")
    return
  end
  local cellPetAttributeInfoList = {}
  local petLearingEnumTplData = _petLearingEnumTpl:getAllEnum(true)
  for i = 1, 4 do
    table.insert(cellPetAttributeInfoList, {})
  end
  self.bind.list_cellPetAttributeInfo:clear()
  self.bind.list_cellPetAttributeInfo:insert_array(cellPetAttributeInfoList)
  for i = 1, #self.bind.list_cellPetAttributeInfo do
    local cellPetAttributeInfo = self.bind.list_cellPetAttributeInfo:getItemCls(i)
    local petLearingEnumTpl = _petLearingEnumTpl:getTplById(i)
    local attrEnumNum = _petLearingEnumTpl:getEnumNum(petLearingEnumTpl)
    cellPetAttributeInfo:setShowPetGuidAndAttrEnumNum(self.petGuid, attrEnumNum)
    cellPetAttributeInfo:refreshBaseInfoUI()
    cellPetAttributeInfo:setAttrUpColor(i)
  end
end

function this:refreshPreAddComprehensionExpUI(preUseFruitInfoList, curLv)
  local addComprehensionExpList = {}
  local petLearingEnumTplData = _petLearingEnumTpl:getAllEnum(true)
  for _, petLearingEnumTpl in pairs(petLearingEnumTplData) do
    local attrEnumNum = _petLearingEnumTpl:getEnumNum(petLearingEnumTpl)
    addComprehensionExpList[attrEnumNum] = 0
  end
  for _, preUseFruitInfo in pairs(preUseFruitInfoList) do
    local itemId = preUseFruitInfo.itemId
    local itemNum = preUseFruitInfo.itemNum
    local petFeedItemTpl = _petFeedItemTpl:getTplById(itemId)
    local effectParamList = _petFeedItemTpl:getEffectParamList(petFeedItemTpl)
    for _, effectParam in pairs(effectParamList) do
      local attrEnumNum = effectParam[1]
      local expAddNum = effectParam[2] * itemNum
      addComprehensionExpList[attrEnumNum] = addComprehensionExpList[attrEnumNum] + expAddNum
    end
  end
  for i = 1, #self.bind.list_cellPetAttributeInfo do
    local cellPetAttributeInfo = self.bind.list_cellPetAttributeInfo:getItemCls(i)
    local attrEnumNum = cellPetAttributeInfo:getAttrEnumNum()
    local addExp = addComprehensionExpList[attrEnumNum]
    cellPetAttributeInfo:refreshPreAddComprehensionExpUI(addExp, curLv)
  end
end

function this:close()
  L_TimerManager:clearTimer(self)
end

function this:attrLevelUp(attrIdList)
  for i = 1, #attrIdList do
    local attrId = attrIdList[i]
    for index = 1, #self.bind.list_cellPetAttributeInfo do
      local cellPetAttributeInfo = self.bind.list_cellPetAttributeInfo:getItemCls(index)
      local petLearingEnumTpl = _petLearingEnumTpl:getTplById(index)
      local attrEnumNum = _petLearingEnumTpl:getEnumNum(petLearingEnumTpl)
      if attrEnumNum == attrId then
        L_TimerManager:newOrResetTimer(cellPetAttributeInfo, "attrLevelUp_" .. i, function()
          if self.isBind then
            cellPetAttributeInfo:attrLevelUp(true)
          end
        end, 0.03 * i)
        break
      end
    end
  end
end

return this
