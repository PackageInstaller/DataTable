local AprilFoolDiscovery2026Page = class("AprilFoolDiscovery2026Page", import("view.activity.CorePage.CoreActivityAprilFoolDiscoveryPage"))
local var_0_1 = "magicbuli"

function AprilFoolDiscovery2026Page:OnInit()
	self.bg = self._tf:Find("AD")
	self.items = CustomIndexLayer.Clone2Full(self._tf:Find("AD/List"), 9)
	self.selectIndex = 0
	self.btnHelp = self.bg:Find("help_btn")
	self.btnBattle = self.bg:Find("battle_btn")
	self.battle_btn = self.bg:Find("battle_btn_1")
	self.btnIncomplete = self.bg:Find("incomplete_btn")
	self.tip = self.bg:Find("tip")
	self.tip_bg = self.bg:Find("tipbg")
	self.slider = self.bg:Find("slider")
	self.leftTime = self.slider:Find("time")
	self.sliderbg = self.bg:Find("sliderbg")
	self.loader = AutoLoader.New()

	for iter_1_0 = 1, #var_0_1 do
		self.loader:GetSprite("UI/AprilFoolDiscovery2026Page_atlas", string.sub(var_0_1, iter_1_0, iter_1_0), self.items[iter_1_0]:Find("Character"), true)
	end

	self._funcsLink = {}

	setText(self.slider:Find("timetext"), i18n("aprilfool_2026_cd"))

	return
end

function AprilFoolDiscovery2026Page:AddFunc(arg_2_1)
	table.insert(self._funcsLink, arg_2_1)

	if #self._funcsLink > 1 then
		return
	end

	self:PlayFuncsLink()

	return
end

function AprilFoolDiscovery2026Page:PlayFuncsLink()
	local var_3_0 = false

	local function var_3_2(...)
		if var_3_0 then
			table.remove(self._funcsLink, 1)
		end

		var_3_0 = true

		if self._funcsLink[1] then
			self._funcsLink[1](var_3_2, ...)
		end

		return
	end

	;(nil)()

	return
end

function AprilFoolDiscovery2026Page:OnDataSetting()
	local var_5_0 = AprilFoolDiscovery2026Page.super.OnDataSetting(self)

	var_5_0 = var_5_0 or (function()
		if self.activity.data1 == 1 and self.activity.data3 == 1 then
			self.activity.data3 = 0

			pg.m02:sendNotification(GAME.PUZZLE_PIECE_OP, {
				cmd = 4,
				actId = self.activity.id
			})

			return true
		end

		return
	end)()

	return var_5_0
end

function AprilFoolDiscovery2026Page:CreateCDTimer()
	if self.CDTimer then
		return
	end

	if #self.activity.data2_list ~= #self.keyList then
		if pg.TimeMgr.GetInstance():GetServerTime() >= self.activity.data2 then
			setActive(self.slider, false)
			setActive(self.sliderbg, false)
			self:RemoveCDTimer()

			return
		end
	end

	setActive(self.slider, true)
	setActive(self.sliderbg, true)

	self.CDTimer = Timer.New(function()
		local var_8_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if self.activity.data2 <= var_8_0 then
			setActive(self.slider, false)
			setActive(self.sliderbg, false)
			self:RemoveCDTimer()

			return
		end

		local var_8_1 = self.activity.data2 - var_8_0

		setText(self.leftTime, string.format("%d:%02d", math.floor((self.activity.data2 - var_8_0) / 60), (self.activity.data2 - var_8_0) % 60))
		setSlider(self.slider, 0, 1, var_8_1 / self.puzzleConfig.cd)

		return
	end, 1, -1)

	self.CDTimer:Start()
	self.CDTimer.func()

	return
end

