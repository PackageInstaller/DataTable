local TowerClimbingMap = class("TowerClimbingMap")

function TowerClimbingMap:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1.gameView
	self.view = arg_1_1
	self.map = arg_1_2

	return
end

function TowerClimbingMap:Init(arg_2_1)
	self.blocks = {}
	self.groundContainer = self._tf:Find("game")
	self.blockPlayCon = self.groundContainer:Find("block_play_con")

	setAnchoredPosition(self.blockPlayCon, {
		x = 0,
		y = 0
	})

	self.blockContainer = self.blockPlayCon:Find("blocks")
	self.hearts = {
		self._tf:Find("prints/score/hearts/1"),
		self._tf:Find("prints/score/hearts/2"),
		self._tf:Find("prints/score/hearts/3")
	}
	self.score = self._tf:Find("prints/score/Text"):GetComponent(typeof(Text))
	self.heartProgress = self._tf:Find("prints/score/progress")
	self.heartProgressTxt = self._tf:Find("prints/score/progress/Text"):GetComponent(typeof(Text))
	self.bg = TowerClimbBgMgr.New(self._tf:Find("bgs"))

	self.bg:Init(self.map.id, arg_2_1)

	self.npc = self._tf:Find("prints/npc")

	self:LoadEffect(self.map.id)

	self.tip = self._tf:Find("prints/tip")

	setActive(self.tip, false)

	self.timers = {}

	return
end

function TowerClimbingMap:LoadEffect(arg_3_1)
	if TowerClimbingGameSettings.MAPID2EFFECT[arg_3_1] then
		for iter_3_0, iter_3_1 in ipairs(TowerClimbingGameSettings.MAPID2EFFECT[arg_3_1]) do
			self:LoadSingleEffect(iter_3_1[1], iter_3_1[2])
		end
	end

	return
end

function TowerClimbingMap:LoadSingleEffect(arg_4_1, arg_4_2, arg_4_3)
	PoolMgr.GetInstance():GetUI(arg_4_1, true, function(arg_5_0)
		if not self.groundContainer then
			PoolMgr.GetInstance():ReturnUI(arg_4_1, arg_5_0)
		else
			arg_5_0.name = arg_4_1

			SetParent(arg_5_0, self.groundContainer)

			arg_5_0.transform.anchoredPosition3D = Vector3(arg_4_2[1], arg_4_2[2], -200)

			setActive(arg_5_0, true)

			if arg_4_3 then
				arg_4_3(arg_5_0)
			end
		end

		return
	end)

	return
end

function TowerClimbingMap:ReturnEffect(arg_6_1)
	if TowerClimbingGameSettings.MAPID2EFFECT[arg_6_1] then
		for iter_6_0, iter_6_1 in ipairs(TowerClimbingGameSettings.MAPID2EFFECT[arg_6_1]) do
			local var_6_0 = self.groundContainer:Find(iter_6_1[1])

			if var_6_0 then
				PoolMgr.GetInstance():ReturnUI(iter_6_1[1], var_6_0.gameObject)
			end
		end
	end

	return
end

function TowerClimbingMap:OnReachAwardScore()
	if LOCK_TOWERCLIMBING_AWARD then
		return
	end

	if self.tipTimer then
		self.tipTimer:Stop()

		self.tipTimer = nil
	end

	setActive(self.tip, true)

	self.tipTimer = Timer.New(function()
		setActive(self.tip, false)
		self.tipTimer:Stop()

		self.tipTimer = nil

		return
	end, 3, 1)

	self.tipTimer:Start()

	local var_7_0 = self.groundContainer:InverseTransformPoint(self.npc.position)
	local var_7_1 = self.groundContainer:InverseTransformPoint(self.player._tf.position)

	local function var_7_2()
		local function var_9_0()
			setActive(self.awardEffect1, true)

			self.awardTimer = Timer.New(function()
				setActive(self.awardEffect1, false)

				return
			end, 2, 1)

			self.awardTimer:Start()

			return
		end

		if not self.awardEffect1 then
			self:LoadSingleEffect(TowerClimbingGameSettings.AWARDEFFECT1, {
				var_7_0.x,
				var_7_0.y
			}, function(arg_12_0)
				self.awardEffect1 = arg_12_0

				var_9_0()

				return
			end)
		else
			var_9_0()
		end

		return
	end

	local function var_7_3()
		local var_13_0 = Vector3(var_7_0.x, var_7_1.y + 200, -200)
		local var_13_1 = {}

		table.insert(var_13_1, Vector3(var_7_1.x, var_7_1.y, -200))
		table.insert(var_13_1, var_13_0)
		table.insert(var_13_1, var_13_0)
		table.insert(var_13_1, Vector3(var_7_0.x, var_7_0.y, -200))

		self.awardEffect.transform.localPosition = Vector3(var_7_1.x, var_7_1.y, -200)

		setActive(self.awardEffect, true)
		LeanTween.moveLocal(self.awardEffect, var_13_1, 1):setOnComplete(System.Action(function()
			setActive(self.awardEffect, false)
			var_7_2()

			return
		end))

		return
	end

	if not self.awardEffect then
		self:LoadSingleEffect(TowerClimbingGameSettings.AWARDEFFECT, {
			var_7_1.x,
			var_7_1.y
		}, function(arg_15_0)
			self.awardEffect = arg_15_0

			var_7_3()

			return
		end)
	else
		var_7_3()
	end

	return
