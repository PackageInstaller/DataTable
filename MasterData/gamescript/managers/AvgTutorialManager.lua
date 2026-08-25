local FeatureId = CommonDefine.FeatureId
local AvgTutorialManager, Super = System.NewClass("AvgTutorialManager", Manager)
local DEFAULT_VAL = 0

function AvgTutorialManager:ctor()
  Super.ctor(self)
  self.url2FeatureIdMap = {
    [Urls.CopyMainView] = FeatureId.MainCopy,
    [Urls.SummonPanel] = FeatureId.DrawCard,
    [Urls.MainShopPanel] = FeatureId.Shop,
    [Urls.TaskMainView] = FeatureId.Task,
    [Urls.MailView] = FeatureId.Mail,
    [Urls.AlchemyMainPanel] = FeatureId.ItemConversion,
    [Urls.BpMainView] = FeatureId.BattlePass,
    [Urls.SocialRelationMainPanel] = FeatureId.Friends,
    [Urls.TutorialMainView] = FeatureId.Tutorial,
    [Urls.ActivityMainPanel] = FeatureId.Activity,
    [Urls.MainPanelPVP] = FeatureId.PVP,
    [Urls.AbyssPanel] = FeatureId.AbyssChallenge,
    [Urls.DungeonsMainView] = FeatureId.DBGCopyGroup
  }
  self.activityType2FeatureIdMap = {}
end

function AvgTutorialManager:Awake(binder)
  Super.Awake(self)
  binder:BindEvent(EventMgr.Instance.AfterAddUIPanel, function(url)
    local panel = UIManager.Instance:GetWindow(url)
    if not panel then
      return
    end
    panel:LoadHideLowerLayerPanelCb(function()
      self:PlayTutorialAvgByUrl(url)
    end)
  end)
  binder:BindEvent(EventMgr.Instance.OnActivityCompOpened, function(activityType)
    local featureId = self.activityType2FeatureIdMap[activityType]
    if featureId then
      self:PlayTutorialAvgByFeatureId(featureId)
    end
  end)
end

function AvgTutorialManager:PlayTutorialAvgByFeatureId(featureId)
  local featureCfg = PlayerDataUtils.GetFeatureConfigByFeatureId(featureId)
  if not featureCfg then
    return
  end
  local storyId = featureCfg.StoryId
  if not storyId then
    return
  end
  self:_PlayTutorialAvg(CommonDefine.ClientDataMainKey.AVG_Feature, featureId, storyId)
end

function AvgTutorialManager:PlayTutorialAvgByKeyWord(storyId, keyWord)
  if not storyId or not keyWord then
    return
  end
  keyWord = tostring(keyWord)
  self:_PlayTutorialAvg(CommonDefine.ClientDataMainKey.AVG, keyWord, storyId)
end

function AvgTutorialManager:_PlayTutorialAvg(mainKey, saveKey, storyId)
  if self:CheckIsPlayed(mainKey, saveKey) then
    return
  end
  AvgStoryManager.Instance:StartStoryById(storyId)
  self:Set_SaveVal(mainKey, saveKey, 1)
end

function AvgTutorialManager:CheckIsPlayed(mainKey, saveKey)
  local saveVal = self:Get_SaveVal(mainKey, saveKey)
  return saveVal ~= DEFAULT_VAL
end

function AvgTutorialManager:PlayTutorialAvgByUrl(url)
  local featureId = self.url2FeatureIdMap[url]
  if not featureId then
    return
  end
  self:PlayTutorialAvgByFeatureId(featureId)
end

function AvgTutorialManager:CreateSaveKeyBySubStr(postStr, subStr)
  do return self.CreateSaveKeyByPostStr, self end
  return self.CreateSaveKeyByPostStr, self, subStr .. "_" .. postStr, "_", postStr
end

function AvgTutorialManager:Get_SaveVal(mainKey, saveKey)
  do return ClientDataUtils.GetData, mainKey, saveKey end
  return ClientDataUtils.GetData, mainKey, saveKey, 0
end

function AvgTutorialManager:Set_SaveVal(mainKey, saveKey, saveVal)
  ClientDataUtils.SetData(mainKey, saveKey, saveVal, true)
end

function AvgTutorialManager:OnDestroy()
  Super.OnDestroy(self)
end

return AvgTutorialManager
