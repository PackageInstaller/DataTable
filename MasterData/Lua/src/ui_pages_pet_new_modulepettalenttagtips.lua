local this = class("modulePetTalentTagTips", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()
local C_TDPetHomeTalentTable = CS.Azur.Gameplay.Table.TDPetHomeTalentTable
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()

function this.bind()
  return {
    list_capacity = {
      moduleName = "pages/pet/cellPetTalentTagTips"
    }
  }
end

function this:Init(petCfgId)
  self:refreshModule(petCfgId)
end

function this:refreshModule(configId)
  local C_TDPetHomeTalent = C_TDPetHomeTalentTable.GetData(configId)
  local tpl = _petHomeTalentTpl:getTplById(configId)
  local size = _petHomeTalentTpl:getSizeType(tpl)
  local lTalent = {}
  if not TableIsNull(C_TDPetHomeTalent) then
    local C_LaborConfigInfoList = C_TDPetHomeTalent:GetLaborConfigInfoList()
    for i = 0, C_LaborConfigInfoList.Count - 1 do
      local C_LaborConfigInfo = C_LaborConfigInfoList[i]
      table.insert(lTalent, {
        id = C_LaborConfigInfo.laborTypeId,
        size = size,
        configId = configId,
        laborGrade = C_LaborConfigInfo.minLaborGrade
      })
    end
  end
  self.bind.list_capacity:clear()
  self.bind.list_capacity:insert_array(lTalent)
  self:UpdateContainerVerticalLayout(self.bindComponents.rect)
end

function this:UpdateContainerVerticalLayout(rect)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  local height = rect:GetComponent("VerticalLayoutGroup").preferredHeight + 2
  rect:SetSizeWithCurrentAnchors(1, height)
end

return this
