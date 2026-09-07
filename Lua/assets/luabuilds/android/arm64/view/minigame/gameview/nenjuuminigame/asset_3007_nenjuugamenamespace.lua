local var_0_0 = {}
local var_0_1 = {
	TargetObject = function()
		local TargetObject = class("TargetObject")

		function TargetObject:GetSize()
			return self.size
		end

		function TargetObject:InTimeLine()
			return false
		end

		function TargetObject:Moveable()
			return false
		end

		function TargetObject:BreakMoveable()
			return false
		end

		function TargetObject:GetBaseOrder()
			return 3
		end

		function TargetObject:Ctor(arg_7_1, arg_7_2, arg_7_3)
			self._tf = arg_7_2
			self.controller = arg_7_1

			self:Init(arg_7_3)

			return
		end

		function TargetObject:Init(arg_8_1)
			self.name = arg_8_1.name
			self.size = arg_8_1.size or NewPos(1, 1)
			self.canHide = arg_8_1.hide

			SetCanvasOverrideSorting(self._tf, true)
			self:UpdatePos(arg_8_1.pos - NewPos(0, self:GetSize().y - 1))

			self.realPos = arg_8_1.realPos or self.pos

			self:UpdatePosition()
			self:InitUI(arg_8_1)

			return
		end

		function TargetObject:InitUI(arg_9_1)
			return
		end

		function TargetObject:UpdatePos(arg_10_1)
			self._tf:GetComponent(typeof(Canvas)).sortingOrder = (arg_10_1.y + self:GetSize().y) * 10 + self:GetBaseOrder()

			self.controller:UpdateTargetPos(self, self.pos, arg_10_1)

			self.pos = arg_10_1

			return
		end

		function TargetObject:UpdatePosition()
			setAnchoredPosition(self._tf, {
				x = self.realPos.x * 32,
				y = self.realPos.y * -32
			})

			return
		end

		function TargetObject:PlayAnim(arg_12_1)
			if self.status ~= arg_12_1 then
				self.status = arg_12_1

				self.mainTarget:GetComponent(typeof(Animator)):Play(arg_12_1, -1, 0)
			end

			return
		end

		return TargetObject
	end,
	TargetIce = function()
		local TargetIce = class("TargetIce", var_0_0.TargetObject)

		function TargetIce:BreakMoveable()
			return true
		end

		function TargetIce:InitUI(arg_15_1)
			self.mainTarget = self._tf:Find("scale/Image")

			self.mainTarget:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
				self.controller:DestoryTarget(self)

				return
			end)

			if arg_15_1.create then
				if self.controller:CheckMelt(self.pos) then
					self.isLost = true

					self:PlayAnim("Ice_Spawn_Melt")
				else
					self:PlayAnim("Ice_Spawn")
				end
			end

			return
		end

		function TargetIce:Break()
			if self.isLost then
				return
			else
				self.isLost = true

				self:PlayAnim("Ice_Break")
			end

			return
		end

		return TargetIce
	end,
	TargetItem = function()
		local TargetItem = class("TargetItem", var_0_0.TargetObject)

		function TargetItem:Moveable()
			return true
		end

		function TargetItem:GetBaseOrder()
			return 2
		end

		function TargetItem:InitUI(arg_21_1)
			self.point = arg_21_1.point

			eachChild(self._tf:Find("scale/type"), function(arg_22_0)
				setActive(arg_22_0, arg_22_0.name == self.name)

				return
			end)

			return
		end

		return TargetItem
	end,
	TargetArbor = function()
		local TargetArbor = class("TargetArbor", var_0_0.TargetObject)

		function TargetArbor:InitUI(arg_24_1)
			local var_24_0 = string.split(self.name, "_")

			eachChild(self._tf:Find("scale/Image"), function(arg_25_0)
				setActive(arg_25_0, arg_25_0.name == var_24_0[#var_24_0])

				return
			end)

			return
		end

		return TargetArbor
	end,
	TargetMove = function()
		local TargetMove = class("TargetMove", var_0_0.TargetObject)

		function TargetMove:InTimeLine()
			return true
		end

		function TargetMove:GetBaseOrder()
			return 4
		end

		function TargetMove:InitUI(arg_29_1)
			self.rtScale = self._tf:Find("scale")
			self.mainTarget = self.rtScale:Find("main")

			local var_29_0 = self.mainTarget:GetComponent(typeof(DftAniEvent))

			var_29_0:SetStartEvent(function()
				self:EventAnim("start")

				return
			end)
			var_29_0:SetTriggerEvent(function()
				self:EventAnim("trigger")

				return
			end)
			var_29_0:SetEndEvent(function()
				self.inLock = false

				self:EventAnim("end")

				return
			end)
			self:PlayIdle()

			return
		end

		function TargetMove:EventAnim(arg_33_1)
			return
		end

		function TargetMove:RushCheck()
			return
		end

		function TargetMove:PlayIdle(arg_35_1)
			self:PlayAnim(string.format("Idle_%s%s", arg_35_1 or self:GetDirMark(), self.inLantern and "_Lantern" or ""))

			return
		end

		function TargetMove:PlayMove(arg_36_1)
			self:PlayAnim(string.format("Move_%s%s", arg_36_1 or self:GetDirMark(), self.inLantern and "_Lantern" or ""))

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

		function TargetMove:GetDirMark(arg_37_1)
			if arg_37_1 then
				for iter_37_0, iter_37_1 in pairs(var_26_1) do
					if iter_37_1[1] == arg_37_1.x and iter_37_1[2] == arg_37_1.y then
						return iter_37_0
					end
				end
			else
				local var_37_0 = string.split(self.status, "_")[2]

				return var_26_1[var_37_0] and var_37_0 or "S"
			end

			return
		end

		function TargetMove:GetDirPos(arg_38_1)
			return NewPos(unpack(var_26_1[arg_38_1 or self:GetDirMark()]))
		end

		function TargetMove:GetStatusMark(arg_39_1)
			return string.split(arg_39_1 or self.status, "_")[1]
		end

		function TargetMove:OnTimerUpdate(arg_40_1)
			return
		end

		TargetMove.loopAnimDic = {
			Fear = true,
			Idle = true,
			Move = true
		}

		function TargetMove:PlayAnim(arg_41_1)
			local var_41_0 = tobool(self.loopAnimDic[self:GetStatusMark(arg_41_1)])

			if var_41_0 and self.status == arg_41_1 then
				-- block empty
			else
				self.inLock = not var_41_0
				self.status = arg_41_1

				self.mainTarget:GetComponent(typeof(Animator)):Play(arg_41_1, -1, 0)
				self:RushCheck()
			end

			return
		end

		return TargetMove
	end,
	TargetFuShun = function()
		local TargetFuShun = class("TargetFuShun", var_0_0.TargetMove)

		function TargetFuShun:GetSpeed()
			return self.speed * (self.controller:GetEnemyEffect("gravity") and 0.85 or 1) * (self.inRush and NenjuuGameConfig.GetSkillParam("rush", self.level.rush)[2] or 1) * (self.controller:InBlackHoleRange(self.pos) and 0.75 or 1) * (NenjuuGameConfig.GetSkillParam("blessing", self.level.blessing) or 1)
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

		function TargetFuShun:CheckSkill(arg_44_1)
			if arg_44_1 == "item" then
				return self.itemType and self.itemCount > 0
			else
				return self.level[arg_44_1] > 0 and self.skillCDs[arg_44_1] <= 0
			end

			return
		end

		function TargetFuShun:ReloadSkill(arg_45_1)
			self.skillCDs[arg_45_1] = (arg_45_1 == "flash" and NenjuuGameConfig.GetSkillParam("flash", self.level.flash) or var_42_4[arg_45_1]) * (self.controller:GetEnemyEffect("delay") and 1.2 or 1)

			return
		end

		function TargetFuShun:InitUI(arg_46_1)
			TargetFuShun.super.InitUI(self, arg_46_1)

			self.level = arg_46_1.level
			self.skillCDs = {
				rush = 0,
				flash = 0,
				item = 0,
				ice = 0
			}
			self.itemType = arg_46_1.itemType
			self.speed = 4.5
			self.icePower = NenjuuGameConfig.GetSkillParam("ice", self.level.ice)
			self.flashPower = 4
			self.decoyCount = self.level.decoy
			self.rushTime = checkExist(NenjuuGameConfig.GetSkillParam("rush", self.level.rush), {
				1
			})
			self.itemCount = 1

			return
		end

		function TargetFuShun:CalcSkillCDs()
			local var_47_0 = {}

			for iter_47_0, iter_47_1 in ipairs({
				"ice",
				"flash",
				"rush",
				"item"
			}) do
				local var_47_1 = self.skillCDs[iter_47_1]
				local var_47_2 = (iter_47_1 == "flash" and NenjuuGameConfig.GetSkillParam("flash", self.level.flash) or var_42_4[iter_47_1]) * (self.controller:GetEnemyEffect("delay") and 1.2 or 1)

				if iter_47_1 == "item" then
					if not self.itemType then
						table.insert(var_47_0, {})
					elseif self.itemCount > 0 then
						table.insert(var_47_0, {
							cd = var_47_1,
							icon = self.itemType
						})
					else
						table.insert(var_47_0, {
							cd = true,
							icon = self.itemType
						})
					end
				elseif self.level[iter_47_1] > 0 then
					table.insert(var_47_0, {
						cd = var_47_1,
						rate = var_47_2 == 0 and 0 or var_47_1 / var_47_2,
						icon = iter_47_1 == "ice" and self.controller:CheckIce(self.pos + self:GetDirPos()) and "attack" or iter_47_1
					})
				else
					table.insert(var_47_0, {})
				end
			end

			return var_47_0
		end

		function TargetFuShun:EventAnim(arg_48_1)
			local var_48_0 = self:GetDirMark()

			if arg_48_1 == "start" then
				-- block empty
			elseif arg_48_1 == "trigger" then
				switch(self.status, {
					["Freeze_" .. var_48_0 .. "_3_Shot"] = function()
						self.controller:CreateTarget({
							name = "EF_bk_Freeze",
							parent = self.rtScale:Find("bk")
						})
						self.controller:BuildIce({
							pos = self.pos,
							dirPos = self:GetDirPos(),
							power = self.icePower
						})

						return
					end,
					["Attack_" .. var_48_0] = function()
						switch(var_48_0, {
							N = function()
								self.controller:CreateTarget({
									name = "EF_Attack_Hit_" .. var_48_0,
									parent = self.rtScale:Find("bk")
								})

								return
							end,
							S = function()
								self.controller:CreateTarget({
									name = "EF_Attack_Hit_" .. var_48_0,
									parent = self.rtScale:Find("fr")
								})

								return
							end
						}, function()
							self.controller:CreateTarget({
								name = "EF_Attack_Hit_" .. var_48_0 .. "_fr",
								parent = self.rtScale:Find("fr")
							})
							self.controller:CreateTarget({
								name = "EF_Attack_Hit_" .. var_48_0 .. "_bk",
								parent = self.rtScale:Find("bk")
							})

							return
						end)
						self.controller:BreakIce({
							pos = self.pos,
							dir = self:GetDirMark(),
							dirPos = self:GetDirPos()
						})

						return
					end,
					Lantern_Activate = function()
						self:ReloadSkill("item")

						self.itemCount = self.itemCount - 1
						self.inLantern = var_42_3
						self.effectLantern = self.controller:CreateTarget({
							name = "EF_bk_overlay_Lantern",
							parent = self.rtScale:Find("bk"),
							time = var_42_3
						})

						return
					end
				})
			elseif arg_48_1 == "end" then
				switch(self.status, {
					["Bomb_" .. var_48_0 .. "_1_Start"] = function()
						self:ReloadSkill("item")

						self.itemCount = self.itemCount - 1

						self:PlayAnim("Bomb_" .. var_48_0 .. "_3_End")
						self.controller:BuildBomb({
							pos = self.pos,
							dir = var_48_0
						})

						return
					end,
					Dead = function()
						if self.isDead then
							self.controller:EndGame()
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

		function TargetFuShun:RushCheck()
			if self.rushEffects then
				for iter_57_0, iter_57_1 in ipairs(self.rushEffects) do
					iter_57_1:Remove()
				end

				self.rushEffects = nil
			end

			if self.inRush and self.loopAnimDic[self:GetStatusMark(self.status)] then
				self.rushEffects = {}

				for iter_57_2, iter_57_3 in ipairs(var_42_5[self:GetDirMark()]) do
					local var_57_0 = string.split(iter_57_3, "_")
					local var_57_1 = {
						name = iter_57_3
					}

					var_57_1.parent = self.rtScale:Find(var_57_0[#var_57_0])

					table.insert(self.rushEffects, self.controller:CreateTarget(var_57_1))
				end
			end

			return
		end

		function TargetFuShun:OnTimerUpdate(arg_58_1)
			for iter_58_0, iter_58_1 in pairs(self.skillCDs) do
				self.skillCDs[iter_58_0] = iter_58_1 - arg_58_1
			end

			if self.inRush then
				self.inRush = self.inRush - arg_58_1

				if self.inRush <= 0 then
					self.inRush = nil
				end
			end

			if self.inLantern then
				self.inLantern = self.inLantern - arg_58_1
			end

			if self.inShock then
				self.inShock = self.inShock - arg_58_1

				if self.inShock <= 0 then
					self.inShock = nil
				end

				return
			end

			if self.inCharge then
				self.inCharge = self.inCharge + arg_58_1

				if self.inCharge > var_42_2 then
					self.inCharge = nil

					self:PlayAnim(string.format("Freeze_%s_3_Shot", self:GetDirMark()))
				end
			elseif self.inMove then
				self.inMove = self.inMove - arg_58_1 * self:GetSpeed()

				if self.inMove > 0 then
					self.realPos = self.pos - self:GetDirPos() * self.inMove
				else
					self.inMove = nil
					self.realPos = self.pos
				end

				self:UpdatePosition()
			elseif self.inLock then
				return
			elseif self.controller:InBlackHoleRange(self.pos, true) then
				self.inShock = 1

				self:PlayAnim("Dead")
			elseif self.inLantern and self.inLantern <= 0 then
				self.inLantern = nil

				self.effectLantern:PlayAnim("EF_bk_overlay_Lantern_Finish")

				self.effectLantern = nil
			elseif self:CheckSkill("ice") and self.controller:GetPressInput("Skill_0") then
				self:ReloadSkill("ice")

				if self.controller:CheckIce(self.pos + self:GetDirPos()) then
					self:PlayAnim(string.format("Attack_%s", self:GetDirMark()))
				else
					self.inCharge = 0

					self:PlayAnim(string.format("Freeze_%s_1_Start", self:GetDirMark()))
				end
			elseif self:CheckSkill("flash") and self.controller:GetPressInput("Skill_1") then
				self:ReloadSkill("flash")

				local var_58_0 = self:GetDirPos()

				for iter_58_2 = self.flashPower, 0, -1 do
					if self.controller:Moveable(self.pos + var_58_0 * iter_58_2) then
						self.controller:CreateTarget({
							name = "EF_bk_Flash_Jump",
							pos = self.pos
						})
						self:UpdatePos(self.pos + var_58_0 * iter_58_2)

						self.realPos = self.pos

						self:UpdatePosition()
						self.controller:CreateTarget({
							name = "EF_bk_Flash_Land",
							parent = self.rtScale:Find("bk")
						})
						self:PlayAnim(string.format("Flash_%s", self:GetDirMark()))

						break
					end
				end
			elseif self:CheckSkill("rush") and self.controller:GetPressInput("Skill_2") then
				self:ReloadSkill("rush")

				self.inRush = self.rushTime

				self:RushCheck()
			elseif self.itemType and self:CheckSkill("item") and self.controller:GetPressInput("Skill_3") and (self.itemType ~= "lantern" or not self.inLantern) then
				if self.itemType == "lantern" then
					self:PlayAnim("Lantern_Activate")
				elseif self.itemType == "bomb" then
					self:PlayAnim(string.format("Bomb_%s_1_Start", self:GetDirMark()))
				else
					assert(false)
				end
			else
				local var_58_1 = self.controller:GetCacheInput()

				if not var_58_1 then
					self.idleTime = defaultValue(self.idleTime, 0) - arg_58_1

					self:PlayIdle()
				elseif self:GetStatusMark() == "Move" then
					if self.controller:Moveable(self.pos + self:GetDirPos(var_58_1)) then
						self.inMove = 1

						self:UpdatePos(self.pos + self:GetDirPos(var_58_1))
						self:PlayMove(var_58_1)
					else
						self:PlayIdle(var_58_1)
					end
				elseif var_58_1 == self:GetDirMark() then
					if defaultValue(self.idleTime, 0) <= 0 and self.controller:Moveable(self.pos + self:GetDirPos()) then
						self.inMove = 1

						self:UpdatePos(self.pos + self:GetDirPos())
						self:PlayMove()
					else
						self.idleTime = defaultValue(self.idleTime, 0) - arg_58_1

						self:PlayIdle()
					end
				else
					self.idleTime = var_42_1

					self:PlayIdle(var_58_1)
				end
			end

			return
		end

		function TargetFuShun:PopPoint(arg_59_1)
			local var_59_0 = self._tf:Find("top/pop")

			setText(var_59_0:Find("Text"), "+" .. arg_59_1)
			setActive(var_59_0, false)
			setActive(var_59_0, true)

			return
		end

		function TargetFuShun:EnemyHit(arg_60_1)
			if self.isDead then
				return
			end

			if self.decoyCount > 0 then
				self.decoyCount = self.decoyCount - 1
				self.inCharge = nil
				self.inMove = nil

				self.controller:BuildDecoy(self.pos)
				self:UpdatePos((self.controller:GetDecoyPos(self.pos, arg_60_1)))

				self.realPos = self.pos

				self:UpdatePosition()
				self:PlayAnim("Decoy_2")
			else
				self.isDead = true
				self.inCharge = nil
				self.inMove = nil

				self:PlayAnim("Dead")
			end

			return
		end

		function TargetFuShun:UpdatePosition()
			TargetFuShun.super.UpdatePosition(self)
			self.controller:WindowFocrus(self._tf.localPosition)

			if self.realPos == self.pos then
				self.controller:EatItem(self.pos)
			end

			return
		end

		return TargetFuShun
	end,
	TargetNenjuu = function()
		local TargetNenjuu = class("TargetNenjuu", var_0_0.TargetMove)

		function TargetNenjuu:GetSpeed()
			return self.speed * (self:CheckAbility("rush") and 1.2 or 1) * (self.inStealth and 1.3 or 1) * (self.isDoppel and 0.8 or 1)
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

		function TargetNenjuu:CheckAbility(arg_64_1)
			return self.featuresAbility[arg_64_1] and self.abilityCDs[arg_64_1] <= 0
		end

		function TargetNenjuu:ReloadAbility(arg_65_1)
			self.abilityCDs[arg_65_1] = var_62_5[arg_65_1]

			return
		end

		function TargetNenjuu:InitUI(arg_66_1)
			TargetNenjuu.super.InitUI(self, arg_66_1)

			self.isDoppel = arg_66_1.isDoppel
			self.speed = 1.5
			self.featuresAbility = {
				attack = true
			}

			for iter_66_0, iter_66_1 in ipairs(NenjuuGameConfig.ABILITY_LIST) do
				self.featuresAbility[iter_66_1] = tobool(arg_66_1.abilitys[iter_66_1])
			end

			self.abilityCDs = {
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

		function TargetNenjuu:EventAnim(arg_67_1)
			local var_67_0 = self:GetDirMark()

			if arg_67_1 == "start" then
				-- block empty
			elseif arg_67_1 == "trigger" then
				switch(self.status, {
					["Attack_" .. var_67_0] = function()
						self.controller:CreateTarget({
							name = "EF_Attack_" .. var_67_0,
							parent = self.rtScale:Find(var_67_0 == "N" and "bk" or "fr")
						})

						if not self.isDoppel then
							self.controller:BreakIce({
								pos = self.pos,
								dir = self:GetDirMark(),
								dirPos = self:GetDirPos(),
								power = self:CheckAbility("breakpassable") and 3 or 1
							})
						end

						self.controller:EnemyAttack({
							pos = self.pos,
							dirPos = self:GetDirPos()
						})

						return
					end
				})
			elseif arg_67_1 == "end" then
				switch(self.status, {
					Warp_1_Jump = function()
						self:UpdatePos(self.telePos)

						self.realPos = self.pos

						self:UpdatePosition()

						self.telePos = nil

						self:PlayAnim("Warp_2_Land")
						self.controller:OnlyBreakIce(self.pos)

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

		function TargetNenjuu:RushCheck()
			if self.rushEffects then
				for iter_70_0, iter_70_1 in ipairs(self.rushEffects) do
					iter_70_1:Remove()
				end

				self.rushEffects = nil
			end

			if self.inStealth and self.loopAnimDic[self:GetStatusMark(self.status)] then
				self.rushEffects = {}

				for iter_70_2, iter_70_3 in ipairs(var_62_6[self:GetDirMark()]) do
					local var_70_0 = string.split(iter_70_3, "_")
					local var_70_1 = {
						name = iter_70_3
					}

					var_70_1.parent = self.rtScale:Find(var_70_0[#var_70_0])

					table.insert(self.rushEffects, self.controller:CreateTarget(var_70_1))
				end
			end

			return
		end

		function TargetNenjuu:OnTimerUpdate(arg_71_1)
			for iter_71_0, iter_71_1 in pairs(self.featuresAbility) do
				if iter_71_1 and var_62_5[iter_71_0] > 0 then
					self.abilityCDs[iter_71_0] = self.abilityCDs[iter_71_0] - arg_71_1
				end
			end

			if self.inStealth then
				self.inStealth = self.inStealth - arg_71_1

				if self.inStealth <= 0 then
					self.inStealth = nil
				end
			end

			if self.inScare then
				self.inScare = self.inScare - arg_71_1

				if self.inScare <= 0 then
					self.inScare = nil
				end
			end

			if self:CheckAbility("doppelgangers") and not self.isSummon then
				self.isSummon = true

				self.controller:BuildDoppelgangers(self.pos)
			end

			if self.inCharge then
				self.inCharge = self.inCharge + arg_71_1

				if self.inCharge > var_62_1 then
					self.inCharge = nil

					self:PlayAnim("Warp_1_Jump")
				end
			elseif self.inMove then
				self.inMove = self.inMove - arg_71_1 * self:GetSpeed()

				if self.inMove > 0 then
					self.realPos = self.pos - self:GetDirPos() * self.inMove
				else
					self.inMove = nil
					self.realPos = self.pos
				end

				self:UpdatePosition()
			elseif self.inLock then
				return
			else
				if self:CheckAbility("blackhole") then
					self:ReloadAbility("blackhole")
					self.controller:BuildBlackHole()
				end

				if self:CheckAbility("stealth") and self.controller:StealthCheck(self.pos) and not self.inScare then
					self:ReloadAbility("stealth")

					self.inStealth = var_62_2

					self:RushCheck()
				end

				if self:CheckAbility("attack") and not self.inScare then
					for iter_71_2, iter_71_3 in ipairs({
						"E",
						"S",
						"W",
						"N"
					}) do
						if self.controller:AttackCheck({
							pos = self.pos,
							dirPos = self:GetDirPos(iter_71_3)
						}) then
							self:DoAttack(iter_71_3)

							return
						end
					end
				end

				local var_71_0 = self.controller:GetWayfindingMap(self.pos, tobool(self.isDoppel))
				local var_71_1 = self.pos

				for iter_71_4, iter_71_5 in ipairs({
					"E",
					"S",
					"W",
					"N"
				}) do
					local var_71_2 = var_71_0[tostring(self.pos + self:GetDirPos(iter_71_5))]

					if var_71_2 then
						local var_71_3 = var_71_0[tostring(var_71_1)]

						if self.inScare then
							if not var_71_3 or var_71_3.value < var_71_2.value then
								var_71_1 = self.pos + self:GetDirPos(iter_71_5)
							end
						elseif var_71_3 then
							if (var_71_2.lightValue or var_71_2.value) < (var_71_3.lightValue or var_71_3.value) then
								var_71_1 = self.pos + self:GetDirPos(iter_71_5)
							end
						end
					end
				end

				if self:CheckAbility("teleport") and not self.inScare then
					if var_71_1 == self.pos then
						if not self.lostTime then
							self.lostTime = 3 - arg_71_1
						elseif arg_71_1 >= self.lostTime and self.controller.timeCount > 5 then
							self.lostTime = nil

							self:DoTeleport(var_71_0)
						else
							self.lostTime = self.lostTime - arg_71_1
						end

						self:PlayIdle()

						return
					else
						self.lostTime = nil

						if var_71_0[tostring(var_71_1)] and var_71_0[tostring(var_71_1)].value > var_62_4 then
							self:DoTeleport(var_71_0)
							self:PlayIdle()

							return
						end
					end
				end

				if not self.isDoppel and self:CheckAbility("attack") and self.controller:CheckIce(var_71_1) then
					self:DoAttack(self:GetDirMark(var_71_1 - self.pos))
				elseif self.controller:Moveable(var_71_1) then
					local var_71_5 = self:GetDirMark(var_71_1 - self.pos)

					self.inMove = 1

					self:UpdatePos(var_71_1)

					if self.inScare then
						self:PlayAnim("Fear_" .. var_71_5)
					else
						self:PlayMove(var_71_5)
					end
				elseif self.inScare then
					self:PlayAnim("Fear_" .. self:GetDirMark())
				else
					self:PlayIdle()
				end
			end

			return
		end

		function TargetNenjuu:DoAttack(arg_72_1)
			if self.inStealth then
				self.inStealth = nil
			end

			self:ReloadAbility("attack")
			self:PlayAnim(string.format("Attack_%s", arg_72_1))

			return
		end

		function TargetNenjuu:DoTeleport(arg_73_1)
			if self.inStealth then
				self.inStealth = nil
			end

			self:ReloadAbility("teleport")

			self.inCharge = 0
			self.telePos = self.controller:GetTeleportTargetPos(arg_73_1, self.pos)

			self.controller:BuildTeleportSign({
				pos = self.telePos,
				time = var_62_1
			})

			return
		end

		function TargetNenjuu:BeScare()
			self.inCharge = nil
			self.inStealth = nil
			self.inScare = var_62_3

			if not self.inMove then
				self:PlayIdle()
			end

			return
		end

		return TargetNenjuu
	end,
	TargetEffect = function()
		local TargetEffect = class("TargetEffect", var_0_0.TargetObject)

		function TargetEffect:Moveable()
			return true
		end

		function TargetEffect:GetBaseOrder()
			return 5
		end

		function TargetEffect:InitUI(arg_78_1)
			self.mainTarget = self._tf:Find("scale/Image")

			self.mainTarget:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
				self.controller:DestoryTarget(self)

				return
			end)

			return
		end

		return TargetEffect
	end,
	TargetBomb = function()
		local TargetBomb = class("TargetBomb", var_0_0.TargetEffect)

		function TargetBomb:InTimeLine()
			return true
		end

		function TargetBomb:GetBaseOrder()
			return 1
		end

		function TargetBomb:OnTimerUpdate(arg_83_1)
			self.controller:ScareEnemy({
				range = 1,
				pos = self.pos
			})

			return
		end

		return TargetBomb
	end,
	TargetTimeEffect = function()
		local TargetTimeEffect = class("TargetTimeEffect", var_0_0.TargetEffect)

		function TargetTimeEffect:GetBaseOrder()
			return 1
		end

		function TargetTimeEffect:InTimeLine()
			return true
		end

		function TargetTimeEffect:InitUI(arg_87_1)
			self.time = arg_87_1.time

			return
		end

		function TargetTimeEffect:OnTimerUpdate(arg_88_1)
			if arg_88_1 < self.time then
				self.time = self.time - arg_88_1
			else
				self.controller:DestoryTarget(self)
			end

			return
		end

		return TargetTimeEffect
	end,
	TargetBlackHole = function()
		local TargetBlackHole = class("TargetBlackHole", var_0_0.TargetEffect)

		function TargetBlackHole:InTimeLine()
			return true
		end

		function TargetBlackHole:GetBaseOrder()
			return 3
		end

		function TargetBlackHole:InitUI(arg_92_1)
			TargetBlackHole.super.InitUI(self, arg_92_1)

			self.time = arg_92_1.time

			return
		end

		function TargetBlackHole:OnTimerUpdate(arg_93_1)
			if self.isLost then
				return
			end

			self.controller:OnlyBreakIce(self.pos)

			if arg_93_1 < self.time then
				self.time = self.time - arg_93_1
			else
				self.isLost = true

				self:PlayAnim("BlackHole_3_Despawn")
			end

			return
		end

		function TargetBlackHole:BeTrigger()
			if self.isLost then
				return
			else
				self.isLost = true

				self:PlayAnim("BlackHole_3_Despawn")
			end

			return
		end

		return TargetBlackHole
	end,
	TargetSubEffect = function()
		local TargetSubEffect = class("TargetSubEffect", var_0_0.TargetObject)

		function TargetSubEffect:Init(arg_96_1)
			self.name = arg_96_1.name

			self:InitUI(arg_96_1)

			return
		end

		function TargetSubEffect:InitUI(arg_97_1)
			self.mainTarget = self._tf:Find("scale/Image")

			self.mainTarget:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
				Destroy(self._tf)

				return
			end)

			return
		end

		return TargetSubEffect
	end,
	TargetRushEffect = function()
		local TargetRushEffect = class("TargetRushEffect", var_0_0.TargetSubEffect)

		function TargetRushEffect:InTimeLine()
			return true
		end

		function TargetRushEffect:InitUI(arg_101_1)
			self.rtScale = self._tf:Find("scale")

			GetOrAddComponent(self.rtScale, typeof(CanvasGroup))

			self.alpha = 0

			setCanvasGroupAlpha(self.rtScale, self.alpha)

			return
		end

		local var_99_1 = 0.01

		function TargetRushEffect:OnTimerUpdate(arg_102_1)
			if self.inRemove then
				self.alpha = self.alpha - arg_102_1 / var_99_1

				if self.alpha <= 0 then
					table.removebyvalue(self.controller.timeFlow, self)
					Destroy(self._tf)
				end
			elseif self.alpha < 1 then
				self.alpha = math.max(1, self.alpha + arg_102_1 / var_99_1)

				setCanvasGroupAlpha(self.rtScale, self.alpha)
			end

			return
		end

		function TargetRushEffect:Remove()
			self.inRemove = true

			return
		end

		return TargetRushEffect
	end
}

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
	var_0_0[iter_0_1] = var_0_1[iter_0_1]()
end

return var_0_0
