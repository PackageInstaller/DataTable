local var_0_0 = {}

for iter_0_0, iter_0_1 in ipairs({
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
	({})[iter_0_1] = ({
		TargetObject = function()
			local var_1_0 = class("TargetObject")

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
				arg_8_0.size = arg_8_1.size or NewPos(1, 1)
				arg_8_0.canHide = arg_8_1.hide

				SetCanvasOverrideSorting(arg_8_0._tf, true)
				arg_8_0:UpdatePos(arg_8_1.pos - NewPos(0, arg_8_0:GetSize().y - 1))

				arg_8_0.realPos = arg_8_1.realPos or arg_8_0.pos

				arg_8_0:UpdatePosition()
				arg_8_0:InitUI(arg_8_1)

				return
			end

			function var_1_0.InitUI(arg_9_0, arg_9_1)
				return
			end

			function var_1_0.UpdatePos(arg_10_0, arg_10_1)
				arg_10_0._tf:GetComponent(typeof(Canvas)).sortingOrder = (arg_10_1.y + arg_10_0:GetSize().y) * 10 + arg_10_0:GetBaseOrder()

				arg_10_0.controller:UpdateTargetPos(arg_10_0, arg_10_0.pos, arg_10_1)

				arg_10_0.pos = arg_10_1

				return
			end

			function var_1_0.UpdatePosition(arg_11_0)
				setAnchoredPosition(arg_11_0._tf, {
					x = arg_11_0.realPos.x * 32,
					y = arg_11_0.realPos.y * -32
				})

				return
			end

			function var_1_0.PlayAnim(arg_12_0, arg_12_1)
				if arg_12_0.status ~= arg_12_1 then
					arg_12_0.status = arg_12_1

					arg_12_0.mainTarget:GetComponent(typeof(Animator)):Play(arg_12_1, -1, 0)
				end

				return
			end

			return var_1_0
		end,
		TargetIce = function()
			local var_13_0 = class("TargetIce", var_0_0.TargetObject)

			function var_13_0.BreakMoveable(arg_14_0)
				return true
			end

			function var_13_0.InitUI(arg_15_0, arg_15_1)
				arg_15_0.mainTarget = arg_15_0._tf:Find("scale/Image")

				arg_15_0.mainTarget:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
					arg_15_0.controller:DestoryTarget(arg_15_0)

					return
				end)

				if arg_15_1.create then
					if arg_15_0.controller:CheckMelt(arg_15_0.pos) then
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
			local var_18_0 = class("TargetItem", var_0_0.TargetObject)

			function var_18_0.Moveable(arg_19_0)
				return true
			end

			function var_18_0.GetBaseOrder(arg_20_0)
				return 2
			end

			function var_18_0.InitUI(arg_21_0, arg_21_1)
				arg_21_0.point = arg_21_1.point

				eachChild(arg_21_0._tf:Find("scale/type"), function(arg_22_0)
					setActive(arg_22_0, arg_22_0.name == arg_21_0.name)

					return
				end)

				return
			end

			return var_18_0
		end,
		TargetArbor = function()
			local var_23_0 = class("TargetArbor", var_0_0.TargetObject)

			function var_23_0.InitUI(arg_24_0, arg_24_1)
				local var_24_0 = string.split(arg_24_0.name, "_")

				eachChild(arg_24_0._tf:Find("scale/Image"), function(arg_25_0)
					setActive(arg_25_0, arg_25_0.name == var_24_0[#var_24_0])

					return
				end)

				return
			end

			return var_23_0
		end,
		TargetMove = function()
			local var_26_0 = class("TargetMove", var_0_0.TargetObject)

			function var_26_0.InTimeLine(arg_27_0)
				return true
			end

			function var_26_0.GetBaseOrder(arg_28_0)
				return 4
			end

			function var_26_0.InitUI(arg_29_0, arg_29_1)
				arg_29_0.rtScale = arg_29_0._tf:Find("scale")
				arg_29_0.mainTarget = arg_29_0.rtScale:Find("main")

				local var_29_0 = arg_29_0.mainTarget:GetComponent(typeof(DftAniEvent))

				var_29_0:SetStartEvent(function()
					arg_29_0:EventAnim("start")

					return
				end)
				var_29_0:SetTriggerEvent(function()
					arg_29_0:EventAnim("trigger")

					return
				end)
				var_29_0:SetEndEvent(function()
					arg_29_0.inLock = false

					arg_29_0:EventAnim("end")

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
				arg_35_0:PlayAnim(string.format("Idle_%s%s", arg_35_1 or arg_35_0:GetDirMark(), arg_35_0.inLantern and "_Lantern" or ""))

				return
			end

			function var_26_0.PlayMove(arg_36_0, arg_36_1)
				arg_36_0:PlayAnim(string.format("Move_%s%s", arg_36_1 or arg_36_0:GetDirMark(), arg_36_0.inLantern and "_Lantern" or ""))

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
					for iter_37_0, iter_37_1 in pairs(var_26_1) do
						if iter_37_1[1] == arg_37_1.x and iter_37_1[2] == arg_37_1.y then
							return iter_37_0
						end
					end
				else
					local var_37_0 = string.split(arg_37_0.status, "_")[2]

					return var_26_1[var_37_0] and var_37_0 or "S"
				end

				return
			end

			function var_26_0.GetDirPos(arg_38_0, arg_38_1)
				return NewPos(unpack(var_26_1[arg_38_1 or arg_38_0:GetDirMark()]))
			end

			function var_26_0.GetStatusMark(arg_39_0, arg_39_1)
				return string.split(arg_39_1 or arg_39_0.status, "_")[1]
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
				local var_41_0 = tobool(arg_41_0.loopAnimDic[arg_41_0:GetStatusMark(arg_41_1)])

				if var_41_0 and arg_41_0.status == arg_41_1 then
					-- block empty
				else
					arg_41_0.inLock = not var_41_0
					arg_41_0.status = arg_41_1

					arg_41_0.mainTarget:GetComponent(typeof(Animator)):Play(arg_41_1, -1, 0)
					arg_41_0:RushCheck()
				end

				return
			end

			return var_26_0
		end,
		TargetFuShun = function()
			local var_42_0 = class("TargetFuShun", var_0_0.TargetMove)

			function var_42_0.GetSpeed(arg_43_0)
				local var_43_0 = arg_43_0.inRush and NenjuuGameConfig.GetSkillParam("rush", arg_43_0.level.rush)[2] or 1
				local var_43_1 = arg_43_0.speed * (arg_43_0.controller:GetEnemyEffect("gravity") and 0.85 or 1) * var_43_0
				local var_43_2 = NenjuuGameConfig.GetSkillParam("blessing", arg_43_0.level.blessing) or 1

				return var_43_1 * (arg_43_0.controller:InBlackHoleRange(arg_43_0.pos) and 0.75 or 1) * var_43_2
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
					return arg_44_0.itemType and arg_44_0.itemCount > 0
				else
					return arg_44_0.level[arg_44_1] > 0 and arg_44_0.skillCDs[arg_44_1] <= 0
				end

				return
			end

			function var_42_0.ReloadSkill(arg_45_0, arg_45_1)
				local var_45_0 = arg_45_1 == "flash" and NenjuuGameConfig.GetSkillParam("flash", arg_45_0.level.flash) or var_42_4[arg_45_1]

				arg_45_0.skillCDs[arg_45_1] = var_45_0 * (arg_45_0.controller:GetEnemyEffect("delay") and 1.2 or 1)

				return
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
				arg_46_0.icePower = NenjuuGameConfig.GetSkillParam("ice", arg_46_0.level.ice)
				arg_46_0.flashPower = 4
				arg_46_0.decoyCount = arg_46_0.level.decoy
				arg_46_0.rushTime = checkExist(NenjuuGameConfig.GetSkillParam("rush", arg_46_0.level.rush), {
					1
				})
				arg_46_0.itemCount = 1

				return
			end

			function var_42_0.CalcSkillCDs(arg_47_0)
				for iter_47_0, iter_47_1 in ipairs({
					"ice",
					"flash",
					"rush",
					"item"
				}) do
					local var_47_0 = arg_47_0.skillCDs[iter_47_1]
					local var_47_1 = iter_47_1 == "flash" and NenjuuGameConfig.GetSkillParam("flash", arg_47_0.level.flash) or var_42_4[iter_47_1]
					local var_47_2 = var_47_1 * (arg_47_0.controller:GetEnemyEffect("delay") and 1.2 or 1)

					if iter_47_1 == "item" then
						if not arg_47_0.itemType then
							table.insert({}, {})
						elseif arg_47_0.itemCount > 0 then
							table.insert({}, {
								cd = var_47_0,
								icon = arg_47_0.itemType
							})
						else
							table.insert({}, {
								cd = true,
								icon = arg_47_0.itemType
							})
						end
					elseif arg_47_0.level[iter_47_1] > 0 then
						table.insert({}, {
							cd = var_47_0,
							rate = var_47_2 == 0 and 0 or var_47_0 / var_47_2,
							icon = iter_47_1 == "ice" and arg_47_0.controller:CheckIce(arg_47_0.pos + arg_47_0:GetDirPos()) and "attack" or iter_47_1
						})
					else
						table.insert({}, {})
					end
				end

				return {}
			end

			function var_42_0.EventAnim(arg_48_0, arg_48_1)
				local var_48_0 = arg_48_0:GetDirMark()

				if arg_48_1 == "start" then
					-- block empty
				elseif arg_48_1 == "trigger" then
					switch(arg_48_0.status, {
						["Freeze_" .. var_48_0 .. "_3_Shot"] = function()
							arg_48_0.controller:CreateTarget({
								name = "EF_bk_Freeze",
								parent = arg_48_0.rtScale:Find("bk")
							})
							arg_48_0.controller:BuildIce({
								pos = arg_48_0.pos,
								dirPos = arg_48_0:GetDirPos(),
								power = arg_48_0.icePower
							})

							return
						end,
						["Attack_" .. var_48_0] = function()
							switch(var_48_0, {
								N = function()
									arg_48_0.controller:CreateTarget({
										name = "EF_Attack_Hit_" .. var_48_0,
										parent = arg_48_0.rtScale:Find("bk")
									})

									return
								end,
								S = function()
									arg_48_0.controller:CreateTarget({
										name = "EF_Attack_Hit_" .. var_48_0,
										parent = arg_48_0.rtScale:Find("fr")
									})

									return
								end
							}, function()
								arg_48_0.controller:CreateTarget({
									name = "EF_Attack_Hit_" .. var_48_0 .. "_fr",
									parent = arg_48_0.rtScale:Find("fr")
								})
								arg_48_0.controller:CreateTarget({
									name = "EF_Attack_Hit_" .. var_48_0 .. "_bk",
									parent = arg_48_0.rtScale:Find("bk")
								})

								return
							end)
							arg_48_0.controller:BreakIce({
								pos = arg_48_0.pos,
								dir = arg_48_0:GetDirMark(),
								dirPos = arg_48_0:GetDirPos()
							})

							return
						end,
						Lantern_Activate = function()
							arg_48_0:ReloadSkill("item")

							arg_48_0.itemCount = arg_48_0.itemCount - 1
							arg_48_0.inLantern = var_42_3
							arg_48_0.effectLantern = arg_48_0.controller:CreateTarget({
								name = "EF_bk_overlay_Lantern",
								parent = arg_48_0.rtScale:Find("bk"),
								time = var_42_3
							})

							return
						end
					})
				elseif arg_48_1 == "end" then
					switch(arg_48_0.status, {
						["Bomb_" .. var_48_0 .. "_1_Start"] = function()
							arg_48_0:ReloadSkill("item")

							arg_48_0.itemCount = arg_48_0.itemCount - 1

							arg_48_0:PlayAnim("Bomb_" .. var_48_0 .. "_3_End")
							arg_48_0.controller:BuildBomb({
								pos = arg_48_0.pos,
								dir = var_48_0
							})

							return
						end,
						Dead = function()
							if arg_48_0.isDead then
								arg_48_0.controller:EndGame()
							end

							return
						end
					})
				else
					assert(false)
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
					for iter_57_0, iter_57_1 in ipairs(arg_57_0.rushEffects) do
						iter_57_1:Remove()
					end

					arg_57_0.rushEffects = nil
				end

				if arg_57_0.inRush and arg_57_0.loopAnimDic[arg_57_0:GetStatusMark(arg_57_0.status)] then
					arg_57_0.rushEffects = {}

					for iter_57_2, iter_57_3 in ipairs(var_42_5[arg_57_0:GetDirMark()]) do
						local var_57_0 = string.split(iter_57_3, "_")

						;({
							name = iter_57_3
						}).parent = arg_57_0.rtScale:Find(var_57_0[#var_57_0])

						table.insert(arg_57_0.rushEffects, arg_57_0.controller:CreateTarget({
							name = iter_57_3
						}))
					end
				end

				return
			end

			function var_42_0.OnTimerUpdate(arg_58_0, arg_58_1)
				for iter_58_0, iter_58_1 in pairs(arg_58_0.skillCDs) do
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

						arg_58_0:PlayAnim(string.format("Freeze_%s_3_Shot", arg_58_0:GetDirMark()))
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
				elseif arg_58_0.controller:InBlackHoleRange(arg_58_0.pos, true) then
					arg_58_0.inShock = 1

					arg_58_0:PlayAnim("Dead")
				elseif arg_58_0.inLantern and arg_58_0.inLantern <= 0 then
					arg_58_0.inLantern = nil

					arg_58_0.effectLantern:PlayAnim("EF_bk_overlay_Lantern_Finish")

					arg_58_0.effectLantern = nil
				elseif arg_58_0:CheckSkill("ice") and arg_58_0.controller:GetPressInput("Skill_0") then
					arg_58_0:ReloadSkill("ice")

					if arg_58_0.controller:CheckIce(arg_58_0.pos + arg_58_0:GetDirPos()) then
						arg_58_0:PlayAnim(string.format("Attack_%s", arg_58_0:GetDirMark()))
					else
						arg_58_0.inCharge = 0

						arg_58_0:PlayAnim(string.format("Freeze_%s_1_Start", arg_58_0:GetDirMark()))
					end
				elseif arg_58_0:CheckSkill("flash") and arg_58_0.controller:GetPressInput("Skill_1") then
					arg_58_0:ReloadSkill("flash")

					local var_58_0 = arg_58_0:GetDirPos()

					for iter_58_2 = arg_58_0.flashPower, 0, -1 do
						if arg_58_0.controller:Moveable(arg_58_0.pos + var_58_0 * iter_58_2) then
							arg_58_0.controller:CreateTarget({
								name = "EF_bk_Flash_Jump",
								pos = arg_58_0.pos
							})
							arg_58_0:UpdatePos(arg_58_0.pos + var_58_0 * iter_58_2)

							arg_58_0.realPos = arg_58_0.pos

							arg_58_0:UpdatePosition()
							arg_58_0.controller:CreateTarget({
								name = "EF_bk_Flash_Land",
								parent = arg_58_0.rtScale:Find("bk")
							})
							arg_58_0:PlayAnim(string.format("Flash_%s", arg_58_0:GetDirMark()))

							break
						end
					end
				elseif arg_58_0:CheckSkill("rush") and arg_58_0.controller:GetPressInput("Skill_2") then
					arg_58_0:ReloadSkill("rush")

					arg_58_0.inRush = arg_58_0.rushTime

					arg_58_0:RushCheck()
				elseif arg_58_0.itemType and arg_58_0:CheckSkill("item") and arg_58_0.controller:GetPressInput("Skill_3") and (arg_58_0.itemType ~= "lantern" or not arg_58_0.inLantern) then
					if arg_58_0.itemType == "lantern" then
						arg_58_0:PlayAnim("Lantern_Activate")
					elseif arg_58_0.itemType == "bomb" then
						arg_58_0:PlayAnim(string.format("Bomb_%s_1_Start", arg_58_0:GetDirMark()))
					else
						assert(false)
					end
				else
					local var_58_1 = arg_58_0.controller:GetCacheInput()

					if not var_58_1 then
						arg_58_0.idleTime = defaultValue(arg_58_0.idleTime, 0) - arg_58_1

						arg_58_0:PlayIdle()
					elseif arg_58_0:GetStatusMark() == "Move" then
						if arg_58_0.controller:Moveable(arg_58_0.pos + arg_58_0:GetDirPos(var_58_1)) then
							arg_58_0.inMove = 1

							arg_58_0:UpdatePos(arg_58_0.pos + arg_58_0:GetDirPos(var_58_1))
							arg_58_0:PlayMove(var_58_1)
						else
							arg_58_0:PlayIdle(var_58_1)
						end
					elseif var_58_1 == arg_58_0:GetDirMark() then
						if defaultValue(arg_58_0.idleTime, 0) <= 0 and arg_58_0.controller:Moveable(arg_58_0.pos + arg_58_0:GetDirPos()) then
							arg_58_0.inMove = 1

							arg_58_0:UpdatePos(arg_58_0.pos + arg_58_0:GetDirPos())
							arg_58_0:PlayMove()
						else
							arg_58_0.idleTime = defaultValue(arg_58_0.idleTime, 0) - arg_58_1

							arg_58_0:PlayIdle()
						end
					else
						arg_58_0.idleTime = var_42_1

						arg_58_0:PlayIdle(var_58_1)
					end
				end

				return
			end

			function var_42_0.PopPoint(arg_59_0, arg_59_1)
				local var_59_0 = arg_59_0._tf:Find("top/pop")

				setText(var_59_0:Find("Text"), "+" .. arg_59_1)
				setActive(var_59_0, false)
				setActive(var_59_0, true)

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

					arg_60_0.controller:BuildDecoy(arg_60_0.pos)
					arg_60_0:UpdatePos((arg_60_0.controller:GetDecoyPos(arg_60_0.pos, arg_60_1)))

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
				arg_61_0.controller:WindowFocrus(arg_61_0._tf.localPosition)

				if arg_61_0.realPos == arg_61_0.pos then
					arg_61_0.controller:EatItem(arg_61_0.pos)
				end

				return
			end

			return var_42_0
		end,
		TargetNenjuu = function()
			local var_62_0 = class("TargetNenjuu", var_0_0.TargetMove)

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
				return arg_64_0.featuresAbility[arg_64_1] and arg_64_0.abilityCDs[arg_64_1] <= 0
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

				for iter_66_0, iter_66_1 in ipairs(NenjuuGameConfig.ABILITY_LIST) do
					arg_66_0.featuresAbility[iter_66_1] = tobool(arg_66_1.abilitys[iter_66_1])
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
				local var_67_0 = arg_67_0:GetDirMark()

				if arg_67_1 == "start" then
					-- block empty
				elseif arg_67_1 == "trigger" then
					switch(arg_67_0.status, {
						["Attack_" .. arg_67_0:GetDirMark()] = function()
							arg_67_0.controller:CreateTarget({
								name = "EF_Attack_" .. var_67_0,
								parent = arg_67_0.rtScale:Find(var_67_0 == "N" and "bk" or "fr")
							})

							if not arg_67_0.isDoppel then
								arg_67_0.controller:BreakIce({
									pos = arg_67_0.pos,
									dir = arg_67_0:GetDirMark(),
									dirPos = arg_67_0:GetDirPos(),
									power = arg_67_0:CheckAbility("breakpassable") and 3 or 1
								})
							end

							arg_67_0.controller:EnemyAttack({
								pos = arg_67_0.pos,
								dirPos = arg_67_0:GetDirPos()
							})

							return
						end
					})
				elseif arg_67_1 == "end" then
					switch(arg_67_0.status, {
						Warp_1_Jump = function()
							arg_67_0:UpdatePos(arg_67_0.telePos)

							arg_67_0.realPos = arg_67_0.pos

							arg_67_0:UpdatePosition()

							arg_67_0.telePos = nil

							arg_67_0:PlayAnim("Warp_2_Land")
							arg_67_0.controller:OnlyBreakIce(arg_67_0.pos)

							return
						end
					})
				else
					assert(false)
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
					for iter_70_0, iter_70_1 in ipairs(arg_70_0.rushEffects) do
						iter_70_1:Remove()
					end

					arg_70_0.rushEffects = nil
				end

				if arg_70_0.inStealth and arg_70_0.loopAnimDic[arg_70_0:GetStatusMark(arg_70_0.status)] then
					arg_70_0.rushEffects = {}

					for iter_70_2, iter_70_3 in ipairs(var_62_6[arg_70_0:GetDirMark()]) do
						local var_70_0 = string.split(iter_70_3, "_")

						;({
							name = iter_70_3
						}).parent = arg_70_0.rtScale:Find(var_70_0[#var_70_0])

						table.insert(arg_70_0.rushEffects, arg_70_0.controller:CreateTarget({
							name = iter_70_3
						}))
					end
				end

				return
			end

			function var_62_0.OnTimerUpdate(arg_71_0, arg_71_1)
				for iter_71_0, iter_71_1 in pairs(arg_71_0.featuresAbility) do
					if iter_71_1 and var_62_5[iter_71_0] > 0 then
						arg_71_0.abilityCDs[iter_71_0] = arg_71_0.abilityCDs[iter_71_0] - arg_71_1
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

					arg_71_0.controller:BuildDoppelgangers(arg_71_0.pos)
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
						arg_71_0.controller:BuildBlackHole()
					end

					if arg_71_0:CheckAbility("stealth") and arg_71_0.controller:StealthCheck(arg_71_0.pos) and not arg_71_0.inScare then
						arg_71_0:ReloadAbility("stealth")

						arg_71_0.inStealth = var_62_2

						arg_71_0:RushCheck()
					end

					if arg_71_0:CheckAbility("attack") and not arg_71_0.inScare then
						for iter_71_2, iter_71_3 in ipairs({
							"E",
							"S",
							"W",
							"N"
						}) do
							if arg_71_0.controller:AttackCheck({
								pos = arg_71_0.pos,
								dirPos = arg_71_0:GetDirPos(iter_71_3)
							}) then
								arg_71_0:DoAttack(iter_71_3)

								return
							end
						end
					end

					local var_71_0 = arg_71_0.controller:GetWayfindingMap(arg_71_0.pos, tobool(arg_71_0.isDoppel))
					local var_71_1 = arg_71_0.pos

					for iter_71_4, iter_71_5 in ipairs({
						"E",
						"S",
						"W",
						"N"
					}) do
						local var_71_2 = var_71_0[tostring(arg_71_0.pos + arg_71_0:GetDirPos(iter_71_5))]

						if var_71_2 then
							local var_71_3 = var_71_0[tostring(var_71_1)]

							if arg_71_0.inScare then
								if not var_71_3 or var_71_3.value < var_71_2.value then
									var_71_1 = arg_71_0.pos + arg_71_0:GetDirPos(iter_71_5)
								end

								goto label_71_0
							end

							::label_71_0::

							if var_71_3 then
								do
									local var_71_4 = var_71_3.lightValue or var_71_3.value
									local var_71_5 = var_71_2.lightValue or var_71_2.value

									if var_71_5 < var_71_4 then
										var_71_1 = arg_71_0.pos + arg_71_0:GetDirPos(iter_71_5)
									end
								end
							end
						end
					end

					if arg_71_0:CheckAbility("teleport") and not arg_71_0.inScare then
						if var_71_1 == arg_71_0.pos then
							if not arg_71_0.lostTime then
								arg_71_0.lostTime = 3 - arg_71_1
							elseif arg_71_1 >= arg_71_0.lostTime and arg_71_0.controller.timeCount > 5 then
								arg_71_0.lostTime = nil

								arg_71_0:DoTeleport(var_71_0)
							else
								arg_71_0.lostTime = arg_71_0.lostTime - arg_71_1
							end

							arg_71_0:PlayIdle()

							return
						else
							arg_71_0.lostTime = nil

							if var_71_0[tostring(var_71_1)] and var_71_0[tostring(var_71_1)].value > var_62_4 then
								arg_71_0:DoTeleport(var_71_0)
								arg_71_0:PlayIdle()

								return
							end
						end
					end

					if not arg_71_0.isDoppel and arg_71_0:CheckAbility("attack") and arg_71_0.controller:CheckIce(var_71_1) then
						arg_71_0:DoAttack(arg_71_0:GetDirMark(var_71_1 - arg_71_0.pos))
					elseif arg_71_0.controller:Moveable(var_71_1) then
						local var_71_6 = arg_71_0:GetDirMark(var_71_1 - arg_71_0.pos)

						arg_71_0.inMove = 1

						arg_71_0:UpdatePos(var_71_1)

						if arg_71_0.inScare then
							arg_71_0:PlayAnim("Fear_" .. var_71_6)
						else
							arg_71_0:PlayMove(var_71_6)
						end
					elseif arg_71_0.inScare then
						arg_71_0:PlayAnim("Fear_" .. arg_71_0:GetDirMark())
					else
						arg_71_0:PlayIdle()
					end
				end

				return
			end

			function var_62_0.DoAttack(arg_72_0, arg_72_1)
				if arg_72_0.inStealth then
					arg_72_0.inStealth = nil
				end

				arg_72_0:ReloadAbility("attack")
				arg_72_0:PlayAnim(string.format("Attack_%s", arg_72_1))

				return
			end

			function var_62_0.DoTeleport(arg_73_0, arg_73_1)
				if arg_73_0.inStealth then
					arg_73_0.inStealth = nil
				end

				arg_73_0:ReloadAbility("teleport")

				arg_73_0.inCharge = 0
				arg_73_0.telePos = arg_73_0.controller:GetTeleportTargetPos(arg_73_1, arg_73_0.pos)

				arg_73_0.controller:BuildTeleportSign({
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
			local var_75_0 = class("TargetEffect", var_0_0.TargetObject)

			function var_75_0.Moveable(arg_76_0)
				return true
			end

			function var_75_0.GetBaseOrder(arg_77_0)
				return 5
			end

			function var_75_0.InitUI(arg_78_0, arg_78_1)
				arg_78_0.mainTarget = arg_78_0._tf:Find("scale/Image")

				arg_78_0.mainTarget:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
					arg_78_0.controller:DestoryTarget(arg_78_0)

					return
				end)

				return
			end

			return var_75_0
		end,
		TargetBomb = function()
			local var_80_0 = class("TargetBomb", var_0_0.TargetEffect)

			function var_80_0.InTimeLine(arg_81_0)
				return true
			end

			function var_80_0.GetBaseOrder(arg_82_0)
				return 1
			end

			function var_80_0.OnTimerUpdate(arg_83_0, arg_83_1)
				arg_83_0.controller:ScareEnemy({
					range = 1,
					pos = arg_83_0.pos
				})

				return
			end

			return var_80_0
		end,
		TargetTimeEffect = function()
			local var_84_0 = class("TargetTimeEffect", var_0_0.TargetEffect)

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
					arg_88_0.controller:DestoryTarget(arg_88_0)
				end

				return
			end

			return var_84_0
		end,
		TargetBlackHole = function()
			local var_89_0 = class("TargetBlackHole", var_0_0.TargetEffect)

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

				arg_93_0.controller:OnlyBreakIce(arg_93_0.pos)

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
			local var_95_0 = class("TargetSubEffect", var_0_0.TargetObject)

			function var_95_0.Init(arg_96_0, arg_96_1)
				arg_96_0.name = arg_96_1.name

				arg_96_0:InitUI(arg_96_1)

				return
			end

			function var_95_0.InitUI(arg_97_0, arg_97_1)
				arg_97_0.mainTarget = arg_97_0._tf:Find("scale/Image")

				arg_97_0.mainTarget:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
					Destroy(arg_97_0._tf)

					return
				end)

				return
			end

			return var_95_0
		end,
		TargetRushEffect = function()
			local var_99_0 = class("TargetRushEffect", var_0_0.TargetSubEffect)

			function var_99_0.InTimeLine(arg_100_0)
				return true
			end

			function var_99_0.InitUI(arg_101_0, arg_101_1)
				arg_101_0.rtScale = arg_101_0._tf:Find("scale")

				GetOrAddComponent(arg_101_0.rtScale, typeof(CanvasGroup))

				arg_101_0.alpha = 0

				setCanvasGroupAlpha(arg_101_0.rtScale, arg_101_0.alpha)

				return
			end

			local var_99_1 = 0.01

			function var_99_0.OnTimerUpdate(arg_102_0, arg_102_1)
				if arg_102_0.inRemove then
					arg_102_0.alpha = arg_102_0.alpha - arg_102_1 / var_99_1

					if arg_102_0.alpha <= 0 then
						table.removebyvalue(arg_102_0.controller.timeFlow, arg_102_0)
						Destroy(arg_102_0._tf)
					end
				elseif arg_102_0.alpha < 1 then
					arg_102_0.alpha = math.max(1, arg_102_0.alpha + arg_102_1 / var_99_1)

					setCanvasGroupAlpha(arg_102_0.rtScale, arg_102_0.alpha)
				end

				return
			end

			function var_99_0.Remove(arg_103_0)
				arg_103_0.inRemove = true

				return
			end

			return var_99_0
		end
	})[iter_0_1]()
end

return {}
