local AprilFoolDiscoveryRePage = class("AprilFoolDiscoveryRePage", import(".AprilFoolDiscoveryPage"))

function AprilFoolDiscoveryRePage:OnInit()
	AprilFoolDiscoveryRePage.super.OnInit(self)

	self.bulin = self.bg:Find("bulin")
	self.bulinAnim = self.bulin:Find("bulin"):GetComponent("SpineAnimUI")

	setText(self.bulin:Find("Text"), i18n("super_bulin_tip"))
	setActive(self.bulin, false)

	self._funcsLink = {}

	return
end

function AprilFoolDiscoveryRePage:AddFunc(arg_2_1)
	table.insert(self._funcsLink, arg_2_1)

	if #self._funcsLink > 1 then
		return
	end

	self:PlayFuncsLink()

	return
end

function AprilFoolDiscoveryRePage:PlayFuncsLink()
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

function AprilFoolDiscoveryRePage:OnDataSetting()
	local var_5_0 = AprilFoolDiscoveryRePage.super.OnDataSetting(self)

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

function AprilFoolDiscoveryRePage:OnFirstFlush()
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

	local var_7_0 = self.activity.id

	onButton(self, self.btnBattle, function()
		if #self.activity.data2_list < #self.keyList then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_not_start"))

			return
		end

		self:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = self.puzzleConfig.chapter
		}, function()
			local var_10_0 = getProxy(ActivityProxy)
			local var_10_1 = var_10_0:getActivityById(var_7_0)

			if var_10_1.data1 == 1 then
				return
			end

			var_10_1.data3 = 1

			var_10_0:updateActivity(var_10_1)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.bulin, function()
		if self.activity.data1 >= 1 then
			seriesAsync({
				function(arg_12_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("super_bulin"),
						onYes = arg_12_0
					})

					return
				end,
				function(arg_13_0)
					self:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
						warnMsg = "bulin_tip_other3",
						stageId = self:GetLinkStage()
					}, function()
						local var_14_0 = getProxy(ActivityProxy)
						local var_14_1 = var_14_0:getActivityById(var_7_0)

						if var_14_1.data1 == 2 then
							return
						end

						var_14_1.data3 = 1

						var_14_0:updateActivity(var_14_1)

						return
					end)

					return
				end
			})
		end

		return
	end)

	local var_7_1 = self.activity:getConfig("config_client").guideName

	self:AddFunc(function(arg_15_0)
		pg.SystemGuideMgr.GetInstance():PlayByGuideId(var_7_1, nil, arg_15_0)

		return
	end)

	return
end

local var_0_1 = {
	"lock",
	"hint",
	"unlock"
}

function AprilFoolDiscoveryRePage:OnUpdateFlush()
	local var_16_0 = self.activity.data1 >= 1
	local var_16_1 = #self.activity.data2_list == #self.keyList
	local var_16_2 = self.activity.data1 >= 1 and "activity_bg_aprilfool_final" or "activity_bg_aprilfool_discovery"

	if (self.activity.data1 >= 1 and "activity_bg_aprilfool_final" or "activity_bg_aprilfool_discovery") ~= self.bgName then
		setImageSprite(self.bg, LoadSprite("ui/activityuipage/AprilFoolDiscoveryRePage_atlas", var_16_2))

		self.bg:GetComponent(typeof(Image)).enabled = true
		self.bgName = var_16_2
	end

	local var_16_3 = self.activity.data2_list

	for iter_16_0, iter_16_1 in ipairs(self.items) do
		local var_16_4 = self.keyList[iter_16_0]
		local var_16_5 = table.contains(var_16_3, self.keyList[iter_16_0]) and 3 or table.contains(self.activity.data3_list, self.keyList[iter_16_0]) and 2 or 1

		onButton(self, iter_16_1, function()
			if var_16_5 >= 3 then
				return
			end

			if var_16_5 == 2 then
				self.selectIndex = iter_16_0

				self:UpdateSelection()

				return
			elseif var_16_5 == 1 then
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
							id = var_16_4
						})

						self.selectIndex = iter_16_0

						return
					end
				})
			end

			return
		end)
		self.loader:GetSprite("UI/ActivityUIPage/AprilFoolDiscoveryRePage_atlas", var_0_1[var_16_5], iter_16_1:Find("state"))
		setActive(iter_16_1:Find("character"), var_16_5 == 3)
	end

	setActive(self.btnBattle, var_16_1)
	setActive(self.btnIncomplete, not var_16_1)
	self:UpdateSelection()
	setActive(self.bulin, var_16_0)

	if self.activity.data1 == 1 then
		local var_16_6 = self.activity:getConfig("config_client").popStory

		self:AddFunc(function(arg_19_0)
			pg.NewStoryMgr.GetInstance():Play(var_16_6, arg_19_0)

			return
		end)
		self:AddFunc(function(arg_20_0)
			local var_20_0 = getProxy(PlayerProxy):getRawData()

			if PlayerPrefs.GetInt("SuperBurinPopUp_" .. var_20_0.id, 0) == 0 then
				LoadContextCommand.LoadLayerOnTopContext(Context.New({
					mediator = SuperBulinPopMediator,
					viewComponent = SuperBulinPopView,
					data = {
						stageId = self:GetLinkStage(),
						actId = self.activity.id,
						onRemoved = arg_20_0
					}
				}))
				PlayerPrefs.SetInt("SuperBurinPopUp_" .. var_20_0.id, 1)
			end

			return
		end)
	end

	return
end

function AprilFoolDiscoveryRePage:OnDestroy()
	AprilFoolDiscoveryRePage.super.OnDestroy(self)

	return
end

function AprilFoolDiscoveryRePage:GetLinkStage()
	return self.activity:getConfig("config_client").lastChapter
end

return AprilFoolDiscoveryRePage
