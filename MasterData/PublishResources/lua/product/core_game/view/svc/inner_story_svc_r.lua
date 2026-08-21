_class("InnerStoryService", BaseService)
InnerStoryService = InnerStoryService

function InnerStoryService:Constructor(world)
end

function InnerStoryService:CheckInnerStory(type, param, showType)
  local utilStatSvc = self._world:GetService("UtilData")
  local waveIndex = utilStatSvc:GetStatCurWaveIndex()
  local waveRoundNum = utilStatSvc:GetStatCurWaveRoundNum()
  local totalWaveRoundNum = utilStatSvc:GetStatCurWaveTotalRoundCount()
  if type == StoryShowType.WaveAndRoundBeginPlayerRound or type == StoryShowType.WaveAndRoundAfterPlayerRound or type == StoryShowType.WaveAndRoundBeginMonsterRound or type == StoryShowType.WaveAndRoundAfterMonsterRound then
    local tmpList = string.split(param, ",")
    if waveIndex == tonumber(tmpList[1]) and totalWaveRoundNum == tonumber(tmpList[2]) and not self:IsInnerStoryShowedInCurWaveAndCurRound(showType, type, waveIndex, waveRoundNum) then
      return true
    else
      return false
    end
  else
    return true
  end
end

function InnerStoryService:CheckMonsterShowAndDeadStoryBanner(type, monsterID)
  local cfgService = self._configService
  local levelConfigData = cfgService:GetLevelConfigData()
  local bannerParam = levelConfigData:GetLevelStoryBannerParam()
  for k, v in pairs(bannerParam) do
    if v:GetType() == type then
      if type == StoryShowType.AfterMonsterDead then
        local tmpList = string.split(v:GetParam(), ",")
        if tonumber(tmpList[1]) == monsterID and tonumber(tmpList[2]) == self:_GetBattleStatComponent():GetCurWaveIndex() then
          local bShow = true
          if not self:_GetBattleStatComponent():IsMonsterShowBannerCurWave(monsterID) then
            self:_GetBattleStatComponent():AddDeadMonsterShowBanner(monsterID)
          else
            bShow = false
          end
          if bShow then
            GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowStoryBanner, v:GetID(), v:GetShowType())
            Log.debug("Show Banner ID ", v:GetID(), "Type:", type)
            return true
          else
            return false
          end
        end
      elseif tonumber(v:GetParam()) == monsterID then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowStoryBanner, v:GetID(), v:GetShowType())
        Log.debug("Show Banner ID ", v:GetID(), "Type:", type)
      end
    end
  end
  return false
end

