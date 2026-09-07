local Monopoly3thGame = class("Monopoly3thGame")
local var_0_1 = 25
local var_0_2 = 25
local var_0_7 = "dafuweng_gold"
local var_0_8 = "dafuweng_oil"
local var_0_9 = "dafuweng_event"
local var_0_10 = "dafuweng_walk"
local var_0_11 = "stand"
local var_0_12 = "dafuweng_stand"
local var_0_13 = "dafuweng_jump"
local var_0_14 = "dafuweng_run"
local var_0_15 = "dafuweng_touch"

function Monopoly3thGame:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._binder = arg_1_1
	self._tf = arg_1_2
	self._event = arg_1_3
	self._configId = arg_1_4

	self:initData()
	self:initUI()
	self:initEvent()

	return
end

function Monopoly3thGame:initData()
	self.leftCount = 0
	self.inAnimatedFlag = false
	self.mapIds = pg.activity_event_monopoly[self._configId].map
	self.lastBonusTimes = pg.activity_event_monopoly[self._configId].drop_times[1]
	self.randomMoveTiemr = Timer.New(function()
		self:checkPlayerRandomMove()

		return
	end, 15, -1)

	return
end

function Monopoly3thGame:initUI()
	self.char = findTF(self._tf, "map/char")

	setActive(self.char, false)

	self.btnStart = findTF(self._tf, "btnStart")
	self.btnHelp = findTF(self._tf, "btnHelp")
	self.btnRp = findTF(self._tf, "btnRp")
	self.commonAnim = findTF(self.btnRp, "rpAni"):GetComponent(typeof(Animator))
	self.labelLeftCountTip = findTF(self._tf, "countTip/labelLeftCountTip")
	self.labelLeftCount = findTF(self._tf, "countTip/labelLeftCount")
	self.labelDropShip = findTF(self._tf, "labelDropShip")
	self.labelLeftRpCount = findTF(self._tf, "labelLeftRpCount")
	self.cellPos = findTF(self._tf, "map/mask/posCell")
	self.tplCell = findTF(self._tf, "map/mask/posCell/tplCell")
	self.mapCells = {}
	self.curCellIndex = nil
	self.groundChildsList = {}
	self.groundMoveRate = {
		0.1,
		0.3,
		1
	}

	for iter_4_0 = 1, 3 do
		local var_4_0 = findTF(self._tf, "map/mask/ground" .. iter_4_0)
		local var_4_1 = {}

		for iter_4_1 = 1, var_4_0.childCount do
			table.insert(var_4_1, var_4_0:GetChild(iter_4_1 - 1))
		end

		table.insert(self.groundChildsList, var_4_1)
	end

	PoolMgr.GetInstance():GetSpineChar(Ship.New({
		configId = var_0_1,
		skin_id = var_0_2
	}):getPrefab(), true, function(arg_5_0)
		self.model = arg_5_0
		self.model.transform.localScale = Vector3.one
		self.model.transform.localPosition = Vector3.zero

		self.model.transform:SetParent(self.char, false)

		self.anim = self.model:GetComponent(typeof(SpineAnimUI))

		self:changeCharAction(var_0_11, 0, nil)
		self:checkCharActive()

		return
	end)
	self.randomMoveTiemr:Start()

	return
end

function Monopoly3thGame:initEvent()
	onButton(self._binder, self.btnStart, function()
		if self.inAnimatedFlag then
			return
		end

		if self.leftCount and self.leftCount <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

			return
		end

		self:changeAnimeState(true)
		self._event:emit(Monopoly3thPage.ON_START, self.activity.id, function(arg_8_0)
			if arg_8_0 and arg_8_0 > 0 then
				self.step = arg_8_0

				self:updataUI()
				self:checkCharActive()
			end

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self._binder, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_monopoly_3th.tip
		})

		return
	end, SFX_PANEL)
	onButton(self._binder, self.char, function()
		if not self.model or self.inAnimatedFlag then
			return
		end

		if LeanTween.isTweening(go(self.cellPos)) then
			LeanTween.cancel(go(self.cellPos))
		end

		self:changeCharAction(var_0_15, 1, function()
			self:changeCharAction(var_0_11)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self._binder, self.btnRp, function()
		if self.leftAwardCnt > 0 then
			self._event:emit(Monopoly3thPage.ON_AWARD)
		end

		return
	end, SFX_PANEL)

	return
end

function Monopoly3thGame:checkPlayerRandomMove()
	if not self.model or self.inAnimatedFlag then
		return
	end

	if math.random() > 0.5 then
		local var_13_0 = math.random(2, 4)
		local var_13_1 = 0

		self:changeCharAction(var_0_10, 0, nil)
		LeanTween.value(go(self.cellPos), 0, 300 * var_13_0, var_13_0 * 2):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_14_0)
			self:updateMap(arg_14_0 - var_13_1)

			var_13_1 = arg_14_0

			return
		end)):setOnComplete(System.Action(function()
			self:changeCharAction(var_0_11, 0, nil)

			return
		end))
	else
		self:changeCharAction(var_0_12, 1, function()
			self:changeCharAction(var_0_11)

			return
		end)
	end

	return
