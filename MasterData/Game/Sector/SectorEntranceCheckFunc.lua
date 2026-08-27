local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local SectorEntranceCheckFunc = {
  [ActivityFrameEnum.eActivityType.SectorI] = function(actId, sectorId, actFrameData)
    if actFrameData ~= nil and actFrameData:IsActivityOpen() then
      return PlayerDataCenter.allActivitySectorIData:IsOpenSectorIEntrance()
    end
    return PlayerDataCenter.sectorStage:IsSectorUnlock(sectorId)
  end,
  [ActivityFrameEnum.eActivityType.HeroGrow] = function(actId, sectorId, actFrameData)
    if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroActivity) then
      return false
    end
    local heroGrowCfg = ConfigData.activity_hero[actId]
    local isChange = heroGrowCfg.rechallenge_stage == sectorId
    if isChange then
      return actFrameData ~= nil and actFrameData:IsActivityOpen() and not actFrameData:IsActivityRunningTimeout()
    end
    if actFrameData == nil or actFrameData:GetIsActivityFinished() then
      local actFrameId = ConfigData.activity.actTypeMapping[ActivityFrameEnum.eActivityType.HeroGrow][actId]
      if ConfigData.handbook_activity.handBookActFrameIdDic[actFrameId] == nil then
        return false
      end
      if ConfigData.game_config.heroDungeonSwitch then
        return true
      end
      local heroId = heroGrowCfg ~= nil and heroGrowCfg.hero_id or nil
      return heroId ~= nil and PlayerDataCenter:ContainsHeroData(heroId)
    end
    return actFrameData:GetCouldShowActivity()
  end
}
return SectorEntranceCheckFunc
