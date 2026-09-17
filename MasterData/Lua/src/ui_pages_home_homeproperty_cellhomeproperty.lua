local this = class("cellHomeProperty", G_UIModuleBase)
local _TechTpl = L_GameTpl:getHomeTechnologyTpl()
local _TechnologyTreeTpl = L_GameTpl:getHomeTechnologyTreeTpl()
local _HomeBuffCountTpl = L_GameTpl:getHomeBuffCountTpl()
local _HomeTalentTpl = L_GameTpl:getHomeTalentTpl()

function this.bind()
  return {
    txt_desc = "",
    list_propertyTip = {
      moduleName = "pages/home/homeProperty/cellHomePropertyTip"
    },
    active_list_propertyTip = false,
    toggle_fold = false
  }
end

function this.methods()
  return {
    onClick_fold = function(self)
      self:_foldPropertyTipList()
    end
  }
end

function this:open(options)
  local buff = self.bind.buff
  local tpl = self.bind.countTpl
  if buff.buffValue > 0 then
    local descKey = _HomeBuffCountTpl:getDescKey(tpl)
    local valueStr = L_HomeBuffManager:getDisplayValue(buff.buffId, buff.buffValue, true)
    local conditions = buff.conditions
    if table.count(conditions) <= 1 then
      local targetNames = {}
      for conditionId, targetId in pairs(conditions or {}) do
        table.insert(targetNames, L_HomeBuffManager:getConditionTargetName(conditionId, targetId))
      end
      self.bind.txt_desc = L_Lang:get(descKey, {
        value = valueStr,
        name = targetNames[1]
      })
    else
      local para = {value = valueStr}
      for conditionId, targetId in pairs(conditions or {}) do
        para["name" .. conditionId] = L_HomeBuffManager:getConditionTargetName(conditionId, targetId)
      end
      self.bind.txt_desc = L_Lang:get(descKey, para)
    end
  end
  local sources = buff.buffSource
  local tmp = {}
  for _, source in ipairs(sources) do
    if not math.isEmpty(source.talentId) then
      local petId = L_PetStore:getPetItem(source.petGuid).petId
      local conf = L_ItemTplManager:getPetItem(petId)
      table.insert(tmp, {source = source, countTpl = tpl})
      if buff.buffValue == 0 then
        local talentId = source.talentId
        local talentTpl = _HomeTalentTpl:getTplById(talentId)
        self.bind.txt_desc = _HomeTalentTpl:getTalentDescription(talentTpl)
      end
    end
    if not math.isEmpty(source.techId) then
      local tpl_tech = _TechTpl:getTplById(source.techId)
      local treeId = _TechTpl:getType(tpl_tech)
      local treeTpl = _TechnologyTreeTpl:getTplById(treeId)
      table.insert(tmp, {source = source, countTpl = tpl})
      if buff.buffValue == 0 then
        self.bind.txt_desc = _TechTpl:getEffectDescription(tpl_tech)
      end
    end
  end
  self.bind.list_propertyTip:clear()
  self.bind.list_propertyTip:insert_array(tmp)
end

function this:_foldPropertyTipList()
  local willFold = not self.bind.active_list_propertyTip
  self.bind.active_list_propertyTip = willFold
  self.bind.toggle_fold = willFold
end

function this:onClosePropertyPanel()
  self.bind.active_list_propertyTip = false
  self.bind.toggle_fold = false
end

function this:close(options)
end

return this