function InnerStoryService:CheckMonsterShowAndDeadStoryTips(type, monsterID, monsterEntityID)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local storyTips = monsterConfigData:GetStoryTips(monsterID)
  if not storyTips then
    return
  end
  for _, v in pairs(storyTips) do
    if v.Type == type then
      local tmpList = string.split(v.Param, ",")
      local rand = Mathf.Random(1, 100)
      if rand <= tonumber(tmpList[1]) then
        local index = Mathf.Random(2, #tmpList)
        self:DoMonsterStoryTips(monsterID, monsterEntityID, tonumber(tmpList[index]))
      end
    end
  end
end

function InnerStoryService:CheckStoryTips(type)
  local cfgService = self._configService
  local levelConfigData = cfgService:GetLevelConfigData()
  local tipsParam = levelConfigData:GetLevelStoryTipsParam()
  local utilStatSvc = self._world:GetService("UtilData")
  local waveIndex = utilStatSvc:GetStatCurWaveIndex()
  local waveRoundNum = utilStatSvc:GetStatCurWaveRoundNum()
  local battleRenderCmpt = self._world:BattleRenderConfig()
  for k, v in pairs(tipsParam) do
    if v:GetType() == type and self:CheckInnerStory(type, v:GetParam(), "tips") then
      battleRenderCmpt:AddInnerStoryShowed("tips", type, waveIndex, waveRoundNum)
      if v:GetSpeakerType() == StoryTipsSpeakerType.Pet then
        local entity = self._world:Player():GetLocalTeamEntity()
        local petPstID = entity:PetPstID():GetPstID()
        self:DoPetStoryTips(petPstID, entity, v:GetID())
      elseif v:GetSpeakerType() == StoryTipsSpeakerType.Monster then
        local monsterTemplateID = v:GetSpeakerMonsterID()
        local monsterEntity
        local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
        for _, e in ipairs(monsterGroup:GetEntities()) do
          if e:MonsterID():GetMonsterID() == monsterTemplateID then
            monsterEntity = e
            break
          end
        end
        self:DoMonsterStoryTips(v:GetSpeakerMonsterID(), monsterEntity:GetID(), v:GetID())
      end
    end
  end
end

function InnerStoryService:CheckStoryBanner(type)
  local cfgService = self._configService
  local levelConfigData = cfgService:GetLevelConfigData()
  local bannerParam = levelConfigData:GetLevelStoryBannerParam()
  local utilStatSvc = self._world:GetService("UtilData")
  local waveIndex = utilStatSvc:GetStatCurWaveIndex()
  local waveRoundNum = utilStatSvc:GetStatCurWaveRoundNum()
  local battleRenderCmpt = self._world:BattleRenderConfig()
  for k, v in pairs(bannerParam) do
    if v:GetType() == type and self:CheckInnerStory(type, v:GetParam(), "Banner") then
      battleRenderCmpt:AddInnerStoryShowed("Banner", type, waveIndex, waveRoundNum)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowStoryBanner, v:GetID(), v:GetShowType())
      Log.debug("Show Banner ID ", v:GetID(), "Type:", type)
      return true
    end
  end
  return false
end

function InnerStoryService:DoMonsterStoryTips(monsterTemplateID, monsterEntityID, tipsID)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local offset = monsterConfigData:GetStoryTipsOffset(monsterTemplateID)
  self:DoStoryTips(monsterEntityID, offset, tipsID)
end

function InnerStoryService:DoTrapStoryTips(trapTemplateID, tarpEntity, tipsID)
  if not tarpEntity then
    local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
    for _, e in ipairs(trapGroup:GetEntities()) do
      if e:TrapRender():GetTrapID() == trapTemplateID then
        tarpEntity = e
        break
      end
    end
  end
  if not tarpEntity then
    Log.fatal("MonsterEntity is Nil ", Log.traceback())
    return
  end
  local cfgService = self._configService
  local trapConfigData = cfgService:GetTrapConfigData()
  local offset = trapConfigData:GetStoryTipsOffset(trapTemplateID)
  self:DoStoryTips(tarpEntity:GetID(), offset, tipsID)
end

function InnerStoryService:DoPetStoryTips(petPstID, petEntity, tipsID)
  local petData = self._world:GetPetData(petPstID)
  local offset = petData:GetStoryTipsOffset()
  self:DoStoryTips(petEntity:GetID(), offset, tipsID)
end

function InnerStoryService:DoChessStoryTips(chessClassID, chessEntityID, tipsID)
  local cfgService = self._configService
  local chessPetConfigData = cfgService:GetChessPetConfigData()
  local offset = chessPetConfigData:GetTipsOffset(chessClassID)
  self:DoStoryTips(chessEntityID, offset, tipsID)
end

function InnerStoryService:DoStoryTips(entityID, offset, tipsID)
  local entityService = self._world:GetService("RenderEntity")
  local tipsEntity = entityService:CreateRenderEntity(EntityConfigIDRender.HeadStoryTips, false)
  tipsEntity:AddInnerStoryTipsComponent(entityID, offset, tipsID)
end

function InnerStoryService:IsInnerStoryShowedInCurWaveAndCurRound(showType, type, waveIndex, roundNum)
  local battleRenderCmpt = self._world:BattleRenderConfig()
  local showedData = battleRenderCmpt:GetInnerStoryShowed()
  for _, v in pairs(showedData) do
    if v:IsMe(type, showType, waveIndex, roundNum) then
      return true
    end
  end
  return false
end
