local Monopoly3thReGame = class("Monopoly3thReGame")
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
local var_0_16 = 35

function Monopoly3thReGame:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._binder = arg_1_1
	self._tf = arg_1_2
	self._event = arg_1_3
	self._configId = arg_1_4

	self:initData()
	self:initUI()
	self:initEvent()

	return
end

function Monopoly3thReGame:initData()
	self.leftCount = 0
	self.mapIds = pg.activity_event_monopoly[self._configId].map
	self.inAnimatedFlag = false
	self.lastBonusTimes = pg.activity_event_monopoly[self._configId].drop_times[1]
	self.randomMoveTiemr = Timer.New(function()
		self:checkPlayerRandomMove()

		return
	end, 15, -1)
	self.awardsTimer = Timer.New(function()
		if self.awardTfs and #self.awardTfs > 0 then
			for iter_4_0 = #self.awardTfs, 1, -1 do
				self.awardTfs[iter_4_0].anchoredPosition.y = self.awardTfs[iter_4_0].anchoredPosition.y + 3

				if self.awardTfs[iter_4_0].anchoredPosition.y >= 150 then
					Destroy(table.remove(self.awardTfs, iter_4_0))
				else
					self.awardTfs[iter_4_0].anchoredPosition = self.awardTfs[iter_4_0].anchoredPosition
				end
			end
		end

		return
	end, 0.03333333333333333, -1)

	self.awardsTimer:Start()

	return
end

function Monopoly3thReGame:initUI()
	self.char = findTF(self._tf, "map/char")

	setActive(self.char, false)
	setText(findTF(self._tf, "desc"), i18n("monopoly3thre_tip"))

	self.btnStart = findTF(self._tf, "btnStart")
	self.btnAutoStart = findTF(self._tf, "btnAutoStart")

	setActive(self.btnStart, true)
	setActive(self.btnAutoStart, true)

	self.btnCancelAuto = findTF(self._tf, "btnCancelAuto")

	setActive(self.btnCancelAuto, false)

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
	self.awardTf = findTF(self._tf, "awardTpl")
	self.awardParent = findTF(self.char, "award")

	for iter_5_0 = 1, 3 do
		local var_5_0 = findTF(self._tf, "map/mask/ground" .. iter_5_0)
		local var_5_1 = {}

		for iter_5_1 = 1, var_5_0.childCount do
			table.insert(var_5_1, var_5_0:GetChild(iter_5_1 - 1))
		end

		table.insert(self.groundChildsList, var_5_1)
	end

	PoolMgr.GetInstance():GetSpineChar(Ship.New({
		configId = var_0_1,
		skin_id = var_0_2
	}):getPrefab(), true, function(arg_6_0)
		self.model = arg_6_0
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

function Monopoly3thReGame:initEvent()
	onButton(self._binder, self.btnAutoStart, function()
		setActive(self.btnCancelAuto, true)

		self.autoFlag = true

		self:start()

		return
	end, SFX_PANEL)
	onButton(self._binder, self.btnCancelAuto, function()
		setActive(self.btnCancelAuto, false)

		self.autoFlag = false

		return
	end, SFX_PANEL)
	onButton(self._binder, self.btnStart, function()
		self:start()

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
			self._event:emit(Monopoly3thRePage.ON_AWARD)
		end

		return
	end, SFX_PANEL)

	return
end

function Monopoly3thReGame:addAwards(arg_15_1)
	self.awardTfs = self.awardTfs or {}

	for iter_15_0 = 1, #arg_15_1 do
		local var_15_0 = tf(instantiate(go(self.awardTf)))

		setParent(var_15_0, self.awardParent)
		updateDrop(var_15_0, arg_15_1[iter_15_0])

		var_15_0.anchoredPosition = Vector2(0, 0)

		setActive(var_15_0, true)
		table.insert(self.awardTfs, var_15_0)
	end

	return
end

function Monopoly3thReGame:start()
	if self.inAnimatedFlag then
		return
	end

	if self.leftCount and self.leftCount <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

		if self.autoFlag and not self:checkLastBonus() then
			self.autoFlag = false

			setActive(self.btnCancelAuto, false)
			self:changeAnimeState(false, true)
		end

		return
	end

	self:changeAnimeState(true)
	self._event:emit(Monopoly3thRePage.ON_START, self.activity.id, function(arg_17_0)
		if arg_17_0 and arg_17_0 > 0 then
			self.step = arg_17_0

			self:updataUI()
			self:checkCharActive()
		end

		return
	end)

	return
end

function Monopoly3thReGame:checkPlayerRandomMove()
	if not self.model or self.inAnimatedFlag then
		return
	end

	if math.random() > 0.5 then
		local var_18_0 = math.random(2, 4)
		local var_18_1 = 0

		self:changeCharAction(var_0_10, 0, nil)
		LeanTween.value(go(self.cellPos), 0, 300 * var_18_0, var_18_0 * 2):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_19_0)
			self:updateMap(arg_19_0 - var_18_1)

			var_18_1 = arg_19_0

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

