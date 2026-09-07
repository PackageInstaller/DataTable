local LimitChallengeScene = class("LimitChallengeScene", import("..base.BaseUI"))
local var_0_1 = LimitChallengeConst

function LimitChallengeScene:getUIName()
	return "LimitChallengeUI"
end

function LimitChallengeScene:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function LimitChallengeScene:didEnter()
	var_0_1.SetRedPointMonth()
	self:updateLeftTime()
	self:updateToggleList()
	self:trigeHigestUnlockLevel()

	return
end

function LimitChallengeScene:onBackPressed()
	self:closeView()

	return
end

function LimitChallengeScene:willExit()
	if self.leftTimer then
		self.leftTimer:Stop()

		self.leftTimer = nil
	end

	return
end

function LimitChallengeScene:initData()
	self.proxy = getProxy(LimitChallengeProxy)
	self.levelList = {
		1,
		2,
		3
	}
	self.curMonth = var_0_1.GetCurMonth()
	self.descList = {}
	self.nextMonthTS = LimitChallengeConst.GetNextMonthTS()
	self.curLevel = 0

	return
end

function LimitChallengeScene:findUI()
	self.blurPanel = self._tf:Find("blur_panel")
	self.homeBtn = self.blurPanel:Find("adapt/top/option")
	self.backBtn = self.blurPanel:Find("adapt/top/back_button")
	self.helpBtn = self.blurPanel:Find("adapt/top/HelpBtn")
	self.shareBtn = self.blurPanel:Find("adapt/top/ShareBtn")
	self.levelPanel = self._tf:Find("Adapt/LevelPanel")
	self.levelToggleList = {}
	self.levelToggleLockList = {}

	for iter_7_0, iter_7_1 in ipairs(self.levelList) do
		local var_7_0 = self.levelPanel:Find("Level_" .. iter_7_1)
		local var_7_1 = var_7_0:Find("Lock")

		self.levelToggleList[iter_7_1] = var_7_0:Find("Toggle")
		self.levelToggleLockList[iter_7_1] = var_7_1
	end

	self.timePanel = self._tf:Find("Adapt/TimePanel")

	local var_7_2 = self.timePanel:Find("Left/LeftTime")

	self.leftTipText = var_7_2:Find("LeftTip")
	self.leftDayTipText = var_7_2:Find("DayTip")
	self.leftDayValueText = var_7_2:Find("DayValue")
	self.leftTimeValueText = var_7_2:Find("TimeValue")
	self.passTimeValueText = self.timePanel:Find("Challenge/Value")

	setText(self.leftTipText, i18n("time_remaining_tip"))
	setText(self.leftDayTipText, i18n("word_date"))

	self.iconContainer = self._tf:Find("Adapt/DescPanel/ScrollView/Viewport/Container")
	self.iconTpl = self._tf:Find("Adapt/DescPanel/IconTpl")

	local var_7_3 = self._tf:Find("Adapt/Award")

	self.awardIconTF = var_7_3:Find("IconTpl")
	self.awardGotTF = var_7_3:Find("Got")
	self.startBtn = self._tf:Find("Adapt/StartBtn")
	self.bgImg = self._tf:Find("BG")
	self.nameImg = self.timePanel:Find("Left")
	self.debugPanel = self._tf:Find("Adapt/Debug")
	self.debugText = self.debugPanel:Find("Text")

	return
end

