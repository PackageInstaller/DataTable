local Match3GameView = class("Match3GameView", import("..BaseMiniGameView"))
local var_0_1 = 6
local var_0_2 = 7
local var_0_3 = -405
local var_0_4 = -275
local var_0_5 = 135
local var_0_6 = 110
local var_0_7 = false
local var_0_8 = 0.1
local var_0_9 = 0
local var_0_10 = 0.3
local var_0_11 = 0.5
local var_0_12 = 100
local var_0_13 = 0.2
local var_0_14 = 0.4
local var_0_15 = 180
local var_0_16 = 60
local var_0_17 = 3
local var_0_18 = 2
local var_0_19 = 0.3
local var_0_20 = 0.3
local var_0_21 = 2.5
local var_0_22 = "event:/ui/ddldaoshu2"
local var_0_23 = "event:/ui/boat_drag"
local var_0_24 = "event:/ui/break_out_full"
local var_0_25 = "event:/ui/sx-good"
local var_0_26 = "event:/ui/sx-perfect"
local var_0_27 = "event:/ui/sx-jishu"
local var_0_28 = "event:/ui/furnitrue_save"

function Match3GameView:getUIName()
	return "Match3GameUI"
end

function Match3GameView:getBGM()
	return "backyard"
end

function Match3GameView:init()
	self.matchEffect = self._tf:Find("effects/sanxiaoxiaoshi")
	self.goodEffect = self._tf:Find("effects/sanxiaoGood")
	self.greatEffect = self._tf:Find("effects/sanxiaoGreat")
	self.perfectEffect = self._tf:Find("effects/sanxiaoPerfect")
	self.hintEffect = self._tf:Find("effects/hint")
	self.selectedEffect = self._tf:Find("effects/selected")
	self.whitenMat = self._tf:Find("effects/whiten"):GetComponent("Image").material
	self.backBtn = self._tf:Find("button/back")
	self.mainPage = self._tf:Find("main")
	self.startBtn = self._tf:Find("main/start")
	self.helpBtn = self._tf:Find("main/rule")
	self.countdownPage = self._tf:Find("countdown")
	self.countdownAnim = self._tf:Find("countdown")
	self.gamePage = self._tf:Find("game")
	self.gameMask = self._tf:Find("game/mask")
	self.warning = self._tf:Find("game/warning")
	self.countdownTf = self._tf:Find("game/countdown")
	self.countdownText = self._tf:Find("game/countdown/Text")
	self.inf = self._tf:Find("game/countdown/inf")
	self.scoreText = self._tf:Find("game/score/Text")
	self.floatText = self._tf:Find("game/floatText")
	self.floatChar = {}
	self.pausePage = self._tf:Find("game/pause")
	self.pauseYes = self._tf:Find("game/pause/yes")
	self.pauseNo = self._tf:Find("game/pause/no")

	for iter_3_0 = 0, 9 do
		self.floatChar[iter_3_0] = self._tf:Find("game/floatText/" .. iter_3_0)
	end

	self.tilesRoot = self._tf:Find("game/tiles")
	self.gameListener = self.tilesRoot:GetComponent("EventTriggerListener")
	self.longPressListener = self.tilesRoot:GetComponent("UILongPressTrigger")
	self.endPage = self._tf:Find("end")
	self.endBtn = self._tf:Find("end/end_btn")
	self.endScore = self._tf:Find("end/score/Text")
	self.newSign = self._tf:Find("end/score/Text/new")
	self.bestScore = self._tf:Find("end/highest/Text")
	self.tiles = {
		self._tf:Find("tiles/Akashi"),
		self._tf:Find("tiles/Ayanami"),
		self._tf:Find("tiles/Javelin"),
		self._tf:Find("tiles/Laffey"),
		self._tf:Find("tiles/Z23")
	}

	return
end

function Match3GameView:onBackPressed()
	if isActive(self.mainPage) then
		self:emit(Match3GameView.ON_BACK)
	elseif isActive(self.pausePage) then
		triggerButton(self.pauseNo)
	elseif isActive(self.gamePage) then
		self:pause()
	elseif isActive(self.endPage) and self.endBtn:GetComponent("Button").enabled then
		triggerButton(self.endBtn)
	end

	return
end

