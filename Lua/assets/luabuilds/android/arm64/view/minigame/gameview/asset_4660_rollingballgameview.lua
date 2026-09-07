local RollingBallGameView = class("RollingBallGameView", import("..BaseMiniGameView"))
local var_0_1 = "event:/ui/ddldaoshu2"
local var_0_2 = "event:/ui/boat_drag"
local var_0_3 = "event:/ui/break_out_full"
local var_0_4 = "event:/ui/sx-good"
local var_0_5 = "event:/ui/sx-perfect"
local var_0_6 = "event:/ui/sx-jishu"
local var_0_7 = "event:/ui/furnitrue_save"

function RollingBallGameView:getUIName()
	return "RollingBallGameUI"
end

function RollingBallGameView:init()
	local var_2_0 = self:GetMGData()
	local var_2_1 = self:GetMGHubData()

	self.tplScoreTip = findTF(self._tf, "tplScoreTip")
	self.tplRemoveEffect = findTF(self._tf, "sanxiaoxiaoshi")
	self.effectUI = findTF(self._tf, "effectUI")
	self.tplEffect = findTF(self._tf, "tplEffect")
	self.effectPoolTf = findTF(self._tf, "effectPool")
	self.effectPool = {}
	self.effectDatas = {}
	self.effectTargetPosition = findTF(self.effectUI, "effectTargetPos").localPosition
	self.rollingUI = findTF(self._tf, "rollingUI")
	self.rollingEffectUI = findTF(self._tf, "rollingEffectUI")
	self.tplGrid = findTF(self._tf, "tplRollingGrid")
	self.gridPoolTf = findTF(self._tf, "gridPool")
	self.gridsPool = {}
	self.gridDic = {}
	self.fillGridDic = {}
	self.startFlag = false
	self.dragAlphaGrid = RollingBallGrid.New((findTF(self.rollingUI, "dragAlphaGrid")))

	setActive(self.dragAlphaGrid:getTf(), false)

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 0.016666666666666666, -1)

	for iter_2_0 = 1, RollingBallConst.horizontal do
		self.gridDic[iter_2_0] = {}
		self.fillGridDic[iter_2_0] = {}

		for iter_2_1 = 1, RollingBallConst.vertical do
			table.insert(self.gridDic[iter_2_0], false)
		end
	end

	self.goodEffect = self._tf:Find("sanxiaoGood")
	self.greatEffect = self._tf:Find("sanxiaoGreat")
	self.perfectEffect = self._tf:Find("sanxiaoPerfect")
	self.caidaiTf = findTF(self._tf, "zhuanzhu_caidai")

	setActive(self.caidaiTf, false)

	self.startUI = findTF(self._tf, "startUI")

	onButton(self, findTF(self.startUI, "btnStart"), function()
		if not self.startFlag then
			setActive(self.startUI, false)
			self:gameStart()
		end

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(self.startUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_rollingBallGame.tip
		})

		return
	end, SFX_CONFIRM)
	setActive(self.startUI, true)

	self.scoreUI = findTF(self._tf, "scoreUI")
	self.labelCurScore = findTF(self.scoreUI, "labelCur")
	self.labelHigh = findTF(self.scoreUI, "labelHigh")
	self.scoreNew = findTF(self.scoreUI, "new")

	onButton(self, findTF(self.scoreUI, "btnEnd"), function()
		setActive(self.scoreUI, false)
		setActive(self.startUI, true)

		return
	end, SFX_CANCEL)
	setActive(self.scoreUI, false)

	self.downProgress = findTF(self._tf, "downProgress")
	self.downTimeSlider = findTF(self.downProgress, "Slider"):GetComponent(typeof(Slider))
	self.labelGameTime = findTF(self._tf, "labelGameTime")
	self.labelGameScore = findTF(self._tf, "labelGameScore")
	self.endLess = findTF(self._tf, "endLess")

	setActive(self.endLess, true)

	self.closeUI = findTF(self._tf, "closeUI")

	setActive(self.closeUI, false)
	onButton(self, findTF(self.closeUI, "btnOk"), function()
		if not self.countStart then
			self:closeView()
		end

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(self.closeUI, "btnCancel"), function()
		setActive(self.closeUI, false)

		return
	end, SFX_CANCEL)

	self.overLight = findTF(self._tf, "overLight")

	setActive(self.overLight, false)
	onButton(self, findTF(self._tf, "btnClose"), function()
		if not self.startFlag then
			self:closeView()
		else
			setActive(self.closeUI, true)
		end

		return
	end, SFX_CANCEL)

	return
end

function RollingBallGameView:getGameTimes()
	return self:GetMGHubData().count
end

function RollingBallGameView:showScoreUI(arg_11_1)
	local var_11_0 = self:GetMGData():GetRuntimeData("elements")
	local var_11_1

	if var_11_0 and #var_11_0 > 0 then
		var_11_1 = var_11_0[1] or 0

		if var_11_1 < arg_11_1 then
			setActive(self.scoreNew, true)

			goto label_11_0
		end
	end

	setActive(self.scoreNew, false)

	::label_11_0::

	var_11_1 = arg_11_1 < var_11_1 and var_11_1 or arg_11_1

	setActive(self.scoreUI, true)
	setText(self.labelCurScore, arg_11_1)
	setText(self.labelHigh, var_11_1)
	self:StoreDataToServer({
		var_11_1
	})

	if self:getGameTimes() > 0 then
		self:SendSuccess(0)
	end

	return
end

