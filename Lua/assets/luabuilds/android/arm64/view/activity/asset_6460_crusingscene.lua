local CrusingScene = class("CrusingScene", import("view.base.BaseUI"))

CrusingScene.optionsPath = {
	"top/home"
}
CrusingScene.FrameSpeed = 10
CrusingScene.PlaySpeed = 1.5

function CrusingScene:getUIName()
	return "CrusingUI"
end

function CrusingScene:preload(arg_2_1)
	local var_2_0 = getProxy(ActivityProxy)
	local var_2_1 = var_2_0:getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)
	local var_2_2 = PoolMgr.GetInstance()
	local var_2_3 = {}

	table.insert(var_2_0, function(arg_3_0)
		local var_3_0 = pg.battlepass_event_pt[var_2_1.id].crusing_map

		var_2_2:GetPrefab("crusingmap/" .. pg.battlepass_event_pt[var_2_1.id].crusing_map, "", true, function(arg_4_0)
			self.rtMap = tf(arg_4_0)
			self.PhaseFrame, self.AllFrameCount = CrusingMapInfo.GetPhaseFrame(var_3_0)

			arg_3_0()

			return
		end)

		return
	end)
	table.insert(var_2_3, function(arg_5_0)
		var_2_2:GetSpineChar(pg.battlepass_event_pt[var_2_1.id].spine_name, true, function(arg_6_0)
			self.rtModel = tf(arg_6_0)

			arg_5_0()

			return
		end)

		return
	end)
	parallelAsync(var_2_3, function()
		setParent(self.rtModel, self.rtMap:Find("icon/model"))

		self.rtModel.localScale = Vector3.one

		arg_2_1()

		return
	end)

	return
end

function CrusingScene:init()
	self.rtBg = self._tf:Find("bg")
	self.scrollMap = self.rtBg:Find("map_scroll")
	self.btnTask = self.rtBg:Find("task_btn")
	self.textTip = self.rtBg:Find("tip")
	self.rtAward = self._tf:Find("award_panel")
	self.textPhase = self.rtAward:Find("phase/Text")
	self.sliderPt = self.rtAward:Find("Slider")
	self.comScroll = GetComponent(self.rtAward:Find("view/content"), "LScrollRect")

	function self.comScroll.onUpdateItem(arg_9_0, arg_9_1)
		self:updateAwardInfo(tf(arg_9_1), self.awardList[arg_9_0 + 1])

		return
	end

	self.rtNextAward = self.rtAward:Find("next")
	self.btnAll = self.rtAward:Find("btn_all")
	self.btnPay = self.rtAward:Find("btn_pay")
	self.btnAfter = self.rtAward:Find("btn_after")
	self.btnFinish = self.rtAward:Find("btn_finish")
	self.rtTop = self._tf:Find("top")
	self.btnBack = self.rtTop:Find("back")
	self.btnHelp = self.rtTop:Find("help")
	self.textDay = self.rtTop:Find("day/Text")
	self.chargeTipWindow = ChargeTipWindow.New(self._tf, self.event)
	self.LTDic = {}

	return
end

