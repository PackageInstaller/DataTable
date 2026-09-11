local EatSnakeResultView = class("EatSnakeResultView", ReduxView)

function EatSnakeResultView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_Com_SnakegameResultPopUI"
end

function EatSnakeResultView:UIParent()
	return manager.ui.uiMain.transform
end

function EatSnakeResultView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EatSnakeResultView:InitUI()
	self:BindCfgUI()

	self.controller = self.controller_:GetController("state")
	self.conditionList = {}

	for iter_4_0 = 1, 3 do
		self.conditionList[iter_4_0] = self["condition" .. iter_4_0 .. "Controller_"]:GetController("status")
	end
end

function EatSnakeResultView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		self.params_.parent.tools:ClearAllBlockStatus()
		EatSnakesLuaBridge.OverGame()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self.Back()
		self.params_.parent:OnEnter()
	end)
end

function EatSnakeResultView:OnEnter()
	self:UpdateData()
	self:UpdateView()
	manager.windowBar:HideBar()
end

function EatSnakeResultView:UpdateData()
	self.stageList = EatSnakeData:GetDataByPara("stageList")
end

function EatSnakeResultView:UpdateView()
	if self.params_.type == 1 then
		self.controller:SetSelectedState("win")
		manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_snake_win", "")
	else
		self.controller:SetSelectedState("lose")
		manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_snake_lose", "")
	end

	self.cfg = ActivityEatSnakeCfg[self.params_.id]
	self.time = self.params_.time

	for iter_10_0, iter_10_1 in ipairs(self.cfg.target_list) do
		self["condition" .. iter_10_0 .. "Txt_"].text = ConditionCfg[iter_10_1].desc
	end

	for iter_10_2 = 1, 3 do
		if self.params_.type == 2 then
			self.conditionList[iter_10_2]:SetSelectedState("notpass")
		elseif iter_10_2 == 1 then
			self.conditionList[iter_10_2]:SetSelectedState("pass")
		else
			self.conditionList[iter_10_2]:SetSelectedState(self.time < ConditionCfg[self.cfg.target_list[iter_10_2]].params[2] and "pass" or "notpass")
		end
	end
end

function EatSnakeResultView:OnExit()
	return
end

function EatSnakeResultView:Dispose()
	EatSnakeResultView.super.Dispose(self)
end

return EatSnakeResultView
