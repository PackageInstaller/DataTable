local UI_Task_Popup_Challenge2Resource = require("UI.UIPackages.UI_Task_Popup_Challenge2Resource")
local UIBasePanel = require("Managers.UI.UIBasePanel")
local System = require("System.System")
local LT = require("System.LangTable")
local DT = require("System.DataTable")
local CommonDefine = require("World.Enums.CommonDefine")
local AchievementTrophyType = CommonDefine.AchievementTrophyType
local HomeAchievementPanelModel = require("Model.HomeAchievementPanelModel")
local BtnCloseItem = require("UI.Public.Button.BtnCloseItem")
local Z1Toggle = CS.Z1Client.Z1Toggle
local Z1ToggleGroup = CS.Z1Client.Z1ToggleGroup
local TaskState = CommonDefine.TaskState
local EventMgr = require("Managers.EventManager.EventMgr")
local RedPointDataUtils = require("Data.RedPointDataUtils")
local typeof = _ENV.typeof
local HomeAchievementPanel, Super = System.NewComponent("HomeAchievementPanel")

function HomeAchievementPanel:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Task_Popup_Challenge2Resource(uiNode)
end

function HomeAchievementPanel:OnBind(binder)
  self.binder = binder
  local model = binder:createModel(HomeAchievementPanelModel)
  self.model = model
  self:BindToggleGroup(binder)
  self:BindTrophyGroup(binder)
  self:BindTaskGroup(binder)
  binder:BindEvent(EventMgr.Instance.TaskViewUpdate, function(viewIndex)
    if viewIndex == CommonDefine.TaskServerIndex.Achivement then
      model.UpdateAchievementShow(model.curTaskType)
    end
  end)
end

function HomeAchievementPanel:BindToggleGroup(binder)
  local toggleTypeGroup = self.model.toggleTypeGroup
  for i, val in ipairs(toggleTypeGroup) do
    local uiName = "UI_Common_Item_Toggle" .. i
    local itemData = {
      name = LT.Text(DT.CommonID[val].Desc),
      clickFunc = function()
        self.model.SetCurTaskType(val)
        binder:CircularScrollTo(self.ui.ScrollView_Career_List, 1)
        binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Career_List)
      end,
      expOrFn = function()
        return self.model.curTaskType == val
      end,
      redFunc = function()
        for _, taskData in pairs(self.model.achievementTaskMap[val]) do
          if taskData.state == TaskState.Receive then
            return RedPointDataUtils.RedAttrType.Red
          end
        end
        return false
      end
    }
    local obj = binder:BindComponent(require("UI.Common.CommonToggleItem")(self.ui[uiName], itemData))
    local uiRoot = obj.rootUINode
    local toggleGroup = self.ui.Content:GetComponent(typeof(Z1ToggleGroup))
    uiRoot:GetComponent(typeof(Z1Toggle)).group = toggleGroup
  end
end

function HomeAchievementPanel:BindTrophyGroup(binder)
  local textObjGroup = {
    [AchievementTrophyType.Gold] = self.ui.Text_GoldNum,
    [AchievementTrophyType.Silver] = self.ui.Text_SilverNum,
    [AchievementTrophyType.Bronze] = self.ui.Text_CopperNum
  }
  for type, obj in pairs(textObjGroup) do
    binder:BindToText(obj, function()
      do return LT.Text end
      return LT.Text, self.model.showTrophyNumGroup[type], type
    end)
  end
end

function HomeAchievementPanel:BindTaskGroup(binder)
  binder:BindToCircularListView(self.ui.ScrollView_Career_List, function()
    return self.model.showTaskGroup
  end, function(itemBinder, item, idx)
    local taskData = self.model.showTaskGroup[idx]
    local itemData = {
      model = self.model,
      taskState = taskData.state,
      taskTid = taskData.tid,
      taskUid = taskData.uid,
      isReplaceText = taskData.isReplaceText
    }
    itemBinder:BindComponent(require("UI.Home.Item.HomeAchievementTaskItem")(item, itemData))
  end)
end

function HomeAchievementPanel:OnOpen()
  self:PlayCircularListAnim()
end

function HomeAchievementPanel:PlayCircularListAnim()
  self.binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Career_List)
  self.binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Career_List2)
end

return HomeAchievementPanel
