local cls = class("cellPetTalentTagTips", G_UIModuleBase)
local _homeBuffTpl = L_GameTpl:getHomeBuffTpl()
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()
local StationBuildingType2LaborDescIndex = {
  [L_HomeConst.StationBuildingType.HomeBuilding] = 1,
  [L_HomeConst.StationBuildingType.Collection] = 2,
  [L_HomeConst.StationBuildingType.Ranch] = 3,
  [L_HomeConst.StationBuildingType.Crop] = 4
}

function cls.bind()
  return {
    txt_label = "",
    img_label = "",
    txt_desc = "",
    list_IconBuilding = {
      moduleName = "pages/pet/cellIconBuildTagTips"
    },
    go_list_IconBuilding = true
  }
end

function cls:refresh()
  self.cfgId = self.bind.id
  self.bind.txt_desc = ""
  self:initModule()
end

function cls:initModule()
  local tmp = {}
  local laborId = self.bind.id
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
  self.bind.img_label = _homeLaborTypeTpl:getLaborIcon(homeLaborTypeTpl)
  self.bind.txt_label = _homeLaborTypeTpl:getLaborName(homeLaborTypeTpl)
  local desTab = _homeLaborTypeTpl:getLaborDescDetailList(homeLaborTypeTpl)
  for i = 1, #desTab do
    local descLangString = _homeLaborTypeTpl:getLaborDescList(homeLaborTypeTpl)[i]
    if descLangString ~= nil and descLangString ~= " " and descLangString ~= "" then
      self.bind.txt_desc = self.bind.txt_desc .. self:getNoTalentDescTextWithNoBonus(i) .. "\n"
    end
  end
  local buildData = {}
  local buildingNameTab = _homeLaborTypeTpl:getBuildingNameListByPetSize(homeLaborTypeTpl, self.bind.size)
  local buildingIconTab = _homeLaborTypeTpl:getBuildingIconListByPetSize(homeLaborTypeTpl, self.bind.size)
  for i = 1, #buildingNameTab do
    table.insert(buildData, {
      name = buildingNameTab[i],
      icon = buildingIconTab[i]
    })
  end
  local isHaveBuildData = buildData ~= nil and next(buildData) ~= nil
  self.bind.go_list_IconBuilding = isHaveBuildData
  if isHaveBuildData then
    self.bind.list_IconBuilding:clear()
    self.bind.list_IconBuilding:insert_array(buildData)
  end
  self.bindComponents.rectDesc:SetSizeWithCurrentAnchors(1, self.bindComponents.tmpDesc.preferredHeight + 2)
  self:UpdateContainerVerticalLayout(self.bindComponents.rect)
end

function cls:UpdateContainerVerticalLayout(rect)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  local height = rect:GetComponent("VerticalLayoutGroup").preferredHeight + 2
  rect:SetSizeWithCurrentAnchors(1, height)
end

function cls:getNoTalentDescText(index)
  local laborId = self.bind.id
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
  local noTalentDesc = _homeLaborTypeTpl:getLaborDescDetailList(homeLaborTypeTpl)[index]
  local buffId = _homeLaborTypeTpl:getHomeBuffIdList(homeLaborTypeTpl)[1]
  local homeBuffTpl = _homeBuffTpl:getTplById(buffId)
  local buffValueType = _homeBuffTpl:getType(homeBuffTpl)
  local buffValue = L_HomeBuffManager:getLaborBuffValue(laborId, self.bind.laborGrade, buffId) / 10000
  local textOfBuffValue
  if buffValueType == L_HomeConst.buffValueType.PERCENT then
    local showBuffValue = buffValue * 100
    local showBuffValueIntPart = math.ceil(showBuffValue - showBuffValue % 1)
    local showBuffValueFloatPart = showBuffValue % 1
    local showBuffValue = showBuffValueIntPart
    textOfBuffValue = showBuffValue .. "%"
  else
    local showBuffValue = buffValue
    local showBuffValueIntPart = math.ceil(showBuffValue - showBuffValue % 1)
    local showBuffValueFloatPart = showBuffValue % 1
    local showBuffValue = showBuffValueIntPart
    textOfBuffValue = tostring(showBuffValue)
  end
  return L_Lang:get(noTalentDesc, {
    [0] = textOfBuffValue
  })
end

function cls:getNoTalentDescTextWithNoBonus(index)
  local laborId = self.bind.id
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
  local noTalentDesc = _homeLaborTypeTpl:getLaborDescDetailListWithNoBonus(homeLaborTypeTpl)[index]
  return L_Lang:get(noTalentDesc)
end

return cls
