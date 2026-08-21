_class("UIWorldBossLegendDan", UIController)
UIWorldBossLegendDan = UIWorldBossLegendDan

function UIWorldBossLegendDan:Constructor()
end

function UIWorldBossLegendDan:LoadDataOnEnter(TT, res, uiParams)
end

function UIWorldBossLegendDan:OnShow(uiParams)
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._btnAnywhere = self:GetUIComponent("RectTransform", "btnAnywhere")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._rewardContent = self:GetUIComponent("UISelectObjectPath", "rewardContent")
  self:AttachEvent(GameEventType.UIQuestWorldBossRest, self.OnUIQuestWorldBossRest)
  self:CreateReward()
  self:FlushReward()
end

function UIWorldBossLegendDan:OnHide()
end

function UIWorldBossLegendDan:BtnAnywhereOnClick(go)
  self:OutAnimation()
end

function UIWorldBossLegendDan:BtnCloseOnClick(go)
  self:OutAnimation()
end

function UIWorldBossLegendDan:CreateReward()
  local worldBossModule = self:GetModule(WorldBossModule)
  local worldBossData = worldBossModule.m_world_boss_data
  local cfgGroup = UIWorldBossHelper.GetWorldBossLegendDanGroup(worldBossData.boss_mission_id)
  self._dataRewardPool = {}
  for k, v in pairs(cfgGroup) do
    table.insert(self._dataRewardPool, v)
  end
  table.sort(self._dataRewardPool, function(a, b)
    return a.ID < b.ID
  end)
  self._widgetRewardPool = self._rewardContent:SpawnObjects("UIWorldBossLegendDanWidget", #self._dataRewardPool)
end

function UIWorldBossLegendDan:FlushReward()
  local idBegin = 1
  for k, v in pairs(self._dataRewardPool) do
    local ui = self._widgetRewardPool[k]
    ui:Flush(idBegin, v)
    idBegin = v.RankingLevel + 1
  end
end

function UIWorldBossLegendDan:OnUIQuestWorldBossRest()
  self:CloseDialog()
end

function UIWorldBossLegendDan:OutAnimation()
  local lockName = "UIWorldBossLegendDan:OutAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("UIWorldBossLegendDan_out")
    YIELD(TT, 433)
    self:UnLock(lockName)
    self:CloseDialog()
  end)
end

_class("UIWorldBossLegendDanWidget", UICustomWidget)
UIWorldBossLegendDanWidget = UIWorldBossLegendDanWidget

function UIWorldBossLegendDanWidget:Constructor()
end

function UIWorldBossLegendDanWidget:OnShow(uiParams)
  self._txtPosition = self:GetUIComponent("UILocalizationText", "txtPosition")
  self._loadBadgeIcon = self:GetUIComponent("RawImageLoader", "BadgeIcon")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIWorldBossLegendDanWidget:OnHide()
end

function UIWorldBossLegendDanWidget:Flush(idBegin, cfg)
  self._idBegin = idBegin
  self._cfg = cfg
  self._txtPosition:SetText(string.format("%d-%d", self._idBegin, self._cfg.RankingLevel))
  self._loadBadgeIcon:LoadImage(self._cfg.SimpleDanBadgeBase)
end

function UIWorldBossLegendDanWidget:PlayAnimation(animName)
  self._animation:Play(animName)
end