function CrusingScene:didEnter()
	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnTask, function()
		if self.phase < #self.awardList then
			self:emit(CrusingMediator.EVENT_OPEN_TASK)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("battlepass_complete"))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.btnAll, function()
		local var_13_0 = self.activity:GetCrusingUnreceiveAward()

		if #var_13_0 > 0 then
			local var_13_1 = {}

			if self:checkLimitMax(var_13_0) then
				table.insert(var_13_1, function(arg_14_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("player_expResource_mail_fullBag"),
						onYes = arg_14_0
					})

					return
				end)
			end

			seriesAsync(var_13_1, function()
				self:emit(CrusingMediator.EVENT_GET_AWARD_ALL)

				return
			end)
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnPay, function()
		self:openBuyPanel()

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnAfter, function()
		local var_17_0 = self.activity:GetCrusingUnreceiveAward()

		if #var_17_0 > 0 then
			local var_17_1 = {}

			if self:checkLimitMax(var_17_0) then
				table.insert(var_17_1, function(arg_18_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("player_expResource_mail_fullBag"),
						onYes = arg_18_0
					})

					return
				end)
			end

			seriesAsync(var_17_1, function()
				self:emit(CrusingMediator.EVENT_GET_AWARD_ALL)

				return
			end)
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("battlepass_main_help_" .. pg.battlepass_event_pt[self.activity.id].map_name)
		})

		return
	end, SFX_PANEL)

	local function var_10_0(arg_21_0)
		local var_21_0 = {
			_tf = arg_21_0,
			rtLine = arg_21_0:Find("line"),
			rtIcon = arg_21_0:Find("icon"),
			rtSimple = arg_21_0:Find("simple")
		}

		setParent(arg_21_0, self.scrollMap)
		SetCompomentEnabled(arg_21_0, typeof(Image), false)

		arg_21_0.name = "map_tpl"

		SetAction(var_21_0.rtIcon:Find("model"):GetChild(0), "normal")

		return var_21_0
	end

	self.maps = {
		var_10_0(self.rtMap)
	}

	while #self.maps < 3 do
		table.insert(self.maps, var_10_0(tf(Instantiate(self.rtMap))))
	end

	Canvas.ForceUpdateCanvases()

	for iter_10_0, iter_10_1 in ipairs(self.maps) do
		setParent(iter_10_1.rtLine, self.scrollMap:Find("bg"), true)
	end

	GetComponent(self.textTip, "RichText"):AddSprite("pt", GetSpriteFromAtlas(Drop.New({
		type = DROP_TYPE_VITEM,
		id = self.ptId
	}):getIcon(), ""))
	setText(self.textTip, i18n("battlepass_main_tip_" .. pg.battlepass_event_pt[self.activity.id].map_name))

	local var_10_1 = self.activity.stopTime - pg.TimeMgr.GetInstance():GetServerTime()

	setText(self.textDay, i18n("battlepass_main_time", math.floor(var_10_1 / 0), math.floor(var_10_1 % 0 / 16)))

	local var_10_2 = GetComponent(self.scrollMap, typeof(ScrollRect))
	local var_10_3 = var_10_2.content.rect.width / 3 / (var_10_2.content.rect.width - var_10_2.viewport.rect.width)

	onScroll(self, self.scrollMap, function(arg_22_0)
		if arg_22_0.x < 0.1 then
			var_10_2.normalizedPosition.x = arg_22_0.x + var_10_3
			var_10_2.normalizedPosition = var_10_2.normalizedPosition
			var_10_2.velocity = var_10_2.velocity
		elseif arg_22_0.x > 0.9 then
			var_10_2.normalizedPosition.x = arg_22_0.x - var_10_3
			var_10_2.normalizedPosition = var_10_2.normalizedPosition
			var_10_2.velocity = var_10_2.velocity
		end

		return
	end)
	self:onScroll(self.comScroll, function(arg_23_0)
		self:updateNextAward(arg_23_0.y)

		return
	end)
	self:updateAwardPanel()
	self:buildPhaseAwardScrollPos()

	if self.phase == 0 then
		self.comScroll:ScrollTo(0)
	elseif self.phase == #self.awardList then
		self.comScroll:ScrollTo(1)
	else
		self.comScroll:ScrollTo(math.clamp(self.phasePos[self.phase], 0, 1))
	end

	self:updateMapStatus()
	LoadImageSpriteAtlasAsync(Drop.New({
		type = DROP_TYPE_VITEM,
		id = self.ptId
	}):getIcon(), "", self.sliderPt:Find("Text/icon"), true)
	self:updateMapWay()

	return
end

