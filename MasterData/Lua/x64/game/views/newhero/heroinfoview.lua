local HeroInfoView = class("HeroInfoView", ReduxView)

function HeroInfoView:OnCtor(arg_1_1, arg_1_2)
	self.oldAtt_ = {}
	self.tweens_ = {}
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function HeroInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroInfoView:InitUI()
	self:BindCfgUI()

	self.moduleImg_.immediate = true
	self.lockController_ = self.controller_:GetController("lock")
	self.pieceEnoughController_ = self.controller_:GetController("pieceEnough")
	self.isSelfController_ = self.controller_:GetController("isSelf")
	self.levelStateController_ = self.controller_:GetController("levelState")
	self.moduleController_ = self.controller_:GetController("module")
	self.polyhedronController_ = self.controller_:GetController("polyhedron")
	self.nameDisplayController = self.controller_:GetController("nameDisplay")
	self.oathReNameController = self.controller_:GetController("oathReName")
	self.propNames_ = {
		self.propName1_,
		self.propName2_,
		self.propName3_,
		self.propName4_
	}
	self.propItems_ = {
		self.propNum1_,
		self.propNum2_,
		self.propNum3_,
		self.propNum4_
	}
	self.propIcon_ = {
		self.propIcon1_,
		self.propIcon2_,
		self.propIcon3_,
		self.propIcon4_
	}
	self.propIndexes_ = {
		HeroConst.HERO_ATTRIBUTE.ATK,
		HeroConst.HERO_ATTRIBUTE.ARM,
		HeroConst.HERO_ATTRIBUTE.STA,
		HeroConst.HERO_ATTRIBUTE.CRITICAL
	}
	self.endfixes_ = {}

	for iter_3_0 = 1, 4 do
		local var_3_0, var_3_1, var_3_2 = SkillTools.GetAttr({
			self.propIndexes_[iter_3_0],
			0
		})

		self.propNames_[iter_3_0].text = GetI18NText(var_3_0)
		self.propIcon_[iter_3_0].sprite = var_3_2
		self.endfixes_[iter_3_0] = PublicAttrCfg[self.propIndexes_[iter_3_0]].percent == 1 and "%" or ""
	end

	if not isNil(self.heroOathEnter1_) and not isNil(self.heroOathEnter2_) then
		self.heroOathEnterObj1_ = OathHeroEnterInfo.New(self.heroOathEnter1_)
		self.heroOathEnterObj2_ = OathHeroEnterInfo.New(self.heroOathEnter2_)
	end
end

