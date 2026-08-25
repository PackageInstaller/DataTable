local function createBattleAwakerDataModelState()
  local data = {}
  
  data.awaked = false
  return data
end

local function createBattleAwakerDataModelViews(_)
  local views = {}
  
  function views:GetProperty(property)
    return self.properties[property] or 0
  end
  
  function views:GetName()
    return self.configData.Name
  end
  
  function views:GetUid()
    return self.uid
  end
  
  function views:GetUltiSkillId()
    return self.ultiSkillId
  end
  
  function views:GetUltiSkillLevel()
    return self.ultiSkillLevel
  end
  
  function views:IsUltiEnergyEnough()
    local ultiEnergy = self:GetProperty(bc.BattleProperty.ulti_energy)
    local params = {
      ulti_energy_max = self:GetProperty(BP.ulti_energy_max) or 0,
      ulti_energy_cost_per = self:GetProperty("ulti_energy_cost_per") or 0,
      ulti_energy_cost_flat = self:GetProperty("ulti_energy_cost_flat") or 0,
      ulti_energy_max_per = self:GetProperty(BP.ulti_energy_max_per) or 0
    }
    local needEnergy = select(1, BattleSkillUtils.CalcSkillManiacMax(params))
    return ultiEnergy >= needEnergy
  end
  
  function views:IsUltiSkillSeal()
    local seal_ulti = self:GetProperty(bc.BattleProperty.seal_ulti) or 0
    local immue_seal_ulti = self:GetProperty(bc.BattleProperty.immue_seal_ulti) or 0
    if seal_ulti > 0 and immue_seal_ulti <= 0 then
      return true
    end
  end
  
  function views:GetSchoolConfigId()
    return self.configData.School
  end
  
  return views
end

local function createBattleAwakerDataModelActions(data)
  local actions = {}
  local DT = bg.DT
  
  function actions:InitData(awakerData, roleData)
    for k, v in pairs(awakerData) do
      data[k] = v
    end
    self.roleUid = roleData.uid
    self.properties = self.properties or {}
    if roleData.roleType == bc.RoleType.Monster then
      self.configData = DT.MonsterConfig[self.tid]
      self.isMonster = true
    else
      self.configData = DT.AwakerConfig[self.tid]
      self.isAwaker = true
    end
  end
  
  function actions:SetProperty(property, value)
    self.properties[property] = value
  end
  
  function actions:UpdateSkillArgs(args, descArgs)
    self.descArgs = descArgs
    self.skillArgs = args
  end
  
  function actions:SetAwaked(awaked)
    self.awaked = awaked
  end
  
  return actions
end

local function onSetup(_, _)
end

local BattleAwakerDataModel = Vue.model("BattleAwakerDataModel", createBattleAwakerDataModelState):views(createBattleAwakerDataModelViews):actions(createBattleAwakerDataModelActions):setup(onSetup)
return BattleAwakerDataModel