function LimitChallengeScene:addListener()
	onButton(self, self.homeBtn, function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	print("-----------", tostring(self.backBtn))
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.challenge_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeChallenge)

		return
	end, SFX_PANEL)

	for iter_8_0, iter_8_1 in ipairs(self.levelToggleList) do
		onToggle(self, iter_8_1, function()
			self.curLevel = iter_8_0

			self:updatePassTime()
			self:updateAward()
			self:updateDescPanel()
			self:updateBossImg()
			self:updateDebug()

			return
		end, SFX_CONFIRM, SFX_CANCEL)
	end

	onButton(self, self.startBtn, function()
		self:emit(var_0_1.OPEN_PRE_COMBAT_LAYER, {
			stageID = var_0_1.GetStageIDByLevel(self.curLevel)
		})

		return
	end, SFX_PANEL)

	self.iconUIItemList = UIItemList.New(self.iconContainer, self.iconTpl)

	self.iconUIItemList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			local var_15_0 = arg_15_2:Find("Icon")

			arg_15_1 = arg_15_1 + 1

			if self.descList[arg_15_1] ~= false then
				local var_15_1, var_15_2 = self:getBuffIconPath(var_0_1.GetChallengeIDByLevel(self.curLevel), arg_15_1)

				setImageSprite(var_15_0, LoadSprite(var_15_1, var_15_2))

				local var_15_3 = self.descList[arg_15_1][1]
				local var_15_4 = self.descList[arg_15_1][2]
				local var_15_5 = {}

				table.insert(var_15_5, {
					info = self.descList[arg_15_1][1]
				})
				table.insert(var_15_5, {
					info = self.descList[arg_15_1][2]
				})
				onButton(self, var_15_0, function()
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						hideNo = true,
						type = MSGBOX_TYPE_DROP_ITEM,
						name = var_15_3,
						content = var_15_4,
						iconPath = {
							var_15_1,
							var_15_2
						}
					})

					return
				end, SFX_PANEL)
			end
		end

		return
	end)

	return
end

function LimitChallengeScene:updateDebug()
	local var_17_0 = string.format(" 月份: %s \n 选择难度: %s \n 选择挑战ID: %s \n 选择关卡ID: %s \n", tostring(self.curMonth), tostring(self.curLevel), tostring((var_0_1.GetChallengeIDByLevel(self.curLevel))), tostring((var_0_1.GetStageIDByLevel(self.curLevel))))

	for iter_17_0, iter_17_1 in ipairs(self.levelList) do
		var_17_0 = var_17_0 .. " 难度" .. iter_17_1 .. "奖励:" .. (self.proxy:isAwardedByChallengeID((LimitChallengeConst.GetChallengeIDByLevel(iter_17_1))) and "已领取" or "未领取") .. "\n"
	end

	for iter_17_2, iter_17_3 in ipairs(self.levelList) do
		local var_17_1 = self.proxy:getPassTimeByChallengeID((LimitChallengeConst.GetChallengeIDByLevel(iter_17_3)))

		var_17_0 = var_17_0 .. " 难度" .. iter_17_3 .. "时间:" .. (var_17_1 and var_17_1 or "没有记录") .. "\n"
	end

	setText(self.debugText, var_17_0)

	return
end

function LimitChallengeScene:updateToggleList()
	local var_18_0 = self:getHigestUnlockLevel()

	for iter_18_0, iter_18_1 in ipairs(self.levelToggleLockList) do
		local var_18_1 = var_18_0 < iter_18_0

		setActive(iter_18_1, var_18_0 < iter_18_0)
		setActive(self.levelToggleList[iter_18_0], not var_18_1)
	end

	return
end

function LimitChallengeScene:updateLeftTime()
	if self.leftTimer then
		self.leftTimer:Stop()

		self.leftTimer = nil
	end

	local var_19_0 = pg.TimeMgr.GetInstance()
	local var_19_1 = self.nextMonthTS - var_19_0:GetServerTime()

	if var_19_0 > 0 then
		if self.leftTimer then
			self.leftTimer:Stop()

			self.leftTimer = nil
		end

		local function var_19_2()
			if var_19_1 <= 0 and self.leftTimer then
				self.leftTimer:Stop()

				self.leftTimer = nil
			end

			local var_20_0, var_20_1, var_20_2, var_20_3 = pg.TimeMgr.GetInstance():parseTimeFrom(var_19_1)

			setText(self.leftDayValueText, var_20_0)
			setText(self.leftTimeValueText, string.format("%02d:%02d:%02d", var_20_1, var_20_2, var_20_3))

			var_19_1 = var_19_1 - 1

			return
		end

		self.leftTimer = Timer.New(var_19_2, 1, -1)

		self.leftTimer:Start()
		var_19_2()
	end

	return
