local var_0_0 = class("HeroInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.oldAtt_ = {}
	arg_1_0.tweens_ = {}
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.moduleImg_.immediate = true
	arg_3_0.lockController_ = arg_3_0.controller_:GetController("lock")
	arg_3_0.pieceEnoughController_ = arg_3_0.controller_:GetController("pieceEnough")
	arg_3_0.isSelfController_ = arg_3_0.controller_:GetController("isSelf")
	arg_3_0.levelStateController_ = arg_3_0.controller_:GetController("levelState")
	arg_3_0.moduleController_ = arg_3_0.controller_:GetController("module")
	arg_3_0.polyhedronController_ = arg_3_0.controller_:GetController("polyhedron")
	arg_3_0.nameDisplayController = arg_3_0.controller_:GetController("nameDisplay")
	arg_3_0.oathReNameController = arg_3_0.controller_:GetController("oathReName")
	arg_3_0.propNames_ = {
		arg_3_0.propName1_,
		arg_3_0.propName2_,
		arg_3_0.propName3_,
		arg_3_0.propName4_
	}
	arg_3_0.propItems_ = {
		arg_3_0.propNum1_,
		arg_3_0.propNum2_,
		arg_3_0.propNum3_,
		arg_3_0.propNum4_
	}
	arg_3_0.propIcon_ = {
		arg_3_0.propIcon1_,
		arg_3_0.propIcon2_,
		arg_3_0.propIcon3_,
		arg_3_0.propIcon4_
	}
	arg_3_0.propIndexes_ = {
		HeroConst.HERO_ATTRIBUTE.ATK,
		HeroConst.HERO_ATTRIBUTE.ARM,
		HeroConst.HERO_ATTRIBUTE.STA,
		HeroConst.HERO_ATTRIBUTE.CRITICAL
	}
	arg_3_0.endfixes_ = {}

	for iter_3_0 = 1, 4 do
		local var_3_0, var_3_1, var_3_2 = SkillTools.GetAttr({
			arg_3_0.propIndexes_[iter_3_0],
			0
		})

		arg_3_0.propNames_[iter_3_0].text = GetI18NText(var_3_0)
		arg_3_0.propIcon_[iter_3_0].sprite = var_3_2
		arg_3_0.endfixes_[iter_3_0] = PublicAttrCfg[arg_3_0.propIndexes_[iter_3_0]].percent == 1 and "%" or ""
	end

	if not isNil(arg_3_0.heroOathEnter1_) and not isNil(arg_3_0.heroOathEnter2_) then
		arg_3_0.heroOathEnterObj1_ = OathHeroEnterInfo.New(arg_3_0.heroOathEnter1_)
		arg_3_0.heroOathEnterObj2_ = OathHeroEnterInfo.New(arg_3_0.heroOathEnter2_)
	end
end

function var_0_0.AddUIListener(arg_4_0)
	if arg_4_0.surpassBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.surpassBtn_, nil, function()
			JumpTools.OpenPageByJump("/heroSurpass", {
				heroId = arg_4_0.heroInfo_.id
			})
		end)
	end

	if arg_4_0.surpass01Btn_ then
		arg_4_0:AddBtnListener(arg_4_0.surpass01Btn_, nil, function()
			JumpTools.OpenPageByJump("/heroSurpass", {
				heroId = arg_4_0.heroInfo_.id
			})
		end)
	end

	arg_4_0:AddBtnListener(arg_4_0.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = arg_4_0.heroInfo_.id
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.getBtn_, nil, function()
		local var_8_0 = arg_4_0:GetHeroPiece()
		local var_8_1 = arg_4_0.heroCfg_.rare

		if var_8_0 < GameSetting.unlock_hero_need.value[var_8_1] then
			ShowPopItem(POP_SOURCE_ITEM, {
				ItemCfg[arg_4_0.heroCfg_.id].fragment
			})
		else
			manager.net:SendWithLoadingNew(14016, {
				id = arg_4_0.heroCfg_.id
			}, 14017, handler(arg_4_0, arg_4_0.OnUnlockHero))
		end
	end)

	if arg_4_0.upgradeBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.upgradeBtn_, nil, function()
			JumpTools.OpenPageByJump("/heroUpgrade", {
				heroId = arg_4_0.heroInfo_.id,
				proxy = arg_4_0.heroViewProxy_
			})
		end)
	end

	arg_4_0:AddBtnListener(arg_4_0.campBgBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription")
	end)
	arg_4_0:AddBtnListener(arg_4_0.buttonHeroAttribute_, nil, function()
		JumpTools.OpenPageByJump("heroAttribute", {
			heroID = arg_4_0.heroInfo_.id,
			proxy = arg_4_0.heroViewProxy_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.moduleView_, nil, function()
		OperationRecorder.RecordButtonTouch("hero_attribute_module")

		if not arg_4_0.heroViewProxy_.isSelf then
			return
		end

		if WeaponModuleCfg[arg_4_0.heroInfo_.id] then
			JumpTools.OpenPageByJump("/weaponModuleView", {
				heroID = arg_4_0.heroInfo_.id
			})
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.proficiencyBtn_, nil, function()
		if arg_4_0.openContent_ then
			arg_4_0.openContent_ = false
		else
			arg_4_0.openContent_ = true
		end

		SetActive(arg_4_0.comTipsGo_, arg_4_0.openContent_)
		SetActive(arg_4_0.proficiencyMaskBtn_.gameObject, arg_4_0.openContent_)

		arg_4_0.comTipsNumText_.text = HeroTools.GetHeroProficiency(arg_4_0.heroInfo_.id) .. "/" .. GameSetting.mastery_level_max.value[1]
	end)
	arg_4_0:AddBtnListener(arg_4_0.proficiencyMaskBtn_, nil, function()
		arg_4_0.openContent_ = false

		SetActive(arg_4_0.comTipsGo_, arg_4_0.openContent_)
		SetActive(arg_4_0.proficiencyMaskBtn_.gameObject, arg_4_0.openContent_)
	end)

	if arg_4_0.oathRenameBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.oathRenameBtn_, nil, function()
			JumpTools.OpenPageByJump("oathNamePopView", {
				heroID = arg_4_0.heroCfg_.id
			})
		end)
	end
end

function var_0_0.OnUnlockHero(arg_16_0, arg_16_1, arg_16_2)
	if isSuccess(arg_16_1.result) then
		HeroAction.UnlockHeroSuccess(arg_16_0.heroCfg_.id)
		gameContext:Go("obtainView", {
			itemList = {
				arg_16_0.heroCfg_
			}
		})
	end
end

function var_0_0.SetHeroInfo(arg_17_0, arg_17_1)
	arg_17_0.oldBattlePower_ = arg_17_0.battlePower_ or 0
	arg_17_0.oldAtt_ = arg_17_0.att_ or {}
	arg_17_0.heroInfo_ = arg_17_1
	arg_17_0.heroCfg_ = HeroCfg[arg_17_1.id]
	arg_17_0.curLv_ = arg_17_0.heroInfo_.level
	arg_17_0.curLvMax_ = HeroTools.GetHeroCurrentMaxLevel(arg_17_0.heroInfo_)
end

function var_0_0.UpdateHeroOathInfo(arg_18_0)
	if arg_18_0.heroViewProxy_:IsHeroOath(arg_18_0.heroInfo_.id) then
		if arg_18_0.heroViewProxy_:HasCustomNickName(arg_18_0.heroInfo_.id) then
			arg_18_0.nameDisplayController:SetSelectedState("oathCustomName")
		else
			arg_18_0.nameDisplayController:SetSelectedState("oath")
		end

		if OathTools.IsCanShowInHeroInfoView() then
			arg_18_0.oathReNameController:SetSelectedState("show")
		else
			arg_18_0.oathReNameController:SetSelectedState("hide")
		end
	else
		arg_18_0.nameDisplayController:SetSelectedState("normal")
		arg_18_0.oathReNameController:SetSelectedState("hide")
	end

	if arg_18_0.heroOathEnterObj1_ and arg_18_0.heroOathEnterObj2_ then
		arg_18_0.heroOathEnterObj1_:SetData(arg_18_0.heroInfo_.id, arg_18_0.heroViewProxy_)
		arg_18_0.heroOathEnterObj2_:SetData(arg_18_0.heroInfo_.id, arg_18_0.heroViewProxy_)
	end
end

function var_0_0.UpdateView(arg_19_0)
	arg_19_0.openContent_ = false

	SetActive(arg_19_0.comTipsGo_, arg_19_0.openContent_)
	SetActive(arg_19_0.proficiencyMaskBtn_.gameObject, arg_19_0.openContent_)

	arg_19_0.nameText_.text = GetI18NText(arg_19_0.heroCfg_.name)
	arg_19_0.subNameText_.text = arg_19_0.heroViewProxy_:GetHeroName(arg_19_0.heroInfo_.id)

	local var_19_0 = arg_19_0.heroInfo_.unlock ~= 0 or arg_19_0.type_ == HeroConst.HERO_DATA_TYPE.PREVIEW

	arg_19_0.lockController_:SetSelectedState(tostring(not var_19_0))
	arg_19_0.isSelfController_:SetSelectedState(tostring(arg_19_0.heroViewProxy_.isSelf))
	arg_19_0.polyhedronController_:SetSelectedState(tostring(arg_19_0.type_ == HeroConst.HERO_DATA_TYPE.POLYHEDRON))

	arg_19_0.campLogo_.sprite = HeroTools.GetRaceIcon(arg_19_0.heroCfg_.race)
	arg_19_0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_19_0.heroCfg_.id)

	if arg_19_0.heroInfo_.unlock == 0 then
		arg_19_0:UpdateLockedView()
	else
		arg_19_0:UpdateUnlockedView()

		if arg_19_0.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			local var_19_1 = arg_19_0.heroCfg_.id

			ArchiveAction.CheckAllRelationRedPoint(var_19_1)
		end
	end

	if arg_19_0.heroViewProxy_.showRedPoint then
		if not isNil(arg_19_0.moduleView_) and not isNil(arg_19_0.moduleView_.transform) then
			manager.redPoint:bindUIandKey(arg_19_0.moduleView_.transform, RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. arg_19_0.heroInfo_.id)
		end

		manager.redPoint:bindUIandKey(arg_19_0.surpassBtn_.transform, RedPointConst.HERO_STAR_ID .. arg_19_0.heroInfo_.id)
		manager.redPoint:bindUIandKey(arg_19_0.surpass01Btn_.transform, RedPointConst.HERO_STAR_ID .. arg_19_0.heroInfo_.id)
		manager.redPoint:bindUIandKey(arg_19_0.upgradeBtn_.transform, RedPointConst.HERO_BREAK_ID .. arg_19_0.heroInfo_.id)
	end

	if not isNil(arg_19_0.moduleView_) and not isNil(arg_19_0.moduleView_.gameObject) then
		LuaForUtil.ActiveHoverEffect(arg_19_0.moduleView_.gameObject, not arg_19_0.heroViewProxy_.isSelf)
	end

	arg_19_0:UpdateHeroOathInfo()
