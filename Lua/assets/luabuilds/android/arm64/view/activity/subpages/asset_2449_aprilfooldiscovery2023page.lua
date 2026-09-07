local AprilFoolDiscovery2023Page = class("AprilFoolDiscovery2023Page", import(".AprilFoolDiscoveryRePage"))
local var_0_1 = "superburin"

function AprilFoolDiscovery2023Page:OnInit()
	self.bg = self._tf:Find("AD")
	self.items = CustomIndexLayer.Clone2Full(self._tf:Find("AD/list1"), 5)

	table.insertto(self.items, CustomIndexLayer.Clone2Full(self._tf:Find("AD/list2"), 5))

	self.selectIndex = 0
	self.btnHelp = self.bg:Find("help_btn")
	self.btnBattle = self.bg:Find("battle_btn")
	self.tip = self.bg:Find("tip")
	self.slider = self.bg:Find("slider")
	self.leftTime = self.slider:Find("time")
	self.loader = AutoLoader.New()

	for iter_1_0 = 1, #var_0_1 do
		self.loader:GetSprite("ui/activityuipage/aprilfooldiscovery2023page_atlas", string.sub(var_0_1, iter_1_0, iter_1_0), self.items[iter_1_0]:Find("character"))
	end

	self._funcsLink = {}

	return
end

function AprilFoolDiscovery2023Page:OnDataSetting()
	local var_2_0 = AprilFoolDiscovery2023Page.super.OnDataSetting(self)

	var_2_0 = var_2_0 or (function()
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

	return var_2_0
end

function AprilFoolDiscovery2023Page:OnFirstFlush()
	assert(pg.activity_event_picturepuzzle[self.activity.id], "Can't Find activity_event_picturepuzzle 's ID : " .. self.activity.id)

	self.puzzleConfig = pg.activity_event_picturepuzzle[self.activity.id]
	self.keyList = Clone(pg.activity_event_picturepuzzle[self.activity.id].pickup_picturepuzzle)

	table.insertto(self.keyList, pg.activity_event_picturepuzzle[self.activity.id].drop_picturepuzzle)
	assert(#self.keyList == #self.items, string.format("keyList has {0}, but items has 9", #self.keyList))
	table.sort(self.keyList)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.caibulin_help.tip
		})

		return
	end, SFX_PANEL)

	local var_4_0 = self.activity.id

	onButton(self, self.btnBattle, function()
		if #self.activity.data2_list < #self.keyList then
			pg.TipsMgr.GetInstance():ShowTips(i18n("caibulin_tip11"))

			return
		end

		local var_6_0 = self.puzzleConfig.chapter

		self:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = self.puzzleConfig.chapter
		}, function()
			if not pg.NewStoryMgr.GetInstance():IsPlayed(tostring(var_6_0), true) then
				pg.m02:sendNotification(GAME.STORY_UPDATE, {
					storyId = tostring(var_6_0)
				})
			end

			local var_7_0 = getProxy(ActivityProxy)
			local var_7_1 = var_7_0:getActivityById(var_4_0)

			if var_7_1.data1 == 1 then
				return
			end

			var_7_1.data3 = 1

			var_7_0:updateActivity(var_7_1)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function AprilFoolDiscovery2023Page:OnUpdateFlush()
	local var_8_1 = #self.activity.data2_list == #self.keyList
	local var_8_2 = self.activity.data2_list

	for iter_8_0, iter_8_1 in ipairs(self.items) do
		local var_8_3 = self.keyList[iter_8_0]
		local var_8_4 = table.contains(var_8_2, self.keyList[iter_8_0]) and 3 or table.contains(self.activity.data3_list, self.keyList[iter_8_0]) and 2 or 1

		onButton(self, iter_8_1, function()
			if var_8_4 >= 3 then
				return
			end

			if var_8_4 == 2 then
				self.selectIndex = iter_8_0

				self:UpdateSelection()

				return
			elseif var_8_4 == 1 then
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
							id = var_8_3
						})

						self.selectIndex = iter_8_0

						return
					end
				})
			end

			return
		end)
		setActive(iter_8_1:Find("character"), var_8_4 == 3)
		setActive(iter_8_1:Find("Unlock"), var_8_4 == 2)
		setActive(iter_8_1:Find("Locked"), var_8_4 == 1)
	end

	setGray(self.btnBattle, not var_8_1)
	self:UpdateSelection()

	if #table.mergeArray(self.activity.data1_list, self.activity.data2_list, true) >= #pg.activity_event_picturepuzzle[self.activity.id].pickup_picturepuzzle + #pg.activity_event_picturepuzzle[self.activity.id].drop_picturepuzzle then
		local var_8_5 = self.activity:getConfig("config_client").comStory

		self:AddFunc(function(arg_11_0)
			pg.NewStoryMgr.GetInstance():Play(var_8_5, arg_11_0)

			return
		end)
	end

	return
end

function AprilFoolDiscovery2023Page:UpdateSelection()
	setText(self.tip, table.contains(self.activity.data3_list, self.keyList[self.selectIndex]) and i18n("caibulin_tip" .. self.selectIndex) or "")
	self:CreateCDTimer()

	return
end

return AprilFoolDiscovery2023Page
