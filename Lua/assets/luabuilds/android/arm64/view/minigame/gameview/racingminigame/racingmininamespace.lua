local var_0_0 = {}

for iter_0_0, iter_0_1 in ipairs({
	function()
		local var_1_0 = class("Object")

		var_1_0.colliderSize = nil

		function var_1_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
			arg_2_0.rt = arg_2_1
			arg_2_0.pos = arg_2_2

			setAnchoredPosition(arg_2_0.rt, arg_2_0.pos)

			arg_2_0.controller = arg_2_3
			arg_2_0.isTriggered = false

			arg_2_0:Show("base")

			return
		end

		function var_1_0.UpdatePos(arg_3_0, arg_3_1)
			arg_3_0.pos = arg_3_0.pos + arg_3_1

			setAnchoredPosition(arg_3_0.rt, arg_3_0.pos)

			return
		end

		function var_1_0.Show(arg_4_0, arg_4_1)
			arg_4_0.state = arg_4_1

			setActive(arg_4_0.rt, true)

			return
		end

		function var_1_0.Trigger(arg_5_0, arg_5_1)
			arg_5_0.isTriggered = true

			arg_5_0:TriggerEffect(arg_5_1)

			return
		end

		function var_1_0.TriggerEffect(arg_6_0, arg_6_1)
			arg_6_1:TriggerEffect(arg_6_0)

			return
		end

		function var_1_0.Clear(arg_7_0)
			table.removebyvalue(arg_7_0.controller.queue, arg_7_0)
			Destroy(arg_7_0.rt)

			return
		end

		return var_1_0
	end,
	function()
		return (class("StartMark", var_0_0.Object))
	end,
	function()
		local var_9_0 = class("Mire", var_0_0.Object)

		var_9_0.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}

		function var_9_0.Trigger(arg_10_0, arg_10_1)
			arg_10_0.isTriggered = true

			if arg_10_1.invincibleTime then
				-- block empty
			else
				arg_10_0:TriggerEffect(arg_10_1)
			end

			return
		end

		return var_9_0
	end,
	function()
		local var_11_0 = class("SpeedBumps", var_0_0.Object)

		var_11_0.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}

		function var_11_0.Trigger(arg_12_0, arg_12_1)
			arg_12_0.isTriggered = true

			if arg_12_1.invincibleTime then
				-- block empty
			else
				arg_12_0:TriggerEffect(arg_12_1)
			end

			return
		end

		return var_11_0
	end,
	function()
		local var_13_0 = class("Obstacle", var_0_0.Object)

		var_13_0.actionDic = {}

		function var_13_0.Ctor(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
			arg_14_0.rt = arg_14_1
			arg_14_0.pos = arg_14_2

			setAnchoredPosition(arg_14_0.rt, arg_14_0.pos)

			arg_14_0.controller = arg_14_3
			arg_14_0.isTriggered = false
			arg_14_0.comSpineAnim = arg_14_1:Find("GameObject"):GetComponent("SpineAnimUI")

			arg_14_0.comSpineAnim:SetActionCallBack(function(arg_15_0)
				if arg_15_0 == "finish" then
					arg_14_0:ActionCallback()
				end

				return
			end)
			arg_14_0:Show("base")

			return
		end

		function var_13_0.ActionCallback(arg_16_0)
			switch(arg_16_0.state, {
				base = function()
					return
				end,
				trigger = function()
					arg_16_0:Clear()

					return
				end,
				broken = function()
					arg_16_0:Clear()

					return
				end
			})

			return
		end

		function var_13_0.Show(arg_20_0, ...)
			var_13_0.super.Show(arg_20_0, ...)

			arg_20_0.action = arg_20_0.actionDic[arg_20_0.state]

			arg_20_0.comSpineAnim:SetAction(arg_20_0.action, 0)

			return
		end

		function var_13_0.Trigger(arg_21_0, arg_21_1)
			arg_21_0.isTriggered = true

			if arg_21_1.invincibleTime then
				arg_21_0:Show("broken")
				pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-crash")
			else
				arg_21_0:Show("trigger")
				arg_21_0:TriggerEffect(arg_21_1)
			end

			return
		end

		return var_13_0
	end,
	function()
		local var_22_0 = class("TrafficCone", var_0_0.Obstacle)

		var_22_0.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}
		var_22_0.actionDic = {
			broken = "roadblocks_smash1",
			trigger = "roadblocks_vanish1",
			base = "roadblocks_normal1"
		}

		return var_22_0
	end,
	function()
		local var_23_0 = class("Roadblock", var_0_0.Obstacle)

		var_23_0.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}
		var_23_0.actionDic = {
			broken = "roadblocks_smash2",
			trigger = "roadblocks_vanish2",
			base = "roadblocks_normal2"
		}

		return var_23_0
	end,
	function()
		local var_24_0 = class("Bomb", var_0_0.Obstacle)

		var_24_0.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}
		var_24_0.actionDic = {
			broken = "bombsmash",
			trigger = "bomb",
			base = "bomb_normal"
		}

		function var_24_0.Trigger(arg_25_0, arg_25_1)
			arg_25_0.isTriggered = true

			if arg_25_1.invincibleTime then
				arg_25_0:Show("broken")
			else
				arg_25_0:Show("trigger")

				arg_25_0.rt:Find("GameObject"):GetComponent("SkeletonGraphic").color = Color.New(1, 1, 1, 0)

				setActive(arg_25_0.rt:Find("GameObject/saiche_zhadan"), true)
				arg_25_0:TriggerEffect(arg_25_1)
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/baozha1")

			return
		end

		return var_24_0
	end,
	function()
		local var_26_0 = class("Item", var_0_0.Object)

		var_26_0.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}

		function var_26_0.Trigger(arg_27_0, arg_27_1)
			arg_27_0.isTriggered = true

			arg_27_0:TriggerEffect(arg_27_1)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/mini_perfect")
			arg_27_0:Clear()

			return
		end

		return var_26_0
	end,
	function()
		return (class("MoreTime", var_0_0.Item))
	end,
	function()
		return (class("Invincibility", var_0_0.Item))
	end,
	function()
		local var_30_0 = class("Motorcycle", var_0_0.Object)

		var_30_0.colliderSize = {
			{
				-100,
				100
			},
			{
				-114,
				114
			}
		}

		function var_30_0.Ctor(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
			arg_31_0.rt = arg_31_1
			arg_31_0.pos = arg_31_2

			setAnchoredPosition(arg_31_0.rt, arg_31_0.pos)

			arg_31_0.controller = arg_31_3
			arg_31_0.isTriggered = false
			arg_31_0.comSpineAnim = arg_31_1:Find("GameObject"):GetComponent(typeof(SpineAnimUI))

			arg_31_0.comSpineAnim:SetActionCallBack(function(arg_32_0)
				if arg_32_0 == "finish" then
					arg_31_0:ActionCallback()
				end

				return
			end)

			arg_31_0.effectList = {}

			for iter_31_0, iter_31_1 in ipairs({
				"saiche_sudu_01",
				"saiche_sudu_02",
				"saiche_sudu_03",
				"saiche_sudu_04"
			}) do
				table.insert(arg_31_0.effectList, arg_31_0.rt:Find("GameObject/" .. iter_31_1))
			end

			arg_31_0:Show("base")

			return
		end

		function var_30_0.UpdatePos(arg_33_0, arg_33_1, arg_33_2)
			arg_33_0.pos = arg_33_0.pos + arg_33_1
			arg_33_0.pos.y = math.clamp(arg_33_0.pos.y, -arg_33_2, arg_33_2)

			setAnchoredPosition(arg_33_0.rt, arg_33_0.pos)

			return
		end

		function var_30_0.ActionCallback(arg_34_0)
			switch(arg_34_0.action, {
				ride = function()
					return
				end,
				accel = function()
					arg_34_0.action = "ride"

					arg_34_0.comSpineAnim:SetAction(arg_34_0.action, 0)

					return
				end,
				fall = function()
					arg_34_0.isBlock = false

					arg_34_0:Show("base")

					return
				end,
				yunxuan = function()
					arg_34_0.isVertigo = false

					setActive(arg_34_0.rt:Find("GameObject/saiche_xuanyun"), false)
					setActive(arg_34_0.rt:Find("GameObject/saiche_jiansu"), false)
					arg_34_0:Show("accel")

					return
				end
			})

			return
		end

		function var_30_0.Show(arg_39_0, ...)
			var_30_0.super.Show(arg_39_0, ...)
			switch(arg_39_0.state, {
				base = function()
					arg_39_0.action = "stop"

					return
				end,
				accel = function()
					if not arg_39_0.afterFirstAccel then
						arg_39_0.afterFirstAccel = true
						arg_39_0.action = "accel"
					else
						arg_39_0.action = "ride"
					end

					return
				end,
				fall = function()
					arg_39_0.action = "fall"
					arg_39_0.isBlock = true

					return
				end,
				yunxuan = function()
					arg_39_0.action = "yunxuan"
					arg_39_0.isVertigo = true

					setActive(arg_39_0.rt:Find("GameObject/saiche_xuanyun"), true)
					setActive(arg_39_0.rt:Find("GameObject/saiche_jiansu"), true)
					pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-yunxuan")

					return
				end
			})
			arg_39_0.comSpineAnim:SetAction(arg_39_0.action, 0)

			return
		end

		function var_30_0.TriggerEffect(arg_44_0, arg_44_1)
			switch(arg_44_1.__cname, {
				MoreTime = function()
					arg_44_0.controller:AddTime(RacingMiniGameConfig.ITEM_ADD_TIME)

					return
				end,
				Invincibility = function()
					arg_44_0.invincibleTime = RacingMiniGameConfig.INVINCIBLE_TIME

					setActive(arg_44_0.rt:Find("invincibility"), true)

					return
				end,
				TrafficCone = function()
					arg_44_0.controller:SetEnginePower(0)
					arg_44_0:Show("fall")
					pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-fall")

					return
				end,
				Roadblock = function()
					arg_44_0.controller:SetEnginePower(0)
					arg_44_0:Show("fall")
					pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-fall")

					return
				end,
				Bomb = function()
					arg_44_0.controller:SetEnginePower(0)
					arg_44_0:Show("fall")

					return
				end,
				Mire = function()
					arg_44_0.controller:SetEnginePower(math.min(arg_44_0.controller.enginePower, RacingMiniGameConfig.OBSTACLE_POWER_BLOCK))
					arg_44_0:Show("yunxuan")

					return
				end,
				SpeedBumps = function()
					arg_44_0.controller:SetEnginePower(math.min(arg_44_0.controller.enginePower, RacingMiniGameConfig.OBSTACLE_POWER_BLOCK))
					arg_44_0:Show("yunxuan")

					return
				end
			})

			return
		end

		function var_30_0.UpdateInvincibility(arg_52_0, arg_52_1)
			assert(arg_52_0.invincibleTime)

			arg_52_0.invincibleTime = arg_52_0.invincibleTime - arg_52_1

			if arg_52_0.invincibleTime <= 0 then
				setActive(arg_52_0.rt:Find("invincibility"), false)

				arg_52_0.invincibleTime = nil
			else
				local var_52_0 = arg_52_0.invincibleTime < 2

				setActive(arg_52_0.rt:Find("invincibility/saiche_wudihudun_xiaoshi"), arg_52_0.invincibleTime < 2)
				setActive(arg_52_0.rt:Find("invincibility/saiche_wudihudun"), not var_52_0)
			end

			return
		end

		return var_30_0
	end
}) do
	local var_0_1 = iter_0_1()

	;({})[var_0_1.__cname] = var_0_1
end

return {}
