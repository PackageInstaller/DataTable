local var_0_0 = import("game.views.heroTeamInfo.SectionHeroInfoView")
local var_0_1 = class("OsirisPlayGameHeroInfoView", var_0_0)

function var_0_1.UpdateUnlockedView(arg_1_0)
	if arg_1_0.type_ ~= HeroConst.HERO_DATA_TYPE.PREVIEW then
		if arg_1_0.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			arg_1_0.proficiencyText_.text = HeroTools.GetHeroProficiency(arg_1_0.heroInfo_.id) .. "/" .. GameSetting.mastery_level_max.value[1]
		end

		local var_1_0 = arg_1_0.heroInfo_.level
		local var_1_1 = arg_1_0.heroInfo_.exp

		arg_1_0.battlePower_ = arg_1_0.heroViewProxy_:GetBattlePower(arg_1_0.heroInfo_.id, arg_1_0.heroInfo_.tempID)

		if arg_1_0.battlePowerTween_ then
			LeanTween.cancel(arg_1_0.battlePowerTween_.id)

			arg_1_0.battlePowerTween_ = nil
		end

		if arg_1_0.oldBattlePower_ ~= arg_1_0.battlePower_ then
			local var_1_2 = arg_1_0.oldBattlePower_ or 0
			local var_1_3 = arg_1_0.battlePower_

			arg_1_0.battlePowerTween_ = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_2_0)
				local var_2_0 = var_1_2
				local var_2_1 = var_1_3
				local var_2_2 = math.floor(var_2_0 + (var_2_1 - var_2_0) * arg_2_0)

				arg_1_0.fightPowerText_.text = var_2_2
			end)):setOnComplete(LuaHelper.VoidAction(function()
				if arg_1_0.battlePowerTween_ then
					arg_1_0.battlePowerTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

					arg_1_0.battlePowerTween_ = nil
				end

				arg_1_0.fightPowerText_.text = var_1_3
			end)):setEase(LeanTweenType.easeOutQuad)
			arg_1_0.oldBattlePower_ = arg_1_0.battlePower_
		else
			arg_1_0.fightPowerText_.text = arg_1_0.oldBattlePower_
		end

		local var_1_4 = HeroTools.GetHeroCurrentMaxLevel(arg_1_0.heroInfo_)
		local var_1_5 = var_1_1 - LvTools.LevelToExp(var_1_0, "hero_level_exp1")

		arg_1_0.att_ = arg_1_0.heroViewProxy_:GetHeroAllAttribute(arg_1_0.heroInfo_.id)

		for iter_1_0, iter_1_1 in pairs(arg_1_0.propItems_) do
			local var_1_6 = PublicAttrCfg[arg_1_0.propIndexes_[iter_1_0]].percent == 1

			if arg_1_0.oldAtt_[arg_1_0.propIndexes_[iter_1_0]] ~= arg_1_0.att_[arg_1_0.propIndexes_[iter_1_0]] then
				local var_1_7 = arg_1_0.oldAtt_[arg_1_0.propIndexes_[iter_1_0]] or 0
				local var_1_8 = arg_1_0.att_[arg_1_0.propIndexes_[iter_1_0]]

				if arg_1_0.tweens_[iter_1_0] then
					LeanTween.cancel(arg_1_0.tweens_[iter_1_0].id)

					arg_1_0.tweens_[iter_1_0] = nil
				end

				arg_1_0.tweens_[iter_1_0] = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_4_0)
					local var_4_0 = var_1_7
					local var_4_1 = var_1_8
					local var_4_2 = math.floor(var_4_0 + (var_4_1 - var_4_0) * arg_4_0)

					if var_1_6 then
						iter_1_1.text = string.format("%.2f", var_4_2 / 10) .. arg_1_0.endfixes_[iter_1_0]
					else
						iter_1_1.text = math.floor(var_4_2)
					end
				end)):setOnComplete(LuaHelper.VoidAction(function()
					if arg_1_0.tweens_[iter_1_0] then
						arg_1_0.tweens_[iter_1_0]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

						arg_1_0.tweens_[iter_1_0] = nil
					end

					if var_1_6 then
						iter_1_1.text = string.format("%.2f", var_1_8 / 10) .. arg_1_0.endfixes_[iter_1_0]
					else
						iter_1_1.text = math.floor(var_1_8)
					end
				end)):setEase(LeanTweenType.easeOutQuad)
				arg_1_0.oldAtt_[arg_1_0.propIndexes_[iter_1_0]] = arg_1_0.att_[arg_1_0.propIndexes_[iter_1_0]]
			end
		end

		arg_1_0.nowLevelText_.text = tostring(var_1_0)

		if var_1_4 < var_1_0 then
			arg_1_0.topLevelText_.text = "/" .. var_1_0
		else
			arg_1_0.topLevelText_.text = "/" .. var_1_4
		end

		if var_1_0 < var_1_4 then
			local var_1_9 = GameLevelSetting[var_1_0].hero_level_exp1

			arg_1_0.expProgressBar_.value = math.floor(var_1_5 / var_1_9 * 1000) / 1000
			arg_1_0.expText_.text = string.format("%d/%d", var_1_5, var_1_9)
		elseif LvTools.GetIsMaxLv(var_1_0, "hero") then
			arg_1_0.expProgressBar_.value = 1
			arg_1_0.expText_.text = "-/-"
		else
			if var_1_5 < 0 then
				var_1_5 = 0
			end

			local var_1_10 = GameLevelSetting[var_1_0].hero_level_exp1

			arg_1_0.expProgressBar_.value = math.floor(var_1_5 / var_1_10 * 1000) / 1000
			arg_1_0.expText_.text = string.format("%d/%d", var_1_5, var_1_10)
		end
	end

	local var_1_11 = HeroStarCfg[arg_1_0.heroInfo_.star]

	arg_1_0.starImg_.sprite = getSprite("Atlas/Common", "star_" .. var_1_11.star)
	arg_1_0.rangeTypeText_.text = CharactorParamCfg[arg_1_0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")

	arg_1_0:UpdateUnlockBtnState()
	arg_1_0:RefreshChargeType()
	arg_1_0:UpdateModuleView()
end

return var_0_1
