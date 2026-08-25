local CareerLevelType2TitleDict = {
  [CareerLevelDefine.CareerLevelType.PvpPreBuilt] = LT.Text("PvpHistoryLevelViewTitle_PreBuild"),
  [CareerLevelDefine.CareerLevelType.PvpDraft] = LT.Text("PvpHistoryLevelViewTitle_Draft"),
  [CareerLevelDefine.CareerLevelType.DailyChallenge] = LT.Text("DailyHistoryLevelViewTitle_DailyChallenge"),
  [CareerLevelDefine.CareerLevelType.RailWay] = LT.Text("RailWayHistoryLevelViewTitle")
}
local CareerLevelType2ExpProgressLangKeyDict = {
  [CareerLevelDefine.CareerLevelType.PvpPreBuilt] = "PvpHistoryLevelViewTitle_PreBuild_ExpProgress",
  [CareerLevelDefine.CareerLevelType.PvpDraft] = "PvpHistoryLevelViewTitle_Draft_ExpProgress",
  [CareerLevelDefine.CareerLevelType.DailyChallenge] = "DailyHistoryLevelViewTitle_DailyChallenge_ExpProgress",
  [CareerLevelDefine.CareerLevelType.RailWay] = "RailHistoryLevelViewTitle_ExpProgress"
}
local TYPEOF_Slider = typeof(CS.UnityEngine.UI.Slider)
local PvpHistoryLevelView, Super = NewClass("PvpHistoryLevelView", BaseView)
PvpHistoryLevelView.uiResCls = UI_Pvp_Popup_TaskRewardResource

function PvpHistoryLevelView:ctor(type)
  Super.ctor(self)
  self.type = type
  self:_InitViewData()
end

function PvpHistoryLevelView:OnBuildView()
  self:_CreateRewardListView()
end

function PvpHistoryLevelView:OnEnterView()
  self:_UpdateViewData()
  self:_RefreshView()
  self:_DefaultJumpToTargetLevel()
  self:SetText(self.ui.Text_Title, CareerLevelType2TitleDict[self.type])
  self:SetImage(self.ui.Image_CG, CommonRes.PvpHistoryRewardTipsBg[self.type])
end

function PvpHistoryLevelView:_DefaultJumpToTargetLevel()
  local careerLevelMO = CareerLevelModel.Instance:GetCareerLevelMO(self.type)
  if careerLevelMO then
    local targetIdx = careerLevelMO:GetClaimedLevel()
    if self._rewardListView.isReady then
      local offset = self._rewardListView:GetOffsetByIndex(math.max(0, targetIdx - 4))
      self._rewardListView:SetOffset(offset, false)
    else
      function self._rewardListView.reloadFinishCallback()
        self._rewardListView.reloadFinishCallback = nil
        
        local offset = self._rewardListView:GetOffsetByIndex(math.max(0, targetIdx - 4))
        self._rewardListView:SetOffset(offset, false)
      end
    end
  end
end

function PvpHistoryLevelView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:BindEvent(EventMgr.Instance.OnGainAllPvpLevelReward, System.fn(self, self._OnGainAllPvpLevelReward))
  self:BindEvent(EventMgr.Instance.OnCareerLevelDataChanged, System.fn(self, self._OnCareerLevelDataChanged))
end

function PvpHistoryLevelView:_OnGainAllPvpLevelReward()
  self:_UpdateViewData()
  self:_RefreshView()
  if self.type == CareerLevelDefine.CareerLevelType.DailyChallenge then
    self:Notify(NotifyId.OnDailyChallengeLevelAwardGet)
  end
end

function PvpHistoryLevelView:_OnCareerLevelDataChanged()
  self:_UpdateViewData()
  self:_RefreshView()
end

function PvpHistoryLevelView:_InitViewData()
  self._careerCfgList = {}
end

function PvpHistoryLevelView:_UpdateViewData()
  local careerCfgList = CareerLevelCfgUtils.GetcfgListByType(self.type)
  self._careerCfgList = table.move(careerCfgList, 2, #careerCfgList, 1, self._careerCfgList)
end

function PvpHistoryLevelView:_GetExpProgress()
  local careerLevelMO = CareerLevelModel.Instance:GetCareerLevelMO(self.type)
  if not careerLevelMO then
    return 0, 0
  end
  local careerCfg = CareerLevelCfgUtils.GetCfgByParams(self.type, careerLevelMO:GetLevel())
  if not careerCfg then
    return 0, 0
  end
  return careerLevelMO:GetExp() or 0, careerCfg.Exp
end

function PvpHistoryLevelView:_RefreshView()
  local careerLevelMO = CareerLevelModel.Instance:GetCareerLevelMO(self.type)
  if not careerLevelMO then
    return
  end
  local langKey = CareerLevelType2ExpProgressLangKeyDict[self.type]
  self:SetText(self.ui.Text_Grade, careerLevelMO:GetLevel())
  if CareerLevelModel.Instance:IsMaxLevel(self.type) then
    self:SetText(self.ui.Text_Experience, LT.Textf(langKey, string.format("  %s", LT.Text("ExpFullTips"))))
  else
    local exp, maxExp = self:_GetExpProgress()
    self:SetText(self.ui.Text_Experience, LT.Textf(langKey, string.format("(%s/%s)", exp, maxExp)))
  end
  self:_RefreshSlider()
  self:_RefreshRewardListView()
end

function PvpHistoryLevelView:_RefreshRewardListView()
  self._rewardListView:ReloadData()
end

function PvpHistoryLevelView:_RefreshSlider()
  local exp, maxExp = self:_GetExpProgress()
  if CareerLevelModel.Instance:IsMaxLevel(self.type) then
    maxExp = 1
    exp = 1
  end
  self.sliderObj = self.ui.Slider_Schedule:GetComponent(TYPEOF_Slider)
  self.sliderObj.minValue = 0
  self.sliderObj.maxValue = maxExp
  self.sliderObj.value = exp
end

function PvpHistoryLevelView:_CreateRewardListView()
  self._rewardListView = self:CreateTableview(self.ui.ScrollView, function()
    return #self._careerCfgList
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.UI_Other_Item_Award)
    self:_FillRewardCell(cell, index)
    return cell
  end, function()
    return 263, 429
  end)
end

function PvpHistoryLevelView:_FillRewardCell(cell, index)
  self:AddViewComponentOnce(cell.gameObject, UICompPvpHistoryLevelItem, self._careerCfgList[index])
end

return PvpHistoryLevelView