end

function Monopoly3thGame:checkCountStory(arg_17_1)
	local var_17_0 = self.useCount
	local var_17_1 = _.detect(self.activity:getDataConfig("story") or {}, function(arg_18_0)
		return arg_18_0[1] == var_17_0
	end)

	if var_17_1 then
		pg.NewStoryMgr.GetInstance():Play(var_17_1[2], arg_17_1)
	else
		arg_17_1()
	end

	return
end

function Monopoly3thGame:changeAnimeState(arg_19_1)
	if arg_19_1 then
		self.btnStart:GetComponent(typeof(Image)).raycastTarget = false
		self.inAnimatedFlag = true

		self._event:emit(ActivityMainScene.LOCK_ACT_MAIN, true)
	else
		self.inAnimatedFlag = false
		self.btnStart:GetComponent(typeof(Image)).raycastTarget = true

		self._event:emit(ActivityMainScene.LOCK_ACT_MAIN, false)
	end

	setActive(self.btnStart, not arg_19_1)

	return
end

function Monopoly3thGame:checkCharActive()
	if self.anim then
		if self.effectId and self.effectId > 0 then
			self:changeAnimeState(true)
			self:checkEffect(function()
				self:changeAnimeState(false)
				self:checkCharActive()

				return
			end)
		elseif self.step and self.step > 0 then
			self:changeAnimeState(true)
			self:checkStep(function()
				self:changeAnimeState(false)
				self:checkCharActive()

				return
			end)
		else
			self:checkLastBonus()
		end
	end

	return
end

function Monopoly3thGame:firstUpdata(arg_23_1)
	self:activityDataUpdata(arg_23_1)
	self:updataUI()
	self:updataChar()
	self:checkCharActive()
	self:checkLastBonus()

	if self.pos and self.pos > 0 then
		self:updateMap(self.pos * 1100 % 2500)
	end

	return
end

function Monopoly3thGame:updataActivity(arg_24_1)
	self:activityDataUpdata(arg_24_1)
	self:updataUI()

	return
end

function Monopoly3thGame:checkLastBonus()
	if (not self.lastBonusFlag or self.lastBonusFlag == 0) and self.useCount and self.useCount >= self.lastBonusTimes then
		self._event:emit(Monopoly3thPage.MONOPOLY_OP_LAST, self.activity.id, function(arg_26_0)
			self.lastBonusFlag = 1

			setActive(findTF(self.labelDropShip, "get"), false)
			setActive(findTF(self.labelDropShip, "got"), true)
			setActive(findTF(self.labelDropShip, "text"), false)

			return
		end)
	end

	if self.lastBonusFlag == 1 then
		setActive(findTF(self.labelDropShip, "get"), false)
		setActive(findTF(self.labelDropShip, "got"), true)
		setActive(findTF(self.labelDropShip, "text"), false)
	end

	return
end

function Monopoly3thGame:activityDataUpdata(arg_27_1)
	self.activity = arg_27_1
	self.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - self.activity.data1) / 0) * self.activity:getDataConfig("daily_time") + self.activity.data1_list[1]
	self.useCount = self.activity.data1_list[2]
	self.leftCount = self.totalCnt - self.useCount
	self.turnCnt = self.activity.data1_list[3] - 1
	self.leftDropShipCnt = 8 - self.turnCnt

	local var_27_0 = self.activity.data2_list[2]

	self.advanceTotalCnt = #arg_27_1:getDataConfig("reward")
	self.isAdvanceRp = self.advanceTotalCnt - var_27_0 > 0
	self.leftAwardCnt = self.activity.data2_list[1] - var_27_0
	self.advanceRpCount = math.max(0, math.min(self.activity.data2_list[1], self.advanceTotalCnt) - var_27_0)
	self.commonRpCount = math.max(0, self.activity.data2_list[1] - self.advanceTotalCnt) - math.max(0, var_27_0 - self.advanceTotalCnt)

	local var_27_1 = arg_27_1:getDataConfig("reward_time")

	self.nextredPacketStep = var_27_1 - self.useCount % var_27_1
	self.pos = self.activity.data2
	self.step = self.activity.data3 or 0
	self.effectId = self.activity.data4 or 0
	self.lastBonusFlag = self.activity.data2_list[3]

	return
end

