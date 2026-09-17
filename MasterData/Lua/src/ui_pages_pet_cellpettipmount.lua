local this = class("cellPetTipMount", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local skillTpl = L_GameTpl:getSkillTpl()
local skillsubLogicTpl = L_GameTpl:getSkillsubLogicTpl()

function this.bind()
  return {
    speed = "???",
    list_moveType = {
      moduleName = "pages/pet/new/cellPetMoveType"
    },
    show_speed = true,
    cellPetNewTipSkillMount = {
      moduleName = "pages/pet/new/cellPetNewTipSkillMount"
    }
  }
end

function this:refreshSkillData()
  if math.isEmpty(self.bind.petId) then
    return
  end
  local tpl_pet = petTpl:getTplById(self.bind.petId)
  if tpl_pet == nil then
    return
  end
  local mountSkillId = petTpl:getMountSkill751(tpl_pet)
  local mountSkillSlot = 751
  if math.isEmpty(mountSkillId) then
    local mountSkillList = petTpl:getMountSkillList(tpl_pet)
    for slot, skillId in pairs(mountSkillList) do
      if not math.isEmpty(skillId) then
        mountSkillId = skillId
        mountSkillSlot = slot
        break
      end
    end
  end
  if math.isEmpty(mountSkillId) then
    return
  end
  local tpl_skillLevel = skillLevelTpl:getTplByIdAndLevel(mountSkillId, 1)
  if TableIsNull(tpl_skillLevel) then
    return
  end
  local skillGroupId = skillLevelTpl:getSkillGroupId(tpl_skillLevel)
  local tpl_skill = skillTpl:getTplById(tonumber(skillGroupId))
  if tpl_skill == nil then
    return
  end
  local tpl_skillSub = skillsubLogicTpl:getTplById(skillGroupId)
  local skillCd = tpl_skillSub and skillsubLogicTpl:getCoolDown(tpl_skillSub) or 0
  local kiboInfo = {
    itemIcon = skillTpl:getIcon(tpl_skill) or "",
    skillLv = "Lv.1",
    skillId = mountSkillId,
    skillCd = skillCd,
    skillName = skillTpl:getName(tpl_skill) or "",
    describe = skillLevelTpl:getSkillDescribe(tpl_skillLevel) or "",
    skillElement = skillTpl:getSkillElement(tpl_skill),
    skillSlot = mountSkillSlot,
    skillLevelTpl = tpl_skillLevel,
    name = skillLevelTpl:getSkillPowerType(tpl_skillLevel)
  }
  self.modules.cellPetNewTipSkillMount:initModule(kiboInfo)
end

function this:open()
  self.bind.speed = self.bind.speed or "???"
  if self.bind.canRide ~= nil then
    self.bind.canRide = self.bind.canRide == true
  end
  self.bind.show_speed = self.bind.show_speed ~= false
  self:refreshSkillData()
  self.bind.list_moveType:clear()
  if type(self.bind.moveTypeData) == "table" then
    self.bind.list_moveType:insert_array(self.bind.moveTypeData)
  end
  if type(self.bind.skillTypeData) == "table" and #self.bind.skillTypeData > 0 then
    self.modules.cellPetNewTipSkillMount:refreshSkillType(self.bind.skillTypeData)
  end
end

return this
