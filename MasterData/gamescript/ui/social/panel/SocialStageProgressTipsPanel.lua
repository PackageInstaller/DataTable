local StageGroupType = CommonDefine.StageGroupType
local INIT_HEIGHT = 55
local TITLE_HEIGHT = 52
local DETAIL_HEIGHT = 69
local SITUATIONTOP_HEIGHT = 16
local LINE_HEIGHT = 4
local StageGroupTab = {
  MainCopy = 1,
  DailyChallenge = 2,
  AbsysChallenge = 3,
  DisposableSchoolTower = 4
}
local SocialStageProgressTipsPanel, Super = System.NewClass("SocialStageProgressTipsPanel", UIBasePanel)
SocialStageProgressTipsPanel.uiResCls = UI_Social_Popup_Situation_TipsResource

function SocialStageProgressTipsPanel:ctor(achieveRecord)
  Super.ctor(self)
  self.schoolTowers = achieveRecord.schoolTower
  self.achieves = achieveRecord.achievement
  self.contentHeight = INIT_HEIGHT
end

function SocialStageProgressTipsPanel:OnBind(binder)
  self.binder = binder
  binder:BindUICustomInput(self.ui.uiNode, System.fn(self, self._OnCustomInput))
  binder:SetActive(self.ui.uiNode, false)
  self:_GenStageGroupViewData()
  self:_BindProgress(binder)
  self:_CalContentHeight()
  binder:BindTimer(0.02, 0, nil, function()
    binder:SetActive(self.ui.uiNode, true)
  end)
end

function SocialStageProgressTipsPanel:_OnCustomInput(hover)
  if not hover then
    self:Close()
  end
end

function SocialStageProgressTipsPanel:_GetMainCopyProgress(tid)
  local nameNumer = CopyDataUtils.GetStageNameNumber(tid)
  return nameNumer or "-"
end

function SocialStageProgressTipsPanel:_GetRankTitle(tid)
  local rankConfig = RankingBoardDataUtils.GetRankCfg(tid)
  if rankConfig then
    do return LT.Text end
    return LT.Text, rankConfig.Name
  end
end

function SocialStageProgressTipsPanel:_GetRankIcon(tid)
  local rankConfig = RankingBoardDataUtils.GetRankCfg(tid)
  if rankConfig then
    return rankConfig.RankIcon
  end
end

function SocialStageProgressTipsPanel:_BindProgress(binder)
  for index = 1, 4 do
    local data = self.progressData[index]
    local obj = self.ui["UI_Social_Item_Situation_" .. index]
    if not obj then
    else
      local ui = UI_Social_Item_SituationResource(obj)
      CS.Framework.TransformUtil.SetAnchoredPos(obj.transform, 0, self.contentHeight * -1)
      local situationConHeight = self.contentHeight
      local hasAchieves = data and data.achieves and #data.achieves > 0
      binder:SetActive(obj, hasAchieves)
      self.contentHeight = self.contentHeight + TITLE_HEIGHT + SITUATIONTOP_HEIGHT + LINE_HEIGHT
      if not hasAchieves then
      else
        binder:SetActive(ui.Image_Star_1, data.showStar)
        binder:UpdateLocalizedTextAndResouce(obj)
        binder:SetText(ui.Text_Name, data.title)
        local subTitle = data.subTitle
        if data.showStar then
          subTitle = data.star
        end
        binder:SetText(ui.Text_Creation, subTitle)
        self:_BindAchieveView(binder, ui, data.achieves)
        situationConHeight = self.contentHeight - situationConHeight
        self:_SetItemHeight(obj, situationConHeight)
      end
    end
  end
end

