local this = class("modulePetMountInfo", G_UIModuleBase)
local petLevelTpl = L_GameTpl:getPetLevelTpl()
local petTpl = L_GameTpl:getPetTpl()
local mountTpl = L_GameTpl:getMountTpl()
local templateValueTpl = L_GameTpl:getTemplateValueTpl()
local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local skillsubLogicTpl = L_GameTpl:getSkillsubLogicTpl()
local petSkillTypeTpl = L_GameTpl:getPetSkillTypeTpl()

local function getPetSkillLogicTagTypeId(pair)
  if pair == nil then
    return nil
  end
  if type(pair) == "table" then
    return pair[1]
  end
  return pair
end

local function isValidPetSkillTypeTag(tagId)
  return tagId ~= nil and 501 <= tagId and tagId <= 505
end

local function buildPetSkillTypeRow(tagId)
  local td_petSkillType = petSkillTypeTpl:getTplById(tagId)
  if TableIsNull(td_petSkillType) then
    return nil
  end
  return {
    moveType = tagId,
    img_icon = petSkillTypeTpl:getIcon(td_petSkillType),
    txt_moveType = petSkillTypeTpl:getName(td_petSkillType)
  }
end

local function appendTagsFromSkill(rows, seen, skillId)
  if math.isEmpty(skillId) then
    return
  end
  local tpl_skillLevel = skillLevelTpl:getTplByIdAndLevel(skillId, 1)
  if TableIsNull(tpl_skillLevel) then
    return
  end
  local subSkillId = skillLevelTpl:getSubSkillId(tpl_skillLevel)
  if math.isEmpty(subSkillId) then
    return
  end
  local tpl_sub = skillsubLogicTpl:getTplById(subSkillId)
  if tpl_sub == nil then
    return
  end
  local petSkillLogicTag = skillsubLogicTpl:getPetSkillLogicTag(tpl_sub)
  if type(petSkillLogicTag) ~= "table" then
    return
  end
  for _, pair in ipairs(petSkillLogicTag) do
    local tagId = getPetSkillLogicTagTypeId(pair)
    if isValidPetSkillTypeTag(tagId) and not seen[tagId] then
      local row = buildPetSkillTypeRow(tagId)
      if row ~= nil then
        seen[tagId] = true
        table.insert(rows, row)
      end
    end
  end
end

local function buildMountSkillTypeRows(petId)
  local rows = {}
  if math.isEmpty(petId) then
    return rows
  end
  local tpl_pet = petTpl:getTplById(petId)
  if tpl_pet == nil then
    return rows
  end
  local seen = {}
  local mountSkillList = petTpl:getMountSkillList(tpl_pet)
  for _, skillId in pairs(mountSkillList) do
    appendTagsFromSkill(rows, seen, skillId)
  end
  table.sort(rows, function(a, b)
    return (a.moveType or 0) < (b.moveType or 0)
  end)
  return rows
end

local mountType = {
  [1] = "ui_modulePetCatalogDetail_01",
  [2] = "ui_modulePetCatalogDetail_02",
  [3] = "ui_modulePetCatalogDetail_03",
  [4] = "ui_modulePetCatalogDetail_04",
  [5] = "ui_modulePetCatalogDetail_08",
  [6] = "ui_modulePetCatalogDetail_09"
}

function this.bind()
  return {
    speed = "???",
    canRide = true,
    list_moveType = {
      moduleName = "pages/pet/new/cellPetMoveType"
    },
    active_self = true,
    show_speed = true,
    active_tip = false,
    list_tipMount = {
      moduleName = "pages/Pet/cellPetTipMount"
    },
    Img_skillType = ""
  }
end

function this.methods()
  return {
    onClick_showTip = function(self)
      if self.bind.active_tip then
        return
      end
      self.bind.active_tip = true
      self:refreshTipData()
      self:emit("onClickShowMountTip")
    end,
    onClick_closeTip = function(self)
      self.bind.active_tip = false
    end
  }
