local AprilFoolDiscoveryPage = class("AprilFoolDiscoveryPage", import("view.base.BaseActivityPage"))

function AprilFoolDiscoveryPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.bgName = nil
	self.itemList = self._tf:Find("AD/list")
	self.items = CustomIndexLayer.Clone2Full(self.itemList, 9)
	self.selectIndex = 0
	self.btnHelp = self.bg:Find("help_btn")
	self.btnBattle = self.bg:Find("battle_btn")
	self.btnIncomplete = self.bg:Find("incomplete_btn")
	self.tip = self.bg:Find("tip")
	self.slider = self.bg:Find("slider")
	self.leftTime = self.slider:Find("time")
	self.loader = AutoLoader.New()

	return
end

function AprilFoolDiscoveryPage:OnDataSetting()
	if self.activity.data1 == 0 and self.activity.data3 == 1 then
		self.activity.data3 = 0

		pg.m02:sendNotification(GAME.PUZZLE_PIECE_OP, {
			cmd = 1,
			actId = self.activity.id
		})

		return true
	end

	for iter_2_0, iter_2_1 in ipairs(self.activity.data1_list) do
		if not table.contains(self.activity.data2_list, iter_2_1) then
			pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
				id = iter_2_1,
				actId = self.activity.id
			})

			return true
		end
	end

	return
end

function AprilFoolDiscoveryPage:OnFirstFlush()
	assert(pg.activity_event_picturepuzzle[self.activity.id], "Can't Find activity_event_picturepuzzle 's ID : " .. self.activity.id)

	self.puzzleConfig = pg.activity_event_picturepuzzle[self.activity.id]
	self.keyList = Clone(pg.activity_event_picturepuzzle[self.activity.id].pickup_picturepuzzle)

	table.insertto(self.keyList, pg.activity_event_picturepuzzle[self.activity.id].drop_picturepuzzle)
	assert(#self.keyList == #self.items, string.format("keyList has {0}, but items has 9", #self.keyList))
	table.sort(self.keyList)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.bulin_help.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = self.activity.id

	onButton(self, self.btnBattle, function()
		if #self.activity.data2_list < #self.keyList then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_not_start"))

			return
		end

		self:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = self.puzzleConfig.chapter
		}, function()
			local var_6_0 = getProxy(ActivityProxy)
			local var_6_1 = var_6_0:getActivityById(var_3_0)

			if var_6_1.data1 == 1 then
				return
			end

			var_6_1.data3 = 1

			var_6_0:updateActivity(var_6_1)

			return
		end)

		return
	end, SFX_PANEL)
	pg.SystemGuideMgr.GetInstance():PlayByGuideId(self.activity:getConfig("config_client").guideName)

	return
end

local var_0_1 = {
	"lock",
	"hint",
	"unlock"
}

function AprilFoolDiscoveryPage:OnUpdateFlush()
	AprilFoolDiscoveryPage.super.OnUpdateFlush(self)

	local var_7_0 = #self.activity.data2_list == #self.keyList
	local var_7_1 = self.activity.data1 > 0 and "activity_bg_aprilfool_final" or "activity_bg_aprilfool_discovery"

	if (self.activity.data1 > 0 and "activity_bg_aprilfool_final" or "activity_bg_aprilfool_discovery") ~= self.bgName then
		setImageSprite(self.bg, LoadSprite("ui/activityuipage/AprilFoolDiscoveryPage_atlas", var_7_1))

		self.bg:GetComponent(typeof(Image)).enabled = true
		self.bgName = var_7_1
	end

	local var_7_2 = self.activity.data2_list

	for iter_7_0, iter_7_1 in ipairs(self.items) do
		local var_7_3 = self.keyList[iter_7_0]
		local var_7_4 = table.contains(var_7_2, self.keyList[iter_7_0]) and 3 or table.contains(self.activity.data3_list, self.keyList[iter_7_0]) and 2 or 1

		onButton(self, iter_7_1, function()
			if var_7_4 >= 3 then
				return
			end

			if var_7_4 == 2 then
				self.selectIndex = iter_7_0

				self:UpdateSelection()

				return
			elseif var_7_4 == 1 then
				if pg.TimeMgr.GetInstance():GetServerTime() < self.activity.data2 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("bulin_tip_other2"))

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("bulin_tip_other1"),
					onYes = function()
						pg.m02:sendNotification(GAME.PUZZLE_PIECE_OP, {
							cmd = 3,
							actId = self.activity.id,
							id = var_7_3
						})

						self.selectIndex = iter_7_0

						return
					end
				})
			end

			return
		end)
		self.loader:GetSprite("UI/ActivityUIPage/AprilFoolDiscoveryPage_atlas", var_0_1[var_7_4], iter_7_1:Find("state"))
		setActive(iter_7_1:Find("character"), var_7_4 == 3)
	end

	setActive(self.btnBattle, var_7_0)
	setActive(self.btnIncomplete, not var_7_0)
	self:UpdateSelection()

	return
end

function AprilFoolDiscoveryPage:UpdateSelection()
	setText(self.tip, table.contains(self.activity.data3_list, self.keyList[self.selectIndex]) and i18n("bulin_tip" .. self.selectIndex) or "")
	self:CreateCDTimer()

	return
end

function AprilFoolDiscoveryPage:CreateCDTimer()
	if self.CDTimer then
		return
	end

	if #self.activity.data2_list ~= #self.keyList then
		if pg.TimeMgr.GetInstance():GetServerTime() >= self.activity.data2 then
			setActive(self.slider, false)
			self:RemoveCDTimer()

			return
		end
	end

	setActive(self.slider, true)

	self.CDTimer = Timer.New(function()
		local var_12_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if self.activity.data2 <= var_12_0 then
			setActive(self.slider, false)
			self:RemoveCDTimer()

			return
		end

		local var_12_1 = self.activity.data2 - var_12_0

		setText(self.leftTime, string.format("%d:%02d", math.floor((self.activity.data2 - var_12_0) / 60), (self.activity.data2 - var_12_0) % 60))
		setSlider(self.slider, 0, 1, var_12_1 / self.puzzleConfig.cd)

		return
	end, 1, -1)

	self.CDTimer:Start()
	self.CDTimer.func()

	return
end

function AprilFoolDiscoveryPage:RemoveCDTimer()
	if self.CDTimer then
		self.CDTimer:Stop()

		self.CDTimer = nil
	end

	return
end

function AprilFoolDiscoveryPage:OnDestroy()
	self.loader:Clear()
	self:RemoveCDTimer()
	AprilFoolDiscoveryPage.super.OnDestroy(self)

	return
end

return AprilFoolDiscoveryPage
