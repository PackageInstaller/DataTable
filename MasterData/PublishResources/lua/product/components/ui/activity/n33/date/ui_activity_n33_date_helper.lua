_class("UIActivityN33DateHelper", Object)
UIActivityN33DateHelper = UIActivityN33DateHelper

function UIActivityN33DateHelper:Constructor()
end

function UIActivityN33DateHelper.CheckFirstStoryIsPlay()
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local txt = "UIActivityN33DateHelper.CheckFirstStoryPlay" .. open_id
  local num = LocalDB.GetInt(txt)
  if num ~= 1 then
    return false
  end
  return true
end

function UIActivityN33DateHelper.CancelFirstStoryPlay()
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local txt = "UIActivityN33DateHelper.CheckFirstStoryPlay" .. open_id
  LocalDB.SetInt(txt, 1)
end

function UIActivityN33DateHelper.GetDateStatus(campaign)
  if not campaign then
    return false, false, 0
  end
  local comp = campaign:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION)
  local compInfo = campaign:GetComponentInfo(ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION)
  if not compInfo then
    return false, false, 0
  end
  local closeTime = comp.m_component_info.m_close_time
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if closeTime < curTime then
    return false, false, 0
  end
  local isNew = not UIActivityN33DateHelper.CheckFirstStoryIsPlay()
  local canReceive = false
  local allFullLevel = true
  local storyNum = 0
  if table.count(compInfo.arch_infos) == 0 then
    return false, false, 0
  end
  for _, v in pairs(compInfo.arch_infos) do
    allFullLevel = allFullLevel and v.level == 4
    local cfg = Cfg.cfg_component_simulation_operation({
      ArchitectureId = v.arch_id,
      Level = v.level
    })[1]
    if v.coin_num + v.default_coin >= cfg.LimitNum * 0.5 then
      canReceive = true
      break
    end
  end
  if allFullLevel then
  end
  local cfgs = Cfg.cfg_component_simulation_operation_story({})
  for _, storyCfg in pairs(cfgs) do
    if not table.icontains(compInfo.story_list, storyCfg.ID) then
      local buildConditions = storyCfg.PreCondition
      local storyConditions = storyCfg.PreStory
      local isStoryOver = true
      if storyConditions then
        for _, v in pairs(storyConditions) do
          local isInvited = table.icontains(compInfo.story_list, v)
          if not isInvited then
            isStoryOver = false
            break
          end
        end
      end
      local isBuildOver = true
      if buildConditions then
        for _, v in pairs(buildConditions) do
          local id = v[1]
          local needLevel = v[2]
          local isGetTargetLevel = needLevel <= compInfo.arch_infos[id].level
          if not isGetTargetLevel then
            isBuildOver = false
            break
          end
        end
      end
      if isStoryOver and isBuildOver and buildConditions then
        storyNum = storyNum + 1
      end
    end
  end
  return isNew, canReceive, storyNum
end

function UIActivityN33DateHelper.GetDateBuildLvel(campaign, buildID)
  local comp = campaign:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION)
  local compInfo = campaign:GetComponentInfo(ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION)
  if table.count(compInfo.arch_infos) < 1 then
    return 1
  end
  return compInfo.arch_infos[buildID].level
end

function UIActivityN33DateHelper.CheckDateOpen(campaign)
  local compInfo = campaign:GetComponentInfo(ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION)
  if table.count(compInfo.arch_infos) < 1 then
    return false
  end
  return true
end