end

function LimitChallengeScene:updateBossImg()
	local var_21_0 = pg.expedition_constellation_challenge_template[var_0_1.GetChallengeIDByLevel(self.curLevel)]

	setImageSprite(self.bgImg, LoadSprite("limitchallenge/boss/" .. var_21_0.painting, var_21_0.painting))
	setImageSprite(self.nameImg, LoadSprite("limitchallenge/name/" .. var_21_0.information_icon, var_21_0.information_icon), true)
	setImageSprite(self.startBtn, LoadSprite("limitchallenge/btn/" .. var_21_0.button_style .. "_btn_start", var_21_0.button_style .. "_btn_start"), true)

	for iter_21_0, iter_21_1 in ipairs(self.levelList) do
		local var_21_1 = string.format("%d_level_%d_selected", var_21_0.button_style, iter_21_1)

		setImageSprite(self.levelToggleList[iter_21_1]:Find("Selected"), LoadSprite("limitchallenge/btn/" .. var_21_1, var_21_1), true)
	end

	return
end

function LimitChallengeScene:updateDescPanel()
	self.descList = {}
	self.descList = pg.expedition_constellation_challenge_template[var_0_1.GetChallengeIDByLevel(self.curLevel)].description

	if 3 - #self.descList > 0 then
		for iter_22_0 = 1, 3 - #self.descList do
			table.insert(self.descList, false)
		end
	end

	self.iconUIItemList:align(#self.descList)

	return
end

function LimitChallengeScene:updatePassTime()
	local var_23_0 = self.proxy:getPassTimeByChallengeID((LimitChallengeConst.GetChallengeIDByLevel(self.curLevel))) or 0

	setText(self.passTimeValueText, (string.format("%02d:%02d", math.floor(var_23_0 / 60), (math.floor(var_23_0 % 60)))))

	return
end

function LimitChallengeScene:updateAward()
	local var_24_0 = LimitChallengeConst.GetChallengeIDByLevel(self.curLevel)

	setActive(self.awardGotTF, (self.proxy:isAwardedByChallengeID(var_24_0)))

	if pg.expedition_constellation_challenge_template[var_24_0].award_display[1] and #pg.expedition_constellation_challenge_template[var_24_0].award_display[1] > 0 then
		local var_24_1 = {
			type = pg.expedition_constellation_challenge_template[var_24_0].award_display[1][1],
			id = pg.expedition_constellation_challenge_template[var_24_0].award_display[1][2]
		}

		var_24_1.count = pg.expedition_constellation_challenge_template[var_24_0].award_display[1][3] or 1

		updateDrop(self.awardIconTF, var_24_1)
		onButton(self, self.awardIconTF, function()
			self:emit(BaseUI.ON_DROP, var_24_1)

			return
		end, SFX_PANEL)
		setActive(self.awardIconTF, true)
	else
		setActive(self.awardIconTF, false)
	end

	return
end

function LimitChallengeScene:trigeHigestUnlockLevel()
	triggerToggle(self.levelToggleList[self:getHigestUnlockLevel()], true)

	return
end

function LimitChallengeScene:onReqInfo()
	self:initData()
	self:updateLeftTime()
	self:updateToggleList()
	self:trigeHigestUnlockLevel()

	return
end

function LimitChallengeScene:getHigestUnlockLevel()
	for iter_28_0 = #self.levelList, 1, -1 do
		if self.proxy:isLevelUnlock(self.levelList[iter_28_0]) then
			return self.levelList[iter_28_0]
		end
	end

	return
end

function LimitChallengeScene:getBuffIconPath(arg_29_1, arg_29_2)
	local var_29_0 = string.format("%s_%d", pg.expedition_constellation_challenge_template[arg_29_1].painting, arg_29_2)

	return "limitchallenge/icon/" .. var_29_0, var_29_0
end

return LimitChallengeScene
