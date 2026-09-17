local this = class("modulePetRaceInfo", G_UIModuleBase)
local wordsTpl = L_GameTpl:getWordsTpl()
local petInfoTpl = L_GameTpl:getPetTpl()
local petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
local petHomeSizeTpl = L_GameTpl:getPetHomeSizeTpl()
local mountTpl = L_GameTpl:getMountTpl()
local petRaceTpl = L_GameTpl:getPetRaceTpl()
local sizeType = {
  [1] = L_WordsTpl:getValue("residual_code_modulepetraceinfo_01"),
  [2] = L_WordsTpl:getValue("residual_code_modulepetraceinfo_02"),
  [3] = L_WordsTpl:getValue("residual_code_modulepetraceinfo_03"),
  [4] = L_WordsTpl:getValue("residual_code_modulepetraceinfo_04")
}

function this.bind()
  return {
    txt_stage = "",
    list_race = {
      moduleName = "pages/Pet/cellTagItem"
    },
    txt_height = "",
    txt_size = "",
    txt_desc = "",
    enabled_scrollView = true,
    groupListY = 0,
    toggle_ultimateStage = false
  }
end

function this:setGuid(guid)
  self.bind.groupListY = 0
  local pet = L_PetStore:getPetItem(guid)
  local petTpl = petInfoTpl:getTplById(pet.id)
  local stage = petInfoTpl:getPetStage(petTpl)
  self.bind.toggle_ultimateStage = false
  self.bind.txt_stage = wordsTpl:getTplById("ui_pet_stage" .. stage)
  local simpleTagData = {}
  local race = petInfoTpl:getRace(petTpl)
  local txt_race = ""
  for i = 1, #race do
    local raceTpl = petRaceTpl:getTplById(race[i])
    if i == 1 then
      txt_race = petRaceTpl:getRaceType(raceTpl)
    else
      txt_race = string.format("%s·%s", txt_race, petRaceTpl:getRaceType(raceTpl))
    end
  end
  table.insert(simpleTagData, {label = txt_race})
  self.bind.list_race:clear()
  self.bind.list_race:insert_array(simpleTagData)
  local size = petInfoTpl:getSize(petTpl)
  if math.isEmpty(size) then
    self.bind.txt_height = "???"
  else
    local integer, float = math.modf(tonumber(string.format("%.1f", size / 10000)))
    if float == 0 then
      self.bind.txt_height = string.format("%dcm", integer)
    else
      self.bind.txt_height = string.format("%.1fcm", size / 10000)
    end
  end
  local tpl_petHomeTalent = petHomeTalentTpl:getTplById(pet.id)
  local petSize = petHomeTalentTpl:getSizeType(tpl_petHomeTalent)
  local tpl_petHomeSize = petHomeSizeTpl:getTplById(petSize)
  self.bind.txt_size = petHomeSizeTpl:getSizeName(tpl_petHomeSize)
  self.bind.txt_desc = petInfoTpl:getDesc(petTpl)
  self:refreshScrollViewEnable()
end

function this:setConfigId(configId)
  self.bind.groupListY = 0
  self.bind.active_special_obj = false
  self.bind.active_flashTag = false
  local petTpl = petInfoTpl:getTplById(configId)
  local stage = petInfoTpl:getPetStage(petTpl)
  self.bind.txt_stage = wordsTpl:getTplById("ui_pet_stage" .. stage)
  local simpleTagData = {}
  local race = petInfoTpl:getRace(petTpl)
  local txt_race = ""
  for i = 1, #race do
    local raceTpl = petRaceTpl:getTplById(race[i])
    if i == 1 then
      txt_race = petRaceTpl:getRaceType(raceTpl)
    else
      txt_race = string.format("%s·%s", txt_race, petRaceTpl:getRaceType(raceTpl))
    end
  end
  table.insert(simpleTagData, {label = txt_race})
  self.bind.list_race:clear()
  self.bind.list_race:insert_array(simpleTagData)
  local size = petInfoTpl:getSize(petTpl)
  if math.isEmpty(size) then
    self.bind.txt_height = "???"
  else
    local integer, float = math.modf(tonumber(string.format("%.1f", size / 10000)))
    if float == 0 then
      self.bind.txt_height = string.format("%dcm", integer)
    else
      self.bind.txt_height = string.format("%.1fcm", size / 10000)
    end
  end
  local tpl_petHomeTalent = petHomeTalentTpl:getTplById(configId)
  local petSize = petHomeTalentTpl:getSizeType(tpl_petHomeTalent)
  local tpl_petHomeSize = petHomeSizeTpl:getTplById(petSize)
  self.bind.txt_size = petHomeSizeTpl:getSizeName(tpl_petHomeSize)
  self.bind.txt_desc = petInfoTpl:getDesc(petTpl)
  self:refreshScrollViewEnable()
end

function this:refreshScrollViewEnable()
  FrameScheduler.add(function()
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rectContent)
    local width = self.bindComponents.horizonLayoutGroupContent.preferredWidth
    self.bind.enabled_scrollView = 413 < width
  end, 1)
end

return this
