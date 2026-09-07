local ActivityBossHuanChangScene = class("ActivityBossHuanChangScene", import(".ActivityBossSceneTemplate"))

function ActivityBossHuanChangScene:getUIName()
	return "ActivityBossHuanChangUI"
end

function ActivityBossHuanChangScene:init()
	self.mainTF = self._tf:Find("adapt")
	self.bg = self._tf:Find("bg")
	self.bottom = self.mainTF:Find("bottom")
	self.hpBar = self.bottom:Find("progress")
	self.barList = {}

	for iter_2_0 = 1, 4 do
		self.barList[iter_2_0] = self.hpBar:Find(iter_2_0)
	end

	self.progressDigit = self.bottom:Find("digit")
	self.digitbig = self.progressDigit:Find("big")
	self.digitsmall = self.progressDigit:Find("small")
	self.left = self.mainTF:Find("left")
	self.right = self.mainTF:Find("right")
	self.rankTF = self.right:Find("rank")
	self.rankList = CustomIndexLayer.Clone2Full(self.rankTF:Find("layout"), 3)

	for iter_2_1, iter_2_2 in ipairs(self.rankList) do
		setActive(iter_2_2, false)
	end

	self.stageList = {}

	for iter_2_3 = 1, 4 do
		self.stageList[iter_2_3] = self.right:Find(iter_2_3)
	end

	self.stageSP = self.right:Find("6")

	if not IsNil(self.stageSP) then
		setActive(self.stageSP, false)
	end

	self.awardFlash = self.right:Find("ptaward/flash")
	self.awardBtn = self.right:Find("ptaward/button")
	self.ptScoreTxt = self.right:Find("ptaward/Text")
	self.top = self.mainTF:Find("top")
	self.ticketNum = self.top:Find("ticket/Text")
	self.helpBtn = self.top:Find("help")

	onButton(self, self.top:Find("back_btn"), function()
		self:emit(ActivityBossHuanChangScene.ON_BACK)

		return
	end, SOUND_BACK)
	setActive(self.top, false)
	setAnchoredPosition(self.top, {
		y = 1080
	})
	setActive(self.left, false)
	setAnchoredPosition(self.left, {
		x = -1920
	})
	setActive(self.right, false)
	setAnchoredPosition(self.right, {
		x = 1920
	})
	setActive(self.bottom, false)
	setAnchoredPosition(self.bottom, {
		y = -1080
	})
	self:buildCommanderPanel()

	return
end

function ActivityBossHuanChangScene:UpdateDropItems()
	for iter_4_0, iter_4_1 in ipairs(self.contextData.DisplayItems or {}) do
		local var_4_1 = self.barList[iter_4_0]:Find("milestone/item")
		local var_4_2 = {
			type = self.contextData.DisplayItems[5 - iter_4_0][1],
			id = self.contextData.DisplayItems[5 - iter_4_0][2],
			count = self.contextData.DisplayItems[5 - iter_4_0][3]
		}

		updateDrop(var_4_1:GetChild(0), var_4_2)
		onButton(self, var_4_1, function()
			self:emit(ActivityBossHuanChangScene.ON_DROP, var_4_2)

			return
		end, SFX_PANEL)
	end

	return
end

function ActivityBossHuanChangScene:UpdatePage()
	setText(self.digitbig, math.floor(self.contextData.bossHP / 100))
	setText(self.digitsmall, string.format("%02d", self.contextData.bossHP % 100) .. "%")

	local var_6_0 = pg.TimeMgr.GetInstance()

	for iter_6_0 = 1, 4 do
		setSlider(self.barList[iter_6_0]:Find("Slider"), 0, 2500, math.min(math.max(self.contextData.bossHP - (iter_6_0 - 1) * 2500, 0), 2500))
		setActive(self.barList[iter_6_0]:Find("milestone/item"), not self.contextData.mileStones[5 - iter_6_0])
		setActive(self.barList[iter_6_0]:Find("milestone/time"), self.contextData.mileStones[5 - iter_6_0])

		if self.contextData.mileStones[5 - iter_6_0] then
			setText(self.barList[iter_6_0]:Find("milestone/time/Text"), (var_6_0:STimeDescC(self.contextData.mileStones[5 - iter_6_0], "%m/%d/%H:%M")))
		end
	end

	for iter_6_1 = 1, #self.stageList - 1 do
		for iter_6_2, iter_6_3 in ipairs(self.contextData.ticketInitPools) do
			for iter_6_4, iter_6_5 in ipairs(iter_6_3[1]) do
				if iter_6_5 == self.contextData.normalStageIDs[iter_6_1] then
					local var_6_1 = iter_6_3[2]
					local var_6_2 = self.contextData.stageTickets[self.contextData.normalStageIDs[iter_6_1]] or 0
					local var_6_3 = self.stageList[iter_6_1]:Find("count")

					setActive(var_6_3, var_6_2 > 0)
					setText(var_6_3:Find("res"), var_6_2)
					setText(var_6_3:Find("max"), var_6_1)
				end
			end
		end
	end

	setText(self.ptScoreTxt, self.contextData.ptData.count)
	setActive(self.awardFlash, self.contextData.ptData:CanGetAward())

	if self.bonusWindow and self.bonusWindow:IsShowing() then
		self.bonusWindow.buffer:UpdateView(self.contextData.ptData)
	end

	setText(self.ticketNum, (self:GetEXTicket()))

	return
end

function ActivityBossHuanChangScene:UpdateRank(arg_7_1)
	arg_7_1 = arg_7_1 or {}

	for iter_7_0 = 1, #self.rankList do
		local var_7_0 = self.rankList[iter_7_0]

		setActive(self.rankList[iter_7_0], iter_7_0 <= #arg_7_1)

		if iter_7_0 <= #arg_7_1 then
			local var_7_1 = var_7_0:Find("Text")
			local var_7_2 = tostring(arg_7_1[iter_7_0].name)

			var_7_1:GetComponent(typeof(Text)).fontSize = #var_7_2 >= 11 and 23 or 28

			setText(var_7_1, var_7_2)
		end
	end

	return
end

return ActivityBossHuanChangScene
