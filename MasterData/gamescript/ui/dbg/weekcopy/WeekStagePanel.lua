local UIBasePanel = require("Managers.UI.UIBasePanel")
local Panel_Resource = require("UI.UIPackages.UI_Dungeous_Weekly_DifficultyResource")
local System = require("System.System")
local CommonDefine = require("World.Enums.CommonDefine")
local WeekStageModel = require("Model.WeekCopy.WeekStageModel")
local EventMgr = require("Managers.EventManager.EventMgr")
local UIManager = require("Managers.UI.UIManager")
local Urls = require("Managers.UI.Urls")
local DT = require("System.DataTable")
local DataCenter = require("Data.DataCenter")
local ProtoManager = require("Net.ProtoManager")
local PlayerDataUtils = require("Data.PlayerDataUtils")
local WorldStageManager = require("Managers.WorldStage.WorldStageManager")
local Alert = require("System.Alert")
local LT = require("System.LangTable")
local BtnCloseItem = require("UI.Public.Button.BtnCloseItem")
local CopyDataUtils = require("Data.CopyDataUtils")
local WeekStagePanel, Super = System.NewClass("WeekStagePanel", UIBasePanel)
WeekStagePanel.uiResCls = Panel_Resource

function WeekStagePanel:ctor(copyTid)
  Super.ctor(self)
  self.copyTid = copyTid
  self.starData = Vue.reactive({star = 0})
end

function WeekStagePanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(WeekStageModel, self.copyTid)
  binder:BindEvent(EventMgr.Instance.StageUIEvent, System.fn(self, self.OnEvent))
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:Close()
  end))
  self:BindImage()
  self:BindText()
  self:BindButton()
  self:BindListView()
  self:BindVisible()
  self:BindRecommendSchool()
  binder:BindComponent(require("UI.Common.StageStarComponent")(self.ui.Group_Star, self.starData))
  binder:BindToRaw(function(_, monsterTid)
    if monsterTid and self.monsterTipItem then
      self.monsterTipItem:SetMonsterTid(monsterTid)
    end
  end, function()
    return self.model.curMonsterTid
  end)
  binder:BindToRaw(function(_, new)
    self.starData.star = new[2]
    self.starData.stageTid = new[1]
  end, function()
    local stageTid = self.model:GetCurStageTid()
    local star = self.model:GetStageStar(stageTid)
    return {stageTid, star}
  end)
  ProtoManager.Instance:ReqServer("GameRequest", "OnChooseWeekChallengeStageGroup", function(data)
    DataCenter.copyData.weekStage[data.groupTid] = data
    if not self.ui or IsNil(self.ui.uiNode) then
      return
    end
    local defaultStage = self.model:GetSelectStage()
    local defaultStageTid = defaultStage.ID
    self.model:SetCurStageTid(defaultStageTid)
    self.monsterTipItem = binder:BindComponent(require("UI.MainCopy.Item.MainCopyMonsterDetailItem")(self.ui.UI_Chapter_Popup_Blame_Tip, self.model:GetCurStageTid(), self.model.curMonsterTid))
    self:BindRelic()
  end, function()
  end, self.copyTid)
  self:ListViewAnimPlay()
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, function()
    local title = LT.Text("WeekChallengeRulesOfPlay")
    local detail = LT.Text("WeekChallengeInstructions")
    UIManager.Instance:Reopen(Urls.CommonillustrateView, title, detail)
  end)
  binder:BindToRaw(function(_, new)
    if new and self.monsterTipItem then
      self.monsterTipItem:SetStageTid(new)
    end
  end, function()
    do return self.model.GetCurStageTid end
    return self.model.GetCurStageTid, self.model
  end)
end

function WeekStagePanel:_OnClickRelicGroup()
  local stageTid = self.model:GetCurStageTid()
  UIManager.Instance:Reopen(Urls.MainCopyRelicGroupPanel, stageTid)
end

function WeekStagePanel:BindImage()
  self.binder:BindToImage(self.ui.Image_Bg, function()
    return self.model.bgImage
  end)
end

function WeekStagePanel:BindVisible()
  self.binder:BindToVisible(self.ui.Relic_Title, function()
    return true
  end)
  self.binder:BindToVisible(self.ui.UI_Chapter_Popup_Blame_Tip, System.fn(self, self._IsMonsterTipVisible))
  self.binder:BindToVisible(self.ui.Btn_Mask, System.fn(self, self._IsMonsterTipVisible))
end

function WeekStagePanel:OnEvent(data)
  if data.secondUI == false then
    Super.Close(self)
    DataCenter.copyData.weekCopyTid = self.copyTid
  end
end

function WeekStagePanel:BindText()
  self.binder:BindToText(self.ui.Text_Introduce, function()
    return self.model.desc
  end)
  self.binder:BindToText(self.ui.Text_Name, function()
    return self.model.titleStr
  end)
  self.binder:BindToText(self.ui.Text_Title, function()
    return self.model.copyName
  end)
end

function WeekStagePanel:BindListView()
  self.binder:BindToCircularListView(self.ui.ScrollView_Difficulty, function()
    return self.model.stageList
  end, function(childBinder, item, index)
    local data = self.model.stageList
    childBinder:BindComponent(require("UI.Dbg.WeekCopy.Item.StageItemComponent")(item, self.model, data[index].ID))
  end)
  
  local function OnClickMonster(monsterTid)
    if not monsterTid then
      return
    end
    self.model:SetCurMonsterTid(monsterTid)
  end
  
  self.binder:BindToCircularListView(self.ui.ScrollView_Monster, function()
    return self.model.monsterList
  end, function(itemBinder, obj, index)
    local monsterTid = self.model.monsterList[index]
    itemBinder:BindComponent(require("UI.Dbg.WeekCopy.Item.MonsterIconComponent")(obj, self.copyTid, monsterTid, OnClickMonster))
  end)