function SocialStageProgressTipsPanel:_BindAchieveView(binder, root, achieves)
  for index = 1, 4 do
    local data = achieves[index]
    local obj = root["UI_Social_Item_Detailed_" .. index]
    if not obj then
    else
      binder:SetActive(obj, nil ~= data)
      if not data then
      else
        local ui = UI_Social_Item_DetailedResource(obj)
        binder:SetText(ui.Text_Name, data.name)
        binder:SetActive(ui.Image_Star, data.showStar)
        local titleUI = UIUtils.GetUIByUINode(ui.Group_Title)
        binder:UpdateLocalizedTextAndResouce(obj)
        binder:SetActive(ui.Group_Title, data.showTitle)
        binder:SetActive(titleUI.TitleView, false)
        binder:SetActive(ui.Text_Stage, not data.showTitle)
        if data.showTitle then
          local titleText, titleIcon
          if data.valueFunc then
            titleText = data.valueFunc(self.achieves[data.key])
          end
          if data.iconFunc then
            titleIcon = data.iconFunc(self.achieves[data.key])
          end
          UIComDungeonsDivingTitle.BindByTitleData(binder, ui.Group_Title, {
            titleText = titleText,
            titleIcon = titleIcon,
            width = 200
          })
        else
          local achieveText = data.value or self.achieves[data.key]
          if data.valueFunc then
            achieveText = data.valueFunc(self.achieves[data.key])
          end
          binder:SetText(ui.Text_Stage, achieveText)
        end
        self.contentHeight = self.contentHeight + DETAIL_HEIGHT
        binder:SetActive(obj, true)
      end
    end
  end
end

function SocialStageProgressTipsPanel:_GenStageGroupViewData()
  self.progressData = {
    {
      title = "SocialSystemSurveyProgress",
      subTitle = "",
      sort = StageGroupTab.MainCopy,
      showStar = false,
      achieves = {
        {
          key = "Main1",
          name = "MainLinesSimple",
          valueFunc = System.fn(self, self._GetMainCopyProgress)
        },
        {
          key = "Main2",
          name = "MainLinesHard",
          valueFunc = System.fn(self, self._GetMainCopyProgress)
        },
        {
          key = "Main3",
          name = "SocialSystemMainLineMadness",
          valueFunc = System.fn(self, self._GetMainCopyProgress)
        }
      }
    },
    {
      title = "MainInterface_Btn_DailyChallenge",
      subTitle = "",
      sort = StageGroupTab.DailyChallenge,
      showStar = false,
      achieves = {
        {
          key = "DailyChallengeLifeMaxScore",
          name = "SocialSystemHighestRecord"
        },
        {
          key = "DailyChallengeRandCfgId",
          name = "SocialSystemHighestTitle",
          showTitle = true,
          iconFunc = System.fn(self, self._GetRankIcon),
          valueFunc = System.fn(self, self._GetRankTitle)
        }
      }
    },
    {
      title = "AbyssChallengeTitle",
      subTitle = "",
      sort = StageGroupTab.AbsysChallenge,
      showStar = false,
      achieves = {
        {
          key = "AbyssChallengeLifeMaxScore",
          name = "SocialSystemHighestRecord"
        }
      }
    },
    {
      title = "SocialSystemSchoolTowerGap",
      subTitle = "",
      sort = StageGroupTab.DisposableSchoolTower,
      showStar = true,
      star = 0,
      achieves = {}
    }
  }
  for stageGroupTid, star in pairs(self.schoolTowers) do
    local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
    if not stageGroupConfig then
    else
      local data = {
        name = LT.Text(stageGroupConfig.Name),
        showStar = true,
        value = star,
        sort = stageGroupConfig.BaseSortID
      }
      if stageGroupConfig.Type == StageGroupType.DisposableSchoolTower then
        local curStar = self.progressData[StageGroupTab.DisposableSchoolTower].star
        self.progressData[StageGroupTab.DisposableSchoolTower].star = curStar + star
        table.insert(self.progressData[StageGroupTab.DisposableSchoolTower].achieves, data)
      end
    end
  end
  
  local function _SortFunc(a, b)
    return a.sort < b.sort
  end
  
  table.sort(self.progressData[StageGroupTab.DisposableSchoolTower].achieves, _SortFunc)
  table.sort(self.progressData, _SortFunc)
end

function SocialStageProgressTipsPanel:_SetItemHeight(go, height)
  if not go then
    return
  end
  local sizeDelta = go.transform.sizeDelta
  local Vector2 = CS.UnityEngine.Vector2(0, 0)
  Vector2.x = sizeDelta.x
  Vector2.y = height
  go.transform.sizeDelta = Vector2
end

function SocialStageProgressTipsPanel:_CalContentHeight()
  self:_SetItemHeight(self.ui.Content.gameObject, self.contentHeight)
  self:_SetItemHeight(self.ui.Image_Bg.gameObject, self.contentHeight)
end

function SocialStageProgressTipsPanel:Close()
  Super.Close(self)
end

return SocialStageProgressTipsPanel
