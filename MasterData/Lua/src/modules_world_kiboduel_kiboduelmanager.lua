local this = class("kiBoDuelManager", G_EventManagerBase)

function this:openTestKiBoDuel(levelId)
  local pets = {}
  local cfg = L_GameTpl:getKiboDuelTpl():getTplById(levelId)
  local kiboList = L_GameTpl:getKiboDuelTpl():getKiboList(cfg)
  local minimun = L_GameTpl:getKiboDuelTpl():getMinimumKibo(cfg)
  local levelType = L_GameTpl:getKiboDuelTpl():getLevelType(cfg)
  local count = 0
  if levelType == L_Const.kiBoDuelLevelType.mix or levelType == L_Const.kiBoDuelLevelType.system then
    for _, petId in ipairs(kiboList) do
      table.insert(pets, {id = petId, is_trial = true})
      count = count + 1
    end
  end
  if levelType == L_Const.kiBoDuelLevelType.mix or levelType == L_Const.kiBoDuelLevelType.player then
    local petItems = L_PetStore:getPetList()
    for _, v in pairs(petItems) do
      if minimun <= count then
        break
      end
      table.insert(pets, {
        id = v.guid,
        is_trial = false
      })
      count = count + 1
    end
  end
  local data = {
    slot = 1,
    pet_guids = pets,
    hero = 199000,
    hero_skills = L_PetDuelStore:getDefaultSkillInfos(levelId)
  }
  L_Net:sendMessage(MsgGenCode.CSProtoKiboDuelSetCurGroup, {u32 = 1}, function(rspData, errorCode)
    L_Net:sendMessage(MsgGenCode.CSProtoKiboDuelGroupInfoChange, data, function(rspData, errorCode)
      L_PetDuelStore:req_CSProtoKiboDuelStart(levelId)
    end)
  end)
end

return this