end

function WeekStagePanel:BindButton()
  self.binder:BindToVisible(self.ui.Btn_Again, function()
    do return self.model.GetResetBtnVisible end
    return self.model.GetResetBtnVisible, self.model
  end)
  self.binder:BindZ1Button(self.ui.Btn_Enter, function()
    self:OnEnter()
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "DailyCopy_Start"
  end, nil, nil, nil)
  self.binder:BindButtonClick(self.ui.Btn_Again, function()
    self:OnReset()
  end)
  self.binder:BindButtonClick(self.ui.Btn_Monster, System.fn(self, self._OnClickRelicGroup))
  self.binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self._OnClickMask))
end

function WeekStagePanel:OnReset()
  local stageTid = self.model:GetCurStageTid()
  Alert.Show(20055, nil, function()
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnWeekChallengeRefresh", function(data)
      CopyDataUtils.ResetWeekStageCopyData(data)
    end, function()
    end, stageTid)
  end)
end

function WeekStagePanel:BindRelic()
  self.binder:BindToCircularListView(self.ui.ScrollView_Initial, function()
    do return CopyDataUtils.GetStageInitRelic, self.model:GetCurStageTid() end
    return CopyDataUtils.GetStageInitRelic, self.model:GetCurStageTid()
  end, function(itemBinder, item, index)
    local relics = CopyDataUtils.GetStageInitRelic(self.model:GetCurStageTid())
    local itemData = relics[index]
    itemBinder:BindComponent(require("UI.Dbg.Common.RelicIconComponent")(item, itemData, nil, self.model:GetCurStageTid()))
  end)
end

function WeekStagePanel:OnEnter()
  local stageId = self.model:GetCurStageTid()
  local cost = DT.Stage[stageId].Cost
  if cost > PlayerDataUtils.GetEnergy() then
    PlayerDataUtils.ShowEnergyRestorePanel()
    return
  end
  DataCenter.dbgTeamData.clearForbiddenAwakers = true
  local star = self.model:GetStageStar(stageId)
  if star > 0 then
    Alert.Show(20058, function()
      DataCenter.dbgTeamData.clearForbiddenAwakers = false
    end, function()
      EventMgr.Instance.OpenReqMask:Dispatch()
      ProtoManager.Instance:ReqServer("GameRequest", "OnWeekChallengeRefresh", function(data)
        CopyDataUtils.ResetWeekStageCopyData(data)
        WorldStageManager.Instance:CheckOpen(stageId, function()
          local stageType = CommonDefine.StageGroupType.WeeklyCopy
          local stageGroup = CopyDataUtils.GetStageGroupId(stageId)
          StageExitPanelManager.Instance:PushPanel(Urls.WeekStagePanel, self.copyTid)
          StageExitPanelManager.Instance:PushPanel(Urls.DungeonsMainView, stageType, stageGroup, CommonDefine.DBGEntryPage.WeeklyPanel)
        end, nil)
      end, function()
      end, stageId)
    end)
  else
    WorldStageManager.Instance:CheckOpen(stageId, function()
      local stageType = CommonDefine.StageGroupType.WeeklyCopy
      local stageGroup = CopyDataUtils.GetStageGroupId(stageId)
      StageExitPanelManager.Instance:PushPanel(Urls.WeekStagePanel, self.copyTid)
      StageExitPanelManager.Instance:PushPanel(Urls.DungeonsMainView, stageType, stageGroup, CommonDefine.DBGEntryPage.WeeklyPanel)
    end, nil)
  end
end

function WeekStagePanel:ShowObjectTip(data)
  self.binder:BindNewComponentWithMask(UIManager.GetTipPopRoot(), require("UI.Public.Tip.ItemObjectTip"), require("UI.UIPackages.Item_Public_Object_TipResource"), data)
end

function WeekStagePanel:Close()
  self.closeBtn:PlayCloseAnim()
  EventMgr.Instance.StageUIEvent:Dispatch({secondUI = false})
  Super.Close(self)
end

function WeekStagePanel:_IsMonsterTipVisible()
  return self.model.curMonsterTid ~= nil
end

function WeekStagePanel:_OnClickMask()
  self.model:SetCurMonsterTid(nil)
end

function WeekStagePanel:BindRecommendSchool()
  local schoolTypeUIMap = {
    [CommonDefine.SchoolType.Chaos] = self.ui.Image_Boundaries_Icon,
    [CommonDefine.SchoolType.Dimension] = self.ui.Image_Boundaries_Icon_1,
    [CommonDefine.SchoolType.Blood] = self.ui.Image_Boundaries_Icon_2,
    [CommonDefine.SchoolType.Ocean] = self.ui.Image_Boundaries_Icon_3
  }
  for schoolName, ui in pairs(schoolTypeUIMap) do
    self.binder:BindToVisible(ui, function()
      local stageId = self.model:GetCurStageTid()
      local stageCfg = DT.Stage[stageId]
      if not stageCfg then
        return false
      end
      local recClass = stageCfg.RecClass or nil
      if not recClass then
        return false
      end
      local recSchoolNameGroup = {}
      for _, schoolId in pairs(recClass) do
        table.insert(recSchoolNameGroup, DT.SchoolConfig[schoolId].NameEn)
      end
      do return table.contains, recSchoolNameGroup end
      return table.contains, recSchoolNameGroup, schoolName, pairs(recClass)
    end)
  end
end

function WeekStagePanel:ListViewAnimPlay()
  self.binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Difficulty)
end

return WeekStagePanel
