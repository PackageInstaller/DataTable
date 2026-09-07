local WarspiteTransformationPage = class("WarspiteTransformationPage", import("view.base.BaseActivityPage"))

function WarspiteTransformationPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.btn = self.bg:Find("battle_btn")
	self.tip = self.bg:Find("help")
	self.mainAward = self.bg:Find("award")
	self.subAwards = CustomIndexLayer.Clone2Full(self.bg:Find("list"), 7)
	self.step = self.bg:Find("receivetimes")
	self.score = self.bg:Find("highscore")

	return
end

function WarspiteTransformationPage:OnDataSetting()
	if self.activity.data4 == 0 and self.activity.data2 >= 7 then
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 3,
			activity_id = self.activity.id
		})

		return true
	elseif defaultValue(self.activity.data2_list[1], 0) > 0 or defaultValue(self.activity.data2_list[2], 0) > 0 then
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 2,
			activity_id = self.activity.id
		})

		return true
	end

	return
end

function WarspiteTransformationPage:OnFirstFlush()
	local var_3_0 = self.activity:getConfig("config_client")[2]
	local var_3_1 = {
		type = var_3_0[1],
		id = var_3_0[2],
		count = var_3_0[3]
	}

	onButton(self, self.mainAward, function()
		self:emit(BaseUI.ON_DROP, var_3_1)

		return
	end, SFX_PANEL)

	for iter_3_0 = 1, 7 do
		local var_3_2 = self.activity:getConfig("config_client")[1]
		local var_3_3 = {
			type = var_3_2[1],
			id = var_3_2[2],
			count = var_3_2[3]
		}

		onButton(self, self.subAwards[iter_3_0], function()
			self:emit(BaseUI.ON_DROP, var_3_3)

			return
		end, SFX_PANEL)
	end

	onButton(self, self.tip, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.goldship_help_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btn, function()
		self:emit(ActivityMediator.GO_DODGEM)

		return
	end, SFX_PANEL)

	return
end

function WarspiteTransformationPage:OnUpdateFlush()
	local var_8_0 = pg.TimeMgr.GetInstance()
	local var_8_1 = var_8_0:DiffDay(self.activity.data1, var_8_0:GetServerTime()) + 1

	setActive(findTF(self.mainAward, "get"), self.activity.data4 > 0)

	for iter_8_0 = 1, 7 do
		local var_8_2 = self.subAwards[iter_8_0]

		setActive(findTF(self.subAwards[iter_8_0], "get"), iter_8_0 <= self.activity.data2)
		setActive(findTF(var_8_2, "lock"), var_8_1 < iter_8_0)
	end

	setText(self.step, self.activity.data2)
	setText(self.score, self.activity.data1_list[1])

	return
end

return WarspiteTransformationPage