function RollingBallGameView:showCountStart(arg_12_1)
	local var_12_0 = findTF(self._tf, "count")

	setActive(var_12_0, true)

	self.countIndex = 3
	self.countStart = true

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1)

	local function var_12_1(arg_13_0)
		local var_13_0 = self.countIndex

		self.countIndex = self.countIndex - 1

		local var_13_1 = findTF(var_12_0, "show")
		local var_13_2 = GetComponent(var_13_1, typeof(CanvasGroup))

		seriesAsync({
			function(arg_14_0)
				GetSpriteFromAtlasAsync(RollingBallConst.ui_atlas, "count_" .. var_13_0, function(arg_15_0)
					setImageSprite(var_13_1, arg_15_0, true)

					return
				end)
				LeanTween.value(go(var_13_1), 0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_16_0)
					var_13_2.alpha = arg_16_0

					return
				end)):setOnComplete(System.Action(function()
					arg_14_0()

					return
				end))

				return
			end,
			function(arg_18_0)
				LeanTween.value(go(var_13_1), 1, 0, 0.5):setOnUpdate(System.Action_float(function(arg_19_0)
					var_13_2.alpha = arg_19_0

					return
				end)):setOnComplete(System.Action(function()
					arg_18_0()

					return
				end))

				return
			end
		}, arg_13_0)

		return
	end

	local var_12_2 = {}

	for iter_12_0 = 1, 3 do
		table.insert(var_12_2, var_12_1)
	end

	seriesAsync(var_12_2, function()
		self.countStart = false

		setActive(var_12_0, false)
		arg_12_1()

		return
	end)

	return
end

function RollingBallGameView:gameStart()
	self.startFlag = true

	seriesAsync({
		function(arg_23_0)
			self:showCountStart(arg_23_0)

			return
		end,
		function(arg_24_0)
			self.moveDatas = {}
			self.selectGrid = nil
			self.selectEnterGrid = nil
			self.dragOffsetPos = Vector3(0, 0, 0)
			self.changeGridsDic = nil
			self.downTime = RollingBallConst.downTime
			self.comboAmount = 0
			self.stopFlag = false
			self.onBeginDragTime = nil
			self.gameTime = self:getGameTimes() > 0 and RollingBallConst.gameTime or RollingBallConst.finishGameTime
			self.gameTimeReal = Time.realtimeSinceStartup
			self.gameTimeFlag = true

			setActive(self.endLess, false)

			self.gameScore = 0

			self:firstInitGrid()
			self:moveGridsBySelfPos(self.gridDic)
			self:timerStart()

			return
		end
	}, nil)

	return
end

function RollingBallGameView:gameStop()
	self:timerStop()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_7)

	for iter_25_0 = #self.effectDatas, 1, -1 do
		self:returnEffect(self.effectDatas[iter_25_0].tf)
		table.remove(self.effectDatas, iter_25_0)
	end

	for iter_25_1 = 1, RollingBallConst.horizontal do
		for iter_25_2 = 1, RollingBallConst.vertical do
			if self.gridDic[iter_25_1][iter_25_2] then
				self.gridDic[iter_25_1][iter_25_2]:setEventActive(false)
			end
		end
	end

	self:clearUI()
	self:showScoreUI(self.gameScore)

	return
end

function RollingBallGameView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function RollingBallGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function RollingBallGameView:fallingGridDic()
	local function var_28_0(arg_29_0, arg_29_1)
		for iter_29_0 = arg_29_1 + 1, RollingBallConst.vertical do
			if self.gridDic[arg_29_0][iter_29_0] then
				return iter_29_0
			end
		end

		return 0
	end

	for iter_28_0 = 1, RollingBallConst.horizontal do
		for iter_28_1 = 1, RollingBallConst.vertical do
			if not self.gridDic[iter_28_0][iter_28_1] and RollingBallConst.vertical - iter_28_1 > 0 then
				local var_28_1 = var_28_0(iter_28_0, iter_28_1)

				if var_28_1 > 0 then
					self.gridDic[iter_28_0][var_28_1] = false
					self.gridDic[iter_28_0][iter_28_1] = self.gridDic[iter_28_0][var_28_1]

					self.gridDic[iter_28_0][iter_28_1]:setPosData(iter_28_0, iter_28_1)
				end
			end
		end
	end

	return
end