function Monopoly3thReGame:checkCountStory(arg_22_1)
	local var_22_0 = self.useCount
	local var_22_1 = _.detect(self.activity:getDataConfig("story") or {}, function(arg_23_0)
		return arg_23_0[1] == var_22_0
	end)

	if var_22_1 then
		pg.NewStoryMgr.GetInstance():Play(var_22_1[2], arg_22_1)
	else
		arg_22_1()
	end

	return
end

function Monopoly3thReGame:changeAnimeState(arg_24_1, arg_24_2)
	if arg_24_1 then
		self.btnStart:GetComponent(typeof(Image)).raycastTarget = false
		self.btnAutoStart:GetComponent(typeof(Image)).raycastTarget = false
		self.inAnimatedFlag = true
	else
		self.inAnimatedFlag = false
		self.btnStart:GetComponent(typeof(Image)).raycastTarget = true
		self.btnAutoStart:GetComponent(typeof(Image)).raycastTarget = true
	end

	if not arg_24_1 and self.autoFlag then
		self:start()
		setActive(self.btnStart, false)
		setActive(self.btnAutoStart, false)
	else
		setActive(self.btnStart, not arg_24_1)
		setActive(self.btnAutoStart, not arg_24_1)
	end

	if not arg_24_1 and not self.autoFlag and arg_24_2 then
		self._event:emit(Monopoly3thRePage.ON_STOP, nil, function()
			return
		end)
	end

	return
end

function Monopoly3thReGame:checkCharActive()
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

function Monopoly3thReGame:firstUpdata(arg_29_1)
	self:activityDataUpdata(arg_29_1)
	self:updataUI()
	self:updataChar()
	self:checkCharActive()
	self:checkLastBonus()

	if self.pos and self.pos > 0 then
		self:updateMap(self.pos * 1100 % 2500)
	end

	return
end

function Monopoly3thReGame:updataActivity(arg_30_1)
	self:activityDataUpdata(arg_30_1)
	self:updataUI()

	return
end

function Monopoly3thReGame:checkLastBonus()
	if (not self.lastBonusFlag or self.lastBonusFlag == 0) and self.useCount and self.useCount >= self.lastBonusTimes then
		self._event:emit(Monopoly3thRePage.MONOPOLY_OP_LAST, self.activity.id, function(arg_32_0)
			self.lastBonusFlag = 1

			setActive(findTF(self.labelDropShip, "get"), false)
			setActive(findTF(self.labelDropShip, "got"), true)
			setActive(findTF(self.labelDropShip, "text"), false)

			if self.autoFlag then
				self:start()
			end

			return
		end)

		return true
	end

	if self.lastBonusFlag == 1 then
		setActive(findTF(self.labelDropShip, "get"), false)
		setActive(findTF(self.labelDropShip, "got"), true)
		setActive(findTF(self.labelDropShip, "text"), false)
	end

	return false
