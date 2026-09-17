local module = class("moduleArealLevelSkillTips", G_UIModuleBase)
local _skillTpl = L_GameTpl:getSkillTpl()

function module.bind()
  return {
    imgSkillIcon = "",
    txtSkillName = "",
    txtSkillDesc = "",
    contentGO = false
  }
end

function module:methods()
  return {
    onClickClose = function(self)
      self:showModule(false)
    end
  }
end

function module:showModule(isShow, params)
  self._skillId = params and params.skillId
  if not self.isBind then
    return
  end
  self.bind.contentGO = isShow
  if isShow then
    self:refresh()
  end
end

function module:refresh()
  if not self._skillId then
    self.bind.contentGO = false
    return
  end
  local tpl = _skillTpl:getTplById(self._skillId)
  self.bind.imgSkillIcon = _skillTpl:getIcon(tpl)
  self.bind.txtSkillName = _skillTpl:getName(tpl)
  self.bind.txtSkillDesc = L_GameUtil.getSkillDesc(self._skillId, 1)
  self.bindComponents.imgSkillIcon:SetNativeSize()
end

return module