function CrusingScene:willExit()
	for iter_24_0, iter_24_1 in pairs(self.LTDic) do
		if iter_24_1 then
			LeanTween.cancel(iter_24_0)
		end
	end

	local var_24_0 = PoolMgr.GetInstance()

	for iter_24_2, iter_24_3 in ipairs(self.maps) do
		setParent(iter_24_3.rtLine, iter_24_3._tf, true)
		var_24_0:ReturnSpineChar(pg.battlepass_event_pt[self.activity.id].spine_name, go(iter_24_3.rtIcon:Find("model"):GetChild(0)))
		var_24_0:ReturnPrefab("crusingmap/" .. pg.battlepass_event_pt[self.activity.id].crusing_map, "", go(iter_24_3._tf))
	end

	if self.chargeTipWindow then
		self.chargeTipWindow:Destroy()

		self.chargeTipWindow = nil
	end

	return
end

function CrusingScene:setActivity(arg_25_1)
	self.activity = arg_25_1

	for iter_25_0, iter_25_1 in pairs(arg_25_1:GetCrusingInfo()) do
		self[iter_25_0] = iter_25_1
	end

	return
end

function CrusingScene:setPlayer(arg_26_1)
	self.player = arg_26_1

	return
end

function CrusingScene:updateAwardInfo(arg_27_1, arg_27_2)
	local var_27_0 = arg_27_2.pt <= self.pt

	if arg_27_1:Find("mask") then
		setActive(arg_27_1:Find("mask"), not var_27_0)
	end

	setText(arg_27_1:Find("Text"), arg_27_2.id)

	local var_27_1 = Drop.Create(arg_27_2.award)

	updateDrop(arg_27_1:Find("award"), var_27_1)
	setActive(arg_27_1:Find("award/get"), var_27_0 and not self.awardDic[arg_27_2.pt])
	setActive(arg_27_1:Find("award/got"), self.awardDic[arg_27_2.pt])
	setActive(arg_27_1:Find("award/mask"), self.awardDic[arg_27_2.pt])
	onButton(self, arg_27_1:Find("award"), function()
		self:emit(CrusingScene.ON_DROP, var_27_1)

		return
	end, SFX_CONFIRM)

	local var_27_2 = Drop.Create(arg_27_2.award_pay)

	updateDrop(arg_27_1:Find("award_pay"), var_27_2)
	setActive(arg_27_1:Find("award_pay/lock"), not self.isPay)
	setActive(arg_27_1:Find("award_pay/get"), self.isPay and var_27_0 and not self.awardPayDic[arg_27_2.pt])
	setActive(arg_27_1:Find("award_pay/got"), self.awardPayDic[arg_27_2.pt])
	setActive(arg_27_1:Find("award_pay/mask"), not self.isPay or self.awardPayDic[arg_27_2.pt])
	onButton(self, arg_27_1:Find("award_pay"), function()
		self:emit(CrusingScene.ON_DROP, var_27_2)

		return
	end, SFX_CONFIRM)

	return
end

