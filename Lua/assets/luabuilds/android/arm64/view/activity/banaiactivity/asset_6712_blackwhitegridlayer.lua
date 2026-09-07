local BlackWhiteGridLayer = class("BlackWhiteGridLayer", import("...base.BaseUI"))
local var_0_1 = "create cell"
local var_0_2 = "reach turn cnt"
local var_0_3 = "cell type changed"
local var_0_4 = "cell check changed"
local var_0_5 = "highest score updated"
local var_0_6 = "destroy cells"
local var_0_7 = "cell tip"
local var_0_8 = "map init done"
local var_0_9 = 1
local var_0_10 = -1
local var_0_11 = {
	Color.New(1, 1, 1, 1),
	[-1] = Color.New(0.37, 0.37, 0.37, 1)
}
local var_0_12 = Color.New(0.9725490196078431, 0.6509803921568628, 0.8509803921568627, 1)
local var_0_13 = 5
local var_0_14 = 3
local var_0_15 = 5
local var_0_16 = pg.activity_event_blackwhite
local var_0_17

local function var_0_18()
	local var_1_0 = {}

	local function var_1_1(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = {}
		local var_2_1 = math.min(arg_2_1 + arg_2_4 - 1, arg_2_2 - 1)

		for iter_2_0 = arg_2_0, math.min(arg_2_0 + arg_2_4 - 1, arg_2_3 - 1) do
			for iter_2_1 = arg_2_1, var_2_1 do
				table.insert(var_2_0, Vector2(iter_2_0, iter_2_1))
			end
		end

		return var_2_0
	end

	local function var_1_2(arg_3_0, arg_3_1)
		assert(#arg_3_0 ~= 0 and arg_3_1 <= #arg_3_0)

		local var_3_0 = {}

		while 0 < arg_3_1 do
			local var_3_1 = math.random(1, #arg_3_0)
			local var_3_2

			if not table.contains(var_3_0, var_3_1) then
				table.insert(var_3_0, var_3_1)

				var_3_2 = 0 + 1
			end
		end

		local var_3_3 = {}

		for iter_3_0 = 1, #arg_3_0 do
			table.insert(var_3_3, {
				arg_3_0[iter_3_0].x,
				arg_3_0[iter_3_0].y,
				table.contains(var_3_0, iter_3_0) and -1 or 1
			})
		end

		return var_3_3
	end

	function var_1_0.RandomMap(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = {}

		for iter_4_0 = 0, arg_4_2 - 1, arg_4_3 do
			for iter_4_1 = 0, arg_4_1 - 1, arg_4_3 do
				_.each(var_1_2(var_1_1(iter_4_0, iter_4_1, arg_4_1, arg_4_2, arg_4_3), arg_4_4), function(arg_5_0)
					table.insert(var_4_0, arg_5_0)

					return
				end)
			end
		end

		return var_4_0
	end

	function var_1_0.Dispose(arg_6_0)
		return
	end

	return var_1_0
end

local function var_0_19(arg_7_0, arg_7_1)
	local var_7_0 = {}

	function var_7_0:Get()
		local var_9_0 = #self.stack == 0 and instantiate(self._go) or table.remove(self.stack, 1)

		setActive(var_9_0, true)

		return var_9_0
	end

	function var_7_0:Return(arg_10_1)
		setActive(arg_10_1, false)

		if #self.stack >= self.maxCnt then
			Object.Destroy(arg_10_1)
		else
			table.insert(self.stack, arg_10_1)
			setParent(arg_10_1, self._root)
		end

		return
	end

	function var_7_0:Dispose()
		for iter_11_0, iter_11_1 in ipairs(self.stack) do
			Destroy(iter_11_1)
		end

		return
	end

	;(function(arg_8_0)
		arg_8_0._go = arg_7_0
		arg_8_0._root = arg_7_1
		arg_8_0.maxCnt = 20
		arg_8_0.stack = {}

		return
	end)(var_7_0)

	return var_7_0
end

local function var_0_20(arg_12_0)
	local var_12_0 = {}

	function var_12_0:Get(arg_14_1)
		local var_14_0 = self.pools[arg_14_1]

		if not self.pools[arg_14_1] then
			var_14_0 = var_0_19(self[arg_14_1], self.root)
			self.pools[arg_14_1] = var_14_0
		end

		return var_14_0:Get()
	end

	function var_12_0:Return(arg_15_1, arg_15_2)
		if self.pools[arg_15_1] then
			self.pools[arg_15_1]:Return(arg_15_2)
		else
			Destroy(arg_15_2)
		end

		return
	end

	function var_12_0:Dispose()
		for iter_16_0, iter_16_1 in pairs(self.pools) do
			iter_16_1:Dispose()
		end

		return
	end

	;(function(arg_13_0)
		arg_13_0.root = arg_12_0
		arg_13_0.white = arg_12_0:Find("white")
		arg_13_0.black = arg_12_0:Find("black")
		arg_13_0.pools = {}

		return
	end)(var_12_0)

	return var_12_0
end

local function var_0_21(arg_17_0)
	local var_17_0 = {}

	function var_17_0:AddListener(arg_19_1, arg_19_2)
		self.events[arg_19_1] = self.events[arg_19_1] or {}

		table.insert(self.events[arg_19_1], arg_19_2)

		return
	end

	function var_17_0:RemoveListener(arg_20_1, arg_20_2)
		for iter_20_0 = #self.events[arg_20_1], 1, -1 do
			if self.events[arg_20_1][iter_20_0] == arg_20_2 then
				table.remove(self.events[arg_20_1], iter_20_0)
			end
		end

		return
	end

	function var_17_0:Notify(arg_21_1, arg_21_2)
		assert(self.events[arg_21_1], arg_21_1)

		for iter_21_0, iter_21_1 in ipairs(self.events[arg_21_1]) do
			iter_21_1(self.sender, arg_21_2)
		end

		return
	end

	;(function(arg_18_0)
		arg_18_0.events = {}
		arg_18_0.sender = arg_17_0

		return
	end)(var_17_0)

	return var_17_0
end

local function var_0_22(arg_22_0)
	local var_22_0 = {}

	function var_22_0:Reset()
		self.x = self.initData.x
		self.y = self.initData.y
		self.color = self.initData.color
		self.check = self.initData.check

		self:Notify(var_0_3, {
			type = self.color
		})

		return
	end

	function var_22_0:GetType()
		return self.color
	end

	function var_22_0:GetPosition()
		return Vector2(self.x, self.y)
	end

	function var_22_0:OnAnimDone()
		if self.animCb then
			self.animCb()
		end

		return
	end

	function var_22_0.SetAnimDoneCallback(arg_28_0, arg_28_1)
		arg_28_0.animCb = arg_28_1

		return
	end

	function var_22_0:Reverse()
		if var_0_9 == self.color then
			self.color = var_0_10
		elseif var_0_10 == self.color then
			self.color = var_0_9
		end

		self:Notify(var_0_3, {
			anim = true,
			type = self.color
		})

		return
	end

	function var_22_0:GetCellColorStr()
		if var_0_9 == self.color then
			return "white"
		elseif var_0_10 == self.color then
			return "black"
		end

		return
	end

	function var_22_0:ClearCheck()
		self.check = false

		self:Notify(var_0_4, self.check)

		return
	end

	function var_22_0:Check()
		self.check = true

		self:Notify(var_0_4, self.check)

		return
	end

	function var_22_0:IsSame(arg_33_1)
		return self.x == arg_33_1.x and self.y == arg_33_1.y
	end

	function var_22_0:GetScore()
		if var_0_9 == self.color then
			return 1
		elseif var_0_10 == self.color then
			return -1
		end

		return 0
	end

	function var_22_0:Serialize()
		return string.format("{%d,%d,%d}", self.x, self.y, self:GetType() == var_0_9 and 1 or -1)
	end

	function var_22_0.Dispose(arg_36_0)
		return
	end

	;(function(arg_23_0)
		arg_23_0.x = arg_22_0.x
		arg_23_0.y = arg_22_0.y
		arg_23_0.color = arg_22_0.color
		arg_23_0.check = false
		arg_23_0.initData = {
			check = false,
			x = arg_23_0.x,
			y = arg_23_0.y,
			color = arg_23_0.color
		}

		return
	end)(var_22_0)

	return setmetatable(var_22_0, {
		__index = var_0_21(var_22_0)
	})
end

local function var_0_23(arg_37_0)
	local var_37_0 = {
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}

	var_37_0.started = arg_37_0.started or false

	function var_37_0.UpdateData(arg_38_0, arg_38_1)
		arg_38_0.highestScore = arg_38_1.highestScore or 0
		arg_38_0.isUnlock = arg_38_1.isUnlock
		arg_38_0.isFinished = arg_38_1.isFinished

		return
	end

	function var_37_0:Init()
		self.isInited = true
		self.randomer = var_0_18()

		local var_39_0 = self.maps

		if not self.maps or #var_39_0 == 0 then
			var_39_0 = self:GenRandomMap()
		end

		self:CreatNewMap(var_39_0)
		self:Notify(var_0_8)

		return
	end

	function var_37_0:CreatNewMap(arg_40_1)
		self.cells = {}

		for iter_40_0, iter_40_1 in ipairs(arg_40_1) do
			local var_40_0 = self:CreateCell(iter_40_1[1], iter_40_1[2], iter_40_1[3])

			table.insert(self.cells, var_40_0)
			self:Notify(var_0_1, var_40_0)
		end

		return
	end

	function var_37_0:GenRandomMap()
		return self.randomer:RandomMap(var_0_16[self.id].theme[1], var_0_16[self.id].theme[2], var_0_14, var_0_15)
	end

	function var_37_0:TriggerTip()
		self:Notify(var_0_7, self.primaryCell)

		return
	end

	function var_37_0:NeedTip()
		return self.primaryCell ~= nil
	end

	function var_37_0:UpdateTurnCnt(arg_44_1)
		self.calcStep = arg_44_1

		self:Notify(var_0_2, self.calcStep)

		if self.calcStep == 0 then
			local var_44_0 = self:CalcScore()

			if var_44_0 > self.highestScore then
				self.highestScore = var_44_0

				if self.isFinished then
					self:Notify(var_0_5, var_44_0)
				end
			end

			self.isFinished = true
		end

		return
	end

	function var_37_0:CalcScore()
		local var_45_0 = 0

		_.each(self.cells, function(arg_46_0)
			var_45_0 = var_45_0 + arg_46_0:GetScore()

			return
		end)

		return 0
	end

	function var_37_0.CreateCell(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		return var_0_22({
			x = arg_47_1,
			y = arg_47_2,
			color = arg_47_3
		})
	end

	function var_37_0:GetCellByPosition(arg_48_1)
		return _.detect(self.cells, function(arg_49_0)
			return arg_49_0:IsSame(arg_48_1)
		end)
	end

	function var_37_0.GetAroundCells(arg_50_0, arg_50_1)
		local var_50_0 = {}
		local var_50_1 = arg_50_1:GetPosition()

		_.each({
			Vector2(var_50_1.x + 1, var_50_1.y),
			Vector2(var_50_1.x - 1, var_50_1.y),
			Vector2(var_50_1.x, var_50_1.y - 1),
			Vector2(var_50_1.x, var_50_1.y + 1),
			Vector2(var_50_1.x - 1, var_50_1.y - 1),
			Vector2(var_50_1.x + 1, var_50_1.y + 1),
			Vector2(var_50_1.x + 1, var_50_1.y - 1),
			Vector2(var_50_1.x - 1, var_50_1.y + 1),
			Vector2(var_50_1.x, var_50_1.y)
		}, function(arg_51_0)
			local var_51_0 = arg_50_0:GetCellByPosition(arg_51_0)

			if var_51_0 then
				table.insert(var_50_0, var_51_0)
			end

			return
		end)

		return var_50_0
	end

	function var_37_0:inProcess()
		return self.started
	end

	function var_37_0.Start(arg_53_0)
		arg_53_0.started = true

		return
	end

	function var_37_0:Reverse(arg_54_1)
		local var_54_0 = #self.primaryCells
		local var_54_1 = 0

		_.each(self.primaryCells, function(arg_55_0)
			arg_55_0:SetAnimDoneCallback(function()
				var_54_1 = var_54_1 + 1

				if var_54_1 == var_54_0 then
					arg_54_1()
				end

				arg_55_0:SetAnimDoneCallback(nil)

				return
			end)
			arg_55_0:Reverse()

			return
		end)

		return
	end

	function var_37_0:Primary(arg_57_1)
		if self.isStartReverse then
			return
		end

		local function var_57_0()
			_.each(self.primaryCells or {}, function(arg_59_0)
				arg_59_0:ClearCheck()

				return
			end)

			return
		end

		if self.primaryCells and self.primaryCell and arg_57_1:IsSame(self.primaryCell) then
			self.isStartReverse = true

			self:Reverse(function()
				var_57_0()

				self.primaryCell = nil
				self.primaryCells = nil

				self:UpdateTurnCnt(self.calcStep - 1)

				self.isStartReverse = false

				return
			end)

			return
		end

		self.primaryCell = arg_57_1

		var_57_0()

		self.primaryCells = self:GetAroundCells(arg_57_1)

		_.each(self.primaryCells, function(arg_61_0)
			arg_61_0:Check()

			return
		end)

		return
	end

	function var_37_0:ReStart()
		self:Notify(var_0_6)
		self:CreatNewMap(#var_0_16[self.id].map == 0 and self:GenRandomMap() or var_0_16[self.id].map)
		self:UpdateTurnCnt(self.maxCount)

		self.started = false

		return
	end

	function var_37_0:Serialize()
		if not self.isInited then
			return ""
		end

		local var_63_0 = "{"

		_.each(self.cells, function(arg_64_0)
			var_63_0 = var_63_0 .. arg_64_0:Serialize() .. ","

			return
		end)

		var_63_0 = var_63_0 .. "}#" .. self.calcStep .. "#" .. (self.started and "1" or "0")

		return var_63_0
	end

	function var_37_0:Dispose()
		_.each(self.cells, function(arg_66_0)
			arg_66_0:Dispose()

			return
		end)

		self.started = false

		return
	end

	return setmetatable(var_37_0, {
		__index = var_0_21(var_37_0)
	})
end

local function var_0_24(arg_67_0, arg_67_1)
	local var_67_0 = {}

	local function var_67_1(arg_68_0, arg_68_1, arg_68_2)
		if arg_68_2.anim then
			arg_68_0.dftAniEvent:SetEndEvent(function()
				arg_68_0.dftAniEvent:SetEndEvent(nil)
				arg_68_0.cell:OnAnimDone()

				return
			end)
			arg_68_0.animation:Stop()
			arg_68_0.animation:Play((arg_68_0:GetAnimationKey(arg_68_2.type)))
		else
			arg_68_0.img.color = var_0_11[arg_68_2.type]
		end

		return
	end

	function var_67_0.onCellTypeChanged(arg_70_0, arg_70_1)
		var_67_1(var_67_0, arg_70_0, arg_70_1)

		return
	end

	local function var_67_2(arg_71_0, arg_71_1, arg_71_2)
		if arg_71_2 then
			arg_71_0.animation:Stop()
			arg_71_0.animation:Play("blink")
		else
			arg_71_0:ResetAlhpa()
			arg_71_0.animation:Stop("blink")
		end

		return
	end

	function var_67_0.onCellCheckChanged(arg_72_0, arg_72_1)
		var_67_2(var_67_0, arg_72_0, arg_72_1)

		return
	end

	function var_67_0:SetCheck(arg_74_1)
		setActive(self.checkTF, arg_74_1)

		return
	end

	function var_67_0:GetSprite()
		local var_75_0 = self.cell.x
		local var_75_1 = self.cell.y

		if self.cell.x > self.maxSpriteIndexX and self.cell.x % self.maxSpriteIndexX == 0 then
			var_75_0 = 0
		elseif var_75_0 > self.maxSpriteIndexX then
			var_75_0 = self.maxSpriteIndexX - self.cell.x % self.maxSpriteIndexX
		end

		if var_75_1 > self.maxSpriteIndexY then
			var_75_1 = self.maxSpriteIndexY - var_75_1 % (self.maxSpriteIndexY + 1)
		end

		return var_0_17[var_75_0][var_75_1]
	end

	function var_67_0.GetAnimationKey(arg_76_0, arg_76_1)
		local var_76_0 = ""

		if arg_76_1 == var_0_9 then
			var_76_0 = "b2w"
		elseif arg_76_1 == var_0_10 then
			var_76_0 = "w2b"
		end

		return var_76_0
	end

	function var_67_0:SetScale()
		local var_77_0 = self.cell.x / self.maxSpriteIndexX > 1 and -1 or 1
		local var_77_1 = self.cell.y / self.maxSpriteIndexY > 1 and -1 or 1

		self.cellImage.localScale = Vector3(self.cell.x / self.maxSpriteIndexX > 1 and -1 or 1, self.cell.y / self.maxSpriteIndexY > 1 and -1 or 1, 1)

		setAnchoredPosition(self.cellImage, Vector2(self.cellImage.anchoredPosition.x * var_77_0, self.cellImage.anchoredPosition.y * var_77_1))

		return
	end

	function var_67_0:ResetAlhpa()
		self.img.color = Color.New(self.img.color.r, self.img.color.g, self.img.color.b, 1)

		return
	end

	function var_67_0:SetPosition()
		local var_79_0 = self.cell:GetPosition()

		go(self._tf).name = var_79_0.x .. "_" .. var_79_0.y
		self._tf.localPosition = Vector3(var_79_0.x * ((var_79_0.x > self.maxSpriteIndexX or nil) and self.width - self.offsetX), -(var_79_0.y * ((var_79_0.y > self.maxSpriteIndexY or nil) and self.height - self.offsetY)), 0)

		if self.cellImage.localScale.x == -1 and self.cellImage.localScale.y == -1 then
			anchorMax = Vector2(1, 0)
			anchorMin = Vector2(1, 0)
		elseif self.cellImage.localScale.x == 1 and self.cellImage.localScale.y == -1 then
			anchorMax = Vector2(0, 0)
			anchorMin = Vector2(0, 0)
		elseif self.cellImage.localScale.x == -1 and self.cellImage.localScale.y == 1 then
			anchorMax = Vector2(1, 1)
			anchorMin = Vector2(1, 1)
		else
			anchorMax = Vector2(0, 1)
			anchorMin = Vector2(0, 1)
		end

		self.cellImage.anchorMax = anchorMax
		self.cellImage.anchorMin = anchorMin

		return
	end

	function var_67_0:AddListener()
		self.cell:AddListener(var_0_3, self.onCellTypeChanged)
		self.cell:AddListener(var_0_4, self.onCellCheckChanged)

		return
	end

	function var_67_0:RemoveListener()
		self.cell:RemoveListener(var_0_3, self.onCellTypeChanged)
		self.cell:RemoveListener(var_0_4, self.onCellCheckChanged)

		return
	end

	function var_67_0:Dispose()
		self:ResetAlhpa()
		self.animation:Stop()

		self._tf.localPosition = Vector3(0, 0, 0)
		self._tf.localScale = Vector3(1, 1, 1)
		self.cellImage.localPosition = Vector3(0, 0, 0)
		self.cellImage.localScale = Vector3(1, 1, 1)
		self.img.sprite = nil
		self.img.color = var_0_11[1]

		self:RemoveListener()
		removeOnButton(self._tf)
		setActive(self.checkTF, false)

		return
	end

	;(function(arg_73_0)
		arg_73_0.maxSpriteIndexX = #var_0_17
		arg_73_0.maxSpriteIndexY = #var_0_17[#var_0_17]
		arg_73_0.cell = arg_67_1
		arg_73_0._tf = arg_67_0
		arg_73_0.cellImage = arg_73_0._tf:Find("image")
		arg_73_0.checkTF = arg_73_0.cellImage:Find("check")
		arg_73_0.dftAniEvent = arg_73_0.cellImage:GetComponent(typeof(DftAniEvent))
		arg_73_0.animation = arg_73_0.cellImage:GetComponent(typeof(Animation))

		arg_73_0.animation:Stop()

		arg_73_0.img = arg_73_0.cellImage:GetComponent(typeof(Image))
		arg_73_0.width = arg_73_0._tf.sizeDelta.x
		arg_73_0.height = arg_73_0._tf.sizeDelta.y
		arg_73_0.offsetX = 2
		arg_73_0.offsetY = 0

		arg_73_0:AddListener()

		arg_73_0.img.color = var_0_11[arg_73_0.cell:GetType()]
		arg_73_0.img.sprite = arg_73_0:GetSprite()

		arg_73_0.img:SetNativeSize()
		setAnchoredPosition(arg_73_0.cellImage, Vector2(arg_73_0.cellImage.sizeDelta.x / 2, -arg_73_0.cellImage.sizeDelta.y / 2))
		arg_73_0:SetScale()
		arg_73_0:SetPosition()

		return
	end)(var_67_0)

	return var_67_0
end

local function var_0_25(arg_83_0, arg_83_1, arg_83_2)
	local var_83_0 = {
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}

	local function var_83_1(arg_87_0, arg_87_1, arg_87_2)
		local var_87_0 = arg_87_0:GetCellTpl(arg_87_2).transform

		setParent(var_87_0, arg_87_0.cellContainer)
		table.insert(arg_87_0.cells, (var_0_24(var_87_0, arg_87_2)))
		onButton(nil, var_87_0, function()
			if arg_87_0.tipCellView then
				arg_87_0.tipCellView:SetCheck(false)

				arg_87_0.tipCellView = nil
			end

			if arg_87_0.map.calcStep == 0 then
				arg_87_0:ResetMap()

				return
			end

			if not arg_87_0.map.primaryCell or arg_87_0.map.primaryCell and arg_87_0.map.primaryCell ~= arg_87_2 then
				arg_87_0:AddTipTimer()
			else
				arg_87_0:StopTipTimer()
			end

			arg_87_0.map:Primary(arg_87_2)

			return
		end, SFX_PANEL)

		return
	end

	function var_83_0.onCellCreate(arg_89_0, arg_89_1)
		var_83_1(var_83_0, arg_89_0, arg_89_1)

		return
	end

	local function var_83_2(arg_90_0, arg_90_1, arg_90_2)
		arg_90_0.leftCountTxt.text = arg_90_2

		local var_90_0 = arg_90_0.map:CalcScore()

		if arg_90_2 == 0 then
			if not arg_90_0.map.isFinished then
				arg_90_0.onFirstFinished(arg_90_0.map.id, var_90_0)

				arg_90_0.highestScoreTxt.text = var_90_0
			end

			arg_90_0.onShowResult(arg_90_0.map.id, var_90_0, function()
				arg_90_0:Reset()

				return
			end)

			arg_90_0.currScoreTxt.text = "-"
		else
			arg_90_0.currScoreTxt.text = var_90_0
		end

		return
	end

	function var_83_0.onTurnCntUpdated(arg_92_0, arg_92_1)
		var_83_2(var_83_0, arg_92_0, arg_92_1)

		return
	end

	local function var_83_3(arg_93_0, arg_93_1, arg_93_2)
		arg_93_0.highestScoreTxt.text = arg_93_2

		arg_93_0.onHighestScore(arg_93_0.map.id, arg_93_2)

		return
	end

	function var_83_0.onHighestUpdated(arg_94_0, arg_94_1)
		var_83_3(var_83_0, arg_94_0, arg_94_1)

		return
	end

	local function var_83_4(arg_95_0, arg_95_1)
		for iter_95_0, iter_95_1 in ipairs(arg_95_0.cells) do
			iter_95_1:Dispose()
			arg_95_0.poolMgr:Return(iter_95_1.cell:GetType(), iter_95_1._tf.gameObject)
		end

		arg_95_0.cells = {}

		return
	end

	function var_83_0.onDestoryCells(arg_96_0)
		var_83_4(var_83_0, arg_96_0)

		return
	end

	local function var_83_5(arg_97_0, arg_97_1, arg_97_2)
		local var_97_0 = _.detect(arg_97_0.cells, function(arg_98_0)
			return arg_98_0.cell:IsSame(arg_97_2)
		end)

		if var_97_0 then
			arg_97_0.tipCellView = var_97_0

			var_97_0:SetCheck(true)
		end

		return
	end

	function var_83_0.onCellTip(arg_99_0, arg_99_1)
		var_83_5(var_83_0, arg_99_0, arg_99_1)

		return
	end

	local function var_83_6(arg_100_0, arg_100_1)
		arg_100_0.highestScoreTxt.text = arg_100_0.map.highestScore
		arg_100_0.leftCountTxt.text = arg_100_0.map.calcStep

		local var_100_0 = arg_100_0.map:CalcScore()
		local var_100_1 = arg_100_0:ShouldShowStartBg()

		arg_100_0.currScoreTxt.text = var_100_1 and "-" or var_100_0

		setActive(arg_100_0.startBg, var_100_1)
		onButton(nil, arg_100_0.startBg, function()
			if not arg_100_0.map.isUnlock then
				return
			end

			setActive(arg_100_0.startBg, false)
			arg_100_0:RecordStartBg()

			arg_100_0.currScoreTxt.text = var_100_0

			setActive(arg_100_0.cellContainer, true)
			arg_100_0.map:Start()

			return
		end)

		if not var_100_1 then
			setActive(arg_100_0.cellContainer, true)
		end

		return
	end

	function var_83_0.onMapInitDone(arg_102_0)
		var_83_6(var_83_0, arg_102_0)

		return
	end

	function var_83_0:Reset()
		self.map:ReStart()
		setActive(self.startBg, true)
		setActive(self.cellContainer, false)

		self.currScoreTxt.text = "-"

		return
	end

	function var_83_0:ResetMap()
		if self.map.calcStep == self.map.maxCount then
			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("black_white_grid_reset"),
			onYes = function()
				self:Reset()

				return
			end
		})

		return
	end

	function var_83_0:AddTipTimer()
		if self.timer then
			self.timer:Stop()
		end

		self.timer = Timer.New(function()
			if self.map:NeedTip() then
				self.map:TriggerTip()
			end

			return
		end, var_0_13, 1)

		self.timer:Start()

		return
	end

	function var_83_0:StopTipTimer()
		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		return
	end

	function var_83_0:ShouldShowStartBg()
		return not self.map:inProcess()
	end

	function var_83_0.RecordStartBg(arg_112_0)
		return
	end

	function var_83_0:GetCellTpl(arg_113_1)
		return self.poolMgr:Get(arg_113_1:GetCellColorStr())
	end

	function var_83_0:AddListener()
		self.map:AddListener(var_0_1, self.onCellCreate)
		self.map:AddListener(var_0_2, self.onTurnCntUpdated)
		self.map:AddListener(var_0_5, self.onHighestUpdated)
		self.map:AddListener(var_0_6, self.onDestoryCells)
		self.map:AddListener(var_0_7, self.onCellTip)
		self.map:AddListener(var_0_8, self.onMapInitDone)

		return
	end

	function var_83_0:RemoveListener()
		self.map:RemoveListener(var_0_1, self.onCellCreate)
		self.map:RemoveListener(var_0_2, self.onTurnCntUpdated)
		self.map:RemoveListener(var_0_5, self.onHighestUpdated)
		self.map:RemoveListener(var_0_6, self.onDestoryCells)
		self.map:RemoveListener(var_0_7, self.onCellTip)
		self.map:RemoveListener(var_0_8, self.onMapInitDone)

		return
	end

	function var_83_0:Dispose()
		self.map:Dispose()
		removeOnButton(self.restartBtn)
		self:RemoveListener()
		var_83_4(self, nil)
		self:StopTipTimer()

		self.tipCellView = nil

		return
	end

	;(function(arg_103_0)
		arg_103_0._tf = arg_83_0
		arg_103_0.cellWhite = arg_103_0._tf:Find("cell")
		arg_103_0.cellContainer = arg_103_0._tf:Find("container")
		arg_103_0.restartBtn = arg_103_0._tf:Find("restart")
		arg_103_0.leftCountTxt = arg_103_0._tf:Find("left_count"):GetComponent(typeof(Text))
		arg_103_0.highestScoreTxt = arg_103_0._tf:Find("highest"):GetComponent(typeof(Text))
		arg_103_0.currScoreTxt = arg_103_0._tf:Find("curr_score"):GetComponent(typeof(Text))
		arg_103_0.startBg = arg_103_0._tf:Find("start_bg")
		arg_103_0.startBgText = arg_103_0.startBg:Find("Text"):GetComponent(typeof(Text))
		arg_103_0.startLabel = arg_103_0.startBg:Find("Image")
		arg_103_0.map = arg_83_1
		arg_103_0.cells = {}

		arg_103_0:AddListener()

		arg_103_0.startBgText.text = arg_103_0.map.isUnlock and "" or arg_103_0.map.condition

		setActive(arg_103_0.startLabel, arg_103_0.map.isUnlock)
		setActive(arg_103_0.cellContainer, false)
		onButton(nil, arg_103_0.restartBtn, function()
			arg_103_0:ResetMap()

			return
		end, SFX_PANEL)

		return
	end)(var_83_0)

	return var_83_0
end

local function var_0_26(arg_117_0)
	local var_117_0 = {
		_tf = arg_117_0
	}

	function var_117_0:Show(arg_120_1, arg_120_2)
		setActive(self._tf, true)

		self.scoreTxt.text = arg_120_1
		self.cb = arg_120_2

		return
	end

	function var_117_0:Hide()
		if self.cb then
			self.cb()
		end

		setActive(self._tf, false)

		self.scoreTxt.text = ""
		self.cb = nil

		return
	end

	function var_117_0:Dispose()
		self:Hide()

		return
	end

	;(function(arg_118_0)
		setActive(arg_118_0._tf, false)

		arg_118_0.scoreTxt = arg_118_0._tf:Find("score/Text"):GetComponent(typeof(Text))

		onButton(nil, arg_118_0._tf, function()
			arg_118_0:Hide()

			return
		end, SFX_PANEL)

		return
	end)(var_117_0)

	return var_117_0
end

function BlackWhiteGridLayer:getUIName()
	return "BlackWhiteGridUI"
end

function BlackWhiteGridLayer:preload(arg_124_1)
	local var_124_0 = {}

	for iter_124_0 = 0, 4 do
		for iter_124_1 = 0, 2 do
			table.insert(var_124_0, iter_124_0 .. "_" .. iter_124_1)
		end
	end

	var_0_17 = {}

	AssetBundleHelper.LoadManyAssets("ui/blackwhitegrid_atlas", var_124_0, nil, true, function(arg_125_0)
		for iter_125_0 = 0, 4 do
			var_0_17[iter_125_0] = {}

			for iter_125_1 = 0, 2 do
				var_0_17[iter_125_0][iter_125_1] = arg_125_0[iter_125_0 .. "_" .. iter_125_1]
			end
		end

		return
	end, true)

	self.bgSprite = nil

	LoadSpriteAsync("clutter/blackwhite_bg", function(arg_126_0)
		self.bgSprite = arg_126_0

		arg_124_1()

		return
	end)

	return
end

function BlackWhiteGridLayer:setActivity(arg_127_1)
	self.activityVO = arg_127_1
	self.passIds = arg_127_1.data1_list
	self.scores = arg_127_1.data2_list

	self:updateFur()

	return
end

function BlackWhiteGridLayer:setPlayer(arg_128_1)
	self.player = arg_128_1

	return
end

function BlackWhiteGridLayer:init()
	self.mapTF = self._tf:Find("map")
	self.backBtn = self._tf:Find("back")
	self.toggleTFs = self._tf:Find("toggles")
	self.poolMgr = var_0_20(self.mapTF:Find("root"))
	self.successMsgbox = var_0_26(self._tf:Find("success_bg"))
	self.failedMsgbox = var_0_26(self._tf:Find("failed_bg"))
	self.furGot = self._tf:Find("fur/got")
	self.helpBtn = self._tf:Find("help")
	self._tf:GetComponent(typeof(Image)).sprite = self.bgSprite

	return
end

function BlackWhiteGridLayer:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(BlackWhiteGridLayer.ON_CLOSE)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.black_white_grid_notice.tip
		})

		return
	end, SFX_PANEL)

	self.selecteds = {}

	local function var_130_0(arg_133_0)
		eachChild(arg_133_0, function(arg_134_0)
			if go(arg_134_0).name ~= "text" and go(arg_134_0).activeSelf then
				local var_134_0 = arg_134_0:GetComponent(typeof(Image))

				var_134_0.color = var_0_12

				table.insert(self.selecteds, var_134_0)
			end

			return
		end)

		return
	end

	local function var_130_1()
		for iter_135_0, iter_135_1 in ipairs(self.selecteds) do
			iter_135_1.color = Color.New(1, 1, 1, 1)
		end

		self.selecteds = {}

		return
	end

	self.btns = {}
	self.maps = {}

	for iter_130_0, iter_130_1 in ipairs(self.activityVO:getConfig("config_data")) do
		local var_130_2 = var_0_16[iter_130_1]
		local var_130_3 = self.toggleTFs:GetChild(iter_130_0 - 1)

		self.maps[iter_130_1] = self:GetMapVO(var_0_16[iter_130_1])

		onButton(self, var_130_3, function()
			if self.id == iter_130_1 then
				return
			end

			if self.mapView and self.mapView.map:inProcess() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("black_white_grid_switch_tip"))

				return
			end

			self.id = iter_130_1

			self:loadMap((self:GetMapVO(var_130_2)))

			if #self.selecteds > 0 then
				var_130_1()
			end

			var_130_0(var_130_3)

			return
		end, SFX_PANEL)

		self.btns[iter_130_1] = var_130_3
	end

	local var_130_4 = self:GetLastestUnlockMap()

	if var_130_4 then
		triggerButton(var_130_4)
	end

	self:updateBtnsState()

	return
