local EatSnakeShowView = class("EatSnakeShowView", ReduxView)

function EatSnakeShowView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_3_10_SnakegameCodexUI"
end

function EatSnakeShowView:UIParent()
	return manager.ui.uiMain.transform
end

function EatSnakeShowView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EatSnakeShowView:InitUI()
	self:BindCfgUI()

	for iter_4_0 = 1, 7 do
		self["controller" .. iter_4_0] = self["controller" .. iter_4_0 .. "_"]:GetController("lock")
	end
end

function EatSnakeShowView:AddUIListener()
	for iter_5_0 = 1, 7 do
		self:AddBtnListener(self["btn" .. iter_5_0 .. "_"], nil, function()
			if self.stageList[iter_5_0] == nil then
				return
			end

			JumpTools.OpenPageByJump("eatSnakeShowPop", {
				id = ActivityEatSnakeCfg.all[iter_5_0],
				isLock = self.stageList[iter_5_0] ~= nil
			})
		end)
	end
end

function EatSnakeShowView:OnEnter()
	self:UpdateData()
	self:UpdateView()
end

function EatSnakeShowView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function EatSnakeShowView:UpdateData()
	self.stageList = EatSnakeData:GetDataByPara("stageList")
end

function EatSnakeShowView:UpdateView()
	for iter_10_0 = 1, 7 do
		self["controller" .. iter_10_0]:SetSelectedState(self.stageList[iter_10_0] == nil and "lock" or "unlock")
	end
end

function EatSnakeShowView:OnExit()
	manager.windowBar:HideBar()
end

function EatSnakeShowView:Dispose()
	EatSnakeShowView.super.Dispose(self)
end

return EatSnakeShowView