end

function var_0_0.GetHeroPiece(arg_20_0)
	return arg_20_0.heroInfo_.piece
end

function var_0_0.UpdateLockedView(arg_21_0)
	local var_21_0 = arg_21_0:GetHeroPiece()
	local var_21_1 = arg_21_0.heroCfg_.rare
	local var_21_2 = GameSetting.unlock_hero_need.value[var_21_1]
	local var_21_3 = math.min(var_21_0, var_21_2)

	arg_21_0.pieceCost_ = -var_21_2
	arg_21_0.curPieceText_.text = tostring(var_21_0)
	arg_21_0.needPieceText_.text = "/" .. tostring(var_21_2)

	if arg_21_0.tweenValue_ then
		LeanTween.cancel(arg_21_0.tweenValue_.id)

		arg_21_0.tweenValue_ = nil
	end

	arg_21_0.tweenValue_ = LeanTween.value(0, 0.7, 0.7):setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
		local var_22_0 = 0

		if arg_22_0 >= 0.2 then
			var_22_0 = (arg_22_0 - 0.2) / 0.5
		end

		arg_21_0.scheduleImage_.fillAmount = var_21_3 * var_22_0 / var_21_2
	end)):setOnComplete(LuaHelper.VoidAction(function()
		if arg_21_0.tweenValue_ then
			arg_21_0.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			arg_21_0.tweenValue_ = nil
		end

		arg_21_0.scheduleImage_.fillAmount = var_21_3 / var_21_2
	end)):setEase(LeanTweenType.easeOutQuad)

	if var_21_2 <= var_21_0 then
		arg_21_0.pieceEnoughController_:SetSelectedState("true")

		arg_21_0.getText_.text = GetTips("DORM_CANTEEN_LEVEL_UNLOCK")
	else
		arg_21_0.pieceEnoughController_:SetSelectedState("false")

		arg_21_0.getText_.text = GetTips("TIP_GET")
	end