function Match3GameView:didEnter()
	onButton(self, self.backBtn, function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self.startBtn, function()
		if var_0_7 then
			setActive(self.mainPage, false)
			setActive(self.gamePage, true)
			self:startGame()
		else
			self.mainPage:GetComponent("CanvasGroup").blocksRaycasts = false

			self:managedTween(LeanTween.value, function()
				self.mainPage:GetComponent("CanvasGroup").alpha = 1
				self.mainPage:GetComponent("CanvasGroup").blocksRaycasts = true

				setActive(self.mainPage, false)
				setActive(self.countdownPage, true)
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_22)

				return
			end, go(self.mainPage), 1, 0, var_0_20):setOnUpdate(System.Action_float(function(arg_9_0)
				self.mainPage:GetComponent("CanvasGroup").alpha = arg_9_0

				return
			end))
		end

		return
	end)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("3match_tip")
		})

		return
	end, SFX_PANEL)
	self.countdownAnim:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_11_0)
		setActive(self.countdownPage, false)
		setActive(self.gamePage, true)
		self:startGame()

		return
	end)
	onButton(self, self.endBtn, function()
		self.mainPage:GetComponent("CanvasGroup").blocksRaycasts = false

		self:managedTween(LeanTween.value, function()
			self.mainPage:GetComponent("CanvasGroup").alpha = 1
			self.mainPage:GetComponent("CanvasGroup").blocksRaycasts = true

			return
		end, go(self.endPage), 0, 1, var_0_20):setOnUpdate(System.Action_float(function(arg_14_0)
			self.mainPage:GetComponent("CanvasGroup").alpha = arg_14_0

			return
		end))
		setActive(self.mainPage, true)
		setActive(self.countdownPage, false)
		setActive(self.gamePage, false)
		setActive(self.endPage, false)

		return
	end)
	onButton(self, self.pauseYes, function()
		self:stopGame()

		return
	end)
	onButton(self, self.pauseNo, function()
		setActive(self.pausePage, false)
		self:resumeGame()

		return
	end)

	local var_5_0 = false

	self.gameListener:AddPointClickFunc(function(arg_17_0, arg_17_1)
		if var_5_0 then
			var_5_0 = false

			return
		end

		if self.updating then
			return
		end

		if not self.inGame then
			return
		end

		local var_17_0, var_17_1 = self:pos2index((LuaHelper.ScreenToLocal(self.tilesRoot, arg_17_1.position, GameObject.Find("UICamera"):GetComponent(typeof(Camera)))))

		if self.selected then
			if self.selected == self.tileTfs[var_17_0][var_17_1] then
				self:unselect()
			elseif math.abs(var_17_0 - self.selectedIndex.i) + math.abs(var_17_1 - self.selectedIndex.j) == 1 then
				self:tryMoveTo({
					i = var_17_0,
					j = var_17_1
				})
			else
				self:select(var_17_0, var_17_1)
			end
		else
			self:select(var_17_0, var_17_1)
		end

		return
	end)
	self.longPressListener.onLongPressed:AddListener(function()
		if self.updating then
			return
		end

		if not self.inGame then
			return
		end

		local var_18_0, var_18_1 = self:pos2index((LuaHelper.ScreenToLocal(self.tilesRoot, Input.mousePosition, GameObject.Find("UICamera"):GetComponent(typeof(Camera)))))

		self:unselect()
		self:animate(var_18_0, var_18_1, true)

		return
	end)
	self.gameListener:AddBeginDragFunc(function(arg_19_0, arg_19_1)
		if self.updating then
			return
		end

		if not self.inGame then
			return
		end

		var_5_0 = true

		local var_19_0, var_19_1 = self:pos2index((LuaHelper.ScreenToLocal(self.tilesRoot, arg_19_1.position, GameObject.Find("UICamera"):GetComponent(typeof(Camera)))))

		self:animate(var_19_0, var_19_1, false)
		self:unselect()

		self.selected = self.tileTfs[var_19_0][var_19_1]
		self.selectedIndex = {
			i = var_19_0,
			j = var_19_1
		}

		if math.abs(arg_19_1.delta.x) > math.abs(arg_19_1.delta.y) then
			var_19_0 = 0
			var_19_1 = arg_19_1.delta.x > 0 and 1 or -1
		else
			var_19_0 = arg_19_1.delta.y > 0 and 1 or -1
			var_19_1 = 0
		end

		self:tryMoveTo({
			i = self.selectedIndex.i + var_19_0,
			j = self.selectedIndex.j + var_19_1
		})

		return
	end)
	setActive(self.mainPage, true)
	self:updateData()

	return
end

