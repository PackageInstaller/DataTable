require("main_world")
_class("BattleRenderConfigComponent", Object)
BattleRenderConfigComponent = BattleRenderConfigComponent

function BattleRenderConfigComponent:Constructor(world)
  self._world = world
  self._battleRenderConfigCommand = nil
  self._isMatchStart = false
  self._deadPetList = {}
  self._innerStoryShowedData = {}
  self._deadMonsterShowBannerList = {}
  self._curWaveBoardCenter = nil
end

function BattleRenderConfigComponent:IsMatchStart()
  return self._isMatchStart
end

function BattleRenderConfigComponent:SetIsMatchStart(isMatchStart)
  self._isMatchStart = isMatchStart
end

function BattleRenderConfigComponent:Destructor()
end

function BattleRenderConfigComponent:Initialize()
end

function BattleRenderConfigComponent:SetRenderConfigCommand(cmd)
  self._battleRenderConfigCommand = cmd
end

function BattleRenderConfigComponent:HasRenderConfigCmd()
  return self._battleRenderConfigCommand ~= nil
end

function BattleRenderConfigComponent:ClearRenderConfigData()
  self._battleRenderConfigCommand = nil
end

function BattleRenderConfigComponent:GetCanPlaySkillSpineInBattle(spineName, petId)
  local skillPermission = self._world._contextInfo.preferenceSkillSpine
  local petList = self._world._contextInfo.preferenceSkillSpineLastPlayList
  local localDBKey = "SkillAnimationSettingKey"
  if skillPermission == SkillAnimationPermissionType.Open then
    return true
  elseif skillPermission == SkillAnimationPermissionType.Close then
    return false
  elseif skillPermission == SkillAnimationPermissionType.Once then
    if not petId then
      if Log.loglevel < ELogLevel.None then
        Log.exception("大招立绘指令没有填光灵ID，需要策划配置")
      end
      return false
    end
    if table.intable(petList, petId) then
      local skillKey = localDBKey .. petId
      table.removev(petList, petId)
      LocalDB.SetInt(skillKey, self._world._contextInfo.enterTime)
      return true
    else
      return false
    end
  end
  return false
end

function BattleRenderConfigComponent:AddInnerStoryShowed(showType, type, waveIndex, waveRoundNum)
  local storyShowedData = InnerStoryShowUpData:New(type, showType, waveIndex, waveRoundNum)
  table.insert(self._innerStoryShowedData, storyShowedData)
end

function BattleRenderConfigComponent:GetInnerStoryShowed()
  return self._innerStoryShowedData
end

function BattleRenderConfigComponent:IsMonsterShowBannerCurWave(monsterID)
  local wave = self:GetCurWaveIndex()
  if not self._deadMonsterShowBannerList[wave] then
    return false
  else
    local deadList = self._deadMonsterShowBannerList[wave]
    return table.icontains(deadList, monsterID)
  end
end

function BattleRenderConfigComponent:AddDeadMonsterShowBanner(monsterID)
  local wave = self:GetCurWaveIndex()
  if not self._deadMonsterShowBannerList[wave] then
    self._deadMonsterShowBannerList[wave] = {}
  end
  table.insert(self._deadMonsterShowBannerList[wave], monsterID)
end

function BattleRenderConfigComponent:AddDeadPet(templateID)
  if not self._deadPetList[templateID] then
    self._deadPetList[templateID] = true
  else
    Log.fatal("Pet Has Dead:", templateID)
  end
end

function BattleRenderConfigComponent:RemoveDeadPet(templateID)
  table.removev(self._deadPetList, templateID)
end

function BattleRenderConfigComponent:PetHasDead(templateID)
  if self._deadPetList[templateID] then
    return true
  else
    return false
  end
end

function BattleRenderConfigComponent:SetWaitInputAuroraTime(value)
  self._showAuroraTimeState = value
end

function BattleRenderConfigComponent:IsWaitInputAuroraTime()
  return self._showAuroraTimeState
end

function BattleRenderConfigComponent:SetReEnterAuroraTimePlayed(played)
  self._reEnterAuroraTimePlayed = played
end

function BattleRenderConfigComponent:IsReEnterAuroraTimePlayed()
  return self._reEnterAuroraTimePlayed
end

function BattleRenderConfigComponent:GetCurWaveBoardCenter()
  return self._curWaveBoardCenter
end

function BattleRenderConfigComponent:SetCurWaveBoardCenter(v3)
  self._curWaveBoardCenter = v3
end

function MainWorld:BattleRenderConfig()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.BattleRenderConfig)
end

function MainWorld:HasBattleRenderConfig()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.BattleRenderConfig) ~= nil
end

function MainWorld:AddBattleRenderConfig()
  local index = self.BW_UniqueComponentsEnum.BattleRenderConfig
  local component = BattleRenderConfigComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function MainWorld:RemoveBattleRenderConfig()
  if self:HasBattleRenderConfig() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.BattleRenderConfig, nil)
  end
end
