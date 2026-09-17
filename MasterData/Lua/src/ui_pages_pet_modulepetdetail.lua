local module = class("modulePetDetail", G_UIModuleBase)
local petInfoTpl = L_GameTpl:getPetTpl()
local _petCustomizedTpl = L_GameTpl:getPetCustomizedTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module.bind()
  return {
    txt_height = "183.5m",
    module_pixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    modulePetBoxName = {
      moduleName = "pages/pet/new/modulePetBoxName"
    },
    modulePetNewSimpleTags = {
      moduleName = "pages/pet/new/modulePetNewSimpleTags"
    },
    modulePetNewHomeTag = {
      moduleName = "pages/pet/new/modulePetNewHomeTags"
    },
    modulePetMountInfo = {
      moduleName = "pages/pet/new/modulePetMountInfo"
    },
    modulePetFeather = {
      moduleName = "pages/pet/new/modulePetFeather"
    },
    modulePetRaceInfo = {
      moduleName = "pages/pet/new/modulePetRaceInfo"
    },
    list_petSkills = {
      moduleName = "pages/pet/cellPetPreviewSkill"
    },
    skillTipsList = {
      moduleName = "pages/pet/new/cellPetNewTipSkill"
    },
    active_tip = false,
    size_tipBoard = C_Vector2(750, 222),
    pos_tipBoard = C_Vector2(0, 0)
  }
end

function module.methods()
  return {
    list_petSkills = {
      onClick_Choose = function(self, skillTipsList)
        self:showTip(skillTipsList)
      end
    },
    modulePetMountInfo = {
      onClickShowMountTip = function(self)
        self.bind.active_tip = false
        self.modules.modulePetFeather:closeTip()
        self.modules.modulePetNewHomeTag:closeTip()
      end
    },
    modulePetFeather = {
      onCLickTagTipFeather = function(self)
        self.bind.active_tip = false
        self.modules.modulePetMountInfo:closeTip()
        self.modules.modulePetNewHomeTag:closeTip()
      end
    },
    modulePetNewHomeTag = {
      onCLickPetNewHomeTag = function(self)
        self.bind.active_tip = false
        self.modules.modulePetMountInfo:closeTip()
        self.modules.modulePetFeather:closeTip()
      end
    }
  }
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

function module:infoRefresh(petConfigId)
  self.configId = petConfigId
  local petTpl = petInfoTpl:getTplById(petConfigId)
  self.modules.modulePetBoxName:setConfigId(petConfigId, true)
  self.modules.modulePetNewSimpleTags:setConfigId(petConfigId, true)
  self.modules.module_pixelIcon:setConfigId(petConfigId)
  self.modules.modulePetNewHomeTag:setConfigId(petConfigId)
  self.modules.modulePetMountInfo:setConfigId(petConfigId)
  self.modules.modulePetFeather:setConfigId(petConfigId)
  self.modules.modulePetRaceInfo:setConfigId(petConfigId)
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
  local signatureSkill, breakSkill, commonSkill = L_PetManager:getPetConfigActiveSkill(petConfigId)
  self.bind.list_petSkills:clear()
  local skillGroupData = {}
  if not table.isEmpty(signatureSkill) then
    table.insert(skillGroupData, {
      tagName = L_WordsTpl:getValue("ui_modulePetDetail_01"),
      skill = signatureSkill or {}
    })
  end
  if not table.isEmpty(breakSkill) then
    table.insert(skillGroupData, {
      tagName = L_WordsTpl:getValue("ui_modulePetDetail_02"),
      skill = breakSkill or {}
    })
  end
  if not table.isEmpty(commonSkill) then
    table.insert(skillGroupData, {
      tagName = L_WordsTpl:getValue("ui_modulePetDetail_03"),
      skill = commonSkill or {}
    })
  end
  self.bind.list_petSkills:insert_array(skillGroupData)
end

function module:infoRefreshCustomized(petConfigId, petCustomizedId)
  self.configId = petConfigId
  self.petCustomizedId = petCustomizedId
  local petTpl = petInfoTpl:getTplById(petConfigId)
  local petCustomizedTpl = _petCustomizedTpl:getTplById(petCustomizedId)
  self.modules.modulePetBoxName:setConfigId(petConfigId, true)
  self.modules.modulePetNewSimpleTags:setConfigId(petConfigId, true)
  local isSpecial = false
  local isFlash = _petCustomizedTpl:getLightParam(petCustomizedTpl) > 0
  self.modules.modulePetNewSimpleTags:setSpecialAndFlash(isSpecial, isFlash)
  self.modules.module_pixelIcon:setConfigId(petConfigId, false)
  self.modules.modulePetNewHomeTag:setConfigId(petConfigId)
  self.modules.modulePetMountInfo:setConfigId(petConfigId)
  self.modules.modulePetFeather:setCustomizedConfigId(petConfigId, petCustomizedId)
  self.modules.modulePetRaceInfo:setConfigId(petConfigId)
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
  local skillType = _petCustomizedTpl:getSkillType(petCustomizedTpl)
  local signatureSkill, breakSkill, commonSkill
  if skillType == 0 then
    signatureSkill, breakSkill, commonSkill = L_PetManager:getPetConfigActiveSkill(petConfigId)
  else
    signatureSkill, breakSkill, commonSkill = L_PetManager:getCustomizedPetConfigActiveSkill(petCustomizedId)
  end
  self.bind.list_petSkills:clear()
  local skillGroupData = {}
  if not table.isEmpty(signatureSkill) then
    table.insert(skillGroupData, {
      tagName = L_WordsTpl:getValue("ui_modulePetDetail_01"),
      skill = signatureSkill or {}
    })
  end
  if not table.isEmpty(breakSkill) then
    table.insert(skillGroupData, {
      tagName = L_WordsTpl:getValue("ui_modulePetDetail_02"),
      skill = breakSkill or {}
    })
  end
  if not table.isEmpty(commonSkill) then
    table.insert(skillGroupData, {
      tagName = L_WordsTpl:getValue("ui_modulePetDetail_03"),
      skill = commonSkill or {}
    })
  end
  self.bind.list_petSkills:insert_array(skillGroupData)
end

function module:showTip(skillTipsList)
  self.bind.skillTipsList:clear()
  self.bind.skillTipsList:insert_array(skillTipsList)
  local rect = skillTipsList[1].cellRect
  self.bind.pos_tipBoard = C_Vector2(rect.anchoredPosition.x, rect.anchoredPosition.y + 74)
  self.bind.active_tip = true
  self.modules.modulePetMountInfo:closeTip()
  self.modules.modulePetFeather:closeTip()
  self.modules.modulePetNewHomeTag:closeTip()
  L_UI:open("pageBlank", {
    callback = function()
      self.bind.active_tip = false
    end
  })
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.content)
end

return module