function Match3GameView:updateData()
	self.infinite = self:GetMGHubData().count == 0

	local var_20_0 = self:GetMGData():GetRuntimeData("elements")

	if var_20_0 then
		self.best = var_20_0[1] or 0
	end

	return
end

function Match3GameView:index2pos(arg_21_1, arg_21_2)
	return Vector3.New(var_0_3 + (arg_21_2 - 1) * var_0_5, var_0_4 + (arg_21_1 - 1) * var_0_6)
end

function Match3GameView:pos2index(arg_22_1)
	local var_22_0 = math.ceil((arg_22_1.y - (var_0_4 - var_0_6 / 2)) / var_0_6)
	local var_22_1 = math.ceil((arg_22_1.x - (var_0_3 - var_0_5 / 2)) / var_0_5)
end

function Match3GameView:dropTime()
	return math.max(self * var_0_8, var_0_9)
end

function Match3GameView:cancelHint()
	if self.hint then
		Destroy(self.hint)
		self.hint1:GetComponent("Animator"):SetBool("selected", false)
		self.hint2:GetComponent("Animator"):SetBool("selected", false)

		self.hint = nil
		self.hint1 = nil
		self.hint2 = nil
	end

	return
end

local var_0_29 = {
	{
		0,
		1
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	},
	{
		1,
		0
	}
}

function Match3GameView:unselect()
	if self.selectedEffectTf then
		Destroy(self.selectedEffectTf)

		self.selectedEffectTf = nil
	end

	if self.selected then
		self:animate(self.selectedIndex.i, self.selectedIndex.j, false)

		self.selected = nil
		self.selectedIndex = nil

		self:reorderTiles()
	end

	return
end

function Match3GameView:select(arg_26_1, arg_26_2)
	self:unselect()

	self.selected = self.tileTfs[arg_26_1][arg_26_2]
	self.selectedIndex = {
		i = arg_26_1,
		j = arg_26_2
	}
	self.selectedEffectTf = rtf(cloneTplTo(self.selectedEffect, self.tilesRoot))
	self.selectedEffectTf.anchoredPosition = self.selected.anchoredPosition

	self.selected:SetAsLastSibling()
	self:animate(arg_26_1, arg_26_2, true)

	return
end

function Match3GameView:animate(arg_27_1, arg_27_2, arg_27_3)
	if not self.tileTfs[arg_27_1][arg_27_2] then
		warning("bad position", arg_27_1, arg_27_2)
	end

	self.tileTfs[arg_27_1][arg_27_2]:GetComponent("Animator"):SetBool("selected", arg_27_3)

	for iter_27_0, iter_27_1 in pairs(var_0_29) do
		if self.tileTfs[arg_27_1 + iter_27_1[1]][arg_27_2 + iter_27_1[2]] then
			self.tileTfs[arg_27_1 + iter_27_1[1]][arg_27_2 + iter_27_1[2]]:GetComponent("Animator"):SetBool("selected", arg_27_3)
		end
	end

	if self.hint then
		self.hint1:GetComponent("Animator"):SetBool("selected", true)
		self.hint2:GetComponent("Animator"):SetBool("selected", true)
	end

	return
end

function Match3GameView:tryMoveTo(arg_28_1)
	if self.selectedIndex == nil then
		return
	end

	if self.hintTimer then
		self.hintTimer:Pause()
	end

	if not self.tileIndicies[arg_28_1.i][arg_28_1.j] then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_23)

	if self:moveValid(self.selectedIndex, arg_28_1) then
		self:unselect()

		self.updating = true

		self:swap(self.selectedIndex, arg_28_1)
		self:managedTween(LeanTween.delayedCall, function()
			if not self.inGame then
				return
			end

			self.combo = 0

			self:update()

			return
		end, var_0_13, nil)
	else
		self:managedTween(LeanTween.move, nil, self.tileTfs[self.selectedIndex.i][self.selectedIndex.j], self:index2pos(arg_28_1.i, arg_28_1.j), var_0_13):setLoopPingPong(1)
		self:managedTween(LeanTween.move, nil, self.tileTfs[arg_28_1.i][arg_28_1.j], self:index2pos(self.selectedIndex.i, self.selectedIndex.j), var_0_13):setLoopPingPong(1)

		self.updating = true

		self:managedTween(LeanTween.delayedCall, function()
			self.updating = false

			self.hintTimer:Resume()

			return
		end, var_0_13 * 2 + 0.1, nil)
		self:unselect()
	end

	return
end

