local this = class("modulePetNewHomeTags", G_UIModuleBase)
local _homeTalentTpl = L_GameTpl:getHomeTalentTpl()
local _petHomeSizeTpl = L_GameTpl:getPetHomeSizeTpl()
local C_HomeManager = AzurWorld.HomeMgr
local C_PetStore = C_HomeManager:GetPetStore()
local C_TDPetHomeTalentTable = CS.Azur.Gameplay.Table.TDPetHomeTalentTable
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
local maxTipHeight = L_DeviceTpl:getIsMobile() and 900 or 940
local isMobile = false

function this.bind()
  return {
    list_petHomeLaborTag = {
      moduleName = "pages/Pet/cellTagPetHomeLabor"
    },
    active_tip = false,
    list_tipLaborList = {
      moduleName = "pages/Pet/cellPetTipHomeLabor"
    },
    size_tipBoard = nil
  }
end

function this.methods()
  return {
    onClick_showTip = function(self)
      if #self.bind.list_tipLaborList < 1 or self.bind.active_tip then
        return
      end
      self:showTip()
      self:emit("onCLickPetNewHomeTag")
    end,
    onClick_closeTip = function(self)
      self.bind.active_tip = false
    end
  }
end

function this:showTip()
  self.bind.active_tip = true
  self:refreshView()
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.TalentList)
  self.isMobile = L_DeviceTpl:getIsMobile()
  if self.bindComponents.TalentList.sizeDelta.y + 160 > maxTipHeight then
    self.bind.size_tipBoard = C_Vector2(1070, maxTipHeight + 5)
  else
    self.bind.size_tipBoard = C_Vector2(1070, self.bindComponents.TalentList.sizeDelta.y + 100)
  end
  self:fixContentPos()
end

function this:fixContentPos()
  if self.bindComponents.tip_content then
    local pos = self.bindComponents.tip_content.anchoredPosition
    pos.y = 0
    self.bindComponents.tip_content.anchoredPosition = pos
  end
end

function this:closeTip()
  self.bind.active_tip = false
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

function this:hide()
  self.bind.active_tip = false
end

function this:refreshView()
  if not self._guid then
    return
  end
  self:refreshPetHomeLaborTagListByPetGuid(self._guid)
  self:fixContentPos()
end

function this:refreshPreviewInfo()
  if not self._configId then
    return
  end
  self:refreshPetHomeLaborTagListByPetConfigId(self._configId)
end

function this:refreshPetHomeLaborTagListByPetGuid(petGuid)
  local C_PetData = C_PetStore:GetPet(petGuid)
  if C_PetData == nil then
    C_MJLog.LogError(string.format("petGuid:%d 没有对应奇波信息", petGuid))
    return
  end
  local C_LaborInfoList = C_PetData:GetLaborInfoList()
  local showParamsList = {}
  for i = 0, C_LaborInfoList.Count - 1 do
    local C_LaborInfo = C_LaborInfoList[i]
    local C_TalentIds = C_PetData.talentIds
    local talentId
    if 0 < C_TalentIds.Count then
      local tmpTalentId = C_TalentIds[0]
      local homeTalentTpl = _homeTalentTpl:getTplById(tmpTalentId)
      local laborOfTmpTalentId = _homeTalentTpl:getLaborTypeIdOfTalent(homeTalentTpl)
      if laborOfTmpTalentId == C_LaborInfo.laborId then
        talentId = tmpTalentId
      end
    end
    local showParams = {
      petId = C_PetData.configId,
      isStationEnter = false,
      laborId = C_LaborInfo.laborId,
      laborGrade = C_LaborInfo.laborGrade,
      talentId = talentId,
      upperLaborGrade = C_LaborInfo.upperLaborGrade,
      laborExp = C_LaborInfo.laborExp,
      showSecondTip = i == C_LaborInfoList.Count - 1
    }
    table.insert(showParamsList, showParams)
  end
  self:refreshPetHomeLaborTagList(showParamsList)
end

function this:refreshPetHomeLaborTagListByPetConfigId(petConfigId)
  local C_TDPetHomeTalent = C_TDPetHomeTalentTable.GetData(petConfigId)
  local showParamsList = {}
  if not TableIsNull(C_TDPetHomeTalent) then
    local C_LaborConfigInfoList = C_TDPetHomeTalent:GetLaborConfigInfoList()
    for i = 0, C_LaborConfigInfoList.Count - 1 do
      local C_LaborConfigInfo = C_LaborConfigInfoList[i]
      local showParams = {
        petId = petConfigId,
        laborId = C_LaborConfigInfo.laborTypeId,
        laborGrade = C_LaborConfigInfo.minLaborGrade,
        isPreview = true
      }
      table.insert(showParamsList, showParams)
    end
  end
  self:refreshPetHomeLaborTagList(showParamsList)
end

function this:refreshPetHomeLaborTagList(showParamsList)
  self.bind.list_petHomeLaborTag:clear()
  self.bind.list_petHomeLaborTag:insert_array(showParamsList)
  local cloneTable = table.deepClone(showParamsList)
  self.bind.list_tipLaborList:clear()
  self.bind.list_tipLaborList:insert_array(cloneTable)
end

return this
