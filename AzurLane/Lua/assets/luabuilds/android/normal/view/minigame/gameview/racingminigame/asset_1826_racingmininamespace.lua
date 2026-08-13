local var_0_0 = {}
local var_0_1 = {
	function()
		class = var_1_10000

		local var_1_0 = var_1_10000("Object")

		var_1_0.colliderSize = nil

		function var_1_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
			arg_2_0.rt = arg_2_1
			arg_2_0.pos = arg_2_2
			setAnchoredPosition = var_2_10004

			var_2_10004(arg_2_0.rt, arg_2_0.pos)

			arg_2_0.controller = arg_2_3
			arg_2_0.isTriggered = false

			arg_2_0:Show("base")

			return
		end

		function var_1_0.UpdatePos(arg_3_0, arg_3_1)
			arg_3_0.pos = arg_3_0.pos + arg_3_1
			setAnchoredPosition = var_2

			var_2(arg_3_0.rt, arg_3_0.pos)

			return
		end

		function var_1_0.Show(arg_4_0, arg_4_1)
			arg_4_0.state = arg_4_1
			setActive = var_2_10002

			var_2_10002(arg_4_0.rt, true)

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
			table = var_2_10001

			var_2_10001.removebyvalue(arg_7_0.controller.queue, arg_7_0)

			Destroy = var_1

			var_1(arg_7_0.rt)

			return
		end

		return var_1_0
	end,
	function()
		class = var_1_10000

		return (var_1_10000("StartMark", var_0_0.Object))
	end,
	function()
		class = var_1_10000

		local var_9_0 = var_1_10000("Mire", var_0_0.Object)

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
		class = var_1_10000

		local var_11_0 = var_1_10000("SpeedBumps", var_0_0.Object)

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
		class = var_1_10000

		local var_13_0 = var_1_10000("Obstacle", var_0_0.Object)

		var_13_0.actionDic = {}

		function var_13_0.Ctor(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
			arg_14_0.rt = arg_14_1
			arg_14_0.pos = arg_14_2
			setAnchoredPosition = var_2_10004

			var_2_10004(arg_14_0.rt, arg_14_0.pos)

			arg_14_0.controller = arg_14_3
			arg_14_0.isTriggered = false

			local var_14_0 = arg_14_1:Find("GameObject")

			arg_14_0.comSpineAnim = var_4.GetComponent(var_14_0, "SpineAnimUI")

			local var_14_1 = arg_14_0.comSpineAnim

			var_4.SetActionCallBack(var_14_1, function(arg_15_0)
				if arg_15_0 == "finish" then
					local var_15_0 = arg_14_0

					var_1.ActionCallback(var_15_0)
				end

				return
			end)
			arg_14_0:Show("base")

			return
		end

		function var_13_0.ActionCallback(arg_16_0)
			switch = var_2_10001

			var_2_10001(arg_16_0.state, {
				base = function()
					return
				end,
				trigger = function()
					local var_18_0 = arg_16_0

					var_0.Clear(var_18_0)

					return
				end,
				broken = function()
					local var_19_0 = arg_16_0

					var_0.Clear(var_19_0)

					return
				end
			})

			return
		end

		function var_13_0.Show(arg_20_0, ...)
			var_13_0.super.Show(arg_20_0, ...)

			arg_20_0.action = arg_20_0.actionDic[arg_20_0.state]

			local var_20_0 = arg_20_0.comSpineAnim

			var_1.SetAction(var_20_0, arg_20_0.action, 0)

			return
		end

		function var_13_0.Trigger(arg_21_0, arg_21_1)
			arg_21_0.isTriggered = true

			if arg_21_1.invincibleTime then
				arg_21_0:Show("broken")

				pg = var_2

				local var_21_0 = var_2.CriMgr.GetInstance()

				var_2.PlaySoundEffect_V3(var_21_0, "ui-crash")
			else
				arg_21_0:Show("trigger")
				arg_21_0:TriggerEffect(arg_21_1)
			end

			return
		end

		return var_13_0
	end,
	function()
		class = var_1_10000

		local var_22_0 = var_1_10000("TrafficCone", var_0_0.Obstacle)

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
		class = var_1_10000

		local var_23_0 = var_1_10000("Roadblock", var_0_0.Obstacle)

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
		class = var_1_10000

		local var_24_0 = var_1_10000("Bomb", var_0_0.Obstacle)

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

			local var_25_2

			if arg_25_1.invincibleTime then
				arg_25_0:Show("broken")
			else
				arg_25_0:Show("trigger")

				local var_25_0 = arg_25_0.rt
				local var_25_1 = var_25_2.Find(var_25_0, "GameObject")

				var_25_2 = var_25_2.GetComponent(var_25_1, "SkeletonGraphic")
				Color = var_25_1
				var_25_2.color = var_25_1.New(1, 1, 1, 0)
				setActive = var_25_2

				local var_25_3 = arg_25_0.rt

				var_25_2(var_3.Find(var_25_3, "GameObject/saiche_zhadan"), true)
				arg_25_0:TriggerEffect(arg_25_1)
			end

			pg = var_25_2

			local var_25_4 = var_25_2.CriMgr.GetInstance()

			var_2.PlaySoundEffect_V3(var_25_4, "event:/ui/baozha1")

			return
		end

		return var_24_0
	end,
	function()
		class = var_1_10000

		local var_26_0 = var_1_10000("Item", var_0_0.Object)

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

			pg = var_2

			local var_27_0 = var_2.CriMgr.GetInstance()

			var_2.PlaySoundEffect_V3(var_27_0, "event:/ui/mini_perfect")
			arg_27_0:Clear()

			return
		end

		return var_26_0
	end,
	function()
		class = var_1_10000

		return (var_1_10000("MoreTime", var_0_0.Item))
	end,
	function()
		class = var_1_10000

		return (var_1_10000("Invincibility", var_0_0.Item))
	end,
	function()
		class = var_1_10000

		local var_30_0 = var_1_10000("Motorcycle", var_0_0.Object)

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
			setAnchoredPosition = var_2_10004

			var_2_10004(arg_31_0.rt, arg_31_0.pos)

			arg_31_0.controller = arg_31_3
			arg_31_0.isTriggered = false

			local var_31_0 = arg_31_1:Find("GameObject")
			local var_31_1 = var_4.GetComponent

			typeof = var_6
			SpineAnimUI = var_2_10007
			arg_31_0.comSpineAnim = var_31_1(var_31_0, var_6(var_2_10007))

			local var_31_2 = arg_31_0.comSpineAnim

			var_4.SetActionCallBack(var_31_2, function(arg_32_0)
				if arg_32_0 == "finish" then
					local var_32_0 = arg_31_0

					var_1.ActionCallback(var_32_0)
				end

				return
			end)

			arg_31_0.effectList = {}
			ipairs = var_4

			for iter_31_0, iter_31_1 in var_4({
				"saiche_sudu_01",
				"saiche_sudu_02",
				"saiche_sudu_03",
				"saiche_sudu_04"
			}) do
				table = var_2_10009
				var_2_10009 = var_2_10009.insert

				local var_31_3 = arg_31_0.effectList
				local var_31_4 = arg_31_0.rt

				var_2_10009(var_31_3, var_11.Find(var_31_4, "GameObject/" .. iter_31_1))
			end

			arg_31_0:Show("base")

			return
		end

		function var_30_0.UpdatePos(arg_33_0, arg_33_1, arg_33_2)
			arg_33_0.pos = arg_33_0.pos + arg_33_1

			local var_33_0 = arg_33_0.pos

			math = var_2_10004
			var_33_0.y = var_2_10004.clamp(arg_33_0.pos.y, -arg_33_2, arg_33_2)
			setAnchoredPosition = var_33_0

			var_33_0(arg_33_0.rt, arg_33_0.pos)

			return
		end

		function var_30_0.ActionCallback(arg_34_0)
			switch = var_2_10001

			var_2_10001(arg_34_0.action, {
				ride = function()
					return
				end,
				accel = function()
					arg_34_0.action = "ride"

					local var_36_0 = arg_34_0.comSpineAnim

					var_0.SetAction(var_36_0, arg_34_0.action, 0)

					return
				end,
				fall = function()
					arg_34_0.isBlock = false

					local var_37_0 = arg_34_0

					var_0.Show(var_37_0, "base")

					return
				end,
				yunxuan = function()
					local var_38_0 = arg_34_0

					var_38_0.isVertigo = false
					setActive = var_38_0

					local var_38_1 = arg_34_0.rt

					var_38_0(var_1.Find(var_38_1, "GameObject/saiche_xuanyun"), false)

					setActive = var_38_0

					local var_38_2 = arg_34_0.rt

					var_38_0(var_1.Find(var_38_2, "GameObject/saiche_jiansu"), false)

					local var_38_3 = arg_34_0

					var_0.Show(var_38_3, "accel")

					return
				end
			})

			return
		end

		function var_30_0.Show(arg_39_0, ...)
			var_30_0.super.Show(arg_39_0, ...)

			switch = var_1

			var_1(arg_39_0.state, {
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

					local var_43_0 = arg_39_0

					var_43_0.isVertigo = true
					setActive = var_43_0

					local var_43_1 = arg_39_0.rt

					var_43_0(var_1.Find(var_43_1, "GameObject/saiche_xuanyun"), true)

					setActive = var_43_0

					local var_43_2 = arg_39_0.rt

					var_43_0(var_1.Find(var_43_2, "GameObject/saiche_jiansu"), true)

					pg = var_43_0

					local var_43_3 = var_43_0.CriMgr.GetInstance()

					var_0.PlaySoundEffect_V3(var_43_3, "ui-yunxuan")

					return
				end
			})

			local var_39_0 = arg_39_0.comSpineAnim

			var_1.SetAction(var_39_0, arg_39_0.action, 0)

			return
		end

		function var_30_0.TriggerEffect(arg_44_0, arg_44_1)
			switch = var_2_10002

			var_2_10002(arg_44_1.__cname, {
				MoreTime = function()
					local var_45_0 = arg_44_0.controller
					local var_45_1 = var_0.AddTime

					RacingMiniGameConfig = var_3_10002

					var_45_1(var_45_0, var_3_10002.ITEM_ADD_TIME)

					return
				end,
				Invincibility = function()
					local var_46_0 = arg_44_0

					RacingMiniGameConfig = var_3_10001
					var_46_0.invincibleTime = var_3_10001.INVINCIBLE_TIME
					setActive = var_46_0

					local var_46_1 = arg_44_0.rt

					var_46_0(var_1.Find(var_46_1, "invincibility"), true)

					return
				end,
				TrafficCone = function()
					local var_47_0 = arg_44_0.controller

					var_0.SetEnginePower(var_47_0, 0)

					local var_47_1 = arg_44_0

					var_0.Show(var_47_1, "fall")

					pg = var_0

					local var_47_2 = var_0.CriMgr.GetInstance()

					var_0.PlaySoundEffect_V3(var_47_2, "ui-fall")

					return
				end,
				Roadblock = function()
					local var_48_0 = arg_44_0.controller

					var_0.SetEnginePower(var_48_0, 0)

					local var_48_1 = arg_44_0

					var_0.Show(var_48_1, "fall")

					pg = var_0

					local var_48_2 = var_0.CriMgr.GetInstance()

					var_0.PlaySoundEffect_V3(var_48_2, "ui-fall")

					return
				end,
				Bomb = function()
					local var_49_0 = arg_44_0.controller

					var_0.SetEnginePower(var_49_0, 0)

					local var_49_1 = arg_44_0

					var_0.Show(var_49_1, "fall")

					return
				end,
				Mire = function()
					local var_50_0 = arg_44_0.controller
					local var_50_1 = var_0.SetEnginePower

					math = var_3_10002

					local var_50_2 = var_3_10002.min
					local var_50_3 = arg_44_0.controller.enginePower

					RacingMiniGameConfig = var_3_10004

					var_50_1(var_50_0, var_50_2(var_50_3, var_3_10004.OBSTACLE_POWER_BLOCK))

					local var_50_4 = arg_44_0

					var_0.Show(var_50_4, "yunxuan")

					return
				end,
				SpeedBumps = function()
					local var_51_0 = arg_44_0.controller
					local var_51_1 = var_0.SetEnginePower

					math = var_3_10002

					local var_51_2 = var_3_10002.min
					local var_51_3 = arg_44_0.controller.enginePower

					RacingMiniGameConfig = var_3_10004

					var_51_1(var_51_0, var_51_2(var_51_3, var_3_10004.OBSTACLE_POWER_BLOCK))

					local var_51_4 = arg_44_0

					var_0.Show(var_51_4, "yunxuan")

					return
				end
			})

			return
		end

		function var_30_0.UpdateInvincibility(arg_52_0, arg_52_1)
			assert = var_2_10002

			var_2_10002(arg_52_0.invincibleTime)

			arg_52_0.invincibleTime = arg_52_0.invincibleTime - arg_52_1

			if arg_52_0.invincibleTime <= 0 then
				setActive = var_2

				local var_52_0 = arg_52_0.rt

				var_2(var_3.Find(var_52_0, "invincibility"), false)

				arg_52_0.invincibleTime = nil
			else
				local var_52_1 = arg_52_0.invincibleTime < 2

				setActive = var_3

				local var_52_2 = arg_52_0.rt

				var_3(var_4.Find(var_52_2, "invincibility/saiche_wudihudun_xiaoshi"), var_52_1)

				setActive = var_3

				local var_52_3 = arg_52_0.rt

				var_3(var_4.Find(var_52_3, "invincibility/saiche_wudihudun"), not var_52_1)
			end

			return
		end

		return var_30_0
	end
}

ipairs = var_2

for iter_0_0, iter_0_1 in var_2(var_0_1) do
	var_0_0[iter_0_1().__cname] = var_7
end

return var_0_0