local var_0_30 = {
	{
		{
			0,
			-2
		},
		{
			0,
			-1
		}
	},
	{
		{
			0,
			-1
		},
		{
			0,
			1
		}
	},
	{
		{
			0,
			1
		},
		{
			0,
			2
		}
	}
}

function Match3GameView:isConnected(arg_31_1)
	for iter_31_0, iter_31_1 in pairs(var_0_30) do
		if self.tileIndicies[arg_31_1.i][arg_31_1.j] == self.tileIndicies[arg_31_1.i + iter_31_1[1][1]][arg_31_1.j + iter_31_1[1][2]] and self.tileIndicies[arg_31_1.i][arg_31_1.j] == nil then
			return true
		end

		if self.tileIndicies[arg_31_1.i][arg_31_1.j] == self.tileIndicies[arg_31_1.i + iter_31_1[1][2]][arg_31_1.j + iter_31_1[1][1]] and self.tileIndicies[arg_31_1.i][arg_31_1.j] == self.tileIndicies[arg_31_1.i + iter_31_1[2][2]][arg_31_1.j + iter_31_1[2][1]] then
			return true
		end
	end

	return false
end

function Match3GameView:moveValid(arg_32_1, arg_32_2)
	self.tileIndicies[arg_32_2.i][arg_32_2.j] = self.tileIndicies[arg_32_1.i][arg_32_1.j]
	self.tileIndicies[arg_32_1.i][arg_32_1.j] = self.tileIndicies[arg_32_2.i][arg_32_2.j]
	self.tileIndicies[arg_32_2.i][arg_32_2.j] = self.tileIndicies[arg_32_1.i][arg_32_1.j]
	self.tileIndicies[arg_32_1.i][arg_32_1.j] = self.tileIndicies[arg_32_2.i][arg_32_2.j]

	return self:isConnected(arg_32_1) or self:isConnected(arg_32_2)
end

function Match3GameView:moveTile(arg_33_1, arg_33_2, arg_33_3)
	self:managedTween(LeanTween.move, nil, arg_33_1, self:index2pos(arg_33_2.i, arg_33_2.j), arg_33_3 or 0):setEase(LeanTweenType.easeInQuad)

	return
end

function Match3GameView:swap(arg_34_1, arg_34_2)
	self:moveTile(self.tileTfs[arg_34_1.i][arg_34_1.j], arg_34_2, var_0_13)
	self:moveTile(self.tileTfs[arg_34_2.i][arg_34_2.j], arg_34_1, var_0_13)

	self.tileTfs[arg_34_2.i][arg_34_2.j] = self.tileTfs[arg_34_1.i][arg_34_1.j]
	self.tileTfs[arg_34_1.i][arg_34_1.j] = self.tileTfs[arg_34_2.i][arg_34_2.j]
	self.tileIndicies[arg_34_2.i][arg_34_2.j] = self.tileIndicies[arg_34_1.i][arg_34_1.j]
	self.tileIndicies[arg_34_1.i][arg_34_1.j] = self.tileIndicies[arg_34_2.i][arg_34_2.j]

	return
end

function Match3GameView:formatTime(arg_35_1)
	local var_35_0 = math.floor(arg_35_1 / 60)

	arg_35_1 = arg_35_1 - var_35_0 * 60

	return var_35_0 .. ":" .. math.floor(arg_35_1)
end

function dir2Angle(arg_36_0)
	if arg_36_0[1] == 1 then
		return -90
	elseif arg_36_0[1] == -1 then
		return 90
	elseif arg_36_0[2] == 1 then
		return 180
	elseif arg_36_0[2] == -1 then
		return 0
	end

	return
end