end

function Monopoly3thReGame:activityDataUpdata(arg_33_1)
	self.activity = arg_33_1
	self.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - self.activity.data1) / 0) * self.activity:getDataConfig("daily_time") + self.activity.data1_list[1]
	self.useCount = self.activity.data1_list[2]
	self.leftCount = self.totalCnt - self.useCount
	self.turnCnt = self.activity.data1_list[3] - 1
	self.leftDropShipCnt = 8 - self.turnCnt

	local var_33_0 = self.activity.data2_list[2]

	self.advanceTotalCnt = #arg_33_1:getDataConfig("reward")
	self.isAdvanceRp = self.advanceTotalCnt - var_33_0 > 0
	self.leftAwardCnt = self.activity.data2_list[1] - var_33_0
	self.advanceRpCount = math.max(0, math.min(self.activity.data2_list[1], self.advanceTotalCnt) - var_33_0)
	self.commonRpCount = math.max(0, self.activity.data2_list[1] - self.advanceTotalCnt) - math.max(0, var_33_0 - self.advanceTotalCnt)

	local var_33_1 = arg_33_1:getDataConfig("reward_time")

	self.nextredPacketStep = var_33_1 - self.useCount % var_33_1

	if self.useCount >= var_0_16 then
		self.nextredPacketStep = nil
	end

	self.pos = self.activity.data2
	self.step = self.activity.data3 or 0
	self.effectId = self.activity.data4 or 0
	self.lastBonusFlag = self.activity.data2_list[3]

	return
end