function HeroInfoView:AddUIListener()
	if self.surpassBtn_ then
		self:AddBtnListener(self.surpassBtn_, nil, function()
			JumpTools.OpenPageByJump("/heroSurpass", {
				heroId = self.heroInfo_.id
			})
		end)
	end

	if self.surpass01Btn_ then
		self:AddBtnListener(self.surpass01Btn_, nil, function()
			JumpTools.OpenPageByJump("/heroSurpass", {
				heroId = self.heroInfo_.id
			})
		end)
	end

	self:AddBtnListener(self.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = self.heroInfo_.id
		})
	end)
	self:AddBtnListener(self.getBtn_, nil, function()
		if self:GetHeroPiece() < GameSetting.unlock_hero_need.value[self.heroCfg_.rare] then
			ShowPopItem(POP_SOURCE_ITEM, {
				ItemCfg[self.heroCfg_.id].fragment
			})
		else
			manager.net:SendWithLoadingNew(14016, {
				id = self.heroCfg_.id
			}, 14017, handler(self, self.OnUnlockHero))
		end
	end)

	if self.upgradeBtn_ then
		self:AddBtnListener(self.upgradeBtn_, nil, function()
			JumpTools.OpenPageByJump("/heroUpgrade", {
				heroId = self.heroInfo_.id,
				proxy = self.heroViewProxy_
			})
		end)
	end

	self:AddBtnListener(self.campBgBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription")
	end)
	self:AddBtnListener(self.buttonHeroAttribute_, nil, function()
		JumpTools.OpenPageByJump("heroAttribute", {
			heroID = self.heroInfo_.id,
			proxy = self.heroViewProxy_
		})
	end)
	self:AddBtnListener(self.moduleView_, nil, function()
		OperationRecorder.RecordButtonTouch("hero_attribute_module")

		if not self.heroViewProxy_.isSelf then
			return
		end

		if WeaponModuleCfg[self.heroInfo_.id] then
			JumpTools.OpenPageByJump("/weaponModuleView", {
				heroID = self.heroInfo_.id
			})
		end
	end)
	self:AddBtnListener(self.proficiencyBtn_, nil, function()
		self.openContent_ = not self.openContent_

		SetActive(self.comTipsGo_, self.openContent_)
		SetActive(self.proficiencyMaskBtn_.gameObject, self.openContent_)

		self.comTipsNumText_.text = HeroTools.GetHeroProficiency(self.heroInfo_.id) .. "/" .. GameSetting.mastery_level_max.value[1]
	end)
	self:AddBtnListener(self.proficiencyMaskBtn_, nil, function()
		self.openContent_ = false

		SetActive(self.comTipsGo_, self.openContent_)
		SetActive(self.proficiencyMaskBtn_.gameObject, self.openContent_)
	end)

	if self.oathRenameBtn_ then
		self:AddBtnListener(self.oathRenameBtn_, nil, function()
			JumpTools.OpenPageByJump("oathNamePopView", {
				heroID = self.heroCfg_.id
			})
		end)
	end
end

function HeroInfoView:OnUnlockHero(arg_16_1, arg_16_2)
	if isSuccess(arg_16_1.result) then
		HeroAction.UnlockHeroSuccess(self.heroCfg_.id)
		gameContext:Go("obtainView", {
			itemList = {
				self.heroCfg_
			}
		})
	end
end

function HeroInfoView:SetHeroInfo(arg_17_1)
	self.oldBattlePower_ = self.battlePower_ or 0
	self.oldAtt_ = self.att_ or {}
	self.heroInfo_ = arg_17_1
	self.heroCfg_ = HeroCfg[arg_17_1.id]
	self.curLv_ = self.heroInfo_.level
	self.curLvMax_ = HeroTools.GetHeroCurrentMaxLevel(self.heroInfo_)
end

function HeroInfoView:UpdateHeroOathInfo()
	if self.heroViewProxy_:IsHeroOath(self.heroInfo_.id) then
		if self.heroViewProxy_:HasCustomNickName(self.heroInfo_.id) then
			self.nameDisplayController:SetSelectedState("oathCustomName")
		else
			self.nameDisplayController:SetSelectedState("oath")
		end

		if OathTools.IsCanShowInHeroInfoView() then
			self.oathReNameController:SetSelectedState("show")
		else
			self.oathReNameController:SetSelectedState("hide")
		end
	else
		self.nameDisplayController:SetSelectedState("normal")
		self.oathReNameController:SetSelectedState("hide")
	end

	if self.heroOathEnterObj1_ and self.heroOathEnterObj2_ then
		self.heroOathEnterObj1_:SetData(self.heroInfo_.id, self.heroViewProxy_)
		self.heroOathEnterObj2_:SetData(self.heroInfo_.id, self.heroViewProxy_)
	end
end

