local this = class("cellHomePropertyTip", G_UIModuleBase)
local _HomeTalentTpl = L_GameTpl:getHomeTalentTpl()
local _TechTpl = L_GameTpl:getHomeTechnologyTpl()
local _TechnologyTreeTpl = L_GameTpl:getHomeTechnologyTreeTpl()
local _TechnologyTypeTpl = L_GameTpl:getHomeTechnologyTypeTpl()

function this.bind()
  return {img_icon = "", txt_desc = ""}
end

function this.methods()
  return {}
end

function this:open()
  local source = self.bind.source
  if source.talentId then
    local talentId = source.talentId
    local talentTpl = _HomeTalentTpl:getTplById(talentId)
    self.bind.img_icon = _HomeTalentTpl:getIcon(talentTpl)
    local titleTxt = _HomeTalentTpl:getTalentName(talentTpl) .. " LV." .. _HomeTalentTpl:getTalentLevel(talentTpl)
    self.bind.txt_desc = string.format("%s:%s", titleTxt, _HomeTalentTpl:getTalentDescription(talentTpl))
  end
  if source.techId then
    local tpl = _TechTpl:getTplById(source.techId)
    local treeId = _TechTpl:getType(tpl)
    local treeTpl = _TechnologyTreeTpl:getTplById(treeId)
    local category = _TechnologyTreeTpl:getCategory(treeTpl)
    local tpl_type = _TechnologyTypeTpl:getTplById(category)
    self.bind.img_icon = _TechnologyTypeTpl:getTechnologyCurrencyPageIcon(tpl_type)
    local titleTxt = _TechnologyTreeTpl:getName(treeTpl)
    self.bind.txt_desc = string.format("%s:%s", titleTxt, _TechTpl:getEffectDescription(tpl))
  end
end

return this
