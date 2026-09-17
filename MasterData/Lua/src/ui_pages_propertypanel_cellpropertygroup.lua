local this = class("cellPropertyGroup", G_UIModuleBase)
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function this.bind()
  return {
    titleBgActive = true,
    titleText = "",
    propertyList = {
      moduleName = "pages/pet/cellAttrItem"
    },
    propertyBgList = {
      moduleName = "pages/propertyPanel/cellPropertyBg"
    },
    propertyListActive = true,
    propertyBgListActive = true,
    pos_propertyBg = C_Vector3.zero
  }
end

function this:open()
  self:refreshPlatform()
end

function this:refresh()
  self.bind.propertyListActive = self.bind.groupType == L_Const.propetyShowType.attribute
  self.bind.propertyBgListActive = self.bind.propertyListActive
  if self.bind.groupType == L_Const.propetyShowType.attribute then
    self:refreshAttributes()
  end
end

function this:refreshAttributes()
  self.bind.titleBgActive = self.bind.groupId > 1
  if self.bind.groupId > 1 then
    self.bind.titleText = L_WordsTpl:getValue("ui_property_title_" .. self.bind.groupId)
    self.bind.pos_propertyBg = C_Vector3(0, -48, 0)
  else
    self.bind.pos_propertyBg = C_Vector3(0, 0, 0)
  end
  local topRankComprehension
  if self.bind.properties and 0 < #self.bind.properties then
    local data = self.bind.properties[1]
    if data.roleType == L_Const.roleType.pet then
      local pet = L_PetStore:getPetItem(data.guid)
      if pet then
        topRankComprehension = L_PetStore:getRangeValueComprehension(false, 8, pet.comprehension)
      end
    end
  end
  self.bind.propertyList:clear()
  local res = {}
  for _, property in ipairs(self.bind.properties) do
    local tpl = _battleInfoTpl:getTplById(property.id)
    local id, baseValue, addValue, value
    local showNum = ""
    local abilityLmt = false
    if property.roleType == L_Const.roleType.hero then
      id, baseValue, addValue = L_AttributeManager:getHeroAttSplitValue(property.attDic, property.id, property.guid, true, property.guid == nil)
      addValue = addValue or 0
    elseif property.roleType == L_Const.roleType.pet then
      baseValue, addValue = L_PetStore:getPetAttSplitValue(property.attDic, property.id, property.guid)
      if property.guid ~= 0 then
        local petItem = L_PetStore:getPetItem(property.guid)
        abilityLmt = petItem:getPetAbilityLimited()
      end
    end
    local isAddValue = not math.isEmpty(addValue)
    local baseValueNum = tonumber(baseValue) or 0
    local addValueNum = tonumber(addValue) or 0
    showNum = _battleInfoTpl:getShowTxt(property.id, math.round(baseValueNum))
    if isAddValue then
      local roundAddValue = math.round(addValueNum)
      local addNum = L_GameUtil.fillColor(string.format("+%s", _battleInfoTpl:getShowTxt(property.id, roundAddValue)), L_Const.colorHtml.green001)
      if addValueNum < 0 then
        addNum = L_GameUtil.fillColor(string.format("%s", _battleInfoTpl:getShowTxt(property.id, roundAddValue)), L_Const.colorHtml.red001)
      end
      showNum = string.format("%s%s", showNum, addNum)
    end
    local enumId = 0
    if topRankComprehension then
      for _, k in pairs(topRankComprehension) do
        if k.attr_id == property.id then
          enumId = k.rankId
          break
        end
      end
    end
    table.insert(res, {
      attrIcon = _battleInfoTpl:getIcon(tpl),
      value = showNum,
      name = _battleInfoTpl:getName(tpl),
      attrId = enumId,
      abilityLimit = abilityLmt
    })
  end
  self.bind.propertyList:insert_array(res)
  self:refreshPropertyBg()
end

function this:refreshPropertyBg()
  local tmp = {}
  local propertyBgListLength
  if self.bind.propertyList:getLength() % 2 == 0 then
    propertyBgListLength = self.bind.propertyList:getLength() / 2
  else
    propertyBgListLength = self.bind.propertyList:getLength() / 2 + 1
  end
  for i = 1, propertyBgListLength do
    local active = i % 2 == 0
    table.insert(tmp, {imgActive = active})
  end
  self.bind.propertyBgList:clear()
  self.bind.propertyBgList:insert_array(tmp)
end

function this:refreshPlatform()
  if L_DeviceTpl:getIsMobile() then
    self.bindComponents.propertyList.cellSize = C_Vector2(485, 37)
  end
end

return this