end

function TowerClimbingMap:GetFirstBlock()
	return self.blocks[1]
end

function TowerClimbingMap:GetHitBlock(arg_17_1)
	local var_17_0 = _.detect(self.blocks, function(arg_18_0)
		return arg_18_0.go == arg_17_1
	end)

	if var_17_0 then
		return var_17_0
	end

	return
end

function TowerClimbingMap:OnCreateGround(arg_19_1, arg_19_2)
	self.ground = arg_19_1

	TowerClimbingResMgr.GetGround(arg_19_1.name, function(arg_20_0)
		self.groundGo = arg_20_0
		arg_20_0.name = "manjuu"

		SetParent(arg_20_0.transform, self.groundContainer)

		arg_20_0.transform.anchoredPosition = arg_19_1.position

		setActive(arg_20_0, true)
		arg_20_0:GetComponent("SpineAnimUI"):SetAction("normal", 0)
		setText(self.groundGo.transform:Find("Text"), "")
		arg_19_2()

		return
	end)

	return
end

function TowerClimbingMap:TranslateBlockPosition(arg_21_1)
	return self.blockContainer:InverseTransformVector(self.groundContainer:TransformVector(arg_21_1))
end

function TowerClimbingMap:OnCreateBlock(arg_22_1, arg_22_2)
	TowerClimbingResMgr.GetBlock(arg_22_1.type, function(arg_23_0)
		SetParent(arg_23_0, self.blockContainer)

		arg_23_0.transform.anchoredPosition = self:TranslateBlockPosition(arg_22_1.position)
		arg_23_0.name = TowerClimbingGameSettings.BLOCK_NAME

		setActive(arg_23_0, true)
		table.insert(self.blocks, {
			go = arg_23_0,
			block = arg_22_1,
			colliders = arg_23_0:GetComponentsInChildren(typeof(UnityEngine.Collider2D)):ToTable()
		})
		self:OnActiveBlock(arg_22_1)

		local var_23_0 = arg_23_0.transform:Find("firer")

		if var_23_0 then
			local var_23_1 = var_23_0:GetComponent(typeof(Animation))

			self.timers[arg_22_1.level] = Timer.New(function()
				var_23_1:Play("action")

				return
			end, math.random(TowerClimbingGameSettings.FIRE_TIME[1], TowerClimbingGameSettings.FIRE_TIME[2]), -1)

			self.timers[arg_22_1.level]:Start()
		end

		arg_22_2()

		return
	end)

	return
end

