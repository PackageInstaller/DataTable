local RivalInfoLayer = class("RivalInfoLayer", import("..base.BaseUI"))

RivalInfoLayer.TYPE_DISPLAY = 1
RivalInfoLayer.TYPE_BATTLE = 2

function RivalInfoLayer:getUIName()
	return "RivalInfoUI"
end

function RivalInfoLayer:setRival(arg_2_1)
	self.rivalVO = arg_2_1

	return
end

function RivalInfoLayer:didEnter()
	pg.UIMgr.GetInstance():LoadingOn()
	onButton(self, findTF(self._tf, "bg"), function()
		self:emit(RivalInfoLayer.ON_CLOSE)

		return
	end)

	self.shipCardTpl = self._tf:Find("ShipCardTpl")
	self.startBtn = findTF(self._tf, "ships_container/start_btn")

	setActive(self.startBtn, false)
	setActive(findTF(self._tf, "info/title_miex"), self.contextData.type == self.TYPE_BATTLE)
	onButton(self, self.startBtn, function()
		self:emit(RivalInfoMediator.START_BATTLE)

		return
	end, SFX_CONFIRM)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:initRivalInfo()

	self.isRealName = false
	self.realNameToggle = self._tf:Find("info/real_name")

	onToggle(self, self.realNameToggle, function(arg_6_0)
		self.isRealName = arg_6_0

		self:UpdateNames()

		return
	end, SFX_PANEL)
	setActive(self.realNameToggle, pg.PushNotificationMgr.GetInstance():isEnableShipName())

	return
end

function RivalInfoLayer:UpdateNames()
	for iter_7_0, iter_7_1 in pairs(self.names) do
		setText(findTF(iter_7_1[1], "content/info/name_mask/name"), self.isRealName and iter_7_1[2]:GetDefaultName() or iter_7_1[2]:getName())
	end

	return
end

function RivalInfoLayer:initRivalInfo()
	setText(findTF(self._tf, "info/name/container/name"), self.rivalVO.name)
	setText(findTF(self._tf, "info/name/container/lv"), "Lv." .. self.rivalVO.level)
	setActive(findTF(self._tf, "info/rank"), self.rivalVO.rank ~= nil)
	setActive(findTF(self._tf, "info/medal"), self.rivalVO.rank ~= nil)
	setActive(findTF(self._tf, "info/medal/Text"), self.rivalVO.rank ~= nil)

	if self.rivalVO.rank then
		setText(findTF(self._tf, "info/rank/container/value"), self.rivalVO.rank)

		local var_8_0 = SeasonInfo.getMilitaryRank(self.rivalVO.score, self.rivalVO.rank)
		local var_8_1 = findTF(self._tf, "info/medal")
		local var_8_2 = var_8_1:GetComponent(typeof(Image))
		local var_8_3 = findTF(self._tf, "info/medal/Text"):GetComponent(typeof(Image))

		LoadSpriteAsync("emblem/" .. var_8_1, function(arg_9_0)
			var_8_2.sprite = arg_9_0

			var_8_3:SetNativeSize()

			return
		end)
		LoadSpriteAsync("emblem/n_" .. SeasonInfo.getEmblem(self.rivalVO.score, self.rivalVO.rank), function(arg_10_0)
			var_8_3.sprite = arg_10_0

			var_8_3:SetNativeSize()

			return
		end)
	end

	self.names = {}

	local function var_8_4(arg_11_0, arg_11_1)
		flushShipCard(arg_11_0, arg_11_1)
		setScrollText(findTF(arg_11_0, "content/info/name_mask/name"), arg_11_1:GetColorName(getProxy(PlayerProxy):getRawData():ShouldCheckCustomName() and arg_11_1:GetDefaultName() or arg_11_1:getName()))

		return
	end

	local function var_8_5(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = cloneTplTo(self.shipCardTpl, arg_12_2)

		setActive(var_12_0, true)

		var_12_0.localScale = Vector3(1.1, 1.1, 1)

		setActive(var_12_0:Find("content"), arg_12_3 ~= nil)
		setActive(var_12_0:Find("empty"), arg_12_3 == nil)

		if arg_12_3 then
			var_8_4(var_12_0, arg_12_3)
			table.insert(self.names, {
				var_12_0,
				arg_12_3
			})
		end

		return
	end

	local var_8_6 = self._tf:Find("ships_container/ships/main")

	for iter_8_0 = 1, 3 do
		var_8_5(#self.rivalVO.mainShips, iter_8_0, var_8_6, self.rivalVO.mainShips[iter_8_0])
	end

	local var_8_7 = self._tf:Find("ships_container/ships/vanguard")

	for iter_8_1 = 1, 3 do
		var_8_5(#self.rivalVO.vanguardShips, iter_8_1, var_8_7, self.rivalVO.vanguardShips[iter_8_1])
	end

	local var_8_8 = self._tf:Find("ships_container/main_comprehensive")
	local var_8_9 = self._tf:Find("ships_container/vanguard_comprehensive")
	local var_8_10 = self._tf:Find("ships_container/main_comprehensive/Text")
	local var_8_11 = self._tf:Find("ships_container/vanguard_comprehensive/Text")

	LeanTween.value(go(var_8_10), 0, self.rivalVO:GetGearScoreSum(TeamType.Main), 0.5):setOnUpdate(System.Action_float(function(arg_13_0)
		setText(var_8_10, math.floor(arg_13_0))

		return
	end))
	LeanTween.value(go(var_8_11), 0, self.rivalVO:GetGearScoreSum(TeamType.Vanguard), 0.5):setOnUpdate(System.Action_float(function(arg_14_0)
		setText(var_8_11, math.floor(arg_14_0))

		return
	end)):setOnComplete(System.Action(function()
		setActive(self.startBtn, self.contextData.type == self.TYPE_BATTLE)
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end))

	return
end

function RivalInfoLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance().UIMain)

	return
end

return RivalInfoLayer