function HeroInfoView:UpdateView()
	self.openContent_ = false

	SetActive(self.comTipsGo_, self.openContent_)
	SetActive(self.proficiencyMaskBtn_.gameObject, self.openContent_)

	self.nameText_.text = GetI18NText(self.heroCfg_.name)
	self.subNameText_.text = self.heroViewProxy_:GetHeroName(self.heroInfo_.id)

	self.lockController_:SetSelectedState(tostring(not (self.heroInfo_.unlock ~= 0 or self.type_ == HeroConst.HERO_DATA_TYPE.PREVIEW)))
	self.isSelfController_:SetSelectedState(tostring(self.heroViewProxy_.isSelf))
	self.polyhedronController_:SetSelectedState(tostring(self.type_ == HeroConst.HERO_DATA_TYPE.POLYHEDRON))

	self.campLogo_.sprite = HeroTools.GetRaceIcon(self.heroCfg_.race)
	self.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroCfg_.id)

	if self.heroInfo_.unlock == 0 then
		self:UpdateLockedView()
	else
		self:UpdateUnlockedView()

		if self.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			ArchiveAction.CheckAllRelationRedPoint(self.heroCfg_.id)
		end
	end

	if self.heroViewProxy_.showRedPoint then
		if not isNil(self.moduleView_) and not isNil(self.moduleView_.transform) then
			manager.redPoint:bindUIandKey(self.moduleView_.transform, RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. self.heroInfo_.id)
		end

		manager.redPoint:bindUIandKey(self.surpassBtn_.transform, RedPointConst.HERO_STAR_ID .. self.heroInfo_.id)
		manager.redPoint:bindUIandKey(self.surpass01Btn_.transform, RedPointConst.HERO_STAR_ID .. self.heroInfo_.id)
		manager.redPoint:bindUIandKey(self.upgradeBtn_.transform, RedPointConst.HERO_BREAK_ID .. self.heroInfo_.id)
	end

	if not isNil(self.moduleView_) and not isNil(self.moduleView_.gameObject) then
		LuaForUtil.ActiveHoverEffect(self.moduleView_.gameObject, not self.heroViewProxy_.isSelf)
	end

	self:UpdateHeroOathInfo()
end

function HeroInfoView:GetHeroPiece()
	return self.heroInfo_.piece
end

function HeroInfoView:UpdateLockedView()
	local var_21_0 = self:GetHeroPiece()
	local var_21_1 = GameSetting.unlock_hero_need.value[self.heroCfg_.rare]
	local var_21_2 = math.min(var_21_0, GameSetting.unlock_hero_need.value[self.heroCfg_.rare])

	self.pieceCost_ = -GameSetting.unlock_hero_need.value[self.heroCfg_.rare]
	self.curPieceText_.text = tostring(var_21_0)
	self.needPieceText_.text = "/" .. tostring(GameSetting.unlock_hero_need.value[self.heroCfg_.rare])

	if self.tweenValue_ then
		LeanTween.cancel(self.tweenValue_.id)

		self.tweenValue_ = nil
	end

	self.tweenValue_ = LeanTween.value(0, 0.7, 0.7):setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
		self.scheduleImage_.fillAmount = var_21_2 * ((arg_22_0 >= 0.2 or nil) and (arg_22_0 - 0.2) / 0.5) / var_21_1
	end)):setOnComplete(LuaHelper.VoidAction(function()
		if self.tweenValue_ then
			self.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			self.tweenValue_ = nil
		end

		self.scheduleImage_.fillAmount = var_21_2 / var_21_1
	end)):setEase(LeanTweenType.easeOutQuad)

	if GameSetting.unlock_hero_need.value[self.heroCfg_.rare] <= var_21_0 then
		self.pieceEnoughController_:SetSelectedState("true")

		self.getText_.text = GetTips("DORM_CANTEEN_LEVEL_UNLOCK")
	else
		self.pieceEnoughController_:SetSelectedState("false")

		self.getText_.text = GetTips("TIP_GET")
	end
end

function HeroInfoView:UpdateModuleView()
	SetActive(self.moduleView_.gameObject, WeaponModuleCfg[self.heroInfo_.id] and not self.heroViewProxy_.hideModule)

	if WeaponModuleCfg[self.heroInfo_.id] then
		if self.heroInfo_.moduleLevel == 0 then
			self.moduleController_:SetSelectedState("lock")
		else
			self.moduleController_:SetSelectedState("unlock")

			self.moduleNameText_.text = WeaponModuleCfg[self.heroInfo_.id].name
			self.moduleImg_.spriteSync = "TextureConfig/WeaponModule/" .. self.heroInfo_.id
			self.moduleLevelText_.text = "Lv." .. self.heroInfo_.moduleLevel
		end
	end
