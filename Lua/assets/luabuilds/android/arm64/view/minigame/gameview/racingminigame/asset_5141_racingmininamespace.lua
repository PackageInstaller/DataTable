local var_0_0 = {}

for iter_0_0, iter_0_1 in ipairs({
	function()
		local Object = class("Object")

		Object.colliderSize = nil

		function Object:Ctor(arg_2_1, arg_2_2, arg_2_3)
			self.rt = arg_2_1
			self.pos = arg_2_2

			setAnchoredPosition(self.rt, self.pos)

			self.controller = arg_2_3
			self.isTriggered = false

			self:Show("base")

			return
		end

		function Object:UpdatePos(arg_3_1)
			self.pos = self.pos + arg_3_1

			setAnchoredPosition(self.rt, self.pos)

			return
		end

		function Object:Show(arg_4_1)
			self.state = arg_4_1

			setActive(self.rt, true)

			return
		end

		function Object:Trigger(arg_5_1)
			self.isTriggered = true

			self:TriggerEffect(arg_5_1)

			return
		end

		function Object:TriggerEffect(arg_6_1)
			arg_6_1:TriggerEffect(self)

			return
		end

		function Object:Clear()
			table.removebyvalue(self.controller.queue, self)
			Destroy(self.rt)

			return
		end

		return Object
	end,
	function()
		return (class("StartMark", var_0_0.Object))
	end,
	function()
		local Mire = class("Mire", var_0_0.Object)

		Mire.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}

		function Mire:Trigger(arg_10_1)
			self.isTriggered = true

			if arg_10_1.invincibleTime then
				-- block empty
			else
				self:TriggerEffect(arg_10_1)
			end

			return
		end

		return Mire
	end,
	function()
		local SpeedBumps = class("SpeedBumps", var_0_0.Object)

		SpeedBumps.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}

		function SpeedBumps:Trigger(arg_12_1)
			self.isTriggered = true

			if arg_12_1.invincibleTime then
				-- block empty
			else
				self:TriggerEffect(arg_12_1)
			end

			return
		end

		return SpeedBumps
	end,
	function()
		local Obstacle = class("Obstacle", var_0_0.Object)

		Obstacle.actionDic = {}

		function Obstacle:Ctor(arg_14_1, arg_14_2, arg_14_3)
			self.rt = arg_14_1
			self.pos = arg_14_2

			setAnchoredPosition(self.rt, self.pos)

			self.controller = arg_14_3
			self.isTriggered = false
			self.comSpineAnim = arg_14_1:Find("GameObject"):GetComponent("SpineAnimUI")

			self.comSpineAnim:SetActionCallBack(function(arg_15_0)
				if arg_15_0 == "finish" then
					self:ActionCallback()
				end

				return
			end)
			self:Show("base")

			return
		end

		function Obstacle:ActionCallback()
			switch(self.state, {
				base = function()
					return
				end,
				trigger = function()
					self:Clear()

					return
				end,
				broken = function()
					self:Clear()

					return
				end
			})

			return
		end

		function Obstacle:Show(...)
			Obstacle.super.Show(self, ...)

			self.action = self.actionDic[self.state]

			self.comSpineAnim:SetAction(self.action, 0)

			return
		end

		function Obstacle:Trigger(arg_21_1)
			self.isTriggered = true

			if arg_21_1.invincibleTime then
				self:Show("broken")
				pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-crash")
			else
				self:Show("trigger")
				self:TriggerEffect(arg_21_1)
			end

			return
		end

		return Obstacle
	end,
	function()
		local TrafficCone = class("TrafficCone", var_0_0.Obstacle)

		TrafficCone.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}
		TrafficCone.actionDic = {
			broken = "roadblocks_smash1",
			trigger = "roadblocks_vanish1",
			base = "roadblocks_normal1"
		}

		return TrafficCone
	end,
	function()
		local Roadblock = class("Roadblock", var_0_0.Obstacle)

		Roadblock.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}
		Roadblock.actionDic = {
			broken = "roadblocks_smash2",
			trigger = "roadblocks_vanish2",
			base = "roadblocks_normal2"
		}

		return Roadblock
	end,
	function()
		local Bomb = class("Bomb", var_0_0.Obstacle)

		Bomb.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}
		Bomb.actionDic = {
			broken = "bombsmash",
			trigger = "bomb",
			base = "bomb_normal"
		}

		function Bomb:Trigger(arg_25_1)
			self.isTriggered = true

			if arg_25_1.invincibleTime then
				self:Show("broken")
			else
				self:Show("trigger")

				self.rt:Find("GameObject"):GetComponent("SkeletonGraphic").color = Color.New(1, 1, 1, 0)

				setActive(self.rt:Find("GameObject/saiche_zhadan"), true)
				self:TriggerEffect(arg_25_1)
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/baozha1")

			return
		end

		return Bomb
	end,
	function()
		local Item = class("Item", var_0_0.Object)

		Item.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}

		function Item:Trigger(arg_27_1)
			self.isTriggered = true

			self:TriggerEffect(arg_27_1)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/mini_perfect")
			self:Clear()

			return
		end

		return Item
	end,
	function()
		return (class("MoreTime", var_0_0.Item))
	end,
	function()
		return (class("Invincibility", var_0_0.Item))
	end,
	function()
		local Motorcycle = class("Motorcycle", var_0_0.Object)

		Motorcycle.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}

		function Motorcycle:Ctor(arg_31_1, arg_31_2, arg_31_3)
			self.rt = arg_31_1
			self.pos = arg_31_2

			setAnchoredPosition(self.rt, self.pos)

			self.controller = arg_31_3
			self.isTriggered = false
			self.comSpineAnim = arg_31_1:Find("GameObject"):GetComponent(typeof(SpineAnimUI))

			self.comSpineAnim:SetActionCallBack(function(arg_32_0)
				if arg_32_0 == "finish" then
					self:ActionCallback()
				end

				return
			end)

			self.effectList = {}

			for iter_31_0, iter_31_1 in ipairs({
				"saiche_sudu_01",
				"saiche_sudu_02",
				"saiche_sudu_03",
				"saiche_sudu_04"
			}) do
				table.insert(self.effectList, self.rt:Find("GameObject/" .. iter_31_1))
			end

			self:Show("base")

			return
		end

		function Motorcycle:UpdatePos(arg_33_1, arg_33_2)
			self.pos = self.pos + arg_33_1
			self.pos.y = math.clamp(self.pos.y, -arg_33_2, arg_33_2)

			setAnchoredPosition(self.rt, self.pos)

			return
		end

		function Motorcycle:ActionCallback()
			switch(self.action, {
				ride = function()
					return
				end,
				accel = function()
					self.action = "ride"

					self.comSpineAnim:SetAction(self.action, 0)

					return
				end,
				fall = function()
					self.isBlock = false

					self:Show("base")

					return
				end,
				yunxuan = function()
					self.isVertigo = false

					setActive(self.rt:Find("GameObject/saiche_xuanyun"), false)
					setActive(self.rt:Find("GameObject/saiche_jiansu"), false)
					self:Show("accel")

					return
				end
			})

			return
		end

		function Motorcycle:Show(...)
			Motorcycle.super.Show(self, ...)
			switch(self.state, {
				base = function()
					self.action = "stop"

					return
				end,
				accel = function()
					if not self.afterFirstAccel then
						self.afterFirstAccel = true
						self.action = "accel"
					else
						self.action = "ride"
					end

					return
				end,
				fall = function()
					self.action = "fall"
					self.isBlock = true

					return
				end,
				yunxuan = function()
					self.action = "yunxuan"
					self.isVertigo = true

					setActive(self.rt:Find("GameObject/saiche_xuanyun"), true)
					setActive(self.rt:Find("GameObject/saiche_jiansu"), true)
					pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-yunxuan")

					return
				end
			})
			self.comSpineAnim:SetAction(self.action, 0)

			return
		end

		function Motorcycle:TriggerEffect(arg_44_1)
			switch(arg_44_1.__cname, {
				MoreTime = function()
					self.controller:AddTime(RacingMiniGameConfig.ITEM_ADD_TIME)

					return
				end,
				Invincibility = function()
					self.invincibleTime = RacingMiniGameConfig.INVINCIBLE_TIME

					setActive(self.rt:Find("invincibility"), true)

					return
				end,
				TrafficCone = function()
					self.controller:SetEnginePower(0)
					self:Show("fall")
					pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-fall")

					return
				end,
				Roadblock = function()
					self.controller:SetEnginePower(0)
					self:Show("fall")
					pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-fall")

					return
				end,
				Bomb = function()
					self.controller:SetEnginePower(0)
					self:Show("fall")

					return
				end,
				Mire = function()
					self.controller:SetEnginePower(math.min(self.controller.enginePower, RacingMiniGameConfig.OBSTACLE_POWER_BLOCK))
					self:Show("yunxuan")

					return
				end,
				SpeedBumps = function()
					self.controller:SetEnginePower(math.min(self.controller.enginePower, RacingMiniGameConfig.OBSTACLE_POWER_BLOCK))
					self:Show("yunxuan")

					return
				end
			})

			return
		end

		function Motorcycle:UpdateInvincibility(arg_52_1)
			assert(self.invincibleTime)

			self.invincibleTime = self.invincibleTime - arg_52_1

			if self.invincibleTime <= 0 then
				setActive(self.rt:Find("invincibility"), false)

				self.invincibleTime = nil
			else
				local var_52_0 = self.invincibleTime < 2

				setActive(self.rt:Find("invincibility/saiche_wudihudun_xiaoshi"), self.invincibleTime < 2)
				setActive(self.rt:Find("invincibility/saiche_wudihudun"), not var_52_0)
			end

			return
		end

		return Motorcycle
	end
}) do
	local var_0_1 = iter_0_1()

	var_0_0[var_0_1.__cname] = var_0_1
end

return var_0_0
