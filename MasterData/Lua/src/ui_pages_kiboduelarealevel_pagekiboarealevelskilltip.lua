local page = class("pageKiboAreaLevelSkillTip", G_UIPageBase)
local _skillTpl = L_GameTpl:getSkillTpl()

function page.bind()
  return {
    imgSkillIcon = "",
    txtSkillName = "",
    txtSkillDesc = ""
  }
end

function page.methods()
  return {
    closeBtn = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self._skillId = options.skillId
end

function page:open()
  page.super.open(self)
  self:refresh()
end

function page:refresh()
  local skillLevel = 1
  local tpl = _skillTpl:getTplById(self._skillId)
  self.bind.imgSkillIcon = _skillTpl:getIcon(tpl)
  self.bind.txtSkillName = _skillTpl:getName(tpl)
  self.bind.txtSkillDesc = L_GameUtil.getSkillDesc(self._skillId, skillLevel)
end

return page
