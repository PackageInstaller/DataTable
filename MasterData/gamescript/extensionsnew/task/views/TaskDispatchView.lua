local CommonDefine = require("World.Enums.CommonDefine")
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local TaskDispatchView, Super = NewClass("TaskDispatchView", BaseView)
TaskDispatchView.uiResCls = UI_Research_Panel_DispatchResource

function TaskDispatchView:ctor()
  Super.ctor(self)
end

function TaskDispatchView:OnBuildView()
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self.taskAppointComp = self:AddViewComponentOnce(self.ui.UI_Research_Panel_Dispatch_Content, TaskDispatchAppointComp)
  self:AddViewComponentOnce(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, {})
end

function TaskDispatchView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.OnDungeonEntryPageChanged, function(curPage)
    self:OnEnterPage(curPage)
  end)
end

function TaskDispatchView:OnEnterView()
  Super.OnEnterView(self)
  PlayerDataUtils.OpenFirstTimeIllustrate(self.__name, nil, LT.Text("Task_Appoint_Rules"))
end

function TaskDispatchView:OnEnterPage(curPage)
  if curPage ~= CommonDefine.DBGEntryPage.SendPanel then
    return
  end
  self.taskAppointComp:OnOpen()
  self.uiAnimController:PlayState("UI_Research_Panel_Dispatch_Open")
end

function TaskDispatchView:OnClose()
  self:Close()
end

return TaskDispatchView
