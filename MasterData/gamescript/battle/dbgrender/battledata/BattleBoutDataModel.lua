local function createBattleBoutDataModelState()
  local data = {}
  
  data.isInit = false
  return data
end

local function createBattleBoutDataModelViews(data)
  local views = {}
  
  function views:GetExtraBout()
    return data.isExtraBout
  end
  
  function views:IsCamp1Bout()
    return self.camp == bc.BattleCamp.Camp1
  end
  
  function views:IsCamp1Action()
    if self.camp == bc.BattleCamp.Camp1 and self.phase == bc.BoutPhase.Action then
      return true
    end
  end
  
  function views:GetBoutDamage()
    return data.boutDamage
  end
  
  function views:GetStatsBoutDamage()
    return data.statsBoutDamage
  end
  
  return views
end

local function createBattleBoutDataModelActions(data)
  local actions = {}
  
  function actions:InitData(initData)
    data.isInit = true
    data.phase = bc.BoutPhase.None
    data.camp = bc.BattleCamp.None
    data.boutNumber = 0
    data.boutDamage = 0
    data.statsBoutDamage = 0
    data.isExtraBout = false
  end
  
  function actions:SetBoutCamp(camp)
    data.camp = camp
  end
  
  function actions:SetBoutPhase(phase)
    data.phase = phase
  end
  
  function actions:SetBoutDamage(damage)
    if 0 == damage then
      data.boutDamage = damage
      return
    end
    data.boutDamage = damage
  end
  
  function actions:SetStatsBoutDamage(damage)
    data.statsBoutDamage = damage
  end
  
  function actions:SetExtraBout(isExtraBout)
    data.isExtraBout = isExtraBout
  end
  
  function actions:SetBoutNumber(boutNumber)
    data.boutNumber = boutNumber
  end
  
  return actions
end

local function onSetup(binder, model)
end

local BattleBoutDataModel = Vue.model("BattleBoutDataModel", createBattleBoutDataModelState):views(createBattleBoutDataModelViews):actions(createBattleBoutDataModelActions):setup(onSetup)
return BattleBoutDataModel