function Monopoly3thReGame:checkStep(arg_34_1)
	if self.step > 0 then
		self._event:emit(Monopoly3thRePage.ON_MOVE, self.activity.id, function(arg_35_0, arg_35_1, arg_35_2)
			self.step = arg_35_0
			self.pos = arg_35_1[#arg_35_1]
			self.effectId = arg_35_2

			seriesAsync({
				function(arg_36_0)
					self:moveCharWithPaths(arg_35_1, var_0_14, arg_36_0)

					return
				end,
				function(arg_37_0)
					self:checkEffect(arg_37_0)

					return
				end
			}, function()
				if arg_34_1 then
					arg_34_1()
				end

				return
			end)

			return
		end)
	elseif arg_34_1 then
		arg_34_1()
	end

	return
end

function Monopoly3thReGame:updataUI()
	setText(self.labelLeftRpCount, "" .. self.leftAwardCnt)

	if LeanTween.isTweening(go(self.btnRp)) then
		LeanTween.cancel(go(self.btnRp))
	end

	LeanTween.delayedCall(go(self.btnRp), 1, System.Action(function()
		if self.commonAnim.isActiveAndEnabled then
			self.commonAnim:SetInteger("count", self.leftAwardCnt)
		end

		return
	end))

	if self.lastBonusTimes - self.useCount > 0 then
		setText(findTF(self.labelDropShip, "text"), "" .. self.lastBonusTimes - self.useCount)
	end

	if self.nextredPacketStep and self.nextredPacketStep ~= 0 then
		setText(self.labelLeftCountTip, self.nextredPacketStep)
		setActive(self.labelLeftCountTip, true)
		setActive(findTF(self._tf, "countTip/ad"), true)
		setActive(findTF(self._tf, "countTip/adB"), false)
	else
		setText(self.labelLeftCountTip, "")
		setActive(self.labelLeftCountTip, false)
		setActive(findTF(self._tf, "countTip/ad"), false)
		setActive(findTF(self._tf, "countTip/adB"), true)
	end

	setText(self.labelLeftCount, self.leftCount)

	return
end

function Monopoly3thReGame:updataChar()
	if not isActive(self.char) then
		SetActive(self.char, true)
		self.char:SetAsLastSibling()
	end

	return
end

function Monopoly3thReGame:checkEffect(arg_42_1)
	if self.effectId > 0 then
		local var_42_0 = pg.activity_event_monopoly_event[self.effectId].story
		local var_42_1 = self:getActionName(self.pos)

		seriesAsync({
			function(arg_43_0)
				if var_42_1 then
					self:changeCharAction(var_42_1, 1, function()
						self:changeCharAction(var_0_11, 0, nil)
						arg_43_0()

						return
					end)
				else
					arg_43_0()
				end

				return
			end,
			function(arg_45_0)
				if var_42_0 and tonumber(var_42_0) ~= 0 then
					pg.NewStoryMgr.GetInstance():Play(var_42_0, arg_45_0, true, true)
				else
					arg_45_0()
				end

				return
			end,
			function(arg_46_0)
				self:triggerEfect(arg_46_0)

				return
			end,
			function(arg_47_0)
				self:checkCountStory(arg_47_0)

				return
			end
		}, arg_42_1)
	elseif arg_42_1 then
		arg_42_1()
	end

	return
end

function Monopoly3thReGame:triggerEfect(arg_48_1)
	self._event:emit(Monopoly3thRePage.ON_TRIGGER, self.activity.id, function(arg_49_0, arg_49_1)
		if arg_49_0 and #arg_49_0 >= 0 then
			self.effectId = arg_49_1
			self.pos = arg_49_0[#arg_49_0]

			seriesAsync({
				function(arg_50_0)
					self:moveCharWithPaths(arg_49_0, var_0_10, arg_50_0)

					return
				end
			}, function()
				arg_48_1()

				return
			end)
		end

		return
	end)

	return
end

function Monopoly3thReGame:moveCharWithPaths(arg_52_1, arg_52_2, arg_52_3)
	if not arg_52_1 or #arg_52_1 <= 0 then
		if arg_52_3 then
			arg_52_3()
		end

		return
	end

	local var_52_0 = {}

	table.insert(var_52_0, function(arg_53_0)
		local var_53_0 = arg_52_2 ~= var_0_14 and 4 or 2
		local var_53_1 = 1100
		local var_53_2 = 0

		self:createCell(1100)
		self:changeCharAction(arg_52_2, 0, nil)

		if LeanTween.isTweening(go(self.cellPos)) then
			LeanTween.cancel(go(self.cellPos))
		end

		LeanTween.value(go(self.cellPos), 0, var_53_1, var_53_0):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_54_0)
			self:updateMap(arg_54_0 - var_53_2)

			var_53_2 = arg_54_0

			return
		end)):setOnComplete(System.Action(function()
			arg_53_0()

			return
		end))

		return
	end)
	table.insert(var_52_0, function(arg_56_0)
		self:changeCharAction(var_0_11, 0, nil)
		arg_56_0()

		return
	end)
	seriesAsync(var_52_0, arg_52_3)

	return
end

