local this = class("modulePetSkills", G_UIModuleBase)

function this.bind()
  return {
    skillList = {
      moduleName = "pages/Pet/cellSkillItem"
    },
    tipsList = {
      moduleName = "pages/Pet/cellPetTipSkill"
    },
    active_tip = false,
    size_tipBoard = C_Vector2(592, 222)
  }
end

function this.methods()
  return {
    skillList = {
      onClick_Choose = function(self, data)
        self:showTip()
      end
    }
  }
end

function this:open()
  self.skillData = {}
end

function this:setGuid(guid)
  local pet = L_PetStore:getPetItem(guid)
  self.bind.skillList:clear()
  local list = L_PetStore:getPetSkills(pet, false, false, true)
  self.skillData = list
  self.bind.skillList:insert_array(list)
  self.bind.tipsList:clear()
  local tipsData = {}
  for i, v in ipairs(list) do
    table.insert(tipsData, {
      img_icon = v.itemIcon,
      img_lv = v.skillLv,
      txt_name = v.skillName,
      txt_desc = v.describe,
      skillElement = v.skillElement
    })
  end
  self.bind.tipsList:insert_array(tipsData)
end

function this:showTip()
  self.bind.active_tip = true
  L_UI:open("pageBlank", {
    callback = function()
      self.bind.active_tip = false
    end
  })
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.content)
end

return this
