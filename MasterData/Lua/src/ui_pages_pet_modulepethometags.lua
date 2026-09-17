local this = class("modulePetHomeTags", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()
local _mountTpl = L_GameTpl:getMountTpl()
local _homeTalentTpl = L_GameTpl:getHomeTalentTpl()
local _gameConstTpl = L_GameTpl:getGameConstTpl()

function this.bind()
  return {
    list_talentTag = {
      moduleName = "pages/Pet/cellTagPetHomeLabor"
    },
    txt_satiety = "",
    active_mount = false,
    isOn_mount = false,
    active_tip = false,
    txt_tipSatietyInterval = "",
    txt_tipSatiety = "",
    color_tipSatiety = C_Color.white,
    color_tipSatietyText = C_Color.white,
    active_tipMount = false,
    txt_tipMountSpeed = "",
    speedTip = true,
    moveTip = false,
    list_tipTalentList = {
      moduleName = "pages/Pet/cellPetTipHomeLabor"
    },
    size_scrollTalent = C_Vector2(545, 638),
    size_tipBoard = C_Vector2(592, 853)
  }
end

function this.methods()
  return {
    onClick_setMount = function(self)
      if math.isEmpty(self._guid) then
        return
      end
      L_UI:open("pageMountEditRoulette")
    end,
    onClick_showTip = function(self)
      self:showTip()
    end
  }
end

function this:showTip()
  self.bind.active_tip = true
  L_UI:open("pageBlank", {
    callback = function()
      self.bind.active_tip = false
    end
  })
  self:refreshView()
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.TalentList)
  self.bind.size_tipBoard = C_Vector2(592, math.min(self.bindComponents.TalentList.sizeDelta.y, 621) + 216 - (self.bind.active_tipMount and 0 or 50))
  self.bind.size_scrollTalent = C_Vector2(545, math.min(self.bindComponents.TalentList.sizeDelta.y, 621) + 17)
end

function this:setGuid(guid)
  self._guid = guid
  self:refreshView()
end

function this:setConfigId(configId)
  self._configId = configId
  self:refreshPreviewInfo()
end

function this:open()
  self:refreshView()
  self._ESyncMountRouletteServerDataHandler = handler(self, self.refreshView)
  AzurWorld.mountMgr:RegisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
  L_SatietyStore:listenCallFunc(L_SatietyStore.event.satiety_value_refresh, self.refreshView, self)
end

function this:close()
  AzurWorld.mountMgr:UnregisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
  L_SatietyStore:unListenCallFunc(L_SatietyStore.event.satiety_value_refresh, self.refreshView, self)
end

function this:refreshView()
  if not self._guid then
    return
  end
  local pet = L_PetStore:getPetItem(self._guid)
  local tpl = _petTpl:getTplById(pet.id)
  local talentDatas = {}
  local talentDatasTip = {}
  for i = 1, 3 do
    if pet.talent_id[i] then
      table.insert(talentDatas, {
        id = pet.talent_id[i]
      })
      table.insert(talentDatasTip, {
        id = pet.talent_id[i],
        isStationEnter = false
      })
    end
  end
  self.bind.list_talentTag:clear()
  self.bind.list_talentTag:insert_array(talentDatas)
  local txtSatiety = string.format("%s/%s", L_SatietyStore:getPetSatiety(self._guid), L_SatietyStore:getPetMaxSatiety(self._guid))
  self.bind.txt_satiety = txtSatiety
  self.bind.active_mount = _petTpl:getIsMount(tpl) and C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mount)
  self.bind.isOn_mount = pet:isInMountRoulette()
  local satietyInterval = L_SatietyStore:getPetSatietyStatus(self._guid)
  local colorSatiety = L_PetConst.SatietyStatusColorPetInfo[satietyInterval]
  self.bind.txt_tipSatietyInterval = L_WordsTpl:getValue(L_PetConst.SatietyStatusText[satietyInterval])
  self.bind.txt_tipSatiety = txtSatiety
  self.bind.color_tipSatiety = colorSatiety
  self.bind.color_tipSatietyText = colorSatiety
  self.bind.active_tipMount = _petTpl:getIsMount(tpl)
  if self.bind.active_tipMount then
    self.bind.speedTip = true
    self.bind.moveTip = false
    self.bind.txt_tipMountSpeed = string.format("%s/%s", L_MountManager:getMountSpeed(self._guid), L_MountManager:getMountSpeed(self._guid, 1))
  end
  self.bind.list_tipTalentList:clear()
  self.bind.list_tipTalentList:insert_array(talentDatasTip)
end

function this:refreshPreviewInfo()
  if not self._configId then
    return
  end
  local tpl = _petTpl:getTplById(self._configId)
  local talentDatas = {}
  local talentDatasTip = {}
  local petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
  local talentTpl = petHomeTalentTpl:getTplById(self._configId)
  if talentTpl then
    local petMaxSatiety = petHomeTalentTpl:getSatietyScore(talentTpl)
    local txtSatiety = string.format("%s/%s", petMaxSatiety, petMaxSatiety)
    self.bind.txt_satiety = txtSatiety
    self.bind.txt_tipSatiety = txtSatiety
    local talentGroupIds = petHomeTalentTpl:getTalentGroupId(talentTpl) or {}
    for i = 1, 3 do
      if talentGroupIds[i] then
        local talentId = _homeTalentTpl:getTalentId(_homeTalentTpl:getTplByGroupId(talentGroupIds[i][1]))
        table.insert(talentDatas, {id = talentId})
        table.insert(talentDatasTip, {id = talentId})
      end
    end
  end
  self.bind.list_talentTag:clear()
  self.bind.list_talentTag:insert_array(talentDatas)
  self.bind.active_mount = _petTpl:getIsMount(tpl) and C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mount)
  self.bind.isOn_mount = false
  local colorSatiety = L_PetConst.SatietyStatusColorPetInfo[L_PetConst.SatietyStatus.FULL]
  self.bind.txt_tipSatietyInterval = L_WordsTpl:getValue(L_PetConst.SatietyStatusText[L_PetConst.SatietyStatus.FULL])
  self.bind.color_tipSatiety = colorSatiety
  self.bind.color_tipSatietyText = colorSatiety
  self.bind.active_tipMount = _petTpl:getIsMount(tpl)
  if self.bind.active_tipMount then
    self.bind.speedTip = false
    self.bind.moveTip = true
    local mountTpl = _mountTpl:getTplById(self._configId)
    self.bind.txt_tipMountSpeed = _mountTpl:getMoveDesc(mountTpl)
  end
  self.bind.list_tipTalentList:clear()
  self.bind.list_tipTalentList:insert_array(talentDatasTip)
end

return this
