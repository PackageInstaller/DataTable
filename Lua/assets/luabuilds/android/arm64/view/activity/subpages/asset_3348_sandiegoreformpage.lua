local SandiegoReformPage = class("SandiegoReformPage", import("...base.BaseActivityPage"))

function SandiegoReformPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.progress = self.bg:Find("progress/left")
	self.gameBtn = self.bg:Find("start")
	self.helpBtn = self.bg:Find("mic")
	self.getSign = self.bg:Find("get")
	self.days = self.bg:Find("days")
	self.nums = self.bg:Find("count")

	return
end

function SandiegoReformPage:OnDataSetting()
	local var_2_0 = self.activity:getConfig("config_client")[1][1]

	if var_2_0 ~= nil then
		pg.NewStoryMgr.GetInstance():Play(var_2_0)
	end

	return
end

function SandiegoReformPage:OnFirstFlush()
	setText(self.nums, _.reduce(_.slice(self.activity:getConfig("config_client")[3], 1, self.activity.data2), 0, function(arg_4_0, arg_4_1)
		return arg_4_0 + arg_4_1
	end))
	setActive(self.getSign, self.activity.data1 == 1)

	local var_3_0 = self.activity:getConfig("config_data")[4]

	self.progress.sizeDelta = Vector2.New(10 + 90 * math.max(self.activity.data2 - 1, 0), self.progress.sizeDelta.y)

	local var_3_1 = Color.New(1, 0.83, 0.15)
	local var_3_2 = Color.New(0.59, 0.62, 0.69)

	for iter_3_0 = 1, 7 do
		setTextColor(self.days:Find(iter_3_0), iter_3_0 <= self.activity.data2 and var_3_1 or var_3_2)
	end

	onButton(self, self.gameBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LINK_LINK)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("link_link_help_tip")
		})

		return
	end, SFX_PANEL)

	return
end

function SandiegoReformPage:OnUpdateFlush()
	return
end

function SandiegoReformPage:OnDestroy()
	return
end

return SandiegoReformPage