function Match3GameView:startGame()
	self:updateData()

	local var_37_0 = Timer.New(function()
		self:managedTween(LeanTween.value, function()
			self.gamePage:GetComponent("CanvasGroup").alpha = 1

			self:stopGame()

			return
		end, go(self.gamePage), 1, 0, var_0_10):setOnUpdate(System.Action_float(function(arg_40_0)
			self.gamePage:GetComponent("CanvasGroup").alpha = arg_40_0

			return
		end))
		UpdateBeat:RemoveListener(self.handle)

		return
	end, (self.infinite or nil) and (var_0_15 or var_0_16))

	self.handle = UpdateBeat:CreateListener(function()
		setText(self.countdownText, math.floor(var_37_0.time))

		if var_37_0.time <= var_0_17 and not isActive(self.warning) then
			setActive(self.warning, true)
		end

		return
	end, self)

	var_37_0:Start()
	UpdateBeat:AddListener(self.handle)

	self.timer = var_37_0

	setActive(self.inf, false)
	setActive(self.countdownText, true)

	self.tileIndicies = {}

	for iter_37_0 = -1, var_0_1 + 2 do
		self.tileIndicies[iter_37_0] = {}
	end

	self.tileTfs = {}

	for iter_37_1 = -1, var_0_1 + 2 do
		self.tileTfs[iter_37_1] = {}
	end

	self:fillTileIndicies()
	self:fillTiles(true)

	self.selected = nil
	self.updating = false
	self.score = 0
	self.combo = 0
	self.inGame = true

	setText(self.scoreText, self.score)

	function self.hintFunc()
		if self.hint then
			return
		end

		local var_42_0, var_42_1, var_42_2 = self:findMove()
		local var_42_3 = rtf(cloneTplTo(self.hintEffect, self.tilesRoot))

		var_42_3.anchoredPosition = (self:index2pos(var_42_0, var_42_1) + self:index2pos(var_42_0 + var_42_2[1], var_42_1 + var_42_2[2])) / 2
		var_42_3.localEulerAngles = Vector3.New(0, 0, dir2Angle(var_42_2))
		self.hint = var_42_3
		self.hint1 = self.tileTfs[var_42_0][var_42_1]
		self.hint2 = self.tileTfs[var_42_0 + var_42_2[1]][var_42_1 + var_42_2[2]]

		self.hint1:GetComponent("Animator"):SetBool("selected", true)
		self.hint2:GetComponent("Animator"):SetBool("selected", true)

		return
	end

	self.hintTimer = Timer.New(self.hintFunc, var_0_21)

	self.hintTimer:Start()

	return
end

function Match3GameView:pauseGame()
	if self.timer then
		self.timer:Pause()
	end

	if self.hintTimer then
		self.hintTimer:Pause()
	end

	if self.warning then
		self.warning:GetComponent("Animator").enabled = false
	end

	self:pauseManagedTween()

	return
end

function Match3GameView:pause()
	setActive(self.pausePage, true)
	self:pauseGame()

	return
end

function Match3GameView:resumeGame()
	if self.timer then
		self.timer:Resume()
	end

	if self.hintTimer then
		self.hintTimer:Resume()
	end

	if self.warning then
		self.warning:GetComponent("Animator").enabled = true
	end

	self:resumeManagedTween()

	return
end

