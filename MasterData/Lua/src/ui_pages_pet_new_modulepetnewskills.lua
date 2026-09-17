local this = class("modulePetNewSkills", G_UIModuleBase)
local modulePetSkillTips_Path = "UI/Pages/PetBox/modulePetSkillTips.prefab"
local modulePetSkillTips = "ui.pages.pet.new.modulePetSkillTips"

function this.bind()
  return {
    skillList = {
      moduleName = "pages/pet/new/cellPetNewSkill"
    },
    active_tip = false,
    size_tipBoard = C_Vector2(750, 222)
  }
end

function this.methods()
  return {
    skillList = {
      onClick_Choose = function(self, data)
      end,
      onClick_Down = function(self, data)
        self.pageTipBuddleOpen = L_UI:checkPageOpen("pageTipBubble")
      end,
      onClick_Up = function(self, data)
        self:showTip()
      end
    },
    onClick_close = function(self)
      self.bind.active_tip = false
    end
  }
end

function this:open()
  self.skillData = {}
  self.pageTipBuddleOpen = false
end

function this:setGuid(guid)
  local pet = L_PetStore:getPetItem(guid)
  self.pet = pet
  self.bind.skillList:clear()
  local list = L_PetStore:getPetSkills(pet, false, false, true)
  self.skillData = list
  for i, v in pairs(list) do
    v.skillLv = string.gsub(v.skillLv, "Lv.", "")
  end
  self.bind.skillList:insert_array(list)
  self.tipsData = {}
  for i, v in ipairs(list) do
    table.insert(self.tipsData, {kiboInfo = v})
  end
end

function this:showTip()
  if table.isEmpty(self.tipsData) then
    return
  end
  if not self.pageTipBuddleOpen then
    local temp = {
      skillData = self.tipsData,
      pet = self.pet
    }
    L_UI:open("pageTipBubble", {
      data = {
        modulePetSkillTips_Path,
        modulePetSkillTips,
        temp,
        self.bindComponents.skillList,
        0,
        true,
        1,
        C_Vector2(32, 10),
        C_Vector2(300, 2),
        nil,
        nil,
        nil,
        nil,
        true
      }
    })
  else
    L_UI:close("pageTipBubble")
  end
end

return this
