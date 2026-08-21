_class("LuckLandInnerGameHelper", Singleton)
LuckLandInnerGameHelper = LuckLandInnerGameHelper

function LuckLandInnerGameHelper:Constructor()
end

function LuckLandInnerGameHelper:Dispose()
end

function LuckLandInnerGameHelper.GetConfigMng()
  return LLConfigMng:GetInstance()
end

function LuckLandInnerGameHelper.GetPetConfigData(ID)
  return LuckLandInnerGameHelper.GetConfigMng():GetPetConfigData(ID)
end

function LuckLandInnerGameHelper.GetMonsterConfigData(ID)
  return LuckLandInnerGameHelper.GetConfigMng():GetMonsterConfigData(ID)
end

function LuckLandInnerGameHelper.GetBuildingConfigData(ID)
  return LuckLandInnerGameHelper.GetConfigMng():GetBuildingConfigData(ID)
end

function LuckLandInnerGameHelper.GetLuckLandGameModule()
  return GameGlobal:GetLuckLandModule()
end

function LuckLandInnerGameHelper.GetFightPetData()
end

function LuckLandInnerGameHelper.GetEntityMgr()
  local module = GameGlobal:GetLuckLandModule()
  if module then
    return module:GetEntityMng()
  end
end

function LuckLandInnerGameHelper.GetBackpackPetData()
  local module = GameGlobal:GetLuckLandModule()
  if module then
    local mgr = module:GetEntityMng()
    return mgr:GetBackpackPets()
  end
end

function LuckLandInnerGameHelper.GetBackpackPetDataByID(id)
  local module = GameGlobal:GetLuckLandModule()
  if module then
    local mgr = module:GetEntityMng()
    return mgr:GetPetByID(id)
  end
end

function LuckLandInnerGameHelper.GetBackpackPetsDataByTemplateID(templateID)
  local module = GameGlobal:GetLuckLandModule()
  if module then
    local mgr = module:GetEntityMng()
    return mgr:GetPetsByTemplateID(templateID)
  end
end

function LuckLandInnerGameHelper.GetFightPetsDataByTemplateID(templateID)
  local module = GameGlobal:GetLuckLandModule()
  if module then
    local mgr = module:GetEntityMng()
    return mgr:GetFightPetsByTemplateID(templateID)
  end
end

function LuckLandInnerGameHelper.GetFightMonsterData()
  local module = GameGlobal:GetLuckLandModule()
  if module then
    local entityMng = module:GetEntityMng()
    return entityMng:GetFightMonsters()
  end
end

function LuckLandInnerGameHelper.GetNextMonster()
  local module = GameGlobal:GetLuckLandModule()
  if module then
    local entityMng = module:GetEntityMng()
    return entityMng:GetNextMonsters()
  end
end

function LuckLandInnerGameHelper.GetLeftMonstersCount()
  local module = GameGlobal:GetLuckLandModule()
  if module then
    local entityMng = module:GetEntityMng()
    return entityMng:GetLeftMonstersCount()
  end
end

function LuckLandInnerGameHelper.GetBuildingData()
end

function LuckLandInnerGameHelper.GetLuckLandBaseData()
end

function LuckLandInnerGameHelper.GetCurRoundCount()
  local module = GameGlobal:GetLuckLandModule()
  return module:GetCurRoundCount()
end

function LuckLandInnerGameHelper.GetRoundRes()
  local module = GameGlobal:GetLuckLandModule()
  return module:GetRoundProduction()
end

function LuckLandInnerGameHelper.GetCurHP()
  local module = GameGlobal:GetLuckLandModule()
  return module:GetCurHP()
end

function LuckLandInnerGameHelper.GetCurMoney()
  local module = GameGlobal:GetLuckLandModule()
  return module:GetGold()
end

function LuckLandInnerGameHelper.CanCostMoney(money)
  local module = GameGlobal:GetLuckLandModule()
  if money <= module:GetGold() then
    return true
  else
    return false
  end
end

function LuckLandInnerGameHelper.CostMoney(money)
  local module = GameGlobal:GetLuckLandModule()
  module:CostGold(money)
end

function LuckLandInnerGameHelper.ResetReDrawCount()
  local module = GameGlobal:GetLuckLandModule()
  module:ResetReDrawCount()
end

function LuckLandInnerGameHelper.GetReDrawCost()
  local module = GameGlobal:GetLuckLandModule()
  return module:GetReDrawCost()
end

function LuckLandInnerGameHelper.GetDeleteCardCost()
  local module = GameGlobal:GetLuckLandModule()
  return module:GetDeleteCardCost()
end

function LuckLandInnerGameHelper.GetDelCardCount()
  local module = GameGlobal:GetLuckLandModule()
  return module:GetDelCardCount()
end

function LuckLandInnerGameHelper.CheckWord(word)
  local module = GameGlobal:GetLuckLandModule()
  local words = module:GetWords()
  if words == nil or #words == 0 then
    return false
  end
  for i = 1, #words do
    local single = words[i]
    if single == word then
      return true
    end
  end
  return false
end

function LuckLandInnerGameHelper.GetWordIDs()
  local module = GameGlobal:GetLuckLandModule()
  local words = module:GetWords()
  return words
end

function LuckLandInnerGameHelper.GetBuildingsData()
  local module = GameGlobal:GetLuckLandModule()
  return module:GetAllBuildings()
end