end

function var_0_0.UpdateModuleView(arg_24_0)
	SetActive(arg_24_0.moduleView_.gameObject, WeaponModuleCfg[arg_24_0.heroInfo_.id] and not arg_24_0.heroViewProxy_.hideModule)

	if WeaponModuleCfg[arg_24_0.heroInfo_.id] then
		local var_24_0 = arg_24_0.heroInfo_.moduleLevel

		if var_24_0 == 0 then
			arg_24_0.moduleController_:SetSelectedState("lock")
		else
			arg_24_0.moduleController_:SetSelectedState("unlock")

			arg_24_0.moduleNameText_.text = WeaponModuleCfg[arg_24_0.heroInfo_.id].name
			arg_24_0.moduleImg_.spriteSync = "TextureConfig/WeaponModule/" .. arg_24_0.heroInfo_.id
			arg_24_0.moduleLevelText_.text = "Lv." .. var_24_0
		end
	end
end

function var_0_0.UpdateUnlockedView(arg_25_0)
	if arg_25_0.type_ ~= HeroConst.HERO_DATA_TYPE.PREVIEW then
		if arg_25_0.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			arg_25_0.proficiencyText_.text = HeroTools.GetHeroProficiency(arg_25_0.heroInfo_.id) .. "/" .. GameSetting.mastery_level_max.value[1]
		end

		local var_25_0 = arg_25_0.heroInfo_.level
		local var_25_1 = arg_25_0.heroInfo_.exp

		arg_25_0.battlePower_ = arg_25_0.heroViewProxy_:GetBattlePower(arg_25_0.heroInfo_.id, arg_25_0.heroInfo_.tempID)

		if arg_25_0.battlePowerTween_ then
			LeanTween.cancel(arg_25_0.battlePowerTween_.id)

			arg_25_0.battlePowerTween_ = nil
		end

		if arg_25_0.oldBattlePower_ ~= arg_25_0.battlePower_ then
			local var_25_2 = arg_25_0.oldBattlePower_ or 0
			local var_25_3 = arg_25_0.battlePower_

			arg_25_0.battlePowerTween_ = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
				local var_26_0 = var_25_2
				local var_26_1 = var_25_3
				local var_26_2 = math.floor(var_26_0 + (var_26_1 - var_26_0) * arg_26_0)

				arg_25_0.fightPowerText_.text = var_26_2
			end)):setOnComplete(LuaHelper.VoidAction(function()
				if arg_25_0.battlePowerTween_ then
					arg_25_0.battlePowerTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

					arg_25_0.battlePowerTween_ = nil
				end

				arg_25_0.fightPowerText_.text = var_25_3
			end)):setEase(LeanTweenType.easeOutQuad)
			arg_25_0.oldBattlePower_ = arg_25_0.battlePower_
		else
			arg_25_0.fightPowerText_.text = arg_25_0.oldBattlePower_
		end

		local var_25_4 = HeroTools.GetHeroCurrentMaxLevel(arg_25_0.heroInfo_)
		local var_25_5 = var_25_1 - LvTools.LevelToExp(var_25_0, "hero_level_exp1")

		arg_25_0.att_ = arg_25_0.heroViewProxy_:GetHeroAllAttribute(arg_25_0.heroInfo_.id)

		for iter_25_0, iter_25_1 in pairs(arg_25_0.propItems_) do
			local var_25_6 = PublicAttrCfg[arg_25_0.propIndexes_[iter_25_0]].percent == 1

			if arg_25_0.oldAtt_[arg_25_0.propIndexes_[iter_25_0]] ~= arg_25_0.att_[arg_25_0.propIndexes_[iter_25_0]] then
				local var_25_7 = arg_25_0.oldAtt_[arg_25_0.propIndexes_[iter_25_0]] or 0
				local var_25_8 = arg_25_0.att_[arg_25_0.propIndexes_[iter_25_0]]

				if arg_25_0.tweens_[iter_25_0] then
					LeanTween.cancel(arg_25_0.tweens_[iter_25_0].id)

					arg_25_0.tweens_[iter_25_0] = nil
				end

				arg_25_0.tweens_[iter_25_0] = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					local var_28_0 = var_25_7
					local var_28_1 = var_25_8
					local var_28_2 = math.floor(var_28_0 + (var_28_1 - var_28_0) * arg_28_0)

					if var_25_6 then
						iter_25_1.text = string.format("%.2f", var_28_2 / 10) .. arg_25_0.endfixes_[iter_25_0]
					else
						iter_25_1.text = math.floor(var_28_2)
					end
				end)):setOnComplete(LuaHelper.VoidAction(function()
					if arg_25_0.tweens_[iter_25_0] then
						arg_25_0.tweens_[iter_25_0]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

						arg_25_0.tweens_[iter_25_0] = nil
					end

					if var_25_6 then
						iter_25_1.text = string.format("%.2f", var_25_8 / 10) .. arg_25_0.endfixes_[iter_25_0]
					else
						iter_25_1.text = math.floor(var_25_8)
					end
				end)):setEase(LeanTweenType.easeOutQuad)
				arg_25_0.oldAtt_[arg_25_0.propIndexes_[iter_25_0]] = arg_25_0.att_[arg_25_0.propIndexes_[iter_25_0]]
			end
		end

		arg_25_0.nowLevelText_.text = tostring(var_25_0)
		arg_25_0.topLevelText_.text = "/" .. var_25_4

		if var_25_0 < var_25_4 then
			var_25_5 = arg_25_0.type_ == HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME and var_25_5 < 0 and 0 or var_25_5

			local var_25_9 = GameLevelSetting[var_25_0].hero_level_exp1

			arg_25_0.expProgressBar_.value = math.floor(var_25_5 / var_25_9 * 1000) / 1000
			arg_25_0.expText_.text = string.format("%d/%d", var_25_5, var_25_9)
		else
			var_25_5 = arg_25_0.type_ == HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME and var_25_5 < 0 and 0 or var_25_5

			if LvTools.GetIsMaxLv(var_25_0, "hero") then
				arg_25_0.expProgressBar_.value = 1
				arg_25_0.expText_.text = "-/-"
			else
				local var_25_10 = GameLevelSetting[var_25_0].hero_level_exp1

				arg_25_0.expProgressBar_.value = math.floor(var_25_5 / var_25_10 * 1000) / 1000
				arg_25_0.expText_.text = string.format("%d/%d", var_25_5, var_25_10)
			end
		end
	end

	local var_25_11 = HeroStarCfg[arg_25_0.heroInfo_.star]

	arg_25_0.starImg_.sprite = getSprite("Atlas/Common", "star_" .. var_25_11.star)
	arg_25_0.rangeTypeText_.text = CharactorParamCfg[arg_25_0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")

	arg_25_0:UpdateUnlockBtnState()
	arg_25_0:RefreshChargeType()
	arg_25_0:UpdateModuleView()
end

function var_0_0.UpdateUnlockBtnState(arg_30_0)
	if arg_30_0.heroInfo_.level >= HeroConst.HERO_LV_MAX then
		arg_30_0.levelStateController_:SetSelectedState("maxLevel")
	elseif arg_30_0.heroInfo_.level >= HeroTools.GetHeroCurrentMaxLevel(arg_30_0.heroInfo_) then
		arg_30_0.levelStateController_:SetSelectedState("break")

		arg_30_0.upgradeBtnText_.text = GetTips("TIP_BREAK")
	else
		arg_30_0.levelStateController_:SetSelectedState("addExp")

		arg_30_0.upgradeBtnText_.text = GetTips("TEXT_UPGRADE")
	end
end

function var_0_0.RefreshChargeType(arg_31_0)
	arg_31_0.chargeType_.text = HeroTools.GetChargeTextByType(arg_31_0.heroCfg_.mechanism_type[1])
end

function var_0_0.OnEnter(arg_32_0, arg_32_1)
	arg_32_0:SetProxy(arg_32_1)
	arg_32_0:RegistEventListener(HERO_DATA_MODIFY, handler(arg_32_0, arg_32_0.OnHeroModify))
	arg_32_0:RegistEventListener(OATH_CHANGE_NAME, handler(arg_32_0, arg_32_0.OnHeroModify))
end

function var_0_0.OnExit(arg_33_0)
	if not isNil(arg_33_0.moduleView_) and not isNil(arg_33_0.moduleView_.transform) then
		manager.redPoint:unbindUIandKey(arg_33_0.moduleView_.transform)
	end

	manager.redPoint:unbindUIandKey(arg_33_0.surpassBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_33_0.surpass01Btn_.transform)
	manager.redPoint:unbindUIandKey(arg_33_0.upgradeBtn_.transform)

	if arg_33_0.heroOathEnterObj1_ and arg_33_0.heroOathEnterObj2_ then
		arg_33_0.heroOathEnterObj1_:OnExit()
		arg_33_0.heroOathEnterObj2_:OnExit()
	end

	arg_33_0:RemoveAllEventListener()
end

function var_0_0.SetProxy(arg_34_0, arg_34_1)
	arg_34_0.heroViewProxy_ = arg_34_1
	arg_34_0.type_ = arg_34_0.heroViewProxy_:GetViewDataType()
end

function var_0_0.OnHeroModify(arg_35_0, arg_35_1)
	if arg_35_1 == arg_35_0.heroInfo_.id then
		arg_35_0:UpdateView()
	end
end

function var_0_0.Dispose(arg_36_0)
	arg_36_0:RemoveAllListeners()

	if arg_36_0.heroOathEnterObj1_ and arg_36_0.heroOathEnterObj2_ then
		arg_36_0.heroOathEnterObj1_:Dispose()
		arg_36_0.heroOathEnterObj2_:Dispose()

		arg_36_0.heroOathEnterObj1_ = nil
		arg_36_0.heroOathEnterObj2_ = nil
	end

	if arg_36_0.tweenValue_ then
		arg_36_0.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_36_0.tweenValue_.id)

		arg_36_0.tweenValue_ = nil
	end

	if arg_36_0.battlePowerTween_ then
		arg_36_0.battlePowerTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_36_0.battlePowerTween_.id)

		arg_36_0.battlePowerTween_ = nil
	end

	if arg_36_0.tweens_ then
		for iter_36_0, iter_36_1 in pairs(arg_36_0.tweens_) do
			iter_36_1:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
			LeanTween.cancel(iter_36_1.id)
		end

		arg_36_0.tweens_ = nil
	end

	arg_36_0.handler_ = nil

	var_0_0.super.Dispose(arg_36_0)
end

return var_0_0
