local CopyChapterDetailView, Super = NewClass("CopyChapterDetailView", BaseView)
CopyChapterDetailView.uiResCls = UI_Chapter_Popup_StageChapterResource

function CopyChapterDetailView:ctor(stageId)
  Super.ctor(self)
  self.stageId = stageId
end

function CopyChapterDetailView:RegisterNotifications()
end

function CopyChapterDetailView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Relic, System.fn(self, self._OnClickRelic))
end

function CopyChapterDetailView:OnEnterView()
  Super.OnEnterView(self)
  self:AddViewComponentOnce(self.ui.UI_Common_StageChapter, CopyChapterMvcItem, self.stageId, true)
  local nowPhase, curIndex, totalIndex = RailWayDataUtils.GetRailWayStageNow(self.stageId)
  self.binder:SetActive(self.ui.Group_Stage, nowPhase and curIndex and totalIndex)
  if nowPhase and curIndex and totalIndex then
    local isCrazy = RailWayDataUtils.IsMadnessDifficulty(self.stageId)
    local belongGroup = DT.Stage[self.stageId] and DT.Stage[self.stageId].BelongGroup
    local isSeasonSwitched = RailWayDataUtils.IsSeasonStageGroupSwitched(belongGroup)
    local langKey = isCrazy and TaskDataUtils.GetTimeReplaceLanguageKey("RailWayStageCrazyNowDescV2", isSeasonSwitched) or "RailWayStageNowDesc"
    self.binder:SetText(self.ui.Text_Stage, LT.Textf(langKey, nowPhase, curIndex))
    self.binder:SetText(self.ui.Text_C_Title, LT.Text("RailWayStageInformationTitle"))
  end
  self:SetText(self.ui.Text_Detail, self:GetStatesDesc())
  local relicList = MainCopyDataUtils.GetRelicGroups(self.stageId)
  self:SetActive(self.ui.Group_Relic, relicList and #relicList > 0)
end

function CopyChapterDetailView:OnExitView()
  Super.OnExitView(self)
end

function CopyChapterDetailView:GetStatesDesc()
  local stateList = CopyDataUtils.GetStageChapterState(self.stageId)
  local stageDescList = {}
  for _, stateId in ipairs(stateList) do
    local stateCfg = DT.State[stateId]
    local stateName = LT.Text(stateCfg and stateCfg.Name or "")
    local stateDesc = LT.Text(stateCfg and stateCfg.Desc or "")
    local lineBreakCount = 0
    stateDesc = stateDesc:gsub("\n", function()
      lineBreakCount = lineBreakCount + 1
      if 1 == lineBreakCount then
        return "\n"
      else
        return [[


]]
      end
    end)
    local stateDescFormated = string.format("<color=#E1E1E1><size=32>%s</size></color>", stateDesc)
    table.insert(stageDescList, string.format(LT.Text("StageInitialStateContent"), stateName, stateDescFormated))
  end
  do return table.concat, stageDescList end
  return table.concat, stageDescList, [[



]], ipairs(stateList)
end

function CopyChapterDetailView:_OnClickRelic()
  UIManager.Instance:Reopen(Urls.MainCopyRelicGroupPanel, self.stageId)
end

return CopyChapterDetailView