function AprilFoolDiscovery2026Page:OnFirstFlush()
	assert(pg.activity_event_picturepuzzle[self.activity.id], "Can't Find activity_event_picturepuzzle 's ID : " .. self.activity.id)

	self.puzzleConfig = pg.activity_event_picturepuzzle[self.activity.id]
	self.keyList = Clone(pg.activity_event_picturepuzzle[self.activity.id].pickup_picturepuzzle)

	table.insertto(self.keyList, pg.activity_event_picturepuzzle[self.activity.id].drop_picturepuzzle)
	assert(#self.keyList == #self.items, string.format("keyList has {0}, but items has {1}", #self.keyList, #self.items))
	table.sort(self.keyList)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.SuperBulin2_help.tip
		})

		return
	end, SFX_PANEL)

	local var_9_0 = self.activity.id

	onButton(self, self.btnBattle, function()
		if #self.activity.data2_list < #self.keyList then
			pg.TipsMgr.GetInstance():ShowTips(i18n("caibulin_lock_tip"))

			return
		end

		local var_11_0 = self.puzzleConfig.chapter

		self:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = self.puzzleConfig.chapter
		}, function()
			if not pg.NewStoryMgr.GetInstance():IsPlayed(tostring(var_11_0), true) then
				pg.m02:sendNotification(GAME.STORY_UPDATE, {
					storyId = tostring(var_11_0)
				})
			end

			local var_12_0 = getProxy(ActivityProxy)
			local var_12_1 = var_12_0:getActivityById(var_9_0)

			if var_12_1.data1 == 1 then
				return
			end

			var_12_1.data3 = 1

			var_12_0:updateActivity(var_12_1)

			return
		end)

		return
	end, SFX_PANEL)

	local var_9_1 = self.activity:getConfig("config_client").guideName

	self:AddFunc(function(arg_13_0)
		pg.NewStoryMgr.GetInstance():Play(var_9_1[1], arg_13_0)

		return
	end)

	return
end

function AprilFoolDiscovery2026Page:OnUpdateFlush()
	local var_14_1 = #self.activity.data2_list == #self.keyList
	local var_14_2 = self.activity.data2_list

	for iter_14_0, iter_14_1 in ipairs(self.items) do
		local var_14_3 = self.keyList[iter_14_0]
		local var_14_4 = table.contains(var_14_2, self.keyList[iter_14_0]) and 3 or table.contains(self.activity.data3_list, self.keyList[iter_14_0]) and 2 or 1

		onButton(self, iter_14_1, function()
			if var_14_4 >= 3 then
				return
			end

			if var_14_4 == 2 then
				self.selectIndex = iter_14_0

				self:UpdateSelection()

				return quickPlayAnimation(iter_14_1:Find("Unlock"), "im_AprilFoolDiscovery2026Page_Unlock")
			elseif var_14_4 == 1 then
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
							id = var_14_3
						})

						self.selectIndex = iter_14_0

						return
					end
				})
			end

			return
		end)
		setActive(iter_14_1:Find("Character"), var_14_4 == 3)

		if var_14_4 == 3 then
			quickPlayAnimation(iter_14_1, "anim_AprilFoolDiscovery2026Page_open")
		end

		setActive(iter_14_1:Find("Selected"), var_14_4 == 2)

		if var_14_4 == 2 then
			setActive(iter_14_1:Find("Unlock"), true)
		end

		setActive(iter_14_1:Find("Locked"), var_14_4 == 1)
	end

	SetActive(self.battle_btn, not var_14_1)
	SetActive(self.btnBattle, var_14_1)
	self:UpdateSelection()

	if #table.mergeArray(self.activity.data1_list, self.activity.data2_list, true) >= #pg.activity_event_picturepuzzle[self.activity.id].pickup_picturepuzzle + #pg.activity_event_picturepuzzle[self.activity.id].drop_picturepuzzle then
		local var_14_5 = self.activity:getConfig("config_client").comStory

		self:AddFunc(function(arg_17_0)
			pg.NewStoryMgr.GetInstance():Play(var_14_5, arg_17_0)

			return
		end)
	end

	return
end

function AprilFoolDiscovery2026Page:UpdateSelection()
	local var_18_0 = table.contains(self.activity.data3_list, self.keyList[self.selectIndex])

	SetActive(self.tip, var_18_0 and i18n("SuperBulin2_tip" .. self.selectIndex) or false)
	SetActive(self.tip_bg, var_18_0 and i18n("SuperBulin2_tip" .. self.selectIndex) or false)
	setText(self.tip, var_18_0 and i18n("SuperBulin2_tip" .. self.selectIndex) or "")
	self:CreateCDTimer()

	return
end

return AprilFoolDiscovery2026Page