function Match3GameView:fillTileIndicies()
	local var_46_0 = {}

	for iter_46_0 = -1, var_0_1 + 2 do
		var_46_0[iter_46_0] = {}

		for iter_46_1 = 1, var_0_2 do
			var_46_0[iter_46_0][iter_46_1] = self.tileIndicies[iter_46_0][iter_46_1]
		end
	end

	repeat
		self.tileIndicies = {}

		for iter_46_2 = -1, var_0_1 + 2 do
			self.tileIndicies[iter_46_2] = {}

			for iter_46_3 = 1, var_0_2 do
				self.tileIndicies[iter_46_2][iter_46_3] = var_46_0[iter_46_2][iter_46_3]
			end
		end

		for iter_46_4 = 1, var_0_1 do
			for iter_46_5 = 1, var_0_2 do
				if not self.tileIndicies[iter_46_4][iter_46_5] then
					local var_46_1
					local var_46_2

					if self.tileIndicies[iter_46_4 - 1][iter_46_5] and self.tileIndicies[iter_46_4 - 1][iter_46_5] == self.tileIndicies[iter_46_4 - 2][iter_46_5] then
						var_46_1 = self.tileIndicies[iter_46_4 - 1][iter_46_5]
					end

					if self.tileIndicies[iter_46_4][iter_46_5 - 1] and self.tileIndicies[iter_46_4][iter_46_5 - 1] == self.tileIndicies[iter_46_4][iter_46_5 - 2] then
						var_46_2 = self.tileIndicies[iter_46_4][iter_46_5 - 2]
					end

					local var_46_3 = math.random(1, #self.tiles)

					while var_46_3 == var_46_1 or var_46_3 == var_46_2 do
						var_46_3 = math.random(1, #self.tiles)
					end

					self.tileIndicies[iter_46_4][iter_46_5] = var_46_3
				end
			end
		end
	until self:findMove()

	return
end

function Match3GameView:reorderTiles()
	for iter_47_0 = 1, var_0_1 do
		for iter_47_1 = 1, var_0_2 do
			if self.tileTfs[iter_47_0][iter_47_1] then
				self.tileTfs[iter_47_0][iter_47_1]:SetAsFirstSibling()
			end
		end
	end

	return
end

function Match3GameView:fillTiles(arg_48_1)
	local var_48_0 = 0

	for iter_48_0 = 1, var_0_2 do
		local var_48_1 = 0

		for iter_48_1 = var_0_1, 1, -1 do
			if not self.tileTfs[iter_48_1][iter_48_0] then
				var_48_1 = var_48_1 + 1
			end
		end

		var_48_0 = math.max(var_48_1, var_48_0)

		for iter_48_2 = 1, var_0_1 do
			if not self.tileTfs[iter_48_2][iter_48_0] then
				local var_48_2 = rtf(cloneTplTo(self.tiles[self.tileIndicies[iter_48_2][iter_48_0]], self.tilesRoot))

				if arg_48_1 then
					var_48_2.anchoredPosition = self:index2pos(iter_48_2, iter_48_0)
				else
					var_48_2.anchoredPosition = self:index2pos(iter_48_2 + var_48_1, iter_48_0)

					self:moveTile(var_48_2, {
						i = iter_48_2,
						j = iter_48_0
					}, self.dropTime(var_48_1))
				end

				self.tileTfs[iter_48_2][iter_48_0] = var_48_2
			end
		end
	end

	self:reorderTiles()

	return var_48_0
end

local var_0_31 = {
	{
		{
			-1,
			-2
		},
		{
			-1,
			-1
		}
	},
	{
		{
			-1,
			-1
		},
		{
			-1,
			1
		}
	},
	{
		{
			-1,
			1
		},
		{
			-1,
			2
		}
	}
}

function Match3GameView:findMove()
	for iter_49_0 = 1, var_0_1 do
		for iter_49_1 = 1, var_0_2 do
			for iter_49_2, iter_49_3 in pairs(var_0_31) do
				if self.tileIndicies[iter_49_0][iter_49_1] == self.tileIndicies[iter_49_0 + iter_49_3[1][1]][iter_49_1 + iter_49_3[1][2]] and self.tileIndicies[iter_49_0][iter_49_1] == self.tileIndicies[iter_49_0 + iter_49_3[2][1]][iter_49_1 + iter_49_3[2][2]] then
					return iter_49_0, iter_49_1, {
						-1,
						0
					}
				end

				if self.tileIndicies[iter_49_0][iter_49_1] == self.tileIndicies[iter_49_0 - iter_49_3[1][1]][iter_49_1 - iter_49_3[1][2]] and self.tileIndicies[iter_49_0][iter_49_1] == self.tileIndicies[iter_49_0 - iter_49_3[2][1]][iter_49_1 - iter_49_3[2][2]] then
					return iter_49_0, iter_49_1, {
						1,
						0
					}
				end

				if self.tileIndicies[iter_49_0][iter_49_1] == self.tileIndicies[iter_49_0 - iter_49_3[1][2]][iter_49_1 + iter_49_3[1][1]] and self.tileIndicies[iter_49_0][iter_49_1] == self.tileIndicies[iter_49_0 - iter_49_3[2][2]][iter_49_1 + iter_49_3[2][1]] then
					return iter_49_0, iter_49_1, {
						0,
						-1
					}
				end

				if self.tileIndicies[iter_49_0][iter_49_1] == self.tileIndicies[iter_49_0 + iter_49_3[1][2]][iter_49_1 - iter_49_3[1][1]] and self.tileIndicies[iter_49_0][iter_49_1] == self.tileIndicies[iter_49_0 + iter_49_3[2][2]][iter_49_1 - iter_49_3[2][1]] then
					return iter_49_0, iter_49_1, {
						0,
						1
					}
				end
			end
		end
	end

	return
end

function Match3GameView:stopGame()
	self.inGame = false

	setActive(self.warning, false)
	self.hintTimer:Reset(self.hintFunc, 5)
	self.hintTimer:Stop()
	self:cleanManagedTween(true)
	self:cancelHint()

	if self.timer then
		self.timer:Pause()
	end

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	for iter_50_0 = 1, var_0_1 do
		for iter_50_1 = 1, var_0_2 do
			if self.tileTfs[iter_50_0][iter_50_1] then
				Destroy(self.tileTfs[iter_50_0][iter_50_1])
			end
		end
	end

	if self.selectedEffectTf then
		Destroy(self.selectedEffectTf)

		self.selectedEffectTf = nil
	end

	setText(self.bestScore, math.max(self.best, self.score))
	setActive(self.gamePage, false)
	setActive(self.pausePage, false)
	setActive(self.endBtn, false)
	setActive(self.endPage, true)

	if self.score > 0 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_27)
	end

	setActive(self.newSign, false)
	setText(self.endScore, 0)
	self:managedTween(LeanTween.value, function()
		setActive(self.newSign, self.best < self.score)
		setActive(self.endBtn, true)
		setImageAlpha(self.endBtn, 0)

		self.endBtn:GetComponent("Button").enabled = false

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_28)
		self:managedTween(LeanTween.value, function()
			self.endBtn:GetComponent("Button").enabled = true

			if self.infinite or self.timer and self.timer.time <= 0 then
				if not self.infinite then
					self:SendSuccess(0)
				end

				if self.score > self.best then
					self:StoreDataToServer({
						self.score
					})
				end
			end

			self.timer = nil

			return
		end, go(self.endBtn), 0, 1, var_0_19):setOnUpdate(System.Action_float(function(arg_53_0)
			setImageAlpha(self.endBtn, arg_53_0)

			return
		end))

		return
	end, go(self.endScore), 0, self.score, (self.score > 0 or nil) and (var_0_18 or 0)):setOnUpdate(System.Action_float(function(arg_54_0)
		setText(self.endScore, math.floor(arg_54_0))

		return
	end))

	return
