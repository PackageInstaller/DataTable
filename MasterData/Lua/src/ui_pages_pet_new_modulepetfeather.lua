local module = class("modulePetFeather", G_UIModuleBase)
local petInfoTpl = L_GameTpl:getPetTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local petFeatureTpl = L_GameTpl:getPetFeatureTpl()
local _petCustomizedTpl = L_GameTpl:getPetCustomizedTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module.bind()
  return {
    tagList_feather = {
      moduleName = "pages/pet/new/cellNewTagItem"
    },
    active_tagTip_feather = false,
    list_tagTip_feather = {
      moduleName = "pages/pet/new/cellNewTagTipItem"
    },
    size_tipBoard_feather = C_Vector2(750, 853),
    tog_Detail = nil
  }
end

function module.methods()
  return {
    onClick_tagTip_feather = function(self)
      self.bind.tog_Detail = L_PetStore:isShowPetSkillDetail()
      if self.bind.tog_Detail == true then
        self:showDetail(true)
      end
      if #self.bind.list_tagTip_feather < 1 then
        return
      end
      self.bind.active_tagTip_feather = true
      self:emit("onCLickTagTipFeather")
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.tagTipNode_feather)
      self.bind.size_tipBoard_feather = C_Vector2(750, math.min(self.bindComponents.tagTipNode_feather.sizeDelta.y + 34, 700))
    end,
    onClick_closeTips = function(self)
      self.bind.active_tagTip_feather = false
    end,
    onValueChanged_Detail = function(self, isOn)
      self:showDetail(isOn)
      L_PetStore:setShowPetSkillDetail(isOn)
      if self.bindComponents.toggleAnimation then
        self.bindComponents.toggleAnimation:PlayMapChangeAnimation()
      end
    end
  }
end

function module:closeTip()
  self.bind.active_tagTip_feather = false
end

function module:created(...)
  module.super.created(self, ...)
  self.uiCamera = C_CameraManager.uiCamera
  self.screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
end

function module:open()
end

function module:close()
end

function module:hide()
  self.bind.active_tagTip_feather = false
end

function module:setGuid(petGuid)
  local pet = L_PetStore:getPetItem(petGuid)
  self.bind.tagList_feather:clear()
  self.bind.list_tagTip_feather:clear()
  local tagData = {}
  local tagTipData = {}
  local kiboDuelFeatureSkill = {}
  local featureList = L_PetStore:getPetFeatureSkill(pet)
  table.fill(kiboDuelFeatureSkill, featureList)
  for i, v in ipairs(kiboDuelFeatureSkill) do
    table.insert(tagData, {
      type = i % 3 == 0 and 3 or i % 3,
      label = string.format("%s", v.skillName)
    })
    table.insert(tagTipData, {
      type = i % 3 == 0 and 3 or i % 3,
      label = string.format("%s", v.skillName),
      txt_desc = string.isEmpty(v.describe) and L_WordsTpl:getValue("residual_code_modulepetfeather_01") or v.describe,
      detailDescribe = v.detailDescribe,
      describe = v.describe
    })
  end
  self.bind.tagList_feather:insert_array(tagData)
  self.bind.list_tagTip_feather:insert_array(tagTipData)
end

function module:setConfigId(petConfigId)
  self.configId = petConfigId
  self.bind.tagList_feather:clear()
  self.bind.list_tagTip_feather:clear()
  local tagData = {}
  local tagTipData = {}
  local kiboDuelFeatureSkill = {}
  local randomfeatureList, fixedFeatureList = L_PetManager:getPetConfigFeatureSkill(petConfigId)
  table.fill(kiboDuelFeatureSkill, fixedFeatureList)
  for i, v in ipairs(kiboDuelFeatureSkill) do
    table.insert(tagData, {
      type = i % 3 == 0 and 3 or i % 3,
      label = string.format("%s", v.skillName)
    })
    table.insert(tagTipData, {
      type = i % 3 == 0 and 3 or i % 3,
      label = string.format("%s", v.skillName),
      txt_desc = string.isEmpty(v.describe) and L_WordsTpl:getValue("residual_code_modulepetfeather_01") or v.describe,
      detailDescribe = v.detailDescribe,
      describe = v.describe
    })
  end
  self.bind.tagList_feather:insert_array(tagData)
  self.bind.list_tagTip_feather:insert_array(tagTipData)
end

function module:setCustomizedConfigId(petConfigId, petCustomizedId)
  self.configId = petConfigId
  self.petCustomizedId = petCustomizedId
  self.bind.tagList_feather:clear()
  self.bind.list_tagTip_feather:clear()
  local tagData = {}
  local tagTipData = {}
  local kiboDuelFeatureSkill = {}
  local randomfeatureList, fixedFeatureList = L_PetManager:getPetConfigFeatureSkill(petConfigId)
  local customizedTpl = _petCustomizedTpl:getTplById(petCustomizedId)
  local skillCountType = _petCustomizedTpl:getSkillCountType(customizedTpl)
  if skillCountType == 0 then
    table.fill(kiboDuelFeatureSkill, fixedFeatureList)
  elseif skillCountType == 1 then
    table.fill(kiboDuelFeatureSkill, randomfeatureList)
    table.fill(kiboDuelFeatureSkill, fixedFeatureList)
  else
    local customizedFeatureSkill = L_PetManager:getCustomizedPropertySkillList(petCustomizedId)
    table.fill(kiboDuelFeatureSkill, customizedFeatureSkill)
  end
  for i, v in ipairs(kiboDuelFeatureSkill) do
    table.insert(tagData, {
      type = i % 3 == 0 and 3 or i % 3,
      label = string.format("%s", v.skillName)
    })
    table.insert(tagTipData, {
      type = i % 3 == 0 and 3 or i % 3,
      label = string.format("%s", v.skillName),
      txt_desc = string.isEmpty(v.describe) and L_WordsTpl:getValue("residual_code_modulepetfeather_01") or v.describe,
      detailDescribe = v.detailDescribe,
      describe = v.describe
    })
  end
  self.bind.tagList_feather:insert_array(tagData)
  self.bind.list_tagTip_feather:insert_array(tagTipData)
end

function module:showDetail(isOn)
  for i, v in pairs(self.modules.list_tagTip_feather) do
    v:showDetail(isOn)
  end
end

return module