end

function this:closeTip()
  self.bind.active_tip = false
end

function this:refreshMountSkillTypeData(petId)
  self.bind.Img_skillType = ""
  self._tipSkillTypeData = {}
  if math.isEmpty(petId) then
    return
  end
  local skillTypeRows = buildMountSkillTypeRows(petId)
  self._tipSkillTypeData = table.deepClone(skillTypeRows)
  local first = self._tipSkillTypeData[1]
  if first ~= nil then
    self.bind.Img_skillType = first.img_icon or ""
  end
end

function this:refreshTipData()
  self.bind.list_tipMount:clear()
  if not self.bind.canRide or not self.bind.active_self then
    return
  end
  self.bind.list_tipMount:insert_array({
    {
      speed = self.bind.speed,
      canRide = self.bind.canRide,
      petId = self._tipPetId,
      moveTypeData = table.deepClone(self._tipMoveType or {}),
      skillTypeData = table.deepClone(self._tipSkillTypeData or {}),
      show_speed = self.bind.show_speed
    }
  })
end

function this:setGuid(guid)
  local pet = L_PetStore:getPetItem(guid)
  self._guid = guid
  local tpl = petTpl:getTplById(pet.id)
  self._tipPetId = pet.id
  local isUnlockRide = petTpl:getIsMount(tpl) and C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mount)
  self.bind.canRide = petTpl:getIsMount(tpl)
  if not petTpl:getIsMount(tpl) then
    self.bind.active_self = false
    self.bind.Img_skillType = ""
    self._tipSkillTypeData = {}
    self:refreshTipData()
    return
  end
  self.bind.active_self = true
  self.bind.show_speed = true
  self._tipMoveType = {}
  self.bind.list_moveType:clear()
  if isUnlockRide then
    self.bind.speed = string.format("%s", L_MountManager:getMountSpeed(self._guid, 1))
  end
  if self.bind.canRide then
    local tpl_mount = mountTpl:getTplById(pet.id)
    local moveType = mountTpl:getMoveType(tpl_mount)
    local tmp = {}
    for i, v in pairs(moveType) do
      table.insert(tmp, {
        moveType = v,
        img_icon = string.format("UI/Atlas/PetSaddle/tex_petsaddle_icon_%s.png", v),
        txt_moveType = L_WordsTpl:getValue(mountType[v])
      })
    end
    self._tipMoveType = table.deepClone(tmp)
    self.bind.list_moveType:insert_array(tmp)
  end
  self:refreshMountSkillTypeData(pet.id)
  self:refreshTipData()
end

function this:setConfigId(configId)
  local tpl = petTpl:getTplById(configId)
  self._tipPetId = configId
  local isUnlockRide = petTpl:getIsMount(tpl) and C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mount)
  self.bind.canRide = petTpl:getIsMount(tpl)
  if not petTpl:getIsMount(tpl) then
    self.bind.active_self = false
    self.bind.Img_skillType = ""
    self._tipSkillTypeData = {}
    self:refreshTipData()
    return
  end
  self.bind.active_self = true
  self.bind.list_moveType:clear()
  self.bind.show_speed = true
  self._tipMoveType = {}
  if isUnlockRide then
    self.bind.show_speed = false
  end
  if self.bind.canRide then
    local tpl_mount = mountTpl:getTplById(configId)
    local moveType = mountTpl:getMoveType(tpl_mount)
    local tmp = {}
    for i, v in pairs(moveType) do
      table.insert(tmp, {
        moveType = v,
        img_icon = string.format("UI/Atlas/PetSaddle/tex_petsaddle_icon_%s.png", v),
        txt_moveType = L_WordsTpl:getValue(mountType[v])
      })
    end
    self._tipMoveType = table.deepClone(tmp)
    self.bind.list_moveType:insert_array(tmp)
  end
  self:refreshMountSkillTypeData(configId)
  self:refreshTipData()
end

return this
