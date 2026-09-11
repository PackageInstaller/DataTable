local EatSnakesGameView = class("EatSnakesGameView", ReduxView)

function EatSnakesGameView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_3_10_SnakegameUI"
end

function EatSnakesGameView:UIParent()
	return manager.ui.uiMain.transform
end

function EatSnakesGameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EatSnakesGameView:InitUI()
	self:BindCfgUI()

	self.controller_ = {}

	for iter_4_0 = 1, 3 do
		self.controller_[iter_4_0] = self["controller_" .. iter_4_0]:GetController("status")
	end

	self.titleController_ = self.titleCon_:GetController("title")
end

function EatSnakesGameView:AddUIListener()
	return
end

function EatSnakesGameView:OnEnter()
	self.tools = EatSnakeMain.Instance
	self.tools.gamePause = false
	self.type = 0

	self:UpdateData()
	self:UpdateView()
	self.tools:LoadGame(self.cfg.stage)
end

function EatSnakesGameView:UpdateData()
	self.cfg = ActivityEatSnakeCfg[self.params_.id]
	self.mapID = self.cfg.stage
	self.finishStar = 0
	self.type = nil

	function self.cancelFunc_()
		self.tools.gamePause = false
	end

	function self.failFunc()
		TimeTools.StartAfterSeconds(1, function()
			JumpTools.GoToSystem("eatSnakeResult", {
				type = 2,
				time = self.tools.showTime,
				id = self.params_.id,
				parent = self
			})
		end, {})
		self.titleController_:SetSelectedState("lose")

		self.type = 2
		self.finishStar = 0

		local var_9_0 = self.tools:CalculateSnakePartCount()

		SDKTools.SendMessageToSDK("activity_combat_over", {
			combat_star = 0,
			activity_id = self.cfg.activity_id,
			stage_id = self.cfg.id,
			result = self.type,
			use_seconds = string.format("%.1f", self.tools.showTime),
			score = self.tools.currentIndex,
			other_data = string.format("[%s, %s, %s]", var_9_0[0], var_9_0[1], var_9_0[2])
		})

		for iter_9_0 = 1, 3 do
			self.controller_[iter_9_0]:SetSelectedState("notpass")
		end
	end

	function self.battAgainFunc()
		self.type = 4

		local var_11_0 = self.tools:CalculateSnakePartCount()

		SDKTools.SendMessageToSDK("activity_combat_over", {
			combat_star = 0,
			activity_id = self.cfg.activity_id,
			stage_id = self.cfg.id,
			result = self.type,
			use_seconds = string.format("%.1f", self.tools.showTime),
			score = self.tools.currentIndex,
			other_data = string.format("[%s, %s, %s]", var_11_0[0], var_11_0[1], var_11_0[2])
		})
		self:OnEnter()
	end

	function self.tools.winGameAction()
		TimeTools.StartAfterSeconds(0.5, function()
			JumpTools.OpenPageByJump("eatSnakeAnimation", {
				type = 1,
				time = self.tools.showTime,
				id = self.params_.id,
				parent = self
			})
		end, {})
		self.titleController_:SetSelectedState("win")

		self.type = 1

		local var_12_0 = 1

		for iter_12_0 = 2, 3 do
			if self.tools.showTime < ConditionCfg[self.cfg.target_list[iter_12_0]].params[2] then
				var_12_0 = var_12_0 + 1
			end
		end

		EatSnakeAction.GetReward({
			activity_id = EatSnakeData:GetDataByPara("activityID"),
			stage_id = self.cfg.id,
			star = var_12_0
		})

		local var_12_1 = self.tools:CalculateSnakePartCount()

		SDKTools.SendMessageToSDK("activity_combat_over", {
			activity_id = self.cfg.activity_id,
			stage_id = self.cfg.id,
			result = self.type,
			use_seconds = string.format("%.1f", self.tools.showTime),
			score = self.tools.currentIndex,
			combat_star = var_12_0,
			other_data = string.format("[%s, %s, %s]", var_12_1[0], var_12_1[1], var_12_1[2])
		})
	end

	self.tools.failGameAction = self.failFunc
end

function EatSnakesGameView:UpdateView()
	for iter_14_0, iter_14_1 in ipairs(self.cfg.target_list) do
		self["condition" .. iter_14_0 .. "Txt_"].text = ConditionCfg[iter_14_1].desc
	end

	for iter_14_2 = 1, 3 do
		self.controller_[iter_14_2]:SetSelectedState("pass")
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.countDown_:Play("normal")

	self.timer = Timer.New(function()
		self.countDown_:Play("normal")

		for iter_15_0 = 2, #self.cfg.target_list do
			if ConditionCfg[self.cfg.target_list[iter_15_0]].params[2] - self.tools.showTime <= 5 and ConditionCfg[self.cfg.target_list[iter_15_0]].params[2] - self.tools.showTime >= 0 then
				self.countDown_:Play("countdown", 0, 0)
			end

			if ConditionCfg[self.cfg.target_list[iter_15_0]].params[2] - self.tools.showTime <= 0 then
				self.controller_[iter_15_0]:SetSelectedState("notpass")
			end
		end
	end, 1, -1, 1)

	self.timer:Start()
end

function EatSnakesGameView:OnExit()
	self:BuryPoint()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function EatSnakesGameView:BuryPoint()
	if self.type == nil then
		self.type = 3

		local var_17_0 = self.tools:CalculateSnakePartCount()

		SDKTools.SendMessageToSDK("activity_combat_over", {
			combat_star = 0,
			activity_id = self.cfg.activity_id,
			stage_id = self.cfg.id,
			result = self.type,
			use_seconds = string.format("%.1f", self.tools.showTime),
			score = self.tools.currentIndex,
			other_data = string.format("[%s, %s, %s]", var_17_0[0], var_17_0[1], var_17_0[2])
		})
	end
end

function EatSnakesGameView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self.tools.gamePause = true

		JumpTools.OpenPageByJump("eatSnakeQuitPop", {
			reBattleBtn_ = true,
			content = GetTips("SNAKEGAME_GIVE_UP"),
			cancelAction = handler(self, self.cancelFunc_),
			battleAction = handler(self, self.battAgainFunc),
			failAction = handler(self, self.failFunc)
		})
	end)
end

function EatSnakesGameView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	EatSnakesGameView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return EatSnakesGameView