end

function Match3GameView:formatScore(arg_55_1, arg_55_2)
	local var_55_0 = {}

	while arg_55_2 > 0 do
		table.insert(var_55_0, math.fmod(arg_55_2, 10))

		arg_55_2 = math.floor(arg_55_2 / 10)
	end

	for iter_55_0 = #var_55_0, 1, -1 do
		cloneTplTo(self.floatChar[var_55_0[iter_55_0]], arg_55_1)
	end

	return
end

function Match3GameView:update()
	self.hintTimer:Stop()

	local var_56_0 = true

	self.updating = true

	local var_56_1 = self:tryMatch()

	if next(var_56_1) ~= nil then
		self:cancelHint()

		var_56_0 = false
		self.combo = self.combo + 1

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_24)

		local var_56_2

		for iter_56_0, iter_56_1 in pairs(var_56_1) do
			var_56_2 = #iter_56_1 == 3 and 30 * self.combo or #iter_56_1 == 4 and 60 * self.combo or 20 * #iter_56_1 * self.combo
			self.score = self.score + var_56_2

			setText(self.scoreText, self.score)

			local var_56_3 = Vector2.zero

			_.each(iter_56_1, function(arg_57_0)
				self.tileIndicies[arg_57_0[1]][arg_57_0[2]] = nil

				if self.tileTfs[arg_57_0[1]][arg_57_0[2]] then
					local var_57_0 = self.tileTfs[arg_57_0[1]][arg_57_0[2]]

					var_56_3 = var_56_3 + self.tileTfs[arg_57_0[1]][arg_57_0[2]].anchoredPosition
					self.tileTfs[arg_57_0[1]][arg_57_0[2]]:GetComponent("Image").material = self.whitenMat
					self.tileTfs[arg_57_0[1]][arg_57_0[2]].localPosition.z = -50

					local var_57_1 = cloneTplTo(self.matchEffect, self.tilesRoot)

					var_57_1.localPosition = self.tileTfs[arg_57_0[1]][arg_57_0[2]].localPosition

					self:managedTween(LeanTween.value, function()
						Destroy(var_57_0)
						Destroy(var_57_1)

						return
					end, go(self.tileTfs[arg_57_0[1]][arg_57_0[2]]), 1, 0, var_0_10):setOnUpdate(System.Action_float(function(arg_59_0)
						setImageAlpha(var_57_0, arg_59_0)
						setLocalScale(var_57_0, Vector3.one * arg_59_0 * 2.7)

						return
					end))
				end

				self.tileTfs[arg_57_0[1]][arg_57_0[2]] = nil

				return
			end)

			var_56_3 = var_56_3 / #iter_56_1

			local var_56_4 = rtf(cloneTplTo(self.floatText, self.tilesRoot))

			var_56_4.anchoredPosition = var_56_3

			self:formatScore(var_56_4, var_56_2)
			self:managedTween(LeanTween.moveY, function()
				Destroy(var_56_4)

				return
			end, var_56_4, var_56_3.y + var_0_12, var_0_11)
		end

		self:managedTween(LeanTween.delayedCall, function()
			if not self.inGame then
				return
			end

			local var_61_0 = 0

			for iter_61_0 = 1, var_0_1 do
				for iter_61_1 = 1, var_0_2 do
					if self.tileIndicies[iter_61_0][iter_61_1] then
						local var_61_1 = iter_61_0

						for iter_61_2 = iter_61_0, 1, -1 do
							if self.tileIndicies[iter_61_2 - 1][iter_61_1] or iter_61_2 == 1 then
								var_61_1 = iter_61_2

								break
							end
						end

						if var_61_1 ~= iter_61_0 then
							var_61_0 = math.max(iter_61_0 - var_61_1, var_61_0)

							self:moveTile(self.tileTfs[iter_61_0][iter_61_1], {
								i = var_61_1,
								j = iter_61_1
							}, self.dropTime(iter_61_0 - var_61_1))

							self.tileTfs[var_61_1][iter_61_1] = self.tileTfs[iter_61_0][iter_61_1]
							self.tileIndicies[var_61_1][iter_61_1] = self.tileIndicies[iter_61_0][iter_61_1]
							self.tileTfs[iter_61_0][iter_61_1] = nil
							self.tileIndicies[iter_61_0][iter_61_1] = nil
						end
					end
				end
			end

			self:fillTileIndicies()

			if self.combo > 1 and next((self:tryMatch())) == nil then
				local var_61_2
				local var_61_3 = Vector3.New(0, 0, -50)

				if self.combo == 2 then
					var_61_2 = cloneTplTo(self.goodEffect, self.tilesRoot)

					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_25)
				elseif self.combo == 3 then
					var_61_2 = cloneTplTo(self.greatEffect, self.tilesRoot)

					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_25)
				else
					var_61_2 = cloneTplTo(self.perfectEffect, self.tilesRoot)

					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_26)
				end

				var_61_2.localPosition = var_61_3

				self:managedTween(LeanTween.delayedCall, function()
					Destroy(var_61_2)

					return
				end, var_0_14, nil)
			end

			self:managedTween(LeanTween.delayedCall, function()
				if not self.inGame then
					return
				end

				self:update()

				return
			end, math.max(var_0_14, self.dropTime((math.max(self:fillTiles(), var_61_0)))), nil)

			return
		end, var_0_10, nil)
	end

	if self.inGame then
		self.hintTimer:Reset(self.hintFunc, var_0_21)
		self.hintTimer:Start()
	end

	self.updating = not var_56_0

	return
