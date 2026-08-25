local System = require("System.System")
local TaskAppointPage = require("UI.Task.Page.TaskAppointPage")
local CommonDefine = require("World.Enums.CommonDefine")
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local TaskServerIndex = CommonDefine.TaskServerIndex
local HomeDispatchPanel, Super = System.NewClass("HomeDispatchPanel", BaseView)
HomeDispatchPanel.uiResCls = UI_Research_Panel_DispatchResource

function HomeDispatchPanel:ctor()
  Super.ctor(self)
end

function HomeDispatchPanel:OnBind(binder)
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self.taskAppointComp = binder:BindComponent(TaskAppointPage(self.ui.UI_Research_Panel_Dispatch_Content, TaskServerIndex.Appoint))
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, {}))
  binder:BindEvent(EventMgr.Instance.OnDungeonEntryPageChanged, function(curPage)
    self:OnEnterPage(curPage)
  end)
  PlayerDataUtils.OpenFirstTimeIllustrate(self.__name, nil, LT.Text("Task_Appoint_Rules"))
end

function HomeDispatchPanel:OnEnterPage(curPage)
  if curPage ~= CommonDefine.DBGEntryPage.SendPanel then
    return
  end
  self.taskAppointComp:OnOpen()
  self.uiAnimController:PlayState("UI_Research_Panel_Dispatch_Open")
end

function HomeDispatchPanel:OnClose()
  self:Close()
end

return HomeDispatchPanel
