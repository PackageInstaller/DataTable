local this = class("pageHomePropertyTip", G_UIPageBase)
local _HomeBuffCountTpl = L_GameTpl:getHomeBuffCountTpl()
local _HomeTalentTpl = L_GameTpl:getHomeTalentTpl()
local _TechTpl = L_GameTpl:getHomeTechnologyTpl()
local _TechnologyTreeTpl = L_GameTpl:getHomeTechnologyTreeTpl()

function this.bind()
  return {
    img_icon = "",
    txt_title = "",
    txt_desc = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  local source = options.source
  local countTpl = options.countTpl
  local buff = source.buff
  if buff.buffValue > 0 then
    local descKey = _HomeBuffCountTpl:getDescKey(countTpl)
    local valueStr = L_HomeBuffManager:getDisplayValue(buff.buffId, buff.buffValue)
    local conditions = buff.conditions
    local targetName
    for conditionId, targetId in pairs(conditions or {}) do
      targetName = L_HomeBuffManager:getConditionTargetName(conditionId, targetId)
      break
    end
    self.bind.txt_desc = L_Lang:get(descKey, {value = valueStr, name = targetName})
  end
  if source.petGuid then
    local talentId = source.talentId
    local talentTpl = _HomeTalentTpl:getTplById(talentId)
    self.bind.img_icon = _HomeTalentTpl:getIcon(talentTpl)
    self.bind.txt_title = _HomeTalentTpl:getTalentName(talentTpl) .. " LV." .. _HomeTalentTpl:getTalentLevel(talentTpl)
    if buff.buffValue == 0 then
      self.bind.txt_desc = _HomeTalentTpl:getTalentDescription(talentTpl)
    end
  end
  if source.techId then
    local tpl = _TechTpl:getTplById(source.techId)
    local treeId = _TechTpl:getType(tpl)
    local treeTpl = _TechnologyTreeTpl:getTplById(treeId)
    self.bind.img_icon = _TechnologyTreeTpl:getIcon(treeTpl)
    self.bind.txt_title = _TechnologyTreeTpl:getName(treeTpl)
    if buff.buffValue == 0 then
      self.bind.txt_desc = _TechTpl:getEffectDescription(tpl)
    end
  end
end

function this:escHandle()
end

function this:close()
end

return this
