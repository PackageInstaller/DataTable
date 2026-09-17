local this = class("moduleBuildingTag", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _petHomeSizeTpl = L_GameTpl:getPetHomeSizeTpl()
local _homeLaborCapacityTpl = L_GameTpl:getHomeLaborCapacityTpl()
local _buildingTypeTpl = L_GameTpl:getHomeBuildingTypeTpl()

function this.bind()
  return {
    txt_buildingTag = nil,
    go_needPet = false,
    img_capacity = nil,
    txt_sizeNeed = nil
  }
end

function this.methods()
  return {}
end

function this:setId(id)
  local tpl = _homeBuildingTpl:getTplById(id)
  local tpl_group = _homeBuildingGroupTpl:getTplById(_homeBuildingTpl:getGroupId(tpl))
  local tpl_type = _buildingTypeTpl:getTplById(_homeBuildingGroupTpl:getType(tpl_group))
  self.bind.txt_buildingTag = _buildingTypeTpl:getTypeName(tpl_type)
  local tpl_product = _homeBuildingProductionTpl:getTplById(id)
  if tpl_product and not math.isEmpty(_homeBuildingProductionTpl:getPetHomeAttribute(tpl_product)) then
    local laborId = _homeBuildingProductionTpl:getPetHomeAttribute(tpl_product)
    local petSize = _homeBuildingProductionTpl:getPetSize(tpl_product)
    self.bind.go_needPet = true
    local txt = ""
    for i, v in ipairs(petSize) do
      local tpl_size = _petHomeSizeTpl:getTplById(v)
      txt = string.concat(txt, _petHomeSizeTpl:getSizeName(tpl_size))
      if i < #petSize then
        txt = string.concat(txt, "/")
      end
    end
    self.bind.txt_sizeNeed = txt
    local tpl_capacity = _homeLaborCapacityTpl:getTplById(laborId)
    self.bind.img_capacity = _homeLaborCapacityTpl:getIconLight(tpl_capacity)
  else
    self.bind.go_needPet = false
  end
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_buildTag)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_size)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_moduleBuildingTag)
end

return this
