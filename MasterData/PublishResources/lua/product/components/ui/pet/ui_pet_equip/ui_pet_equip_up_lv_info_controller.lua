_class("UIPetEquipUpLvInfoController", UIController)
UIPetEquipUpLvInfoController = UIPetEquipUpLvInfoController

function UIPetEquipUpLvInfoController:Constructor()
  self._petModule = self:GetModule(PetModule)
end

function UIPetEquipUpLvInfoController:OnShow(uiParams)
  self:_GetComponents()
  self._petInfo = uiParams[1]
  self._equipLv = uiParams[2]
  self._skillID = uiParams[3]
  self:_OnValue()
end

function UIPetEquipUpLvInfoController:_GetComponents()
  self._skillGo = self:GetGameObject("skill")
  self._attGo = self:GetGameObject("att")
  self._skillPool = self:GetUIComponent("UISelectObjectPath", "skillPool")
  self._attPool = self:GetUIComponent("UISelectObjectPath", "attPool")
end

function UIPetEquipUpLvInfoController:_OnValue()
  self._skillGo:SetActive(self._skillID ~= nil)
  self._attGo:SetActive(self._skillID == nil)
  if self._skillID then
    self:_ShowSkillInfos()
  else
    self:_ShowAttInfos()
  end
end

function UIPetEquipUpLvInfoController:_ShowSkillInfos()
  local skillData = self:_CreateSkillData()
  local spawnCount = #skillData
  self._skillPool:SpawnObjects("UIPetEquipUpLvInfoSkillItem", spawnCount)
  local items = self._skillPool:GetAllSpawnList()
  for i = 1, #items do
    local item = items[i]
    item:SetData(skillData[i])
  end
end

function UIPetEquipUpLvInfoController:_CreateSkillData()
  local data = {}
  local cfg_equip = Cfg.cfg_pet_equip({
    PetID = self._petInfo:GetTemplateID()
  })
  if not cfg_equip then
    Log.fatal("###[UIPetEquipUpLvInfoController] cfg_equip is nil ! id --> ", self._petInfo:GetTemplateID())
  end
  for i = 1, #cfg_equip do
    local cfgData = cfg_equip[i]
    if cfgData.IsParamImprove and cfgData.IsParamImprove == 1 then
      local skillDataCls = UIEquipUpLvSkillCls:New()
      local lv = cfgData.Level
      local desc = self:_GetEquipSkillDesc(lv)
      skillDataCls:SetData(lv, desc)
      data[#data + 1] = skillDataCls
    end
  end
  table.sort(data, function(a, b)
    return a._lv < b._lv
  end)
  return data
end

function UIPetEquipUpLvInfoController:_GetEquipSkillDesc(lv)
  local skillID = self._petInfo:GetPetPassiveSkill()
  local cfg = BattleSkillCfg(skillID)
  if cfg then
    local skillTypeTex = "str_pet_config_skill_equip"
    local skillIcon = cfg.Icon
    local skillName = cfg.Name
    local descStr = HelperProxy:GetInstance():GetEquipSkillDesc(cfg.Desc, self._petInfo:GetTemplateID(), lv, skillID)
    return descStr
  end
end

function UIPetEquipUpLvInfoController:_ShowAttInfos()
  local attData = self:_CreateAttData()
  local spawnCount = #attData
  self._attPool:SpawnObjects("UIPetEquipUpLvInfoAttItem", spawnCount)
  local items = self._attPool:GetAllSpawnList()
  for i = 1, #items do
    local item = items[i]
    item:SetData(attData[i], self._petInfo:GetPetFirstElement())
  end
end

function UIPetEquipUpLvInfoController:_CreateAttData()
  local data = {}
  local cfg_equip = Cfg.cfg_pet_equip({
    PetID = self._petInfo:GetTemplateID()
  })
  if not cfg_equip then
    Log.fatal("###[UIPetEquipUpLvInfoController] cfg_equip is nil ! id --> ", self._petInfo:GetTemplateID())
  end
  table.sort(cfg_equip, function(a, b)
    return a.Level < b.Level
  end)
  for i = 1, #cfg_equip do
    local cfgData = cfg_equip[i]
    if 1 < cfgData.Level then
      local cfgDataLast = cfg_equip[i - 1]
      local addPro = cfgData.PropertyRestraint - cfgDataLast.PropertyRestraint
      local addAtk = cfgData.Attack - cfgDataLast.Attack
      local addDef = cfgData.Defence - cfgDataLast.Defence
      local addHp = cfgData.Health - cfgDataLast.Health
      if addPro ~= 0 or addAtk ~= 0 or addDef ~= 0 or addHp ~= 0 then
        local attDataCls = UIEquipUpLvAttCls:New()
        local lv = cfgData.Level
        attDataCls:SetData(lv, addPro, addAtk, addDef, addHp)
        data[#data + 1] = attDataCls
      end
    end
  end
  table.sort(data, function(a, b)
    return a._lv < b._lv
  end)
  return data
end

function UIPetEquipUpLvInfoController:OnHide()
end

function UIPetEquipUpLvInfoController:bgOnClick()
  self:CloseDialog()
end

_class("UIEquipUpLvSkillCls", Object)
UIEquipUpLvSkillCls = UIEquipUpLvSkillCls

function UIEquipUpLvSkillCls:Constructor()
  self._lv = 0
  self._desc = ""
end

function UIEquipUpLvSkillCls:SetData(lv, desc)
  self._lv = lv
  self._desc = desc
end

function UIEquipUpLvSkillCls:GetData()
  return self._lv, self._desc
end

_class("UIEquipUpLvAttCls", Object)
UIEquipUpLvAttCls = UIEquipUpLvAttCls

function UIEquipUpLvAttCls:Constructor()
  self._lv = 0
  self._elem = 0
  self._atk = 0
  self._def = 0
  self._hp = 0
end

function UIEquipUpLvAttCls:SetData(lv, elem, atk, def, hp)
  self._lv = lv
  self._elem = elem
  self._atk = atk
  self._def = def
  self._hp = hp
end

function UIEquipUpLvAttCls:GetData()
  return self._lv, self._elem, self._atk, self._def, self._hp
end