end

function HeroInfoView:UpdateUnlockedView()
	if self.type_ ~= HeroConst.HERO_DATA_TYPE.PREVIEW then
		if self.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			self.proficiencyText_.text = HeroTools.GetHeroProficiency(self.heroInfo_.id) .. "/" .. GameSetting.mastery_level_max.value[1]
		end

		local var_25_0 = self.heroInfo_.level
		local var_25_1 = self.heroInfo_.exp

		self.battlePower_ = self.heroViewProxy_:GetBattlePower(self.heroInfo_.id, self.heroInfo_.tempID)

		if self.battlePowerTween_ then
			LeanTween.cancel(self.battlePowerTween_.id)

			self.battlePowerTween_ = nil
		end

		if self.oldBattlePower_ ~= self.battlePower_ then
			local var_25_2 = self.oldBattlePower_ or 0
			local var_25_3 = self.battlePower_

			self.battlePowerTween_ = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
				self.fightPowerText_.text = math.floor(var_25_2 + (var_25_3 - var_25_2) * arg_26_0)
			end)):setOnComplete(LuaHelper.VoidAction(function()
				if self.battlePowerTween_ then
					self.battlePowerTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

					self.battlePowerTween_ = nil
				end

				self.fightPowerText_.text = var_25_3
			end)):setEase(LeanTweenType.easeOutQuad)
			self.oldBattlePower_ = self.battlePower_
		else
			self.fightPowerText_.text = self.oldBattlePower_
		end

		local var_25_4 = HeroTools.GetHeroCurrentMaxLevel(self.heroInfo_)
		local var_25_5 = var_25_1 - LvTools.LevelToExp(var_25_0, "hero_level_exp1")

		self.att_ = self.heroViewProxy_:GetHeroAllAttribute(self.heroInfo_.id)

		for iter_25_0, iter_25_1 in pairs(self.propItems_) do
			local var_25_6 = PublicAttrCfg[self.propIndexes_[iter_25_0]].percent == 1

			if self.oldAtt_[self.propIndexes_[iter_25_0]] ~= self.att_[self.propIndexes_[iter_25_0]] then
				local var_25_7 = self.oldAtt_[self.propIndexes_[iter_25_0]] or 0
				local var_25_8 = self.att_[self.propIndexes_[iter_25_0]]

				if self.tweens_[iter_25_0] then
					LeanTween.cancel(self.tweens_[iter_25_0].id)

					self.tweens_[iter_25_0] = nil
				end

				self.tweens_[iter_25_0] = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					local var_28_0 = math.floor(var_25_7 + (var_25_8 - var_25_7) * arg_28_0)

					iter_25_1.text = var_25_6 and string.format("%.2f", var_28_0 / 10) .. self.endfixes_[iter_25_0] or math.floor(var_28_0)
				end)):setOnComplete(LuaHelper.VoidAction(function()
					if self.tweens_[iter_25_0] then
						self.tweens_[iter_25_0]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

						self.tweens_[iter_25_0] = nil
					end

					iter_25_1.text = var_25_6 and string.format("%.2f", var_25_8 / 10) .. self.endfixes_[iter_25_0] or math.floor(var_25_8)
				end)):setEase(LeanTweenType.easeOutQuad)
				self.oldAtt_[self.propIndexes_[iter_25_0]] = self.att_[self.propIndexes_[iter_25_0]]
			end
		end

		self.nowLevelText_.text = tostring(var_25_0)
		self.topLevelText_.text = "/" .. var_25_4

		if var_25_0 < var_25_4 then
			var_25_5 = self.type_ == HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME and var_25_5 < 0 and 0 or var_25_5

			local var_25_9 = GameLevelSetting[var_25_0].hero_level_exp1

			self.expProgressBar_.value = math.floor(var_25_5 / GameLevelSetting[var_25_0].hero_level_exp1 * 1000) / 1000
			self.expText_.text = string.format("%d/%d", var_25_5, var_25_9)
		else
			var_25_5 = self.type_ == HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME and var_25_5 < 0 and 0 or var_25_5

			if LvTools.GetIsMaxLv(var_25_0, "hero") then
				self.expProgressBar_.value = 1
				self.expText_.text = "-/-"
			else
				local var_25_10 = GameLevelSetting[var_25_0].hero_level_exp1

				self.expProgressBar_.value = math.floor(var_25_5 / GameLevelSetting[var_25_0].hero_level_exp1 * 1000) / 1000
				self.expText_.text = string.format("%d/%d", var_25_5, var_25_10)
			end
		end
	end

	self.starImg_.sprite = getSprite("Atlas/Common", "star_" .. HeroStarCfg[self.heroInfo_.star].star)
	self.rangeTypeText_.text = CharactorParamCfg[self.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")

	self:UpdateUnlockBtnState()
	self:RefreshChargeType()
	self:UpdateModuleView()
end

function HeroInfoView:UpdateUnlockBtnState()
	if self.heroInfo_.level >= HeroConst.HERO_LV_MAX then
		self.levelStateController_:SetSelectedState("maxLevel")
	elseif self.heroInfo_.level >= HeroTools.GetHeroCurrentMaxLevel(self.heroInfo_) then
		self.levelStateController_:SetSelectedState("break")

		self.upgradeBtnText_.text = GetTips("TIP_BREAK")
	else
		self.levelStateController_:SetSelectedState("addExp")

		self.upgradeBtnText_.text = GetTips("TEXT_UPGRADE")
	end
end

function HeroInfoView:RefreshChargeType()
	self.chargeType_.text = HeroTools.GetChargeTextByType(self.heroCfg_.mechanism_type[1])
end

function HeroInfoView:OnEnter(arg_32_1)
	self:SetProxy(arg_32_1)
	self:RegistEventListener(HERO_DATA_MODIFY, handler(self, self.OnHeroModify))
	self:RegistEventListener(OATH_CHANGE_NAME, handler(self, self.OnHeroModify))
end

function HeroInfoView:OnExit()
	if not isNil(self.moduleView_) and not isNil(self.moduleView_.transform) then
		manager.redPoint:unbindUIandKey(self.moduleView_.transform)
	end

	manager.redPoint:unbindUIandKey(self.surpassBtn_.transform)
	manager.redPoint:unbindUIandKey(self.surpass01Btn_.transform)
	manager.redPoint:unbindUIandKey(self.upgradeBtn_.transform)

	if self.heroOathEnterObj1_ and self.heroOathEnterObj2_ then
		self.heroOathEnterObj1_:OnExit()
		self.heroOathEnterObj2_:OnExit()
	end

	self:RemoveAllEventListener()
end

function HeroInfoView:SetProxy(arg_34_1)
	self.heroViewProxy_ = arg_34_1
	self.type_ = self.heroViewProxy_:GetViewDataType()
end

function HeroInfoView:OnHeroModify(arg_35_1)
	if arg_35_1 == self.heroInfo_.id then
		self:UpdateView()
	end
end

function HeroInfoView:Dispose()
	self:RemoveAllListeners()

	if self.heroOathEnterObj1_ and self.heroOathEnterObj2_ then
		self.heroOathEnterObj1_:Dispose()
		self.heroOathEnterObj2_:Dispose()

		self.heroOathEnterObj1_ = nil
		self.heroOathEnterObj2_ = nil
	end

	if self.tweenValue_ then
		self.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tweenValue_.id)

		self.tweenValue_ = nil
	end

	if self.battlePowerTween_ then
		self.battlePowerTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.battlePowerTween_.id)

		self.battlePowerTween_ = nil
	end

	if self.tweens_ then
		for iter_36_0, iter_36_1 in pairs(self.tweens_) do
			iter_36_1:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
			LeanTween.cancel(iter_36_1.id)
		end

		self.tweens_ = nil
	end

	self.handler_ = nil

	HeroInfoView.super.Dispose(self)
end

return HeroInfoView
