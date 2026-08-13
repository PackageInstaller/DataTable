local var_0_0 = {}
local var_0_1 = {
	TargetObject = function()
		class = var_1_10000

		local var_1_0 = var_1_10000("TargetObject")

		function var_1_0.GetSize(arg_2_0)
			return arg_2_0.size
		end

		function var_1_0.InTimeLine(arg_3_0)
			return false
		end

		function var_1_0.Moveable(arg_4_0)
			return false
		end

		function var_1_0.BreakMoveable(arg_5_0)
			return false
		end

		function var_1_0.GetBaseOrder(arg_6_0)
			return 3
		end

		function var_1_0.Ctor(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
			arg_7_0._tf = arg_7_2
			arg_7_0.controller = arg_7_1

			arg_7_0:Init(arg_7_3)

			return
		end

		function var_1_0.Init(arg_8_0, arg_8_1)
			arg_8_0.name = arg_8_1.name

			local var_8_0

			if not arg_8_1.size then
				NewPos = var_8_0
				var_8_0 = var_8_0(1, 1)
			end

			arg_8_0.size = var_8_0
			arg_8_0.canHide = arg_8_1.hide
			SetCanvasOverrideSorting = var_2

			var_2(arg_8_0._tf, true)

			local var_8_1 = arg_8_0
			local var_8_2 = arg_8_0.UpdatePos
			local var_8_3 = arg_8_1.pos

			NewPos = var_2_10005

			var_8_2(var_8_1, var_8_3 - var_2_10005(0, arg_8_0:GetSize().y - 1))

			local var_8_4

			if not arg_8_1.realPos then
				var_8_4 = arg_8_0.pos
			end

			arg_8_0.realPos = var_8_4

			arg_8_0:UpdatePosition()
			arg_8_0:InitUI(arg_8_1)

			return
		end

		function var_1_0.InitUI(arg_9_0, arg_9_1)
			return
		end

		function var_1_0.UpdatePos(arg_10_0, arg_10_1)
			local var_10_0 = arg_10_0._tf
			local var_10_1 = var_2.GetComponent

			typeof = var_2_10004
			Canvas = var_2_10005
			var_10_1(var_10_0, var_2_10004(var_2_10005)).sortingOrder = (arg_10_1.y + arg_10_0:GetSize().y) * 10 + arg_10_0:GetBaseOrder()

			local var_10_2 = arg_10_0.controller

			var_2.UpdateTargetPos(var_10_2, arg_10_0, arg_10_0.pos, arg_10_1)

			arg_10_0.pos = arg_10_1

			return
		end

		function var_1_0.UpdatePosition(arg_11_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_11_0._tf, {
				x = arg_11_0.realPos.x * 32,
				y = arg_11_0.realPos.y * -32
			})

			return
		end

		function var_1_0.PlayAnim(arg_12_0, arg_12_1)
			if arg_12_0.status ~= arg_12_1 then
				arg_12_0.status = arg_12_1

				local var_12_0 = arg_12_0.mainTarget
				local var_12_1 = var_2.GetComponent

				typeof = var_2_10004
				Animator = var_2_10005

				local var_12_2 = var_12_1(var_12_0, var_2_10004(var_2_10005))

				var_2.Play(var_12_2, arg_12_1, -1, 0)
			end

			return
		end

		return var_1_0
	end,
	TargetIce = function()
		class = var_1_10000

		local var_13_0 = var_1_10000("TargetIce", var_0_0.TargetObject)

		function var_13_0.BreakMoveable(arg_14_0)
			return true
		end

		function var_13_0.InitUI(arg_15_0, arg_15_1)
			local var_15_0 = arg_15_0._tf

			arg_15_0.mainTarget = var_2.Find(var_15_0, "scale/Image")

			local var_15_1 = arg_15_0.mainTarget
			local var_15_2 = var_2.GetComponent

			typeof = var_4
			DftAniEvent = var_2_10005

			local var_15_3 = var_15_2(var_15_1, var_4(var_2_10005))

			var_2.SetEndEvent(var_15_3, function()
				local var_16_0 = arg_15_0.controller

				var_0.DestoryTarget(var_16_0, arg_15_0)

				return
			end)

			if arg_15_1.create then
				local var_15_4 = arg_15_0.controller

				if var_3.CheckMelt(var_15_4, arg_15_0.pos) then
					arg_15_0.isLost = true

					arg_15_0:PlayAnim("Ice_Spawn_Melt")
				else
					arg_15_0:PlayAnim("Ice_Spawn")
				end
			end

			return
		end

		function var_13_0.Break(arg_17_0)
			if arg_17_0.isLost then
				return
			else
				arg_17_0.isLost = true

				arg_17_0:PlayAnim("Ice_Break")
			end

			return
		end

		return var_13_0
	end,
	TargetItem = function()
		class = var_1_10000

		local var_18_0 = var_1_10000("TargetItem", var_0_0.TargetObject)

		function var_18_0.Moveable(arg_19_0)
			return true
		end

		function var_18_0.GetBaseOrder(arg_20_0)
			return 2
		end

		function var_18_0.InitUI(arg_21_0, arg_21_1)
			arg_21_0.point = arg_21_1.point
			eachChild = var_2

			local var_21_0 = arg_21_0._tf

			var_2(var_3.Find(var_21_0, "scale/type"), function(arg_22_0)
				setActive = var_3_10001

				var_3_10001(arg_22_0, arg_22_0.name == arg_21_0.name)

				return
			end)

			return
		end

		return var_18_0
	end,
	TargetArbor = function()
		class = var_1_10000

		local var_23_0 = var_1_10000("TargetArbor", var_0_0.TargetObject)

		function var_23_0.InitUI(arg_24_0, arg_24_1)
			string = var_2_10002

			local var_24_0 = var_2_10002.split(arg_24_0.name, "_")

			eachChild = var_3

			local var_24_1 = arg_24_0._tf

			var_3(var_4.Find(var_24_1, "scale/Image"), function(arg_25_0)
				setActive = var_3_10001

				var_3_10001(arg_25_0, arg_25_0.name == var_24_0[#var_24_0])

				return
			end)

			return
		end

		return var_23_0
	end,
	TargetMove = function()
		class = var_1_10000

		local var_26_0 = var_1_10000("TargetMove", var_0_0.TargetObject)

		function var_26_0.InTimeLine(arg_27_0)
			return true
		end

		function var_26_0.GetBaseOrder(arg_28_0)
			return 4
		end

		function var_26_0.InitUI(arg_29_0, arg_29_1)
			local var_29_0 = arg_29_0._tf

			arg_29_0.rtScale = var_2.Find(var_29_0, "scale")

			local var_29_1 = arg_29_0.rtScale

			arg_29_0.mainTarget = var_2.Find(var_29_1, "main")

			local var_29_2 = arg_29_0.mainTarget
			local var_29_3 = var_2.GetComponent

			typeof = var_4
			DftAniEvent = var_2_10005

			local var_29_4 = var_29_3(var_29_2, var_4(var_2_10005))

			var_2.SetStartEvent(var_29_4, function()
				local var_30_0 = arg_29_0

				var_0.EventAnim(var_30_0, "start")

				return
			end)
			var_2:SetTriggerEvent(function()
				local var_31_0 = arg_29_0

				var_0.EventAnim(var_31_0, "trigger")

				return
			end)
			var_2:SetEndEvent(function()
				arg_29_0.inLock = false

				local var_32_0 = arg_29_0

				var_0.EventAnim(var_32_0, "end")

				return
			end)
			arg_29_0:PlayIdle()

			return
		end

		function var_26_0.EventAnim(arg_33_0, arg_33_1)
			return
		end

		function var_26_0.RushCheck(arg_34_0)
			return
		end

		function var_26_0.PlayIdle(arg_35_0, arg_35_1)
			local var_35_0 = arg_35_0
			local var_35_1 = arg_35_0.PlayAnim

			string = var_2_10004

			var_35_1(var_35_0, var_2_10004.format("Idle_%s%s", arg_35_1 or arg_35_0:GetDirMark(), arg_35_0.inLantern and "_Lantern" or ""))

			return
		end

		function var_26_0.PlayMove(arg_36_0, arg_36_1)
			local var_36_0 = arg_36_0
			local var_36_1 = arg_36_0.PlayAnim

			string = var_2_10004

			var_36_1(var_36_0, var_2_10004.format("Move_%s%s", arg_36_1 or arg_36_0:GetDirMark(), arg_36_0.inLantern and "_Lantern" or ""))

			return
		end

		local var_26_1 = {
			E = {
				1,
				0
			},
			S = {
				0,
				1
			},
			W = {
				-1,
				0
			},
			N = {
				0,
				-1
			}
		}

		function var_26_0.GetDirMark(arg_37_0, arg_37_1)
			if arg_37_1 then
				pairs = var_2_10002

				for iter_37_0, iter_37_1 in var_2_10002(var_26_1) do
					if iter_37_1[1] == arg_37_1.x and iter_37_1[2] == arg_37_1.y then
						return iter_37_0
					end
				end
			else
				string = var_2_10002

				local var_37_0 = var_2_10002.split(arg_37_0.status, "_")[2]

				return var_26_1[var_37_0] and var_37_0 or "S"
			end

			return
		end

		function var_26_0.GetDirPos(arg_38_0, arg_38_1)
			NewPos = var_2_10002
			unpack = var_2_10003

			return var_2_10002(var_2_10003(var_26_1[arg_38_1 or arg_38_0:GetDirMark()]))
		end

		function var_26_0.GetStatusMark(arg_39_0, arg_39_1)
			string = var_2_10002

			return var_2_10002.split(arg_39_1 or arg_39_0.status, "_")[1]
		end

		function var_26_0.OnTimerUpdate(arg_40_0, arg_40_1)
			return
		end

		var_26_0.loopAnimDic = {
			Fear = true,
			Idle = true,
			Move = true
		}

		function var_26_0.PlayAnim(arg_41_0, arg_41_1)
			tobool = var_2_10002

			local var_41_0 = arg_41_0.loopAnimDic
			local var_41_1 = arg_41_0

			if var_2_10002(var_41_0[arg_41_0.GetStatusMark(var_41_1, arg_41_1)]) and arg_41_0.status == arg_41_1 then
				-- block empty
			else
				arg_41_0.inLock = not var_2
				arg_41_0.status = arg_41_1

				local var_41_2 = arg_41_0.mainTarget
				local var_41_3 = var_3.GetComponent

				typeof = var_41_1
				Animator = var_6

				local var_41_4 = var_41_3(var_41_2, var_41_1(var_6))

				var_3.Play(var_41_4, arg_41_1, -1, 0)
				arg_41_0:RushCheck()
			end

			return
		end

		return var_26_0
	end,
	TargetFuShun = function()
		class = var_1_10000

		local var_42_0 = var_1_10000("TargetFuShun", var_0_0.TargetMove)

		function var_42_0.GetSpeed(arg_43_0)
			local var_43_0 = arg_43_0.speed
			local var_43_1 = arg_43_0.controller
			local var_43_2 = var_43_0 * (var_2.GetEnemyEffect(var_43_1, "gravity") and 0.85 or 1)

			if arg_43_0.inRush then
				NenjuuGameConfig = var_2

				local var_43_3

				if not var_2.GetSkillParam("rush", arg_43_0.level.rush)[2] then
					var_43_3 = 1
				end

				local var_43_4 = var_43_2 * var_43_3
				local var_43_5 = arg_43_0.controller
				local var_43_6 = var_43_4 * (var_2.InBlackHoleRange(var_43_5, arg_43_0.pos) and 0.75 or 1)

				NenjuuGameConfig = var_2

				local var_43_7

				if not var_2.GetSkillParam("blessing", arg_43_0.level.blessing) then
					var_43_7 = 1
				end

				return var_43_6 * var_43_7
			end
		end

		local var_42_1 = 0.1
		local var_42_2 = 0.1
		local var_42_3 = 5
		local var_42_4 = {
			rush = 20,
			flash = 30,
			item = 0,
			ice = 1
		}

		function var_42_0.CheckSkill(arg_44_0, arg_44_1)
			if arg_44_1 == "item" then
				local var_44_0

				if arg_44_0.itemType then
					var_44_0 = arg_44_0.itemCount > 0
				end

				return var_44_0
			else
				return arg_44_0.level[arg_44_1] > 0 and arg_44_0.skillCDs[arg_44_1] <= 0
			end

			return
		end

		function var_42_0.ReloadSkill(arg_45_0, arg_45_1)
			local var_45_0 = arg_45_0.skillCDs

			if arg_45_1 == "flash" then
				NenjuuGameConfig = var_2_10003

				local var_45_1

				if not var_2_10003.GetSkillParam("flash", arg_45_0.level.flash) then
					var_45_1 = var_42_4[arg_45_1]
				end

				local var_45_2 = arg_45_0.controller

				var_45_0[arg_45_1] = var_45_1 * (var_4.GetEnemyEffect(var_45_2, "delay") and 1.2 or 1)

				return
			end
		end

		function var_42_0.InitUI(arg_46_0, arg_46_1)
			var_42_0.super.InitUI(arg_46_0, arg_46_1)

			arg_46_0.level = arg_46_1.level
			arg_46_0.skillCDs = {
				rush = 0,
				flash = 0,
				item = 0,
				ice = 0
			}
			arg_46_0.itemType = arg_46_1.itemType
			arg_46_0.speed = 4.5
			NenjuuGameConfig = var_2
			arg_46_0.icePower = var_2.GetSkillParam("ice", arg_46_0.level.ice)
			arg_46_0.flashPower = 4
			arg_46_0.decoyCount = arg_46_0.level.decoy
			checkExist = var_2
			NenjuuGameConfig = var_3
			arg_46_0.rushTime = var_2(var_3.GetSkillParam("rush", arg_46_0.level.rush), {
				1
			})
			arg_46_0.itemCount = 1

			return
		end

		function var_42_0.CalcSkillCDs(arg_47_0)
			local var_47_0 = {}

			ipairs = var_2_10002

			for iter_47_0, iter_47_1 in var_2_10002({
				"ice",
				"flash",
				"rush",
				"item"
			}) do
				local var_47_1 = arg_47_0.skillCDs[iter_47_1]

				if iter_47_1 == "flash" then
					NenjuuGameConfig = var_2_10008

					if not var_2_10008.GetSkillParam("flash", arg_47_0.level.flash) then
						var_2_10008 = var_42_4[iter_47_1]
					end

					local var_47_2 = arg_47_0.controller

					var_2_10008 = var_2_10008 * (var_9.GetEnemyEffect(var_47_2, "delay") and 1.2 or 1)

					if iter_47_1 == "item" then
						if not arg_47_0.itemType then
							table = var_9

							var_9.insert(var_47_0, {})
						elseif arg_47_0.itemCount > 0 then
							table = var_9

							var_9.insert(var_47_0, {
								cd = var_47_1,
								icon = arg_47_0.itemType
							})
						else
							table = var_9

							var_9.insert(var_47_0, {
								cd = true,
								icon = arg_47_0.itemType
							})
						end
					else
						local var_47_3

						if arg_47_0.level[iter_47_1] > 0 then
							table = var_47_3
							var_47_3 = var_47_3.insert

							local var_47_4 = var_47_0
							local var_47_5 = {
								cd = var_47_1,
								rate = var_2_10008 == 0 and 0 or var_47_1 / var_2_10008
							}
							local var_47_7

							if iter_47_1 == "ice" then
								local var_47_6 = arg_47_0.controller

								if var_12.CheckIce(var_47_6, arg_47_0.pos + arg_47_0:GetDirPos()) then
									var_47_7 = "attack"

									goto label_47_0
								end
							end

							var_47_7 = iter_47_1

							::label_47_0::

							var_47_5.icon = var_47_7

							var_47_3(var_47_4, var_47_5)
						else
							table = var_47_3

							var_47_3.insert(var_47_0, {})
						end
					end
				end
			end

			return var_47_0
		end

		function var_42_0.EventAnim(arg_48_0, arg_48_1)
			local var_48_0 = arg_48_0
			local var_48_1 = arg_48_0.GetDirMark(var_48_0)

			if arg_48_1 == "start" then
				-- block empty
			elseif arg_48_1 == "trigger" then
				switch = var_48_0

				var_48_0(arg_48_0.status, {
					["Freeze_" .. var_48_1 .. "_3_Shot"] = function()
						local var_49_0 = arg_48_0.controller
						local var_49_1 = var_0.CreateTarget
						local var_49_2 = {
							name = "EF_bk_Freeze"
						}
						local var_49_3 = arg_48_0.rtScale

						var_49_2.parent = var_3.Find(var_49_3, "bk")

						var_49_1(var_49_0, var_49_2)

						local var_49_4 = arg_48_0.controller
						local var_49_5 = var_0.BuildIce
						local var_49_6 = {
							pos = arg_48_0.pos
						}
						local var_49_7 = arg_48_0

						var_49_6.dirPos = var_3.GetDirPos(var_49_7)
						var_49_6.power = arg_48_0.icePower

						var_49_5(var_49_4, var_49_6)

						return
					end,
					["Attack_" .. var_48_1] = function()
						switch = var_3_10000

						var_3_10000(var_48_1, {
							N = function()
								local var_51_0 = arg_48_0.controller
								local var_51_1 = var_0.CreateTarget
								local var_51_2 = {
									name = "EF_Attack_Hit_" .. var_48_1
								}
								local var_51_3 = arg_48_0.rtScale

								var_51_2.parent = var_3.Find(var_51_3, "bk")

								var_51_1(var_51_0, var_51_2)

								return
							end,
							S = function()
								local var_52_0 = arg_48_0.controller
								local var_52_1 = var_0.CreateTarget
								local var_52_2 = {
									name = "EF_Attack_Hit_" .. var_48_1
								}
								local var_52_3 = arg_48_0.rtScale

								var_52_2.parent = var_3.Find(var_52_3, "fr")

								var_52_1(var_52_0, var_52_2)

								return
							end
						}, function()
							local var_53_0 = arg_48_0.controller
							local var_53_1 = var_0.CreateTarget
							local var_53_2 = {
								name = "EF_Attack_Hit_" .. var_48_1 .. "_fr"
							}
							local var_53_3 = arg_48_0.rtScale

							var_53_2.parent = var_3.Find(var_53_3, "fr")

							var_53_1(var_53_0, var_53_2)

							local var_53_4 = arg_48_0.controller
							local var_53_5 = var_0.CreateTarget
							local var_53_6 = {
								name = "EF_Attack_Hit_" .. var_48_1 .. "_bk"
							}
							local var_53_7 = arg_48_0.rtScale

							var_53_6.parent = var_3.Find(var_53_7, "bk")

							var_53_5(var_53_4, var_53_6)

							return
						end)

						local var_50_0 = arg_48_0.controller
						local var_50_1 = var_0.BreakIce
						local var_50_2 = {
							pos = arg_48_0.pos
						}
						local var_50_3 = arg_48_0

						var_50_2.dir = var_3.GetDirMark(var_50_3)

						local var_50_4 = arg_48_0

						var_50_2.dirPos = var_3.GetDirPos(var_50_4)

						var_50_1(var_50_0, var_50_2)

						return
					end,
					Lantern_Activate = function()
						local var_54_0 = arg_48_0

						var_0.ReloadSkill(var_54_0, "item")

						arg_48_0.itemCount = arg_48_0.itemCount - 1
						arg_48_0.inLantern = var_42_3

						local var_54_1 = arg_48_0
						local var_54_2 = arg_48_0.controller
						local var_54_3 = var_1.CreateTarget
						local var_54_4 = {
							name = "EF_bk_overlay_Lantern"
						}
						local var_54_5 = arg_48_0.rtScale

						var_54_4.parent = var_4.Find(var_54_5, "bk")
						var_54_4.time = var_42_3
						var_54_1.effectLantern = var_54_3(var_54_2, var_54_4)

						return
					end
				})
			elseif arg_48_1 == "end" then
				switch = var_48_0

				var_48_0(arg_48_0.status, {
					["Bomb_" .. var_48_1 .. "_1_Start"] = function()
						local var_55_0 = arg_48_0

						var_0.ReloadSkill(var_55_0, "item")

						arg_48_0.itemCount = arg_48_0.itemCount - 1

						local var_55_1 = arg_48_0

						var_0.PlayAnim(var_55_1, "Bomb_" .. var_48_1 .. "_3_End")

						local var_55_2 = arg_48_0.controller

						var_0.BuildBomb(var_55_2, {
							pos = arg_48_0.pos,
							dir = var_48_1
						})

						return
					end,
					Dead = function()
						if arg_48_0.isDead then
							local var_56_0 = arg_48_0.controller

							var_0.EndGame(var_56_0)
						end

						return
					end
				})
			else
				assert = var_48_0

				var_48_0(false)
			end

			return
		end

		local var_42_5 = {
			E = {
				"EF_Ghost_E_bk"
			},
			N = {
				"EF_Ghost_N_bk",
				"EF_Ghost_N_fr"
			},
			S = {
				"EF_Ghost_S_bk"
			},
			W = {
				"EF_Ghost_W_bk"
			}
		}

		function var_42_0.RushCheck(arg_57_0)
			if arg_57_0.rushEffects then
				ipairs = var_1

				for iter_57_0, iter_57_1 in var_1(arg_57_0.rushEffects) do
					iter_57_1:Remove()
				end

				arg_57_0.rushEffects = nil
			end

			if arg_57_0.inRush and arg_57_0.loopAnimDic[arg_57_0:GetStatusMark(arg_57_0.status)] then
				arg_57_0.rushEffects = {}
				ipairs = var_1

				for iter_57_2, iter_57_3 in var_1(var_42_5[arg_57_0:GetDirMark()]) do
					string = var_2_10006
					var_2_10006 = var_2_10006.split(iter_57_3, "_")
					table = var_7

					local var_57_0 = var_7.insert
					local var_57_1 = arg_57_0.rushEffects
					local var_57_2 = arg_57_0.controller
					local var_57_3 = var_9.CreateTarget
					local var_57_4 = {
						name = iter_57_3
					}
					local var_57_5 = arg_57_0.rtScale

					var_57_4.parent = var_12.Find(var_57_5, var_2_10006[#var_2_10006])

					var_57_0(var_57_1, var_57_3(var_57_2, var_57_4))
				end
			end

			return
		end

		function var_42_0.OnTimerUpdate(arg_58_0, arg_58_1)
			pairs = var_2_10002

			for iter_58_0, iter_58_1 in var_2_10002(arg_58_0.skillCDs) do
				arg_58_0.skillCDs[iter_58_0] = iter_58_1 - arg_58_1
			end

			if arg_58_0.inRush then
				arg_58_0.inRush = arg_58_0.inRush - arg_58_1

				if arg_58_0.inRush <= 0 then
					arg_58_0.inRush = nil
				end
			end

			if arg_58_0.inLantern then
				arg_58_0.inLantern = arg_58_0.inLantern - arg_58_1
			end

			if arg_58_0.inShock then
				arg_58_0.inShock = arg_58_0.inShock - arg_58_1

				if arg_58_0.inShock <= 0 then
					arg_58_0.inShock = nil
				end

				return
			end

			if arg_58_0.inCharge then
				arg_58_0.inCharge = arg_58_0.inCharge + arg_58_1

				if arg_58_0.inCharge > var_42_2 then
					arg_58_0.inCharge = nil

					local var_58_0 = arg_58_0
					local var_58_1 = arg_58_0.PlayAnim

					string = var_4

					var_58_1(var_58_0, var_4.format("Freeze_%s_3_Shot", arg_58_0:GetDirMark()))
				end
			elseif arg_58_0.inMove then
				arg_58_0.inMove = arg_58_0.inMove - arg_58_1 * arg_58_0:GetSpeed()

				if arg_58_0.inMove > 0 then
					arg_58_0.realPos = arg_58_0.pos - arg_58_0:GetDirPos() * arg_58_0.inMove
				else
					arg_58_0.inMove = nil
					arg_58_0.realPos = arg_58_0.pos
				end

				arg_58_0:UpdatePosition()
			elseif arg_58_0.inLock then
				return
			else
				local var_58_2 = arg_58_0.controller

				if var_2.InBlackHoleRange(var_58_2, arg_58_0.pos, true) then
					arg_58_0.inShock = 1

					arg_58_0:PlayAnim("Dead")
				elseif arg_58_0.inLantern and arg_58_0.inLantern <= 0 then
					arg_58_0.inLantern = nil

					local var_58_3 = arg_58_0.effectLantern

					var_2.PlayAnim(var_58_3, "EF_bk_overlay_Lantern_Finish")

					arg_58_0.effectLantern = nil
				else
					if arg_58_0:CheckSkill("ice") then
						local var_58_4 = arg_58_0.controller

						if var_2.GetPressInput(var_58_4, "Skill_0") then
							arg_58_0:ReloadSkill("ice")

							local var_58_5 = arg_58_0.controller

							if var_2.CheckIce(var_58_5, arg_58_0.pos + arg_58_0:GetDirPos()) then
								local var_58_6 = arg_58_0
								local var_58_7 = arg_58_0.PlayAnim

								string = var_4

								var_58_7(var_58_6, var_4.format("Attack_%s", arg_58_0:GetDirMark()))
							else
								arg_58_0.inCharge = 0

								local var_58_8 = arg_58_0
								local var_58_9 = arg_58_0.PlayAnim

								string = var_4

								var_58_9(var_58_8, var_4.format("Freeze_%s_1_Start", arg_58_0:GetDirMark()))
							end

							goto label_58_0
						end
					end

					if arg_58_0:CheckSkill("flash") then
						local var_58_10 = arg_58_0.controller

						if var_2.GetPressInput(var_58_10, "Skill_1") then
							arg_58_0:ReloadSkill("flash")

							local var_58_11 = arg_58_0:GetDirPos()

							for iter_58_2 = arg_58_0.flashPower, 0, -1 do
								local var_58_12 = arg_58_0.controller

								if var_7.Moveable(var_58_12, arg_58_0.pos + var_58_11 * iter_58_2) then
									local var_58_13 = arg_58_0.controller

									var_7.CreateTarget(var_58_13, {
										name = "EF_bk_Flash_Jump",
										pos = arg_58_0.pos
									})
									arg_58_0:UpdatePos(arg_58_0.pos + var_58_11 * iter_58_2)

									arg_58_0.realPos = arg_58_0.pos

									arg_58_0:UpdatePosition()

									local var_58_14 = arg_58_0.controller
									local var_58_15 = var_7.CreateTarget
									local var_58_16 = {
										name = "EF_bk_Flash_Land"
									}
									local var_58_17 = arg_58_0.rtScale

									var_58_16.parent = var_10.Find(var_58_17, "bk")

									var_58_15(var_58_14, var_58_16)

									local var_58_18 = arg_58_0
									local var_58_19 = arg_58_0.PlayAnim

									string = var_58_16

									var_58_19(var_58_18, var_58_16.format("Flash_%s", arg_58_0:GetDirMark()))

									break
								end
							end

							goto label_58_0
						end
					end

					if arg_58_0:CheckSkill("rush") then
						local var_58_20 = arg_58_0.controller

						if var_2.GetPressInput(var_58_20, "Skill_2") then
							arg_58_0:ReloadSkill("rush")

							arg_58_0.inRush = arg_58_0.rushTime

							arg_58_0:RushCheck()

							goto label_58_0
						end
					end

					if arg_58_0.itemType and arg_58_0:CheckSkill("item") then
						local var_58_21 = arg_58_0.controller

						if var_2.GetPressInput(var_58_21, "Skill_3") and (arg_58_0.itemType ~= "lantern" or not arg_58_0.inLantern) then
							if arg_58_0.itemType == "lantern" then
								arg_58_0:PlayAnim("Lantern_Activate")
							else
								local var_58_23

								if arg_58_0.itemType == "bomb" then
									local var_58_22 = arg_58_0

									var_58_23 = arg_58_0.PlayAnim
									string = var_4

									var_58_23(var_58_22, var_4.format("Bomb_%s_1_Start", arg_58_0:GetDirMark()))
								else
									assert = var_58_23

									var_58_23(false)
								end
							end

							goto label_58_0
						end
					end

					local var_58_24 = arg_58_0.controller

					if not var_2.GetCacheInput(var_58_24) then
						defaultValue = var_58_24
						arg_58_0.idleTime = var_58_24(arg_58_0.idleTime, 0) - arg_58_1

						arg_58_0:PlayIdle()
					elseif arg_58_0:GetStatusMark() == "Move" then
						local var_58_25 = arg_58_0.controller

						if var_3.Moveable(var_58_25, arg_58_0.pos + arg_58_0:GetDirPos(var_2)) then
							arg_58_0.inMove = 1

							arg_58_0:UpdatePos(arg_58_0.pos + arg_58_0:GetDirPos(var_2))
							arg_58_0:PlayMove(var_2)
						else
							arg_58_0:PlayIdle(var_2)
						end
					elseif var_2 == arg_58_0:GetDirMark() then
						defaultValue = var_3

						if var_3(arg_58_0.idleTime, 0) <= 0 then
							local var_58_26 = arg_58_0.controller

							if var_3.Moveable(var_58_26, arg_58_0.pos + arg_58_0:GetDirPos()) then
								arg_58_0.inMove = 1

								arg_58_0:UpdatePos(arg_58_0.pos + arg_58_0:GetDirPos())
								arg_58_0:PlayMove()

								goto label_58_0
							end
						end

						defaultValue = var_3
						arg_58_0.idleTime = var_3(arg_58_0.idleTime, 0) - arg_58_1

						arg_58_0:PlayIdle()
					else
						arg_58_0.idleTime = var_42_1

						arg_58_0:PlayIdle(var_2)
					end
				end
			end

			::label_58_0::

			return
		end

		function var_42_0.PopPoint(arg_59_0, arg_59_1)
			local var_59_0 = arg_59_0._tf
			local var_59_1 = var_2.Find(var_59_0, "top/pop")

			setText = var_59_0

			var_59_0(var_59_1:Find("Text"), "+" .. arg_59_1)

			setActive = var_59_0

			var_59_0(var_59_1, false)

			setActive = var_59_0

			var_59_0(var_59_1, true)

			return
		end

		function var_42_0.EnemyHit(arg_60_0, arg_60_1)
			if arg_60_0.isDead then
				return
			end

			if arg_60_0.decoyCount > 0 then
				arg_60_0.decoyCount = arg_60_0.decoyCount - 1
				arg_60_0.inCharge = nil
				arg_60_0.inMove = nil

				local var_60_0 = arg_60_0.controller

				var_2.BuildDecoy(var_60_0, arg_60_0.pos)

				local var_60_1 = arg_60_0.controller
				local var_60_2 = var_2.GetDecoyPos(var_60_1, arg_60_0.pos, arg_60_1)

				arg_60_0:UpdatePos(var_60_2)

				arg_60_0.realPos = arg_60_0.pos

				arg_60_0:UpdatePosition()
				arg_60_0:PlayAnim("Decoy_2")
			else
				arg_60_0.isDead = true
				arg_60_0.inCharge = nil
				arg_60_0.inMove = nil

				arg_60_0:PlayAnim("Dead")
			end

			return
		end

		function var_42_0.UpdatePosition(arg_61_0)
			var_42_0.super.UpdatePosition(arg_61_0)

			local var_61_0 = arg_61_0.controller

			var_1.WindowFocrus(var_61_0, arg_61_0._tf.localPosition)

			if arg_61_0.realPos == arg_61_0.pos then
				local var_61_1 = arg_61_0.controller

				var_1.EatItem(var_61_1, arg_61_0.pos)
			end

			return
		end

		return var_42_0
	end,
	TargetNenjuu = function()
		class = var_1_10000

		local var_62_0 = var_1_10000("TargetNenjuu", var_0_0.TargetMove)

		function var_62_0.GetSpeed(arg_63_0)
			return arg_63_0.speed * (arg_63_0:CheckAbility("rush") and 1.2 or 1) * (arg_63_0.inStealth and 1.3 or 1) * (arg_63_0.isDoppel and 0.8 or 1)
		end

		local var_62_1 = 1.5
		local var_62_2 = 5
		local var_62_3 = 5
		local var_62_4 = 12
		local var_62_5 = {
			gravity = 0,
			teleport = 7,
			doppelgangers = 0,
			delay = 0,
			blackhole = 20,
			stealth = 10,
			rush = 0,
			attack = 2,
			breakpassable = 0
		}

		function var_62_0.CheckAbility(arg_64_0, arg_64_1)
			local var_64_0

			if arg_64_0.featuresAbility[arg_64_1] then
				var_64_0 = arg_64_0.abilityCDs[arg_64_1] <= 0
			end

			return var_64_0
		end

		function var_62_0.ReloadAbility(arg_65_0, arg_65_1)
			arg_65_0.abilityCDs[arg_65_1] = var_62_5[arg_65_1]

			return
		end

		function var_62_0.InitUI(arg_66_0, arg_66_1)
			var_62_0.super.InitUI(arg_66_0, arg_66_1)

			arg_66_0.isDoppel = arg_66_1.isDoppel
			arg_66_0.speed = 1.5
			arg_66_0.featuresAbility = {
				attack = true
			}
			ipairs = var_2
			NenjuuGameConfig = var_3

			for iter_66_0, iter_66_1 in var_2(var_3.ABILITY_LIST) do
				local var_66_0 = arg_66_0.featuresAbility

				tobool = var_2_10008
				var_66_0[iter_66_1] = var_2_10008(arg_66_1.abilitys[iter_66_1])
			end

			arg_66_0.abilityCDs = {
				gravity = 0,
				teleport = 10,
				doppelgangers = 0,
				delay = 0,
				blackhole = 0,
				stealth = 0,
				rush = 0,
				attack = 0,
				breakpassable = 0
			}

			return
		end

		function var_62_0.EventAnim(arg_67_0, arg_67_1)
			local var_67_0 = arg_67_0
			local var_67_1 = arg_67_0.GetDirMark(var_67_0)

			if arg_67_1 == "start" then
				-- block empty
			elseif arg_67_1 == "trigger" then
				switch = var_67_0

				var_67_0(arg_67_0.status, {
					["Attack_" .. var_67_1] = function()
						local var_68_0 = arg_67_0.controller
						local var_68_1 = var_0.CreateTarget
						local var_68_2 = {
							name = "EF_Attack_" .. var_67_1
						}
						local var_68_3 = arg_67_0.rtScale

						var_68_2.parent = var_3.Find(var_68_3, var_67_1 == "N" and "bk" or "fr")

						var_68_1(var_68_0, var_68_2)

						if not arg_67_0.isDoppel then
							local var_68_4 = arg_67_0.controller
							local var_68_5 = var_0.BreakIce
							local var_68_6 = {
								pos = arg_67_0.pos
							}
							local var_68_7 = arg_67_0

							var_68_6.dir = var_3.GetDirMark(var_68_7)

							local var_68_8 = arg_67_0

							var_68_6.dirPos = var_3.GetDirPos(var_68_8)

							local var_68_9 = arg_67_0

							var_68_6.power = var_3.CheckAbility(var_68_9, "breakpassable") and 3 or 1

							var_68_5(var_68_4, var_68_6)
						end

						local var_68_10 = arg_67_0.controller
						local var_68_11 = var_0.EnemyAttack
						local var_68_12 = {
							pos = arg_67_0.pos
						}
						local var_68_13 = arg_67_0

						var_68_12.dirPos = var_3.GetDirPos(var_68_13)

						var_68_11(var_68_10, var_68_12)

						return
					end
				})
			elseif arg_67_1 == "end" then
				switch = var_67_0

				var_67_0(arg_67_0.status, {
					Warp_1_Jump = function()
						local var_69_0 = arg_67_0

						var_0.UpdatePos(var_69_0, arg_67_0.telePos)

						arg_67_0.realPos = arg_67_0.pos

						local var_69_1 = arg_67_0

						var_0.UpdatePosition(var_69_1)

						arg_67_0.telePos = nil

						local var_69_2 = arg_67_0

						var_0.PlayAnim(var_69_2, "Warp_2_Land")

						local var_69_3 = arg_67_0.controller

						var_0.OnlyBreakIce(var_69_3, arg_67_0.pos)

						return
					end
				})
			else
				assert = var_67_0

				var_67_0(false)
			end

			return
		end

		local var_62_6 = {
			E = {
				"EF_Nenjuu_Ghost_E_bk"
			},
			N = {
				"EF_Nenjuu_Ghost_N_bk",
				"EF_Nenjuu_Ghost_N_fr"
			},
			S = {
				"EF_Nenjuu_Ghost_S_bk"
			},
			W = {
				"EF_Nenjuu_Ghost_W_bk"
			}
		}

		function var_62_0.RushCheck(arg_70_0)
			if arg_70_0.rushEffects then
				ipairs = var_1

				for iter_70_0, iter_70_1 in var_1(arg_70_0.rushEffects) do
					iter_70_1:Remove()
				end

				arg_70_0.rushEffects = nil
			end

			if arg_70_0.inStealth and arg_70_0.loopAnimDic[arg_70_0:GetStatusMark(arg_70_0.status)] then
				arg_70_0.rushEffects = {}
				ipairs = var_1

				for iter_70_2, iter_70_3 in var_1(var_62_6[arg_70_0:GetDirMark()]) do
					string = var_2_10006
					var_2_10006 = var_2_10006.split(iter_70_3, "_")
					table = var_7

					local var_70_0 = var_7.insert
					local var_70_1 = arg_70_0.rushEffects
					local var_70_2 = arg_70_0.controller
					local var_70_3 = var_9.CreateTarget
					local var_70_4 = {
						name = iter_70_3
					}
					local var_70_5 = arg_70_0.rtScale

					var_70_4.parent = var_12.Find(var_70_5, var_2_10006[#var_2_10006])

					var_70_0(var_70_1, var_70_3(var_70_2, var_70_4))
				end
			end

			return
		end

		function var_62_0.OnTimerUpdate(arg_71_0, arg_71_1)
			pairs = var_2_10002

			for iter_71_2, iter_71_1 in var_2_10002(arg_71_0.featuresAbility) do
				if iter_71_1 and var_62_5[iter_71_2] > 0 then
					arg_71_0.abilityCDs[iter_71_2] = arg_71_0.abilityCDs[iter_71_2] - arg_71_1
				end
			end

			if arg_71_0.inStealth then
				arg_71_0.inStealth = arg_71_0.inStealth - arg_71_1

				if arg_71_0.inStealth <= 0 then
					arg_71_0.inStealth = nil
				end
			end

			if arg_71_0.inScare then
				arg_71_0.inScare = arg_71_0.inScare - arg_71_1

				if arg_71_0.inScare <= 0 then
					arg_71_0.inScare = nil
				end
			end

			if arg_71_0:CheckAbility("doppelgangers") and not arg_71_0.isSummon then
				arg_71_0.isSummon = true

				local var_71_0 = arg_71_0.controller

				var_2.BuildDoppelgangers(var_71_0, arg_71_0.pos)
			end

			if arg_71_0.inCharge then
				arg_71_0.inCharge = arg_71_0.inCharge + arg_71_1

				if arg_71_0.inCharge > var_62_1 then
					arg_71_0.inCharge = nil

					arg_71_0:PlayAnim("Warp_1_Jump")
				end
			elseif arg_71_0.inMove then
				arg_71_0.inMove = arg_71_0.inMove - arg_71_1 * arg_71_0:GetSpeed()

				if arg_71_0.inMove > 0 then
					arg_71_0.realPos = arg_71_0.pos - arg_71_0:GetDirPos() * arg_71_0.inMove
				else
					arg_71_0.inMove = nil
					arg_71_0.realPos = arg_71_0.pos
				end

				arg_71_0:UpdatePosition()
			elseif arg_71_0.inLock then
				return
			else
				if arg_71_0:CheckAbility("blackhole") then
					arg_71_0:ReloadAbility("blackhole")

					local var_71_1 = arg_71_0.controller

					var_2.BuildBlackHole(var_71_1)
				end

				if arg_71_0:CheckAbility("stealth") then
					local var_71_2 = arg_71_0.controller

					if var_2.StealthCheck(var_71_2, arg_71_0.pos) and not arg_71_0.inScare then
						arg_71_0:ReloadAbility("stealth")

						arg_71_0.inStealth = var_62_2

						arg_71_0:RushCheck()
					end
				end

				if arg_71_0:CheckAbility("attack") and not arg_71_0.inScare then
					ipairs = var_2

					for iter_71_2, iter_71_3 in var_2({
						"E",
						"S",
						"W",
						"N"
					}) do
						local var_71_3 = arg_71_0.controller

						if var_7.AttackCheck(var_71_3, {
							pos = arg_71_0.pos,
							dirPos = arg_71_0:GetDirPos(iter_71_3)
						}) then
							arg_71_0:DoAttack(iter_71_3)

							return
						end
					end
				end

				local var_71_4 = arg_71_0.controller
				local var_71_5 = var_2.GetWayfindingMap
				local var_71_6 = arg_71_0.pos

				tobool = iter_71_2

				local var_71_7 = var_71_5(var_71_4, var_71_6, iter_71_2(arg_71_0.isDoppel))
				local var_71_8 = arg_71_0.pos

				ipairs = var_71_6

				for iter_71_4, iter_71_5 in var_71_6({
					"E",
					"S",
					"W",
					"N"
				}) do
					tostring = var_2_10009

					if var_71_7[var_2_10009(arg_71_0.pos + arg_71_0:GetDirPos(iter_71_5))] then
						tostring = var_10

						local var_71_9 = var_71_7[var_10(var_71_8)]

						if arg_71_0.inScare then
							if not var_71_9 or var_71_9.value < var_2_10009.value then
								var_71_8 = arg_71_0.pos + arg_71_0:GetDirPos(iter_71_5)
							end

							goto label_71_0
						end

						if var_71_9 then
							do
								local var_71_10

								if not var_71_9.lightValue then
									var_71_10 = var_71_9.value
								end

								local var_71_11

								if not var_2_10009.lightValue then
									var_71_11 = var_2_10009.value
								end

								if var_71_11 < var_71_10 then
									var_71_8 = arg_71_0.pos + arg_71_0:GetDirPos(iter_71_5)
								end
							end

							::label_71_0::
						end
					end
				end

				if arg_71_0:CheckAbility("teleport") and not arg_71_0.inScare then
					if var_71_8 == arg_71_0.pos then
						if not arg_71_0.lostTime then
							arg_71_0.lostTime = 3 - arg_71_1
						elseif arg_71_1 >= arg_71_0.lostTime and arg_71_0.controller.timeCount > 5 then
							arg_71_0.lostTime = nil

							arg_71_0:DoTeleport(var_71_7)
						else
							arg_71_0.lostTime = arg_71_0.lostTime - arg_71_1
						end

						arg_71_0:PlayIdle()

						return
					else
						arg_71_0.lostTime = nil
						tostring = var_4

						if var_71_7[var_4(var_71_8)] then
							tostring = var_4

							if var_71_7[var_4(var_71_8)].value > var_62_4 then
								arg_71_0:DoTeleport(var_71_7)
								arg_71_0:PlayIdle()

								return
							end
						end
					end
				end

				if not arg_71_0.isDoppel and arg_71_0:CheckAbility("attack") then
					local var_71_12 = arg_71_0.controller

					if var_4.CheckIce(var_71_12, var_71_8) then
						arg_71_0:DoAttack(arg_71_0:GetDirMark(var_71_8 - arg_71_0.pos))

						goto label_71_1
					end
				end

				local var_71_13 = arg_71_0.controller

				if var_4.Moveable(var_71_13, var_71_8) then
					local var_71_14 = arg_71_0:GetDirMark(var_71_8 - arg_71_0.pos)

					arg_71_0.inMove = 1

					arg_71_0:UpdatePos(var_71_8)

					if arg_71_0.inScare then
						arg_71_0:PlayAnim("Fear_" .. var_71_14)
					else
						arg_71_0:PlayMove(var_71_14)
					end
				elseif arg_71_0.inScare then
					arg_71_0:PlayAnim("Fear_" .. arg_71_0:GetDirMark())
				else
					arg_71_0:PlayIdle()
				end
			end

			::label_71_1::

			return
		end

		function var_62_0.DoAttack(arg_72_0, arg_72_1)
			if arg_72_0.inStealth then
				arg_72_0.inStealth = nil
			end

			arg_72_0:ReloadAbility("attack")

			local var_72_0 = arg_72_0
			local var_72_1 = arg_72_0.PlayAnim

			string = var_4

			var_72_1(var_72_0, var_4.format("Attack_%s", arg_72_1))

			return
		end

		function var_62_0.DoTeleport(arg_73_0, arg_73_1)
			if arg_73_0.inStealth then
				arg_73_0.inStealth = nil
			end

			arg_73_0:ReloadAbility("teleport")

			arg_73_0.inCharge = 0

			local var_73_0 = arg_73_0.controller

			arg_73_0.telePos = var_2.GetTeleportTargetPos(var_73_0, arg_73_1, arg_73_0.pos)

			local var_73_1 = arg_73_0.controller

			var_2.BuildTeleportSign(var_73_1, {
				pos = arg_73_0.telePos,
				time = var_62_1
			})

			return
		end

		function var_62_0.BeScare(arg_74_0)
			arg_74_0.inCharge = nil
			arg_74_0.inStealth = nil
			arg_74_0.inScare = var_62_3

			if not arg_74_0.inMove then
				arg_74_0:PlayIdle()
			end

			return
		end

		return var_62_0
	end,
	TargetEffect = function()
		class = var_1_10000

		local var_75_0 = var_1_10000("TargetEffect", var_0_0.TargetObject)

		function var_75_0.Moveable(arg_76_0)
			return true
		end

		function var_75_0.GetBaseOrder(arg_77_0)
			return 5
		end

		function var_75_0.InitUI(arg_78_0, arg_78_1)
			local var_78_0 = arg_78_0._tf

			arg_78_0.mainTarget = var_2.Find(var_78_0, "scale/Image")

			local var_78_1 = arg_78_0.mainTarget
			local var_78_2 = var_2.GetComponent

			typeof = var_4
			DftAniEvent = var_2_10005

			local var_78_3 = var_78_2(var_78_1, var_4(var_2_10005))

			var_2.SetEndEvent(var_78_3, function()
				local var_79_0 = arg_78_0.controller

				var_0.DestoryTarget(var_79_0, arg_78_0)

				return
			end)

			return
		end

		return var_75_0
	end,
	TargetBomb = function()
		class = var_1_10000

		local var_80_0 = var_1_10000("TargetBomb", var_0_0.TargetEffect)

		function var_80_0.InTimeLine(arg_81_0)
			return true
		end

		function var_80_0.GetBaseOrder(arg_82_0)
			return 1
		end

		function var_80_0.OnTimerUpdate(arg_83_0, arg_83_1)
			local var_83_0 = arg_83_0.controller

			var_2.ScareEnemy(var_83_0, {
				range = 1,
				pos = arg_83_0.pos
			})

			return
		end

		return var_80_0
	end,
	TargetTimeEffect = function()
		class = var_1_10000

		local var_84_0 = var_1_10000("TargetTimeEffect", var_0_0.TargetEffect)

		function var_84_0.GetBaseOrder(arg_85_0)
			return 1
		end

		function var_84_0.InTimeLine(arg_86_0)
			return true
		end

		function var_84_0.InitUI(arg_87_0, arg_87_1)
			arg_87_0.time = arg_87_1.time

			return
		end

		function var_84_0.OnTimerUpdate(arg_88_0, arg_88_1)
			if arg_88_1 < arg_88_0.time then
				arg_88_0.time = arg_88_0.time - arg_88_1
			else
				local var_88_0 = arg_88_0.controller

				var_2.DestoryTarget(var_88_0, arg_88_0)
			end

			return
		end

		return var_84_0
	end,
	TargetBlackHole = function()
		class = var_1_10000

		local var_89_0 = var_1_10000("TargetBlackHole", var_0_0.TargetEffect)

		function var_89_0.InTimeLine(arg_90_0)
			return true
		end

		function var_89_0.GetBaseOrder(arg_91_0)
			return 3
		end

		function var_89_0.InitUI(arg_92_0, arg_92_1)
			var_89_0.super.InitUI(arg_92_0, arg_92_1)

			arg_92_0.time = arg_92_1.time

			return
		end

		function var_89_0.OnTimerUpdate(arg_93_0, arg_93_1)
			if arg_93_0.isLost then
				return
			end

			local var_93_0 = arg_93_0.controller

			var_2.OnlyBreakIce(var_93_0, arg_93_0.pos)

			if arg_93_1 < arg_93_0.time then
				arg_93_0.time = arg_93_0.time - arg_93_1
			else
				arg_93_0.isLost = true

				arg_93_0:PlayAnim("BlackHole_3_Despawn")
			end

			return
		end

		function var_89_0.BeTrigger(arg_94_0)
			if arg_94_0.isLost then
				return
			else
				arg_94_0.isLost = true

				arg_94_0:PlayAnim("BlackHole_3_Despawn")
			end

			return
		end

		return var_89_0
	end,
	TargetSubEffect = function()
		class = var_1_10000

		local var_95_0 = var_1_10000("TargetSubEffect", var_0_0.TargetObject)

		function var_95_0.Init(arg_96_0, arg_96_1)
			arg_96_0.name = arg_96_1.name

			arg_96_0:InitUI(arg_96_1)

			return
		end

		function var_95_0.InitUI(arg_97_0, arg_97_1)
			local var_97_0 = arg_97_0._tf

			arg_97_0.mainTarget = var_2.Find(var_97_0, "scale/Image")

			local var_97_1 = arg_97_0.mainTarget
			local var_97_2 = var_2.GetComponent

			typeof = var_4
			DftAniEvent = var_2_10005

			local var_97_3 = var_97_2(var_97_1, var_4(var_2_10005))

			var_2.SetEndEvent(var_97_3, function()
				Destroy = var_3_10000

				var_3_10000(arg_97_0._tf)

				return
			end)

			return
		end

		return var_95_0
	end,
	TargetRushEffect = function()
		class = var_1_10000

		local var_99_0 = var_1_10000("TargetRushEffect", var_0_0.TargetSubEffect)

		function var_99_0.InTimeLine(arg_100_0)
			return true
		end

		function var_99_0.InitUI(arg_101_0, arg_101_1)
			local var_101_0 = arg_101_0._tf

			arg_101_0.rtScale = var_2.Find(var_101_0, "scale")
			GetOrAddComponent = var_2

			local var_101_1 = arg_101_0.rtScale

			typeof = var_4
			CanvasGroup = var_2_10005

			var_2(var_101_1, var_4(var_2_10005))

			arg_101_0.alpha = 0
			setCanvasGroupAlpha = var_2

			var_2(arg_101_0.rtScale, arg_101_0.alpha)

			return
		end

		local var_99_1 = 0.01

		function var_99_0.OnTimerUpdate(arg_102_0, arg_102_1)
			if arg_102_0.inRemove then
				arg_102_0.alpha = arg_102_0.alpha - arg_102_1 / var_99_1

				if arg_102_0.alpha <= 0 then
					table = var_2

					var_2.removebyvalue(arg_102_0.controller.timeFlow, arg_102_0)

					Destroy = var_2

					var_2(arg_102_0._tf)
				end
			elseif arg_102_0.alpha < 1 then
				math = var_2
				arg_102_0.alpha = var_2.max(1, arg_102_0.alpha + arg_102_1 / var_99_1)
				setCanvasGroupAlpha = var_2

				var_2(arg_102_0.rtScale, arg_102_0.alpha)
			end

			return
		end

		function var_99_0.Remove(arg_103_0)
			arg_103_0.inRemove = true

			return
		end

		return var_99_0
	end
}

ipairs = var_2

for iter_0_0, iter_0_1 in var_2({
	"TargetObject",
	"TargetIce",
	"TargetMove",
	"TargetFuShun",
	"TargetNenjuu",
	"TargetEffect",
	"TargetBomb",
	"TargetTimeEffect",
	"TargetBlackHole",
	"TargetSubEffect",
	"TargetItem",
	"TargetRushEffect",
	"TargetArbor"
}) do
	var_0_0[iter_0_1] = var_0_1[iter_0_1]()
end

return var_0_0
