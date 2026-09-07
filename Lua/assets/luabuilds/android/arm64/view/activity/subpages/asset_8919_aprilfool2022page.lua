local AprilFool2022Page = class("AprilFool2022Page", import("view.base.BaseActivityPage"))

AprilFool2022Page.Order = {
	1,
	3,
	2
}

function AprilFool2022Page:OnInit()
	self.bg = self._tf:Find("AD")
	self.selectIndex = 0
	self.stars = {}

	for iter_1_0 = 1, 3 do
		self.stars[iter_1_0] = self.bg:Find("Star" .. iter_1_0)
	end

	self.clickIndex = 0
	self.btnBattle = self.bg:Find("Battle_btn")

	return
end

function AprilFool2022Page:OnDataSetting()
	local var_2_0 = self.activity:getConfig("config_client")

	if type(var_2_0) == "table" and var_2_0[2] and type(var_2_0[2]) == "string" then
		if not pg.NewStoryMgr.GetInstance():IsPlayed(var_2_0[2]) then
			pg.NewStoryMgr.GetInstance():Play(var_2_0[2], nil, true, true)
		end
	end

	if self.activity.data2 == 0 and self.activity.data3 == 1 then
		self.activity.data3 = 0

		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 2,
			activity_id = self.activity.id
		})

		return true
	end

	if self.activity.data1 == 0 then
		if self.activity:getConfig("config_client").autounlock <= pg.TimeMgr.GetInstance():GetServerTime() - self.activity:getStartTime() then
			self:emit(ActivityMediator.EVENT_OPERATION, {
				arg1 = 1,
				cmd = 1,
				activity_id = self.activity.id
			})

			return true
		end
	end

	return
end

function AprilFool2022Page:OnFirstFlush()
	AprilFool2022Page.super.OnFirstFlush(self)
	onButton(self, self.btnBattle, function()
		local var_4_0 = self.activity:getConfig("config_client").stageid

		self:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = var_4_0
		}, function()
			if not pg.NewStoryMgr.GetInstance():IsPlayed(tostring(var_4_0), true) then
				pg.m02:sendNotification(GAME.STORY_UPDATE, {
					storyId = tostring(var_4_0)
				})
			end

			local var_5_0 = getProxy(ActivityProxy)
			local var_5_1 = var_5_0:getActivityById(self.activity.id)

			if var_5_1.data2 > 0 then
				return
			end

			var_5_1.data3 = 1

			var_5_0:updateActivity(var_5_1)

			return
		end)

		return
	end, SFX_PANEL)

	local function var_3_0(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = GetOrAddComponent(arg_6_1, "ButtonEventExtend").onPointerDown

		pg.DelegateInfo.Add(arg_6_0, var_6_0)
		var_6_0:RemoveAllListeners()
		var_6_0:AddListener(function()
			if self.activity.data1 ~= 0 then
				return
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_6_2 ~= self.Order[self.clickIndex + 1] and "event:/ui/shibai" or "event:/ui/deng" .. self.clickIndex + 1)

			return
		end)

		return
	end

	table.Foreach(self.stars, function(arg_8_0, arg_8_1)
		onButton(self, arg_8_1, function()
			if self.activity.data1 ~= 0 then
				return
			end

			if arg_8_0 ~= self.Order[self.clickIndex + 1] then
				self.clickIndex = 0

				self:OnUpdateFlush()

				return
			end

			self.clickIndex = self.clickIndex + 1

			self:OnUpdateFlush()

			if self.clickIndex < #self.Order then
				return
			end

			self:emit(ActivityMediator.EVENT_OPERATION, {
				arg1 = 1,
				cmd = 1,
				activity_id = self.activity.id
			})

			return
		end)
		var_3_0(self, arg_8_1, arg_8_0)

		return
	end)

	return
end

function AprilFool2022Page:OnUpdateFlush()
	AprilFool2022Page.super.OnUpdateFlush(self)
	setActive(self.btnBattle, self.activity.data1 ~= 0)
	SetCompomentEnabled(self.btnBattle, "Animator", self.activity.data2 == 0)
	table.Foreach(self.Order, function(arg_11_0, arg_11_1)
		setActive(self.stars[arg_11_1]:Find("Effect"), arg_11_0 <= self.clickIndex or self.activity.data1 ~= 0)

		return
	end)

	return
end

return AprilFool2022Page