end

function BlackWhiteGridLayer:updateFur()
	if self.furGot then
		local var_137_0 = self.activityVO:getConfig("config_data")

		setActive(self.furGot, table.contains(self.passIds, var_137_0[#var_137_0 - 1]))
	end

	return
end

function BlackWhiteGridLayer:isUnlock(arg_138_1)
	local var_138_0 = getProxy(ChapterProxy):getChapterById(arg_138_1.unlock[2])

	return var_138_0 and var_138_0:isUnlock() and var_138_0:isAllAchieve() and (arg_138_1.unlock[1] == 0 or table.contains(self.passIds, arg_138_1.unlock[1]))
end

function BlackWhiteGridLayer:GetLastestUnlockMap()
	local var_139_0 = self:GetMapIndex()

	if self.btns[var_139_0] then
		return self.btns[var_139_0]
	else
		local var_139_1
		local var_139_2 = 0

		for iter_139_0, iter_139_1 in pairs(self.btns) do
			var_139_2 = var_139_2 + 1

			if self:isUnlock(var_0_16[iter_139_0]) or var_139_2 == 1 then
				var_139_1 = iter_139_1
			end
		end

		return var_139_1
	end

	return
end

function BlackWhiteGridLayer:updateBtnsState()
	for iter_140_0, iter_140_1 in pairs(self.btns) do
		local var_140_0 = table.contains(self.passIds, iter_140_0)
		local var_140_1 = self:isUnlock(var_0_16[iter_140_0])

		setActive(iter_140_1:Find("finished"), var_140_0)
		setActive(iter_140_1:Find("locked"), not var_140_1)
		setActive(iter_140_1:Find("opening"), not var_140_0 and var_140_1)
	end

	return
end

function BlackWhiteGridLayer:GetMapVO(arg_141_1)
	local var_141_0
	local var_141_1 = table.indexof(self.passIds, arg_141_1.id)
	local var_141_2 = table.contains(self.passIds, arg_141_1.id)
	local var_141_3 = {
		highestScore = (var_141_1 or nil) and (self.scores[var_141_1] or 0),
		isFinished = var_141_2,
		isUnlock = self:isUnlock(arg_141_1)
	}

	if self.maps[arg_141_1.id] then
		var_141_0 = self.maps[arg_141_1.id]

		self.maps[arg_141_1.id]:UpdateData(var_141_3)
	else
		local var_141_4, var_141_5, var_141_6 = self:parseMap(arg_141_1)

		var_141_0 = var_0_23({
			id = arg_141_1.id,
			maps = var_141_4,
			calcStep = var_141_5,
			maxCount = arg_141_1.num,
			condition = arg_141_1.condition,
			started = var_141_6
		})

		var_141_0:UpdateData(var_141_3)
	end

	return var_141_0
end

function BlackWhiteGridLayer:parseMap(arg_142_1)
	local var_142_0 = PlayerPrefs.GetString("BlackWhiteGridMapData-" .. arg_142_1.id .. "-" .. self.player.id, "")

	if not var_142_0 or var_142_0 == "" then
		return arg_142_1.map, arg_142_1.num, false
	else
		local var_142_1 = var_142_0:split("#")

		return loadstring("return " .. var_142_1[1])(), tonumber(var_142_1[2]), var_142_1[3] == "1"
	end

	return
end

function BlackWhiteGridLayer:SaveMapsData()
	for iter_143_0, iter_143_1 in ipairs(self.maps) do
		local var_143_0 = iter_143_1:Serialize()

		if var_143_0 and var_143_0 ~= "" then
			PlayerPrefs.SetString("BlackWhiteGridMapData-" .. iter_143_1.id .. "-" .. self.player.id, var_143_0)
		end
	end

	PlayerPrefs.Save()

	return
end

function BlackWhiteGridLayer:GetMapIndex()
	return (PlayerPrefs.GetInt("BlackWhiteGridMapIndex-" .. self.player.id, 1))
end

function BlackWhiteGridLayer:SaveMapIndex()
	PlayerPrefs.SetInt("BlackWhiteGridMapIndex-" .. self.player.id, self.id or 1)
	PlayerPrefs.Save()

	return
end

function BlackWhiteGridLayer:loadMap(arg_146_1)
	if self.mapView then
		self.mapView:Dispose()
	end

	self.mapView = var_0_25(self.mapTF, arg_146_1, self.poolMgr)

	function self.mapView.onFirstFinished(arg_147_0, arg_147_1)
		self:emit(BlackWhiteGridMediator.ON_FINISH, arg_147_0, arg_147_1)

		return
	end

	function self.mapView.onHighestScore(arg_148_0, arg_148_1)
		self:emit(BlackWhiteGridMediator.ON_UPDATE_SCORE, arg_148_0, arg_148_1)

		return
	end

	function self.mapView.onShowResult(arg_149_0, arg_149_1, arg_149_2)
		if arg_149_1 >= 0 then
			self.successMsgbox:Show(arg_149_1, arg_149_2)
		else
			self.failedMsgbox:Show(arg_149_1, arg_149_2)
		end

		return
	end

	arg_146_1:Init()

	return
end

function BlackWhiteGridLayer:playStory(arg_150_1)
	if var_0_16[self.mapView.map.id].story and var_0_16[self.mapView.map.id].story ~= "" then
		pg.NewStoryMgr.GetInstance():Play(var_0_16[self.mapView.map.id].story, arg_150_1, true, true)
	else
		arg_150_1()
	end

	return
end

function BlackWhiteGridLayer:willExit()
	self:SaveMapsData()
	self:SaveMapIndex()

	if self.mapView then
		self.mapView:Dispose()
	end

	self.successMsgbox:Dispose()
	self.failedMsgbox:Dispose()
	self.poolMgr:Dispose()

	var_0_17 = nil

	return
end

return BlackWhiteGridLayer
