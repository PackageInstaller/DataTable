local OsirisPlayGameHeroInfoView = class("OsirisPlayGameHeroInfoView", (import("game.views.heroTeamInfo.SectionHeroInfoView")))

function OsirisPlayGameHeroInfoView:UpdateUnlockedView()
	if self.type_ ~= HeroConst.HERO_DATA_TYPE.PREVIEW then
		if self.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			self.proficiencyText_.text = HeroTools.GetHeroProficiency(self.heroInfo_.id) .. "/" .. GameSetting.mastery_level_max.value[1]
		end

		local var_1_0 = self.heroInfo_.level
		local var_1_1 = self.heroInfo_.exp

		self.battlePower_ = self.heroViewProxy_:GetBattlePower(self.heroInfo_.id, self.heroInfo_.tempID)

		if self.battlePowerTween_ then
			LeanTween.cancel(self.battlePowerTween_.id)

			self.battlePowerTween_ = nil
		end

		if self.oldBattlePower_ ~= self.battlePower_ then
			local var_1_2 = self.oldBattlePower_ or 0
			local var_1_3 = self.battlePower_

			self.battlePowerTween_ = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_2_0)
				self.fightPowerText_.text = math.floor(var_1_2 + (var_1_3 - var_1_2) * arg_2_0)
			end)):setOnComplete(LuaHelper.VoidAction(function()
				if self.battlePowerTween_ then
					self.battlePowerTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

					self.battlePowerTween_ = nil
				end

				self.fightPowerText_.text = var_1_3
			end)):setEase(LeanTweenType.easeOutQuad)
			self.oldBattlePower_ = self.battlePower_
		else
			self.fightPowerText_.text = self.oldBattlePower_
		end

		local var_1_4 = HeroTools.GetHeroCurrentMaxLevel(self.heroInfo_)
		local var_1_5 = var_1_1 - LvTools.LevelToExp(var_1_0, "hero_level_exp1")

		self.att_ = self.heroViewProxy_:GetHeroAllAttribute(self.heroInfo_.id)

		for iter_1_0, iter_1_1 in pairs(self.propItems_) do
			local var_1_6 = PublicAttrCfg[self.propIndexes_[iter_1_0]].percent == 1

			if self.oldAtt_[self.propIndexes_[iter_1_0]] ~= self.att_[self.propIndexes_[iter_1_0]] then
				local var_1_7 = self.oldAtt_[self.propIndexes_[iter_1_0]] or 0
				local var_1_8 = self.att_[self.propIndexes_[iter_1_0]]

				if self.tweens_[iter_1_0] then
					LeanTween.cancel(self.tweens_[iter_1_0].id)

					self.tweens_[iter_1_0] = nil
				end

				self.tweens_[iter_1_0] = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_4_0)
					local var_4_0 = math.floor(var_1_7 + (var_1_8 - var_1_7) * arg_4_0)

					iter_1_1.text = var_1_6 and string.format("%.2f", var_4_0 / 10) .. self.endfixes_[iter_1_0] or math.floor(var_4_0)
				end)):setOnComplete(LuaHelper.VoidAction(function()
					if self.tweens_[iter_1_0] then
						self.tweens_[iter_1_0]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

						self.tweens_[iter_1_0] = nil
					end

					iter_1_1.text = var_1_6 and string.format("%.2f", var_1_8 / 10) .. self.endfixes_[iter_1_0] or math.floor(var_1_8)
				end)):setEase(LeanTweenType.easeOutQuad)
				self.oldAtt_[self.propIndexes_[iter_1_0]] = self.att_[self.propIndexes_[iter_1_0]]
			end
		end

		self.nowLevelText_.text = tostring(var_1_0)
		self.topLevelText_.text = var_1_4 < var_1_0 and "/" .. var_1_0 or "/" .. var_1_4

		if var_1_0 < var_1_4 then
			self.expProgressBar_.value = math.floor(var_1_5 / GameLevelSetting[var_1_0].hero_level_exp1 * 1000) / 1000
			self.expText_.text = string.format("%d/%d", var_1_5, GameLevelSetting[var_1_0].hero_level_exp1)
		elseif LvTools.GetIsMaxLv(var_1_0, "hero") then
			self.expProgressBar_.value = 1
			self.expText_.text = "-/-"
		else
			if var_1_5 < 0 then
				var_1_5 = 0
			end

			local var_1_9 = GameLevelSetting[var_1_0].hero_level_exp1

			self.expProgressBar_.value = math.floor(var_1_5 / GameLevelSetting[var_1_0].hero_level_exp1 * 1000) / 1000
			self.expText_.text = string.format("%d/%d", var_1_5, var_1_9)
		end
	end

	self.starImg_.sprite = getSprite("Atlas/Common", "star_" .. HeroStarCfg[self.heroInfo_.star].star)
	self.rangeTypeText_.text = CharactorParamCfg[self.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")

	self:UpdateUnlockBtnState()
	self:RefreshChargeType()
	self:UpdateModuleView()
end

return OsirisPlayGameHeroInfoView