function Monopoly3thGame:checkStep(arg_28_1)
	if self.step > 0 then
		self._event:emit(Monopoly3thPage.ON_MOVE, self.activity.id, function(arg_29_0, arg_29_1, arg_29_2)
			self.step = arg_29_0
			self.pos = arg_29_1[#arg_29_1]
			self.effectId = arg_29_2

			seriesAsync({
				function(arg_30_0)
					self:moveCharWithPaths(arg_29_1, var_0_14, arg_30_0)

					return
				end,
				function(arg_31_0)
					self:checkEffect(arg_31_0)

					return
				end
			}, function()
				if arg_28_1 then
					arg_28_1()
				end

				return
			end)

			return
		end)
	elseif arg_28_1 then
		arg_28_1()
	end

	return
end

function Monopoly3thGame:updataUI()
	setText(self.labelLeftRpCount, "" .. self.leftAwardCnt)
	LeanTween.delayedCall(go(self.btnRp), 1, System.Action(function()
		if self.commonAnim.isActiveAndEnabled then
			self.commonAnim:SetInteger("count", self.leftAwardCnt)
		end

		return
	end))

	if self.lastBonusTimes - self.useCount > 0 then
		setText(findTF(self.labelDropShip, "text"), "" .. self.lastBonusTimes - self.useCount)
	end

	setText(self.labelLeftCountTip, self.nextredPacketStep)
	setText(self.labelLeftCount, self.leftCount)

	return
end

function Monopoly3thGame:updataChar()
	if not isActive(self.char) then
		SetActive(self.char, true)
		self.char:SetAsLastSibling()
	end

	return
end

function Monopoly3thGame:checkEffect(arg_36_1)
	if self.effectId > 0 then
		local var_36_0 = pg.activity_event_monopoly_event[self.effectId].story
		local var_36_1 = self:getActionName(self.pos)

		seriesAsync({
			function(arg_37_0)
				if var_36_1 then
					self:changeCharAction(var_36_1, 1, function()
						self:changeCharAction(var_0_11, 0, nil)
						arg_37_0()

						return
					end)
				else
					arg_37_0()
				end

				return
			end,
			function(arg_39_0)
				if var_36_0 and tonumber(var_36_0) ~= 0 then
					pg.NewStoryMgr.GetInstance():Play(var_36_0, arg_39_0, true, true)
				else
					arg_39_0()
				end

				return
			end,
			function(arg_40_0)
				self:triggerEfect(arg_40_0)

				return
			end,
			function(arg_41_0)
				self:checkCountStory(arg_41_0)

				return
			end
		}, arg_36_1)
	elseif arg_36_1 then
		arg_36_1()
	end

	return
end

function Monopoly3thGame:triggerEfect(arg_42_1)
	self._event:emit(Monopoly3thPage.ON_TRIGGER, self.activity.id, function(arg_43_0, arg_43_1)
		if arg_43_0 and #arg_43_0 >= 0 then
			self.effectId = arg_43_1
			self.pos = arg_43_0[#arg_43_0]

			seriesAsync({
				function(arg_44_0)
					self:moveCharWithPaths(arg_43_0, var_0_10, arg_44_0)

					return
				end
			}, function()
				arg_42_1()

				return
			end)
		end

		return
	end)

	return
end

function Monopoly3thGame:moveCharWithPaths(arg_46_1, arg_46_2, arg_46_3)
	if not arg_46_1 or #arg_46_1 <= 0 then
		if arg_46_3 then
			arg_46_3()
		end

		return
	end

	local var_46_0 = {}

	table.insert(var_46_0, function(arg_47_0)
		local var_47_0 = arg_46_2 ~= var_0_14 and 4 or 2
		local var_47_1 = 1100
		local var_47_2 = 0

		self:createCell(1100)
		self:changeCharAction(arg_46_2, 0, nil)

		if LeanTween.isTweening(go(self.cellPos)) then
			LeanTween.cancel(go(self.cellPos))
		end

		LeanTween.value(go(self.cellPos), 0, var_47_1, var_47_0):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_48_0)
			self:updateMap(arg_48_0 - var_47_2)

			var_47_2 = arg_48_0

			return
		end)):setOnComplete(System.Action(function()
			arg_47_0()

			return
		end))

		return
	end)
	table.insert(var_46_0, function(arg_50_0)
		self:changeCharAction(var_0_11, 0, nil)
		arg_50_0()

		return
	end)
	seriesAsync(var_46_0, arg_46_3)

	return
end

