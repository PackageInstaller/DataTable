local BeatMonsterController = class("BeatMonsterController")

function BeatMonsterController:Ctor()
	self.mediator = BeatMonsterMeidator.New(self)
	self.model = BeatMonsterModel.New(self)

	return
end

function BeatMonsterController:SetUp(arg_2_1, arg_2_2)
	seriesAsync({
		function(arg_3_0)
			self.OnDisenabelUIEvent = arg_2_2

			self:InitStage(arg_2_1)

			local var_3_0 = self.model:GetPlayableStory()

			if not var_3_0 then
				arg_3_0()

				return
			end

			self.mediator:PlayStory(var_3_0, arg_3_0)

			return
		end,
		function(arg_4_0)
			if arg_2_1.hp > 0 then
				self.mediator:DoCurtainUp(arg_4_0)
			else
				arg_4_0()
			end

			return
		end,
		function(arg_5_0)
			self.mediator:OnInited()

			return
		end
	})

	return
end

function BeatMonsterController:NetData(arg_6_1)
	self.model:UpdateData(arg_6_1)
	self.mediator:OnMonsterHpUpdate(self.model.mosterNian.hp)
	self.mediator:OnAttackCntUpdate(self.model.attackCnt, self.isFake or self.model.mosterNian.hp <= 0)

	return
end

function BeatMonsterController:InitStage(arg_7_1)
	self.model:AddMonsterNian(arg_7_1.hp, arg_7_1.maxHp)
	self.model:AddFuShun()
	self.mediator:OnAddMonsterNian(self.model.mosterNian.hp, self.model.mosterNian.maxHp)
	self.mediator:OnAddFuShun(self.model.mosterNian.hp)
	self.model:SetAttackCnt(arg_7_1.leftCount)
	self.mediator:OnAttackCntUpdate(self.model.attackCnt, self.isFake or self.model.mosterNian.hp <= 0)
	self.model:SetStorys(arg_7_1.storys)

	return
end

function BeatMonsterController:Input(arg_8_1)
	if self.isOnAction then
		return
	end

	self:RemoveInputTimer()
	self:UpdateActionStr(arg_8_1)

	local var_8_0 = self.model:IsMatchAction()
	local var_8_1 = var_8_0 and 0.5 or BeatMonsterNianConst.INPUT_TIME

	if var_8_0 then
		self.OnDisenabelUIEvent(true)

		self.isOnAction = true
	end

	self.inputTimer = Timer.New(function()
		self:UpdateActionStr("")

		if var_8_0 then
			self:StartAction(self.model:GetMatchAction(), (self.model:GetMonsterAction()))
		end

		return
	end, var_8_1, 1)

	self.inputTimer:Start()

	return
end

function BeatMonsterController:StartAction(arg_10_1, arg_10_2)
	self:RemoveAnimationTimer()

	local var_10_0

	seriesAsync({
		function(arg_11_0)
			self:SendRequestToServer(function(arg_12_0)
				var_10_0 = arg_12_0

				arg_11_0()

				return
			end)

			return
		end,
		function(arg_13_0)
			self.mediator:OnChangeFuShunAction(arg_10_1)
			self.mediator:OnChangeNianAction(arg_10_2)

			self.animationTimer = Timer.New(arg_13_0, 2, 1)

			self.animationTimer:Start()

			return
		end,
		function(arg_14_0)
			self.mediator:OnUIHpUpdate(self.model.mosterNian.hp, self.model.mosterNian.maxHp, arg_14_0)

			return
		end,
		function(arg_15_0)
			local var_15_0 = self.model:GetPlayableStory()

			if not var_15_0 then
				arg_15_0()

				return
			end

			self.mediator:PlayStory(var_15_0, arg_15_0)

			return
		end,
		function(arg_16_0)
			if not var_10_0 or #var_10_0 == 0 then
				arg_16_0()

				return
			end

			self.mediator:DisplayAwards(var_10_0, arg_16_0)

			return
		end,
		function(arg_17_0)
			self.isOnAction = false

			self.OnDisenabelUIEvent(false)

			return
		end
	})

	return
end

function BeatMonsterController:SendRequestToServer(arg_18_1)
	if self.isFake then
		self:NetData({
			hp = self.model:RandomDamage(),
			maxHp = self.model:GetMonsterMaxHp(),
			leftCount = self.model:GetAttackCount() - 1,
			storys = {}
		})
		arg_18_1()
	else
		pg.m02:sendNotification(GAME.ACT_BEAT_MONSTER_NIAN, {
			cmd = 1,
			activity_id = ActivityConst.BEAT_MONSTER_NIAN_2020,
			callback = arg_18_1
		})
	end

	return
end

function BeatMonsterController:UpdateActionStr(arg_19_1)
	self.model:UpdateActionStr(arg_19_1)
	self.mediator:OnInputChange((self.model:GetActionStr()))

	return
end

function BeatMonsterController:RemoveInputTimer()
	if self.inputTimer then
		self.inputTimer:Stop()

		self.inputTimer = nil
	end

	return
end

function BeatMonsterController:RemoveAnimationTimer()
	if self.animationTimer then
		self.animationTimer:Stop()

		self.animationTimer = nil
	end

	return
end

function BeatMonsterController:ReStartGame()
	self.isFake = true

	self:NetData({
		leftCount = 10,
		hp = 10,
		maxHp = 10,
		storys = {}
	})
	self.mediator:OnUIHpUpdate(10, 10)

	return
end

function BeatMonsterController:Dispose()
	self:RemoveAnimationTimer()
	self:RemoveInputTimer()
	self.mediator:Dispose()
	self.model:Dispose()

	self.OnDisenabelUIEvent = nil

	return
end

return BeatMonsterController