end

function Match3GameView:tryMatch()
	local var_64_0 = {}

	for iter_64_0 = 1, var_0_1 do
		var_64_0[iter_64_0] = {}
	end

	return self:bfs(var_64_0)
end

function Match3GameView:bfs(arg_65_1)
	local var_65_0 = {}

	for iter_65_0 = 1, var_0_1 do
		for iter_65_1 = 1, var_0_2 do
			if not arg_65_1[iter_65_0][iter_65_1] then
				if not self:isConnected({
					i = iter_65_0,
					j = iter_65_1
				}) then
					arg_65_1[iter_65_0][iter_65_1] = true
				else
					local var_65_1 = {
						{
							iter_65_0,
							iter_65_1
						}
					}
					local var_65_2 = {
						{
							iter_65_0,
							iter_65_1
						}
					}

					while next(var_65_1) ~= nil do
						local var_65_3, var_65_4 = unpack(table.remove(var_65_1))

						arg_65_1[var_65_3][var_65_4] = true

						for iter_65_2, iter_65_3 in pairs(var_0_29) do
							if self.tileIndicies[var_65_3 + iter_65_3[1]][var_65_4 + iter_65_3[2]] and not arg_65_1[var_65_3 + iter_65_3[1]][var_65_4 + iter_65_3[2]] and self.tileIndicies[var_65_3 + iter_65_3[1]][var_65_4 + iter_65_3[2]] == self.tileIndicies[iter_65_0][iter_65_1] and self:isConnected({
								i = var_65_3 + iter_65_3[1],
								j = var_65_4 + iter_65_3[2]
							}) then
								table.insert(var_65_1, {
									var_65_3 + iter_65_3[1],
									var_65_4 + iter_65_3[2]
								})
								table.insert(var_65_2, {
									var_65_3 + iter_65_3[1],
									var_65_4 + iter_65_3[2]
								})
							end
						end
					end

					if #var_65_2 >= 3 then
						table.insert(var_65_0, var_65_2)
					end
				end
			end
		end
	end

	return var_65_0
end

return Match3GameView
