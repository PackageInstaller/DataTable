local RedAttrType = RedPointDataUtils.RedAttrType
local TaskServerIndex = CommonDefine.TaskServerIndex
local ResearchUtils = {}
ResearchUtils.FeatureKeyMap = {
  [CommonDefine.FeatureId.Task] = {
    [TaskServerIndex.Appoint] = {
      callFunc = function()
        TaskDataUtils.OpenDispatchPanel()
      end,
      redFunc = TaskDataUtils.AppointTaskRedFunc,
      redRemoveData = {
        RedPointDataUtils.RedType.Task,
        RedAttrType.IsNew,
        CommonDefine.TaskServerIndex.Appoint
      }
    }
  }
}
ResearchUtils.FeatureMap = {
  [CommonDefine.FeatureId.SpecialSkillList] = {
    callFunc = function()
      UIManager.Instance:Reopen(Urls.AwakerTalentPanel)
    end,
    redType = CommonDefine.RedDotType.Dot,
    redFunc = TalentDataUtils.TalentResearchItemShowRed
  },
  [CommonDefine.FeatureId.ItemConversion] = {
    callFunc = function()
      UIManager.Instance:Reopen(Urls.AlchemyMainPanel)
    end,
    redFunc = RedPointDataUtils.IsShowNewItemConversion,
    redRemoveData = {
      RedPointDataUtils.RedType.ItemConversion,
      RedAttrType.IsNew
    }
  },
  [CommonDefine.FeatureId.Manual] = {},
  [CommonDefine.FeatureId.Friends] = {},
  [CommonDefine.FeatureId.Arena] = {},
  [CommonDefine.FeatureId.Guild] = {}
}

function ResearchUtils.GetFeatureData(featureId, key)
  if not key then
    return ResearchUtils.FeatureMap[featureId]
  end
  return ResearchUtils.FeatureKeyMap[featureId][key]
end

function ResearchUtils.GetResearchRedPoint()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Home, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local tRedData = {}
  local result = false
  for _, featureData in pairs(ResearchUtils.FeatureMap) do
    local redFunc = featureData.redFunc
    local redType = featureData.redType
    if redFunc then
      tRedData = ResearchUtils.HandleRedFunc(featureData, redType, tRedData)
    end
  end
  for _, subFeatrueData in pairs(ResearchUtils.FeatureKeyMap) do
    for _, featureData in pairs(subFeatrueData) do
      local redFunc = featureData.redFunc
      local redType = featureData.redType
      if redFunc then
        tRedData = ResearchUtils.HandleRedFunc(featureData, redType, tRedData)
      end
    end
  end
  if tRedData[RedAttrType.IsNew] then
    return RedAttrType.IsNew
  elseif tRedData[RedAttrType.Red] then
    return RedAttrType.Red
  elseif tRedData[RedAttrType.Num] then
    return tRedData[RedAttrType.Num]
  end
  return result
end

function ResearchUtils.HandleRedFunc(featureData, redType, tRedData)
  local ret = featureData.redFunc()
  if nil == redType then
    if ret == RedAttrType.IsNew then
      tRedData[RedAttrType.IsNew] = true
    elseif ret == RedAttrType.Red then
      tRedData[RedAttrType.Red] = true
    elseif type(ret) == "number" then
      local curNum = tRedData[RedAttrType.Num] or 0
      if ret > curNum then
        tRedData[RedAttrType.Num] = ret
      end
    end
  elseif redType == CommonDefine.RedDotType.TextNew and true == ret then
    tRedData[RedAttrType.IsNew] = true
  elseif redType == CommonDefine.RedDotType.Dot and true == ret then
    tRedData[RedAttrType.Red] = true
  end
  return tRedData
end

return ResearchUtils
