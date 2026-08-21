require("base_ins_r")
_class("PlayCasterChangeToMonsterInstruction", BaseInstruction)
PlayCasterChangeToMonsterInstruction = PlayCasterChangeToMonsterInstruction

function PlayCasterChangeToMonsterInstruction:Constructor(paramList)
  self._monsterID = tonumber(paramList.monsterID)
end

function PlayCasterChangeToMonsterInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local configService = world:GetService("Config")
  local resPath = configService:GetMonsterConfigData():GetMonsterResPath(self._monsterID)
  casterEntity:ReplaceAsset(NativeUnityPrefabAsset:New(resPath, true))
  casterEntity:SetLocation(casterEntity:GetGridPosition() + casterEntity:GetGridOffset(), casterEntity:GetGridDirection())
  local sMonsterShowRender = world:GetService("MonsterShowRender")
  sMonsterShowRender:CreateMonsterEffect(casterEntity, self._monsterID)
end