function RollingBallGameView:firstInitGrid()
	for iter_30_0 = 1, RollingBallConst.horizontal do
		self.fillGridDic[iter_30_0] = {}

		for iter_30_1 = 1, RollingBallConst.vertical do
			if not self.gridDic[iter_30_0][iter_30_1] then
				local var_30_0 = {}

				if iter_30_0 > 2 and self.gridDic[iter_30_0 - 2][iter_30_1]:getType() == self.gridDic[iter_30_0 - 1][iter_30_1]:getType() then
					table.insert(var_30_0, self.gridDic[iter_30_0 - 2][iter_30_1]:getType())
				end

				if iter_30_1 > 2 and self.gridDic[iter_30_0][iter_30_1 - 2]:getType() == self.gridDic[iter_30_0][iter_30_1 - 1]:getType() then
					table.insert(var_30_0, self.gridDic[iter_30_0][iter_30_1 - 2]:getType())
				end

				local var_30_1 = self:createGrid(self:getRandomType(var_30_0), iter_30_0, iter_30_1)

				self.gridDic[iter_30_0][iter_30_1] = var_30_1

				self:setFillGridPosition(var_30_1, iter_30_0, #self.fillGridDic[iter_30_0])
				table.insert(self.fillGridDic[iter_30_0], var_30_1)
			end
		end
	end

	return
end

function RollingBallGameView:fillEmptyGrid()
	for iter_31_0 = 1, RollingBallConst.horizontal do
		self.fillGridDic[iter_31_0] = {}

		for iter_31_1 = 1, RollingBallConst.vertical do
			if not self.gridDic[iter_31_0][iter_31_1] then
				local var_31_0 = self:createGrid(self:getRandomType(), iter_31_0, iter_31_1)

				self.gridDic[iter_31_0][iter_31_1] = var_31_0

				self:setFillGridPosition(var_31_0, iter_31_0, #self.fillGridDic[iter_31_0])
				table.insert(self.fillGridDic[iter_31_0], var_31_0)
			end
		end
	end

	return
end

function RollingBallGameView:setFillGridPosition(arg_32_1, arg_32_2, arg_32_3)
	arg_32_1:setPosition((arg_32_2 - 1) * RollingBallConst.grid_width, (RollingBallConst.vertical + arg_32_3) * RollingBallConst.grid_height)

	return
end

function RollingBallGameView:onTimer()
	for iter_33_0 = #self.moveDatas, 1, -1 do
		local var_33_0 = self.moveDatas[iter_33_0].grid
		local var_33_1 = self.moveDatas[iter_33_0].grid:getPosition().x
		local var_33_2 = self.moveDatas[iter_33_0].grid:getPosition().y
		local var_33_3 = self.moveDatas[iter_33_0].endY

		if var_33_1 == self.moveDatas[iter_33_0].endX and var_33_2 == var_33_3 then
			var_33_0:setEventActive(true)
			table.remove(self.moveDatas, iter_33_0)
		else
			local var_33_4
			local var_33_5

			if math.abs(self.moveDatas[iter_33_0].endX - var_33_1) < RollingBallConst.moveSpeed or self.moveDatas[iter_33_0].endX == var_33_1 then
				var_33_4 = self.moveDatas[iter_33_0].endX - var_33_1
			elseif var_33_1 < self.moveDatas[iter_33_0].endX then
				var_33_4 = RollingBallConst.moveSpeed
			elseif self.moveDatas[iter_33_0].endX < var_33_1 then
				var_33_4 = -RollingBallConst.moveSpeed
			end

			if math.abs(var_33_3 - var_33_2) < RollingBallConst.moveSpeed or var_33_2 == var_33_3 then
				var_33_5 = 0
				var_33_2 = var_33_3
			elseif var_33_2 < var_33_3 then
				var_33_5 = RollingBallConst.moveSpeed
			elseif var_33_3 < var_33_2 then
				var_33_5 = -RollingBallConst.moveSpeed
			end

			var_33_0:setPosition(var_33_1 + var_33_4, var_33_2 + var_33_5)
		end
	end

	for iter_33_1 = #self.effectDatas, 1, -1 do
		self.effectDatas[iter_33_1].ax = (self.effectTargetPosition.x - self.effectDatas[iter_33_1].tf.localPosition.x) * 0.002
		self.effectDatas[iter_33_1].ay = (self.effectTargetPosition.y - self.effectDatas[iter_33_1].tf.localPosition.y) * 0.002
		self.effectDatas[iter_33_1].vx = self.effectDatas[iter_33_1].vx + self.effectDatas[iter_33_1].ax
		self.effectDatas[iter_33_1].vy = self.effectDatas[iter_33_1].vy + self.effectDatas[iter_33_1].ay
		self.effectDatas[iter_33_1].tf.localPosition.x = self.effectDatas[iter_33_1].tf.localPosition.x + self.effectDatas[iter_33_1].vx
		self.effectDatas[iter_33_1].tf.localPosition.y = self.effectDatas[iter_33_1].tf.localPosition.y + self.effectDatas[iter_33_1].vy
		self.effectDatas[iter_33_1].tf.localPosition = self.effectDatas[iter_33_1].tf.localPosition

		if self.effectDatas[iter_33_1].tf.localPosition.x < self.effectTargetPosition.x then
			self:returnEffect(self.effectDatas[iter_33_1].tf)
			table.remove(self.effectDatas, iter_33_1)
		end
	end

	if self.onBeginDragTime and self.downTime > 0 then
		self.downTime = self.downTime - (Time.realtimeSinceStartup - self.onBeginDragTime) * 1000
		self.onBeginDragTime = Time.realtimeSinceStartup

		if self.downTime <= 0 then
			self.downTime = 0

			if self.selectGrid then
				local var_33_6 = self.selectGrid

				self.selectGrid:onEndDrag()
				self:onGridUp(self.selectGrid)
				self.selectGrid:addUpCallback(function(arg_34_0, arg_34_1)
					self:onGridUp(var_33_6)

					return
				end)
				self.selectGrid:addDragCallback(function(arg_35_0, arg_35_1)
					self:onGridDrag(var_33_6, arg_35_0, arg_35_1)

					return
				end)
			end
		end
	end

	self.downTimeSlider.value = self.downTime / RollingBallConst.downTime

	if self.gameTimeFlag and self.gameTime > 0 and not isActive(self.closeUI) then
		self.gameTime = self.gameTime - (Time.realtimeSinceStartup - self.gameTimeReal) * 1000

		if self.gameTime > 0 and self.gameTime <= 8000 and not isActive(self.overLight) then
			setActive(self.overLight, true)
		end

		if self.gameTime <= 0 then
			self.gameTime = 0

			setActive(self.overLight, false)

			self.stopFlag = true
		end
	end

	self.gameTimeReal = Time.realtimeSinceStartup

	local var_33_7 = math.floor(self.gameTime / 60000)

	var_33_7 = var_33_7 < 10 and "0" .. var_33_7 or var_33_7

	local var_33_8 = math.floor(self.gameTime % 60000 / 1000)

	var_33_8 = var_33_8 < 10 and "0" .. var_33_8 or var_33_8

	local var_33_9 = math.floor(math.floor(self.gameTime % 1000) / 10)

	var_33_9 = var_33_9 < 10 and "0" .. var_33_9 or var_33_9

	setText(self.labelGameTime, var_33_7 .. ":" .. var_33_8 .. ":" .. var_33_9)

	if #self.moveDatas == 0 then
		if self.stopFlag then
			self:gameStop()

			return
		end

		if self.checkSuccesFlag then
			self.checkSuccesFlag = false

			self:checkSuccessGrid()
		end

		if self.isMoveing then
			self.isMoveing = false
		end
	else
		self.isMoveing = self.isMoveing or true
	end

	return
end

function RollingBallGameView:moveGridsByChangeDic()
	self.moveDatas = {}

	for iter_36_0 = 1, #self.changeGridsDic do
		for iter_36_1 = 1, #self.changeGridsDic[iter_36_0] do
			if self.changeGridsDic[iter_36_0][iter_36_1].grid ~= self.selectGrid then
				self:moveGridToPos(self.changeGridsDic[iter_36_0][iter_36_1].grid, self.changeGridsDic[iter_36_0][iter_36_1].posX, self.changeGridsDic[iter_36_0][iter_36_1].posY)
			end
		end
	end

	if #self.moveDatas > 0 then
		self:timerStart()
	end

	return
end

function RollingBallGameView:moveGridsBySelfPos(arg_37_1, arg_37_2)
	self.moveDatas = {}

	for iter_37_0 = 1, #arg_37_1 do
		for iter_37_1 = 1, #arg_37_1[iter_37_0] do
			if arg_37_1[iter_37_0][iter_37_1] and arg_37_1[iter_37_0][iter_37_1] ~= arg_37_2 then
				self:moveGridToPos(arg_37_1[iter_37_0][iter_37_1], arg_37_1[iter_37_0][iter_37_1]:getPosData())
			end
		end
	end

	if #self.moveDatas > 0 then
		self:timerStart()
	end

	return
end

function RollingBallGameView:moveGridToPos(arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_1:getPosition().x
	local var_38_1 = arg_38_1:getPosition().y

	if math.floor((arg_38_2 - 1) * RollingBallConst.grid_width) == math.floor(arg_38_2) and math.floor((arg_38_3 - 1) * RollingBallConst.grid_height) == math.floor(arg_38_3) then
		return
	end

	arg_38_1:setEventActive(false)
	table.insert(self.moveDatas, {
		grid = arg_38_1,
		endX = (arg_38_2 - 1) * RollingBallConst.grid_width,
		endY = (arg_38_3 - 1) * RollingBallConst.grid_height
	})

	return
end

function RollingBallGameView:updateMoveGridDic()
	for iter_39_0 = 1, #self.changeGridsDic do
		for iter_39_1 = 1, #self.changeGridsDic[iter_39_0] do
			if self.changeGridsDic[iter_39_0][iter_39_1].grid then
				self.changeGridsDic[iter_39_0][iter_39_1].grid:setPosData(self.changeGridsDic[iter_39_0][iter_39_1].posX, self.changeGridsDic[iter_39_0][iter_39_1].posY)
			end
		end
	end

	self:sortGridDic()

	return
end

function RollingBallGameView:sortGridDic()
	local var_40_0 = {}

	local function var_40_1(arg_41_0, arg_41_1)
		for iter_41_0 = 1, #var_40_0 do
			local var_41_0, var_41_1 = var_40_0[iter_41_0]:getPosData()

			if var_41_0 == arg_41_0 and var_41_1 == arg_41_1 then
				return table.remove(var_40_0, iter_41_0)
			end
		end

		return nil
	end

	for iter_40_0 = 1, #self.gridDic do
		for iter_40_1 = 1, #self.gridDic[iter_40_0] do
			if self.gridDic[iter_40_0][iter_40_1] ~= iter_40_0 or nil ~= iter_40_1 then
				table.insert(var_40_0, self.gridDic[iter_40_0][iter_40_1])

				self.gridDic[iter_40_0][iter_40_1] = false
			end
		end
	end

	for iter_40_2 = 1, #self.gridDic do
		for iter_40_3 = 1, #self.gridDic[iter_40_2] do
			if self.gridDic[iter_40_2][iter_40_3] == false then
				local var_40_2 = var_40_1(iter_40_2, iter_40_3)

				assert(var_40_2 ~= nil, "异常，位置x:" .. iter_40_2 .. "y:" .. iter_40_3 .. "处珠子不存在，考虑是否在交换位置时设置了错误的格子数据")

				self.gridDic[iter_40_2][iter_40_3] = var_40_2
			end
		end
	end

	return
end

function RollingBallGameView:checkSuccessGrid()
	local var_42_0

	self:updateRemoveFlag()

	self.gameTimeFlag = false

	local var_42_1 = {}

	seriesAsync({
		function(arg_43_0)
			for iter_43_0 = 1, RollingBallConst.horizontal do
				for iter_43_1 = 1, RollingBallConst.vertical do
					self.gridDic[iter_43_0][iter_43_1]:setEventActive(false)

					if self.gridDic[iter_43_0][iter_43_1]:getRemoveFlagV() or self.gridDic[iter_43_0][iter_43_1]:getRemoveFlagH() then
						local var_43_0 = self.gridDic[iter_43_0][iter_43_1]:getRemoveId()
						local var_43_1, var_43_2 = self.gridDic[iter_43_0][iter_43_1]:getPosData()

						var_42_1[var_43_0] = var_42_1[var_43_0] or {
							amount = 0,
							posList = {}
						}
						var_42_1[var_43_0].amount = var_42_1[var_43_0].amount + 1

						table.insert(var_42_1[var_43_0].posList, {
							x = var_43_1,
							y = var_43_2
						})
						self:returnGrid(self.gridDic[iter_43_0][iter_43_1])

						self.gridDic[iter_43_0][iter_43_1] = false
						var_42_0 = var_42_0 or true
					end
				end
			end

			arg_43_0()

			return
		end,
		function(arg_44_0)
			if var_42_0 then
				LeanTween.delayedCall(go(self.rollingUI), 0.7, System.Action(function()
					arg_44_0()

					return
				end))
				self:updateScore(var_42_1)
				self:updateCombo()
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
			else
				self.comboAmount = 0

				arg_44_0()
			end

			return
		end,
		function(arg_46_0)
			if not self.stopFlag then
				self:fallingGridDic()
				self:fillEmptyGrid()
				self:moveGridsBySelfPos(self.gridDic, nil)

				if var_42_0 then
					self.checkSuccesFlag = true
				end
			end

			arg_46_0()

			return
		end
	}, function()
		self.gameTimeFlag = true

		return
	end)

	return
end

function RollingBallGameView:updateCombo()
	setActive(self.goodEffect, false)
	setActive(self.greatEffect, false)
	setActive(self.perfectEffect, false)

	if self.comboAmount == 2 then
		setActive(self.goodEffect, true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
	elseif self.comboAmount == 3 then
		setActive(self.greatEffect, true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
	elseif self.comboAmount >= 4 then
		setActive(self.perfectEffect, true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5)
	end

	if self.comboAmount > 1 then
		if LeanTween.isTweening(go(self.caidaiTf)) then
			LeanTween.cancel(go(self.caidaiTf))
		end

		LeanTween.delayedCall(go(self.caidaiTf), 3, System.Action(function()
			setActive(self.caidaiTf, false)

			return
		end))
		setActive(self.caidaiTf, true)
	end

	return
end

function RollingBallGameView:updateScore(arg_50_1)
	for iter_50_0, iter_50_1 in pairs(arg_50_1) do
		self.comboAmount = self.comboAmount + 1
	end

	local var_50_0 = 10 * self.comboAmount
	local var_50_1 = 0

	for iter_50_2, iter_50_3 in pairs(arg_50_1) do
		var_50_1 = var_50_1 + var_50_0 * (iter_50_3.amount == 3 and 1 or iter_50_3.amount == 4 and 1.5 or 2) * iter_50_3.amount

		for iter_50_4 = 1, #iter_50_3.posList do
			self:addGridScoreTip(iter_50_3.posList[iter_50_4], var_50_0 * (iter_50_3.amount == 3 and 1 or iter_50_3.amount == 4 and 1.5 or 2))
			self:addRemoveEffect(iter_50_3.posList[iter_50_4])
		end
	end

	LeanTween.delayedCall(go(self.labelGameScore), 0.7, System.Action(function()
		if LeanTween.isTweening(go(self.labelGameScore)) then
			LeanTween.cancel(go(self.labelGameScore))

			local var_51_0 = self.gameScore + var_50_1
		end

		LeanTween.value(go(self.labelGameScore), self.gameScore, self.gameScore + var_50_1, 1.7):setOnUpdate(System.Action_float(function(arg_52_0)
			setText(self.labelGameScore, math.floor(arg_52_0))

			return
		end)):setOnComplete(System.Action(function()
			setText(self.labelGameScore, var_51_0)

			return
		end))

		self.gameScore = self.gameScore + var_50_1

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_6)

		return
	end))

	return
end

function RollingBallGameView:updateRemoveFlag()
	for iter_54_0 = 1, RollingBallConst.horizontal do
		for iter_54_1 = 1, RollingBallConst.vertical do
			self:checkGridRemove(self.gridDic[iter_54_0][iter_54_1], iter_54_0, iter_54_1)
		end
	end

	return
end

function RollingBallGameView:checkGridRemove(arg_55_1, arg_55_2, arg_55_3)
	if not arg_55_1:getRemoveFlagH() and arg_55_2 < RollingBallConst.horizontal - 1 then
		local var_55_0 = 0
		local var_55_1 = true
		local var_55_2
		local var_55_3 = {}

		for iter_55_0 = arg_55_2, RollingBallConst.horizontal do
			if arg_55_1:getType() == self.gridDic[iter_55_0][arg_55_3]:getType() and var_55_1 then
				var_55_0 = var_55_0 + 1

				table.insert(var_55_3, self.gridDic[iter_55_0][arg_55_3])

				if self.gridDic[iter_55_0][arg_55_3]:getRemoveId() then
					var_55_2 = self.gridDic[iter_55_0][arg_55_3]:getRemoveId()
				end
			else
				var_55_1 = false
			end
		end

		if var_55_0 and var_55_0 >= 3 then
			var_55_2 = var_55_2 or self:getGridRemoveId()

			for iter_55_1 = 1, #var_55_3 do
				var_55_3[iter_55_1]:setRemoveFlagH(true, var_55_2)
			end
		end
	end

	if not arg_55_1:getRemoveFlagV() and arg_55_3 < RollingBallConst.vertical - 1 then
		local var_55_4 = 0
		local var_55_5 = true
		local var_55_6
		local var_55_7 = {}

		for iter_55_2 = arg_55_3, RollingBallConst.vertical do
			if arg_55_1:getType() == self.gridDic[arg_55_2][iter_55_2]:getType() and var_55_5 then
				var_55_4 = var_55_4 + 1

				table.insert(var_55_7, self.gridDic[arg_55_2][iter_55_2])

				if self.gridDic[arg_55_2][iter_55_2]:getRemoveId() then
					var_55_6 = self.gridDic[arg_55_2][iter_55_2]:getRemoveId()
				end
			else
				var_55_5 = false
			end
		end

		if var_55_4 and var_55_4 >= 3 then
			var_55_6 = var_55_6 or self:getGridRemoveId()

			for iter_55_3 = 1, #var_55_7 do
				var_55_7[iter_55_3]:setRemoveFlagV(true, var_55_6)
			end
		end
	end

	return
end

function RollingBallGameView:onGridDown(arg_56_1)
	if self.isMoveing or self.selectGrid or #self.moveDatas > 0 then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	self.selectGrid = arg_56_1

	self.selectGrid:getTf():SetAsLastSibling()

	return
end

function RollingBallGameView:onGridUp(arg_57_1)
	self.selectGrid = nil

	if self.changeGridsDic then
		self:updateMoveGridDic()

		self.changeGridsDic = nil
	end

	self:clearDragAlpha()

	self.onBeginDragTime = nil

	self:moveGridsBySelfPos(self.gridDic, nil)

	self.checkSuccesFlag = true
	self.downTime = RollingBallConst.downTime

	return
end

function RollingBallGameView:checkChangePos(arg_58_1)
	local var_58_0, var_58_1 = arg_58_1:getPosData()
	local var_58_2, var_58_3 = self.selectGrid:getPosData()

	if arg_58_1 == self.selectGrid or var_58_2 ~= var_58_0 and var_58_3 ~= var_58_1 then
		self:moveGridsBySelfPos(self.gridDic, self.selectGrid)

		self.selectEnterGrid = nil
		self.changeGridsDic = nil
		self.changePosX, self.changePosY = nil
	else
		if self.changePosX == var_58_0 and self.changePosY == var_58_1 then
			return
		end

		self.changePosX, self.changePosY = var_58_0, var_58_1

		self:updateEnterGrid(self.changePosX, self.changePosY)
		self:moveGridsByChangeDic()
	end

	return
end

function RollingBallGameView:onGridBeginDrag(arg_59_1, arg_59_2, arg_59_3)
	if self.isMoveing or not self.selectGrid or arg_59_1 ~= self.selectGrid then
		return
	end

	self.onBeginDragTime = Time.realtimeSinceStartup
	self.downTime = RollingBallConst.downTime

	local var_59_0 = self.selectGrid:getTf()
	local var_59_1, var_59_2 = self.selectGrid:getPosData()

	self:setDragAlpha(var_59_1, var_59_2, (self.selectGrid:getType()))

	self.changePosX, self.changePosY = nil
	self.dragOffsetPos.x = arg_59_3.position.x - var_59_0.transform.localPosition.x
	self.dragOffsetPos.y = arg_59_3.position.y - var_59_0.transform.localPosition.y

	return
end

function RollingBallGameView:onGridDrag(arg_60_1, arg_60_2, arg_60_3)
	if not self.selectGrid or arg_60_1 ~= self.selectGrid then
		return
	end

	self.uiCam = self.uiCam or GameObject.Find("UICamera"):GetComponent("Camera")

	local var_60_0 = self.rollingUI:InverseTransformPoint((self.uiCam:ScreenToWorldPoint(arg_60_3.position)))
	local var_60_1 = var_60_0.x - RollingBallConst.grid_width / 2
	local var_60_2 = var_60_0.y - RollingBallConst.grid_height / 2

	if var_60_0.x - RollingBallConst.grid_width / 2 < 0 then
		var_60_1 = 0
	end

	if var_60_2 < 0 then
		var_60_2 = 0
	end

	if var_60_1 > (RollingBallConst.horizontal - 1) * RollingBallConst.grid_width then
		var_60_1 = (RollingBallConst.horizontal - 1) * RollingBallConst.grid_width
	end

	if var_60_2 > (RollingBallConst.vertical - 1) * RollingBallConst.grid_height then
		var_60_2 = (RollingBallConst.vertical - 1) * RollingBallConst.grid_height
	end

	self.selectGrid:changePosition(var_60_1, var_60_2)

	local var_60_3 = self:getGridByPosition(self.selectGrid:getPosition())

	if var_60_3 and var_60_3 ~= self.selectGrid then
		local var_60_4, var_60_5 = var_60_3:getPosData()
		local var_60_6, var_60_7 = self.selectGrid:getPosData()

		if math.abs(var_60_4 - var_60_6) + math.abs(var_60_5 - var_60_7) == 1 then
			self:updateMove(var_60_4, var_60_5)
		elseif math.abs(var_60_4 - var_60_6) > math.abs(var_60_5 - var_60_7) then
			if var_60_4 - var_60_6 > 0 then
				var_60_4 = var_60_6 + 1
			end

			if var_60_4 - var_60_6 < 0 then
				var_60_4 = var_60_6 - 1
			end

			self:updateMove(var_60_4, var_60_7)
		else
			if var_60_5 - var_60_7 > 0 then
				var_60_5 = var_60_7 + 1
			end

			if var_60_5 - var_60_7 < 0 then
				var_60_5 = var_60_7 - 1
			end

			self:updateMove(var_60_6, var_60_5)
		end
	end

	return
end

function RollingBallGameView:updateMove(arg_61_1, arg_61_2)
	if arg_61_1 > RollingBallConst.horizontal or arg_61_2 > RollingBallConst.vertical then
		return
	end

	self:changeDragGrid(arg_61_1, arg_61_2)
	self:updateMoveGridDic()

	self.changeGridsDic = nil

	self:moveGridsBySelfPos(self.gridDic, self.selectGrid)
	self:setDragAlpha(arg_61_1, arg_61_2, self.selectGrid:getType())

	return
end

function RollingBallGameView:getGridByPosition(arg_62_1)
	local var_62_0 = math.floor((arg_62_1.x + RollingBallConst.grid_width / 2) / RollingBallConst.grid_width) + 1
	local var_62_1 = math.floor((arg_62_1.y + RollingBallConst.grid_height / 2) / RollingBallConst.grid_height) + 1

	if var_62_0 >= 1 and var_62_0 <= RollingBallConst.horizontal and var_62_1 >= 1 and var_62_1 <= RollingBallConst.vertical then
		return self.gridDic[var_62_0][var_62_1]
	end

	return nil
end

function RollingBallGameView:updateEnterGrid(arg_63_1, arg_63_2)
	local var_63_0, var_63_1 = self.selectGrid:getPosData()

	self.changeGridsDic = {}

	for iter_63_0 = 1, #self.gridDic do
		self.changeGridsDic[iter_63_0] = {}

		for iter_63_1 = 1, #self.gridDic[iter_63_0] do
			if iter_63_0 ~= var_63_0 and iter_63_1 ~= var_63_1 then
				table.insert(self.changeGridsDic[iter_63_0], {
					grid = self.gridDic[iter_63_0][iter_63_1],
					posX = iter_63_0,
					posY = iter_63_1
				})
			elseif iter_63_0 == var_63_0 and iter_63_1 == var_63_1 then
				table.insert(self.changeGridsDic[iter_63_0], {
					grid = self.gridDic[iter_63_0][iter_63_1],
					posX = arg_63_1,
					posY = arg_63_2
				})
			elseif iter_63_0 == var_63_0 then
				if var_63_1 < iter_63_1 and iter_63_1 <= arg_63_2 then
					table.insert(self.changeGridsDic[iter_63_0], {
						grid = self.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0,
						posY = iter_63_1 - 1
					})
				elseif iter_63_1 < var_63_1 and arg_63_2 <= iter_63_1 then
					table.insert(self.changeGridsDic[iter_63_0], {
						grid = self.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0,
						posY = iter_63_1 + 1
					})
				else
					table.insert(self.changeGridsDic[iter_63_0], {
						grid = self.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0,
						posY = iter_63_1
					})
				end
			elseif iter_63_1 == var_63_1 then
				if var_63_0 < iter_63_0 and iter_63_0 <= arg_63_1 then
					table.insert(self.changeGridsDic[iter_63_0], {
						grid = self.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0 - 1,
						posY = iter_63_1
					})
				elseif iter_63_0 < var_63_0 and arg_63_1 <= iter_63_0 then
					table.insert(self.changeGridsDic[iter_63_0], {
						grid = self.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0 + 1,
						posY = iter_63_1
					})
				else
					table.insert(self.changeGridsDic[iter_63_0], {
						grid = self.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0,
						posY = iter_63_1
					})
				end
			end
		end
	end

	return
end

function RollingBallGameView:changeDragGrid(arg_64_1, arg_64_2)
	local var_64_0, var_64_1 = self.selectGrid:getPosData()

	self.changeGridsDic = {}

	for iter_64_0 = 1, #self.gridDic do
		self.changeGridsDic[iter_64_0] = {}

		for iter_64_1 = 1, #self.gridDic[iter_64_0] do
			if iter_64_0 == arg_64_1 and iter_64_1 == arg_64_2 then
				table.insert(self.changeGridsDic[iter_64_0], {
					grid = self.gridDic[iter_64_0][iter_64_1],
					posX = var_64_0,
					posY = var_64_1
				})
			elseif iter_64_0 == var_64_0 and iter_64_1 == var_64_1 then
				table.insert(self.changeGridsDic[iter_64_0], {
					grid = self.gridDic[iter_64_0][iter_64_1],
					posX = arg_64_1,
					posY = arg_64_2
				})
			else
				table.insert(self.changeGridsDic[iter_64_0], {
					grid = self.gridDic[iter_64_0][iter_64_1],
					posX = iter_64_0,
					posY = iter_64_1
				})
			end
		end
	end

	return
end

function RollingBallGameView:createGrid(arg_65_1, arg_65_2, arg_65_3)
	local var_65_0

	if #self.gridsPool > 0 then
		var_65_0 = table.remove(self.gridsPool, 1)
	else
		var_65_0 = RollingBallGrid.New(tf(Instantiate(self.tplGrid)))

		var_65_0:addDownCallback(function(arg_66_0, arg_66_1)
			self:onGridDown(var_65_0)

			return
		end)
		var_65_0:addUpCallback(function(arg_67_0, arg_67_1)
			self:onGridUp(var_65_0)

			return
		end)
		var_65_0:addBeginDragCallback(function(arg_68_0, arg_68_1)
			self:onGridBeginDrag(var_65_0, arg_68_0, arg_68_1)

			return
		end)
		var_65_0:addDragCallback(function(arg_69_0, arg_69_1)
			self:onGridDrag(var_65_0, arg_69_0, arg_69_1)

			return
		end)
		setActive(var_65_0:getTf(), true)
	end

	var_65_0:setParent(self.rollingUI)
	var_65_0:setType(arg_65_1)
	var_65_0:setPosData(arg_65_2, arg_65_3)

	return var_65_0
end

function RollingBallGameView:setDragAlpha(arg_70_1, arg_70_2, arg_70_3)
	self.dragAlphaGrid:setPosition((arg_70_1 - 1) * RollingBallConst.grid_width, (arg_70_2 - 1) * RollingBallConst.grid_height)
	self.dragAlphaGrid:setType(arg_70_3)
	setActive(self.dragAlphaGrid:getTf(), true)

	return
end

function RollingBallGameView:clearDragAlpha()
	setActive(self.dragAlphaGrid:getTf(), false)

	return
end

function RollingBallGameView:returnGrid(arg_72_1)
	self:removeGrid(arg_72_1)
	arg_72_1:clearData()
	arg_72_1:setParent(self.gridPoolTf)
	arg_72_1:setEventActive(false)
	table.insert(self.gridsPool, arg_72_1)

	return
end

function RollingBallGameView:removeGrid(arg_73_1)
	local var_73_0, var_73_1 = arg_73_1:getPosData()

	self.gridDic[var_73_0][var_73_1] = self.gridDic[var_73_0][var_73_1] or false

	return
end

function RollingBallGameView:getRandomType(arg_74_1)
	if arg_74_1 then
		local var_74_0 = {}

		for iter_74_0 = 1, RollingBallConst.grid_type_amount do
			if not table.contains(arg_74_1, iter_74_0) then
				table.insert(var_74_0, iter_74_0)
			end
		end

		return var_74_0[math.random(1, #var_74_0)]
	end

	return math.random(1, RollingBallConst.grid_type_amount)
end

function RollingBallGameView:addGridScoreTip(arg_75_1, arg_75_2)
	local var_75_0 = self:getScoreTip()

	var_75_0.localPosition = Vector3((arg_75_1.x - 1) * RollingBallConst.grid_width, (arg_75_1.y - 1) * RollingBallConst.grid_height, 0)

	setText(findTF(var_75_0, "text"), "+" .. arg_75_2)
	LeanTween.moveLocalY(go(var_75_0), (arg_75_1.y - 1) * RollingBallConst.grid_height + 30, 0.5):setOnComplete(System.Action(function()
		self:returnScoreTip(var_75_0)

		return
	end))

	return
end

function RollingBallGameView:addRemoveEffect(arg_77_1)
	local var_77_0 = self:getRemoveEffect()

	var_77_0.localPosition = Vector3((arg_77_1.x - 1) * RollingBallConst.grid_width + 50, (arg_77_1.y - 1) * RollingBallConst.grid_height + 50, -350)

	LeanTween.delayedCall(go(var_77_0), 0.7, System.Action(function()
		self:returnRemoveEffect(var_77_0)

		return
	end))

	return
end

function RollingBallGameView:getRemoveEffect()
	if not self.removeEffectPool then
		self.removeEffectPool = {}
		self.removeEffects = {}
	end

	local var_79_0

	if #self.removeEffectPool > 1 then
		var_79_0 = table.remove(self.removeEffectPool, #self.removeEffectPool)
	else
		var_79_0 = tf(Instantiate(self.tplRemoveEffect))

		setParent(var_79_0, self.rollingEffectUI, false)
		table.insert(self.removeEffects, var_79_0)
	end

	setActive(var_79_0, true)

	return var_79_0
end

function RollingBallGameView:returnRemoveEffect(arg_80_1)
	setActive(arg_80_1, false)
	table.insert(self.removeEffectPool, arg_80_1)

	return
end

function RollingBallGameView:getScoreTip()
	if not self.scoreTipPool then
		self.scoreTipPool = {}
		self.scoreTips = {}
	end

	local var_81_0

	if #self.scoreTipPool > 1 then
		var_81_0 = table.remove(self.scoreTipPool, #self.scoreTipPool)
	else
		var_81_0 = tf(Instantiate(self.tplScoreTip))

		setParent(var_81_0, self.rollingEffectUI, false)
		table.insert(self.scoreTips, var_81_0)
	end

	setActive(var_81_0, true)

	return var_81_0
end

function RollingBallGameView:returnScoreTip(arg_82_1)
	setActive(arg_82_1, false)
	table.insert(self.scoreTipPool, arg_82_1)

	return
end

function RollingBallGameView:addEffect(arg_83_1)
	local var_83_0 = self:getEffect()

	setParent(var_83_0, self.effectUI, false)
	setActive(var_83_0, true)

	var_83_0.localPosition = self.effectUI:InverseTransformPoint(arg_83_1)

	table.insert(self.effectDatas, {
		vx = 2,
		ax = 0,
		ay = 0,
		vy = 2,
		tf = var_83_0
	})

	return
end

function RollingBallGameView:clearUI()
	self.moveDatas = {}
	self.startFlag = false
	self.stopFlag = false

	setText(self.labelGameScore, "0000")
	setText(self.labelGameTime, "")
	setActive(self.endLess, true)

	self.downTimeSlider.value = 1

	setActive(self.closeUI, false)
	setActive(self.overLight, false)
	self:clearDragAlpha()

	for iter_84_0 = #self.effectDatas, 1, -1 do
		self:returnEffect(self.effectDatas[iter_84_0].tf)
		table.remove(self.effectDatas, iter_84_0)
	end

	for iter_84_1 = 1, RollingBallConst.horizontal do
		for iter_84_2 = 1, RollingBallConst.vertical do
			if self.gridDic[iter_84_1][iter_84_2] then
				self:returnGrid(self.gridDic[iter_84_1][iter_84_2])

				self.gridDic[iter_84_1][iter_84_2] = false
			end
		end
	end

	return
end

function RollingBallGameView:getEffect()
	if #self.effectPool > 0 then
		return table.remove(self.effectPool, #self.effectPool)
	end

	return (tf(Instantiate(self.tplEffect)))
end

function RollingBallGameView:returnEffect(arg_86_1)
	SetParent(arg_86_1, self.effectPoolTf, false)
	table.insert(self.effectPool, arg_86_1)

	return
end

function RollingBallGameView:getGridRemoveId()
	self.removeId = self.removeId or 0
	self.removeId = self.removeId + 1

	return tostring(self.removeId)
end

function RollingBallGameView:onBackPressed()
	if not self.startFlag then
		self:emit(RollingBallGameView.ON_BACK_PRESSED)
	end

	return
end

function RollingBallGameView:willExit()
	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	if LeanTween.isTweening(go(self.caidaiTf)) then
		LeanTween.cancel(go(self.caidaiTf))
	end

	if LeanTween.isTweening(go(self.labelGameScore)) then
		LeanTween.cancel(go(self.labelGameScore))
	end

	if LeanTween.isTweening(go(self.rollingUI)) then
		LeanTween.cancel(go(self.rollingUI))
	end

	if self.scoreTips then
		for iter_89_0 = 1, #self.scoreTips do
			if LeanTween.isTweening(go(self.scoreTips[iter_89_0])) then
				LeanTween.cancel(go(self.scoreTips[iter_89_0]))
			end
		end
	end

	if self.removeEffects then
		for iter_89_1 = 1, #self.removeEffects do
			if LeanTween.isTweening(go(self.removeEffects[iter_89_1])) then
				LeanTween.cancel(go(self.removeEffects[iter_89_1]))
			end
		end
	end

	self.timer = nil

	return
end

return RollingBallGameView