function Monopoly3thGame:createCell(arg_51_1)
	local var_51_0 = tf(instantiate(go(self.tplCell)))

	var_51_0.localPosition = Vector3(arg_51_1, 0, 0)
	findTF(var_51_0, "icon"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/activityuipage/monopoly3th_atlas", pg.activity_event_monopoly_map[self.mapIds[self.pos]].icon)

	findTF(var_51_0, "icon"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(var_51_0, true)
	setParent(var_51_0, self.cellPos)
	table.insert(self.mapCells, var_51_0)

	return
end

function Monopoly3thGame:updateMap(arg_52_1)
	for iter_52_0 = 1, #self.mapCells do
		self.mapCells[iter_52_0].anchoredPosition.x = self.mapCells[iter_52_0].anchoredPosition.x - arg_52_1
		self.mapCells[iter_52_0].anchoredPosition = self.mapCells[iter_52_0].anchoredPosition
	end

	if #self.mapCells > 0 and self.mapCells[1].anchoredPosition.x < -1000 then
		Destroy((table.remove(self.mapCells, 1)))
	end

	for iter_52_1 = 1, #self.groundChildsList do
		for iter_52_2 = #self.groundChildsList[iter_52_1], 1, -1 do
			self.groundChildsList[iter_52_1][iter_52_2].anchoredPosition = Vector3(self.groundChildsList[iter_52_1][iter_52_2].anchoredPosition.x - arg_52_1 * self.groundMoveRate[iter_52_1], self.groundChildsList[iter_52_1][iter_52_2].anchoredPosition.y, self.groundChildsList[iter_52_1][iter_52_2].anchoredPosition.z)
		end
	end

	for iter_52_3 = 1, #self.groundChildsList do
		for iter_52_4 = #self.groundChildsList[iter_52_3], 1, -1 do
			if self.groundChildsList[iter_52_3][iter_52_4].anchoredPosition.x <= -self.groundChildsList[iter_52_3][iter_52_4].sizeDelta.x and #self.groundChildsList[iter_52_3] > 1 then
				local var_52_0 = table.remove(self.groundChildsList[iter_52_3], iter_52_4)

				var_52_0.anchoredPosition = Vector3(self.groundChildsList[iter_52_3][#self.groundChildsList[iter_52_3]].anchoredPosition.x + self.groundChildsList[iter_52_3][#self.groundChildsList[iter_52_3]].sizeDelta.x, self.groundChildsList[iter_52_3][iter_52_4].anchoredPosition.y, self.groundChildsList[iter_52_3][iter_52_4].anchoredPosition.z)

				table.insert(self.groundChildsList[iter_52_3], var_52_0)
			end
		end
	end

	return
end

function Monopoly3thGame:changeCharAction(arg_53_1, arg_53_2, arg_53_3)
	if self.actionName == arg_53_1 and self.actionName ~= var_0_13 then
		return
	end

	self.actionName = arg_53_1

	self.anim:SetActionCallBack(nil)
	self.anim:SetAction(arg_53_1, 0)
	self.anim:SetActionCallBack(function(arg_54_0)
		if arg_54_0 == "finish" then
			if arg_53_2 == 1 then
				self.anim:SetActionCallBack(nil)
				self.anim:SetAction(var_0_11, 0)
			end

			if arg_53_3 then
				arg_53_3()
			end
		end

		return
	end)

	if arg_53_2 ~= 1 and arg_53_3 then
		arg_53_3()
	end

	return
end

function Monopoly3thGame:getActionName(arg_55_1)
	if pg.activity_event_monopoly_map[self.mapIds[arg_55_1]].icon == "icon_1" then
		return var_0_9
	elseif pg.activity_event_monopoly_map[self.mapIds[arg_55_1]].icon == "icon_2" then
		return var_0_7
	elseif pg.activity_event_monopoly_map[self.mapIds[arg_55_1]].icon == "icon_3" then
		return nil
	elseif pg.activity_event_monopoly_map[self.mapIds[arg_55_1]].icon == "icon_4" then
		return var_0_9
	elseif pg.activity_event_monopoly_map[self.mapIds[arg_55_1]].icon == "icon_5" then
		return var_0_8
	elseif pg.activity_event_monopoly_map[self.mapIds[arg_55_1]].icon == "icon_6" then
		return var_0_9
	end

	return var_0_9
end

function Monopoly3thGame:dispose()
	if self.model then
		PoolMgr.GetInstance():ReturnSpineChar(var_0_1, self.model)
	end

	if self.randomMoveTiemr then
		if self.randomMoveTiemr.running then
			self.randomMoveTiemr:Stop()
		end

		self.randomMoveTiemr = nil
	end

	if LeanTween.isTweening(go(self.btnRp)) then
		LeanTween.cancel(go(self.btnRp))
	end

	if LeanTween.isTweening(go(self.cellPos)) then
		LeanTween.cancel(go(self.cellPos))
	end

	return
end

return Monopoly3thGame