function CrusingScene:updateAwardPanel()
	setText(self.textPhase, self.phase)

	if self.phase < #self.awardList then
		local var_30_0 = self.pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt)

		setSlider(self.sliderPt, 0, self.awardList[self.phase + 1].pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt), self.pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt))
		setText(self.sliderPt:Find("Text"), var_30_0 .. "/" .. self.awardList[self.phase + 1].pt - (self.phase == 0 and 0 or self.awardList[self.phase].pt))
	else
		setSlider(self.sliderPt, 0, 1, 1)
		setText(self.sliderPt:Find("Text"), "MAX")
	end

	self.nextAward = nil

	self.comScroll:SetTotalCount(#self.awardList - 1)
	self:updateNextAward(self.comScroll.value)

	local var_30_1 = #self.activity:GetCrusingUnreceiveAward() > 0

	setActive(self.btnAll, not self.isPay and var_30_1)
	setActive(self.btnPay, not self.isPay)
	setActive(self.rtAward:Find("text_image_3"), not self.isPay)
	setActive(self.btnFinish, self.isPay and self.phase == #self.awardList and not var_30_1)
	setActive(self.btnAfter, self.isPay and not isActive(self.btnFinish))
	setButtonEnabled(self.btnAfter, var_30_1)

	return
end

function CrusingScene:updateMapStatus()
	for iter_31_0, iter_31_1 in ipairs(self.maps) do
		local var_31_0
		local var_31_1 = {}

		eachChild(iter_31_1.rtLine, function(arg_32_0)
			local var_32_0 = tonumber(arg_32_0.name)

			if var_32_0 > self.phase then
				if not var_31_0 then
					var_31_0 = var_32_0

					table.insert(var_31_1, arg_32_0)
					setActive(arg_32_0, true)
				elseif var_32_0 < var_31_0 then
					while #var_31_1 > 0 do
						setActive(table.remove(var_31_1), false)
					end

					var_31_0 = var_32_0

					table.insert(var_31_1, arg_32_0)
					setActive(arg_32_0, true)
				elseif var_31_0 == var_32_0 then
					table.insert(var_31_1, arg_32_0)
					setActive(arg_32_0, true)
				else
					setActive(arg_32_0, false)
				end
			else
				setActive(arg_32_0, true)
			end

			local var_32_1 = var_32_0 > self.phase

			setGray(arg_32_0, not (var_32_0 > self.phase), false)
			setImageAlpha(arg_32_0, var_32_1 and 1 or 0.9)

			if isActive(arg_32_0) then
				local function var_32_3(arg_33_0, arg_33_1)
					local var_33_0 = getImageSprite(arg_33_0)

					if var_33_0 then
						setImageSprite(arg_33_1, var_33_0)
					end

					eachChild(arg_33_0, function(arg_34_0)
						var_32_3(arg_34_0, arg_33_1:Find(arg_34_0.name))

						return
					end)

					return
				end

				local var_32_4 = iter_31_1.rtSimple:Find(var_32_1 and "active" or "gray")

				eachChild(arg_32_0, function(arg_35_0)
					var_32_3(var_32_4:Find(arg_35_0.name), arg_35_0)

					return
				end)
			end

			return
		end)
	end

	return
end

function CrusingScene:updateMapWay()
	if self.exited or self.contextData.frozenMapUpdate then
		return
	end

	local var_36_0 = PlayerPrefs.GetInt(string.format("crusing_%d_phase_display", self.activity.id), 0)

	PlayerPrefs.SetInt(string.format("crusing_%d_phase_display", self.activity.id), self.phase)

	for iter_36_0, iter_36_1 in ipairs(self.maps) do
		local var_36_1 = GetComponent(iter_36_1.rtIcon, typeof(Animator))

		if var_36_0 < self.phase then
			local var_36_2 = self.PhaseFrame[self.phase]

			var_36_1.speed = CrusingScene.PlaySpeed

			var_36_1:Play("empty")
			var_36_1:Play("mix", 0, self.PhaseFrame[var_36_0] / self.AllFrameCount)

			if iter_36_1.rtIcon:Find("model").childCount > 0 then
				SetAction(iter_36_1.rtIcon:Find("model"):GetChild(0), "move")
			end

			local var_36_3

			var_36_3 = LeanTween.delayedCall((self.PhaseFrame[self.phase] - self.PhaseFrame[var_36_0]) / CrusingScene.FrameSpeed / CrusingScene.PlaySpeed, System.Action(function()
				var_36_1.speed = 0

				var_36_1:Play("empty")
				var_36_1:Play("mix", 0, var_36_2 / self.AllFrameCount)

				self.LTDic[var_36_3] = false

				if iter_36_1.rtIcon:Find("model").childCount > 0 then
					SetAction(iter_36_1.rtIcon:Find("model"):GetChild(0), "normal")
				end

				return
			end)).uniqueId
			self.LTDic[nil] = true
		else
			var_36_1.speed = 0

			var_36_1:Play("empty")
			var_36_1:Play("mix", 0, self.PhaseFrame[self.phase] / self.AllFrameCount)
		end
	end

	return
end

function CrusingScene:buildPhaseAwardScrollPos()
	self.phasePos = {}

	for iter_38_0 = 1, #self.awardList - 1 do
		table.insert(self.phasePos, self.comScroll:HeadIndexToValue(iter_38_0 - 1))
	end

	return
end

function CrusingScene:onScroll(arg_39_1, arg_39_2)
	assert(arg_39_2, "callback should exist")
	arg_39_1.onValueChanged:RemoveAllListeners()
	pg.DelegateInfo.Add(self, arg_39_1.onValueChanged)
	arg_39_1.onValueChanged:AddListener(arg_39_2)

	return
end

function CrusingScene:updateNextAward(arg_40_1)
	if not self.phasePos then
		return
	end

	local var_40_0 = self.phasePos[#self.phasePos] - 1
	local var_40_1 = #self.awardList

	for iter_40_0 = #self.awardList - 1, 1, -1 do
		if self.phasePos[iter_40_0] < arg_40_1 + var_40_0 or self.awardList[iter_40_0].pt <= self.pt then
			break
		elseif self.awardList[iter_40_0].isImportent then
			var_40_1 = iter_40_0
		end
	end

	if self.nextAward ~= var_40_1 then
		self.nextAward = var_40_1

		self:updateAwardInfo(self.rtNextAward, self.awardList[var_40_1])
	end

	return
end

function CrusingScene:checkLimitMax(arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		if iter_41_1.type == DROP_TYPE_RESOURCE then
			if iter_41_1.id == 1 then
				if self.player:GoldMax(iter_41_1.count) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title"))

					return true
				end
			elseif iter_41_1.id == 2 and self.player:OilMax(iter_41_1.count) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title"))

				return true
			end
		elseif iter_41_1.type == DROP_TYPE_ITEM then
			local var_41_0 = Item.getConfigData(iter_41_1.id)

			if var_41_0.type == Item.EXP_BOOK_TYPE then
				if getProxy(BagProxy):getItemCountById(iter_41_1.id) + iter_41_1.count > var_41_0.max_num then
					return true
				end
			end
		end
	end

	return false
end

function CrusingScene:openBuyPanel()
	local var_42_0 = Goods.Create({
		shop_id = self:getPassID()
	}, Goods.TYPE_CHARGE)
	local var_42_2 = {
		isChargeType = true,
		commodity = var_42_0,
		infoTip = var_42_0:GetInfoTip(),
		icon = "chargeicon/" .. var_42_0:getConfig("picture"),
		name = var_42_0:getConfig("name_display"),
		tipExtra = i18n("battlepass_pay_tip"),
		extraItems = var_42_0:GetExtraServiceItem(),
		price = var_42_0:getConfig("money"),
		isLocalPrice = var_42_0:IsLocalPrice(),
		tagType = var_42_0:getConfig("tag"),
		isMonthCard = var_42_0:isMonthCard()
	}

	var_42_2.tipBonus = nil
	var_42_2.bonusItem = nil
	var_42_2.extraDrop = var_42_0:GetExtraDrop()
	var_42_2.descExtra = var_42_0:getConfig("descrip_extra")

	function var_42_2.onYes()
		if ChargeConst.isNeedSetBirth() then
			self:emit(CrusingMediator.EVENT_OPEN_BIRTHDAY)
		else
			pg.m02:sendNotification(GAME.CHARGE_OPERATION, {
				shopId = var_42_0.id
			})
		end

		return
	end

	self:emit(CrusingMediator.EVENT_GO_CHARGE, var_42_2)

	return
end

function CrusingScene:getPassID()
	local var_44_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)

	if var_44_0 and not var_44_0:isEnd() then
		for iter_44_0, iter_44_1 in ipairs(pg.pay_data_display.all) do
			if pg.pay_data_display[iter_44_1].sub_display and type(pg.pay_data_display[iter_44_1].sub_display) == "table" and pg.pay_data_display[iter_44_1].sub_display[1] == var_44_0.id then
				return iter_44_1
			end
		end
	end

	return
end

function CrusingScene:OnChargeSuccess(arg_45_1)
	self.chargeTipWindow:ExecuteAction("Show", arg_45_1)

	return
end

return CrusingScene
