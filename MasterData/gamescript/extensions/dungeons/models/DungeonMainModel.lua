local DBGEntryPage = CommonDefine.DBGEntryPage
local DungeonMainModel, Super = NewClass("DungeonMainModel", BaseModel)

function DungeonMainModel:OnReset()
  self.curDBGEntryPage = DBGEntryPage.MaterialPanel
end

function DungeonMainModel:OnInit()
  self:OnReset()
end

function DungeonMainModel:SetCurDBGEntryPage(curDBGEntryPage)
  if self.curDBGEntryPage == curDBGEntryPage then
    return
  end
  self.curDBGEntryPage = curDBGEntryPage or DBGEntryPage.MaterialPanel
  self:LocalNotify(NotifyId.OnDungeonEntryPageChanged, self.curDBGEntryPage)
  EventMgr.Instance.OnDungeonEntryPageChanged:Dispatch(self.curDBGEntryPage)
end

function DungeonMainModel:GetCurDBGEntryPage()
  return self.curDBGEntryPage
end

function DungeonMainModel:GetDBGEntryPageTitle(entryPage)
  local langId
  if entryPage == CommonDefine.DBGEntryPage.MaterialPanel then
    langId = "MainInterface_Btn_DailyCopy"
  elseif entryPage == CommonDefine.DBGEntryPage.TrinketPanel then
    langId = "MainInterface_Btn_TrinketCopy"
  elseif entryPage == CommonDefine.DBGEntryPage.DailyChallengePanel then
    langId = "MainInterface_Btn_DailyChallenge"
  elseif entryPage == CommonDefine.DBGEntryPage.WeekBossPanel then
    langId = "MainInterface_Btn_BOSS"
  elseif entryPage == CommonDefine.DBGEntryPage.SchoolTowerPanel then
    langId = "MainInterface_Btn_WeekChallenge"
  elseif entryPage == CommonDefine.DBGEntryPage.MockPanel then
    langId = "MockDungeonTitle"
  elseif entryPage == CommonDefine.DBGEntryPage.Abyss then
    langId = "AbyssChallengeTitle"
  elseif entryPage == CommonDefine.DBGEntryPage.AwakerTrial then
    langId = "FreeTrialTitle"
  elseif entryPage == CommonDefine.DBGEntryPage.SendPanel then
    langId = "MainInterface_Btn_Send"
  end
  do return LT.Text, langId end
  return LT.Text, langId, true
end

return DungeonMainModel