function Monopoly3thReGame:createCell(arg_57_1)
	local var_57_0 = tf(instantiate(go(self.tplCell)))

	var_57_0.localPosition = Vector3(arg_57_1, 0, 0)
	findTF(var_57_0, "icon"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/activityuipage/monopoly3thre_atlas", pg.activity_event_monopoly_map[self.mapIds[self.pos]].icon)

	findTF(var_57_0, "icon"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(var_57_0, true)
	setParent(var_57_0, self.cellPos)
	table.insert(self.mapCells, var_57_0)

	return
end

function Monopoly3thReGame:updateMap(arg_58_1)
	for iter_58_0 = 1, #self.mapCells do
		self.mapCells[iter_58_0].anchoredPosition.x = self.mapCells[iter_58_0].anchoredPosition.x - arg_58_1
		self.mapCells[iter_58_0].anchoredPosition = self.mapCells[iter_58_0].anchoredPosition
	end

	if #self.mapCells > 0 and self.mapCells[1].anchoredPosition.x < -1000 then
		Destroy((table.remove(self.mapCells, 1)))
	end

	for iter_58_1 = 1, #self.groundChildsList do
		for iter_58_2 = #self.groundChildsList[iter_58_1], 1, -1 do
			self.groundChildsList[iter_58_1][iter_58_2].anchoredPosition = Vector3(self.groundChildsList[iter_58_1][iter_58_2].anchoredPosition.x - arg_58_1 * self.groundMoveRate[iter_58_1], self.groundChildsList[iter_58_1][iter_58_2].anchoredPosition.y, self.groundChildsList[iter_58_1][iter_58_2].anchoredPosition.z)
		end
	end

	for iter_58_3 = 1, #self.groundChildsList do
		for iter_58_4 = #self.groundChildsList[iter_58_3], 1, -1 do
			if self.groundChildsList[iter_58_3][iter_58_4].anchoredPosition.x <= -self.groundChildsList[iter_58_3][iter_58_4].sizeDelta.x and #self.groundChildsList[iter_58_3] > 1 then
				local var_58_0 = table.remove(self.groundChildsList[iter_58_3], iter_58_4)

				var_58_0.anchoredPosition = Vector3(self.groundChildsList[iter_58_3][#self.groundChildsList[iter_58_3]].anchoredPosition.x + self.groundChildsList[iter_58_3][#self.groundChildsList[iter_58_3]].sizeDelta.x, self.groundChildsList[iter_58_3][iter_58_4].anchoredPosition.y, self.groundChildsList[iter_58_3][iter_58_4].anchoredPosition.z)

				table.insert(self.groundChildsList[iter_58_3], var_58_0)
			end
		end
	end

	return
end

function Monopoly3thReGame:changeCharAction(arg_59_1, arg_59_2, arg_59_3)
	if self.actionName == arg_59_1 and self.actionName ~= var_0_13 then
		return
	end

	self.actionName = arg_59_1

	self.anim:SetActionCallBack(nil)
	self.anim:SetAction(arg_59_1, 0)
	self.anim:SetActionCallBack(function(arg_60_0)
		if arg_60_0 == "finish" then
			if arg_59_2 == 1 then
				self.anim:SetActionCallBack(nil)
				self.anim:SetAction(var_0_11, 0)
			end

			if arg_59_3 then
				arg_59_3()
			end
		end

		return
	end)

	if arg_59_2 ~= 1 and arg_59_3 then
		arg_59_3()
	end

	return
end

function Monopoly3thReGame:getActionName(arg_61_1)
	if pg.activity_event_monopoly_map[self.mapIds[arg_61_1]].icon == "icon_1" then
		return var_0_9
	elseif pg.activity_event_monopoly_map[self.mapIds[arg_61_1]].icon == "icon_2" then
		return var_0_7
	elseif pg.activity_event_monopoly_map[self.mapIds[arg_61_1]].icon == "icon_3" then
		return nil
	elseif pg.activity_event_monopoly_map[self.mapIds[arg_61_1]].icon == "icon_4" then
		return var_0_9
	elseif pg.activity_event_monopoly_map[self.mapIds[arg_61_1]].icon == "icon_5" then
		return var_0_8
	elseif pg.activity_event_monopoly_map[self.mapIds[arg_61_1]].icon == "icon_6" then
		return var_0_9
	end

	return var_0_9
end

function Monopoly3thReGame:onHide()
	return
end

function Monopoly3thReGame:dispose()
	if self.model then
		PoolMgr.GetInstance():ReturnSpineChar(var_0_1, self.model)
	end

	for iter_63_0 = #self.mapCells, 1, -1 do
		Destroy(self.mapCells[iter_63_0])
	end

	self.mapCells = {}

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

	if self.awardsTimer then
		if self.awardsTimer.running then
			self.awardsTimer:Stop()
		end

		self.awardsTimer = nil
	end

	if self.awardTfs and #self.awardTfs > 0 then
		for iter_63_1 = #self.awardTfs, 1, -1 do
			Destroy(table.remove(self.awardTfs, iter_63_1))
		end
	end

	return
end

return Monopoly3thReGame