function TowerClimbingMap:OnActiveBlock(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(_.detect(self.blocks, function(arg_26_0)
		return arg_26_0.block.level == arg_25_1.level
	end).colliders) do
		iter_25_1.enabled = arg_25_1.isActive
	end

	return
end

function TowerClimbingMap:SinkHandler(arg_27_1, arg_27_2)
	LeanTween.value(self.blockPlayCon.gameObject, self.blockPlayCon.anchoredPosition.y, self.blockPlayCon.anchoredPosition.y - arg_27_1, 0.2):setOnUpdate(System.Action_float(function(arg_28_0)
		setAnchoredPosition(self.blockPlayCon, {
			y = arg_28_0
		})

		return
	end)):setEase(LeanTweenType.easeOutQuad):setOnComplete(System.Action(arg_27_2))

	return
end

function TowerClimbingMap:OnBlockDestory(arg_29_1)
	if self.timers[arg_29_1] then
		self.timers[arg_29_1]:Stop()

		self.timers[arg_29_1] = nil
	end

	local var_29_0 = _.detect(self.blocks, function(arg_30_0)
		return arg_30_0.block.level == arg_29_1
	end)

	TowerClimbingResMgr.ReturnBlock(var_29_0.block.type, var_29_0.go)

	return
end

function TowerClimbingMap:OnSink(arg_31_1, arg_31_2)
	self.bg:DoMove(arg_31_1, arg_31_2)
	arg_31_2()

	return
end

function TowerClimbingMap:OnPlayerLifeUpdate(arg_32_1)
	triggerToggle(self.hearts[3], arg_32_1 >= 3)
	triggerToggle(self.hearts[2], arg_32_1 >= 2)
	triggerToggle(self.hearts[1], arg_32_1 >= 1)

	self.heartProgressTxt.text = arg_32_1 .. "/" .. 3

	setFillAmount(self.heartProgress, arg_32_1 / 3)

	return
end

function TowerClimbingMap:OnScoreUpdate(arg_33_1)
	self.score.text = arg_33_1

	return
end

function TowerClimbingMap:OnCreatePlayer(arg_34_1, arg_34_2)
	self.player = TowerClimbingPlayer.New(self, arg_34_1)

	self.player:Init(arg_34_2)

	return
end

function TowerClimbingMap:OnEnableStab(arg_35_1, arg_35_2)
	local var_35_0 = _.detect(self.blocks, function(arg_36_0)
		return arg_36_0.block.level == arg_35_1.level
	end)

	assert(var_35_0)

	local var_35_1 = var_35_0.go:GetComponent(typeof(UnityEngine.Collider2D))

	for iter_35_0, iter_35_1 in ipairs(var_35_0.colliders) do
		if iter_35_1 ~= var_35_1 then
			iter_35_1.enabled = arg_35_2
		end
	end

	return
end

function TowerClimbingMap:OnEnableGround(arg_37_1)
	self.groundGo:GetComponent(typeof(UnityEngine.Collider2D)).enabled = arg_37_1

	return
end

function TowerClimbingMap:GetPlayer()
	return self.player
end

function TowerClimbingMap:SendEvent(arg_39_1, ...)
	self.view.controller[arg_39_1](self.view.controller, unpack({
		...
	}))

	return
end

function TowerClimbingMap:OnGroundRuning()
	self.groundGo:GetComponent("SpineAnimUI"):SetAction("up", 0)

	return
end

function TowerClimbingMap:OnGroundPositionChange(arg_41_1)
	setAnchoredPosition(self.groundGo.transform, arg_41_1)

	return
end

function TowerClimbingMap:OnGroundSleepTimeChange(arg_42_1)
	local var_42_0 = math.ceil(arg_42_1)

	if var_42_0 > 0 then
		setText(self.groundGo.transform:Find("Text"), var_42_0)
	else
		setText(self.groundGo.transform:Find("Text"), "")
	end

	return
end

function TowerClimbingMap:Dispose()
	if self.awardTimer then
		self.awardTimer:Stop()

		self.awardTimer = nil
	end

	self.bg:Clear()
	self:ReturnEffect(self.map.id)

	if self.awardEffect then
		PoolMgr.GetInstance():ReturnUI(self.awardEffect.name, self.awardEffect)

		self.awardEffect = nil
	end

	if self.awardEffect1 then
		PoolMgr.GetInstance():ReturnUI(self.awardEffect1.name, self.awardEffect1)

		self.awardEffect1 = nil
	end

	if self.tipTimer then
		self.tipTimer:Stop()
	end

	self.tipTimer = nil

	for iter_43_0, iter_43_1 in pairs(self.timers or {}) do
		iter_43_1:Stop()
	end

	self.timers = nil

	if self.player then
		self.player:Dispose()

		self.player = nil
	end

	if self.ground and not IsNil(self.groundGo) then
		TowerClimbingResMgr.ReturnGround(self.ground.name, self.groundGo)
	end

	if self.blocks then
		for iter_43_2, iter_43_3 in ipairs(self.blocks) do
			if not IsNil(iter_43_3.go) then
				TowerClimbingResMgr.ReturnBlock(iter_43_3.block.type, iter_43_3.go)
			end
		end

		self.blocks = nil
	end

	return
end

return TowerClimbingMap
