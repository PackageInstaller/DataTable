local SpringFestivalZumaTaskView = class("SpringFestivalZumaTaskView", (import("game.views.activity.Submodule.Zuma.Normal.View.ZumaTaskView")))

function SpringFestivalZumaTaskView:UIName()
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumarewardPopUI"
end

function SpringFestivalZumaTaskView:InitUI()
	self:BindCfgUI()

	self.showStateController = self.controllerexcollection_:GetController("clear")
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, SpringFestivalZumaTaskItem)
end

function SpringFestivalZumaTaskView:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		self:OnReceive()
	end)
	self:AddBtnListener(self.onClickBtn_, nil, function()
		JumpTools.Back()
	end)
end

return SpringFestivalZumaTaskView
