local this = class("cellPetPreviewSkill", G_UIModuleBase)

function this.bind()
  return {
    skillList = {
      moduleName = "pages/pet/new/cellPetNewSkill"
    },
    skillTag = "BATTLE SKILL"
  }
end

function this.methods()
  return {
    skillList = {
      onClick_Choose = function(self, data)
        self:emit("onClick_Choose", self.bind.tipsData)
      end
    }
  }
end

function this:open()
  if self.bind.skill and self.bind.tagName then
    self:setSkillList(self.bind.skill, self.bind.tagName)
  end
end

function this:setSkillList(skillList, tagName)
  if not string.isEmpty(tagName) then
    self.bind.skillTag = tagName
  end
  for i, v in ipairs(skillList) do
    v.skillLv = string.gsub(v.skillLv, "Lv.", "<size=16>Lv.</size>")
  end
  self.bind.skillList:clear()
  self.bind.skillList:insert_array(skillList)
  self.bind.tipsData = {}
  for i, v in ipairs(skillList) do
    table.insert(self.bind.tipsData, {
      img_icon = v.itemIcon,
      img_lv = string.gsub(v.skillLv, "<size=16>Lv.</size>", ""),
      txt_name = v.skillName,
      txt_desc = v.describe,
      skillElement = v.skillElement,
      cellRect = self.bindComponents.cellRect
    })
  end
end

return this
