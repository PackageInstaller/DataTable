local ActivityFrameUtil = class("ActivityFrameUtil")
local emptyString = ""

function ActivityFrameUtil.GetShowEndTimeStr(activityBase)
  local activityFrameId, endTime, destroyTime
  activityFrameId = 0
  local endTime = activityBase:GetActivityEndTime()
  local destroyTime = activityBase:GetActivityDestroyTime()
  if activityBase.GetActivityFrameId ~= nil then
    activityFrameId = activityBase:GetActivityFrameId()
  elseif activityBase.GetActFrameId ~= nil then
    activityFrameId = activityBase:GetActFrameId()
  end
  local activityCfg = ConfigData.activity[activityFrameId]
  if activityCfg ~= nil and activityCfg.cat == 4 then
    return ConfigData:GetTipContent(9606), emptyString, math.maxinteger
  end
  return ActivityFrameUtil.__GetShowEndTimeStr(activityFrameId, endTime, destroyTime)
end

function ActivityFrameUtil.__GetShowEndTimeStr(activityFrameId, endTime, destroyTime)
  local title = ""
  local timeStr = ""
  local expireTime = math.maxinteger
  if endTime > PlayerDataCenter.timestamp then
    expireTime = endTime
    title = ConfigData:GetTipContent(6036)
    timeStr = ConfigData:GetTipContent(6052)
  elseif destroyTime > PlayerDataCenter.timestamp then
    expireTime = destroyTime
    title = ConfigData:GetTipContent(6037)
    timeStr = ConfigData:GetTipContent(6052)
  else
    expireTime = destroyTime
    title = ConfigData:GetTipContent(6033)
  end
  expireTime = math.max(expireTime, 0)
  timeStr = TimeUtil:TimestampToDateString(expireTime, false, true, timeStr)
  return title, timeStr, expireTime
end

function ActivityFrameUtil.CombineShowEndTimeStr(title, timeStr)
  if string.IsNullOrEmpty(timeStr) then
    return title
  else
    return title .. ": " .. timeStr
  end
end

function ActivityFrameUtil.GetCountdownTimeStr(expireTime, isShotTitle)
  local timeStr = ""
  local diff = expireTime - PlayerDataCenter.timestamp
  if diff < 0 then
    timeStr = string.format(ConfigData:GetTipContent(6045), "0")
    return timeStr, diff
  end
  local d, h, m = TimeUtil:TimestampToTimeInter(diff, false, true)
  if 0 < d then
    local tip = isShotTitle and 9201 or 6043
    timeStr = string.format(ConfigData:GetTipContent(tip), tostring(d))
  elseif 0 < h then
    local tip = isShotTitle and 9202 or 6044
    timeStr = string.format(ConfigData:GetTipContent(tip), tostring(h))
  else
    local tip = isShotTitle and 9203 or 6045
    timeStr = string.format(ConfigData:GetTipContent(tip), tostring(m))
  end
  return timeStr, diff
end

function ActivityFrameUtil.CalActTechRedWithSpBranchAndItem(actBase, actTechTree, spBranch, itemCountLimit)
  if not actBase:IsActivityRunning() then
    return false
  end
  local flag = actTechTree:IsExsitCouldLvUpTechInBranch(spBranch)
  if flag or itemCountLimit == nil then
    return flag
  end
  local needItemRed, itemId = actTechTree:GetTreeResetReturnItemId()
  if not needItemRed or itemCountLimit > PlayerDataCenter:GetItemCount(itemId) then
    return flag
  end
  local treeDic = actTechTree:GetTechDataDic()
  for k, v in pairs(treeDic) do
    if k ~= spBranch and actTechTree:IsExsitCouldLvUpTechInBranch(k) then
      flag = true
      break
    end
  end
  return flag
end

function ActivityFrameUtil.GetSpecialReplaceCfg(activityId)
  local cfg = ConfigData.activity_general_special_replace[activityId]
  if cfg == nil then
    return nil
  end
  if CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
    return cfg
  end
  return nil
end

function ActivityFrameUtil.GetActivityRealPopId(actEntranceCfg)
  local cfg = ActivityFrameUtil.GetSpecialReplaceCfg(actEntranceCfg.activityId)
  if cfg == nil or cfg.new_login_popup == 0 then
    return actEntranceCfg.popup_id
  end
  return cfg.new_login_popup
end

function ActivityFrameUtil.GetActivityRealImageEntrance(actEntranceCfg)
  local cfg = ActivityFrameUtil.GetSpecialReplaceCfg(actEntranceCfg.activityId)
  if cfg == nil or string.IsNullOrEmpty(cfg.new_image_entrance) then
    return actEntranceCfg.image_entrance
  end
  return cfg.new_image_entrance
end

function ActivityFrameUtil.GetActivityRealEntranceLogoData(actEntranceCfg)
  local data = {}
  local cfg = ActivityFrameUtil.GetSpecialReplaceCfg(actEntranceCfg.activityId)
  if cfg == nil or string.IsNullOrEmpty(cfg.new_entrance_logo) then
    data.entranceLogo = actEntranceCfg.entrance_logo
    data.logoPosition = actEntranceCfg.logo_position
    data.logoSize = actEntranceCfg.logo_size
    return data
  end
  data.entranceLogo = cfg.new_entrance_logo
  data.logoPosition = cfg.new_logo_position
  data.logoSize = cfg.new_logo_size
  return data
end

function ActivityFrameUtil.GetActivityRealName(activityId)
  local cfg = ActivityFrameUtil.GetSpecialReplaceCfg(activityId)
  if cfg == nil then
    return nil
  end
  return cfg.new_name
end

return ActivityFrameUtil
