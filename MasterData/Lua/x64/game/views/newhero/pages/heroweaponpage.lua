local HeroWeaponPage = class("HeroWeaponPage", HeroPageBase)

function HeroWeaponPage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function HeroWeaponPage:Init()
	self.weaponInfo_ = {}
	self.heroInfo_ = {}
	self.servantInfo_ = {}

	self:InitUI()
	self:AddUIListener()

	self.lockController_ = self.controller_:GetController("lock")
	self.isSelfController_ = self.controller_:GetController("isSelf")
end

function HeroWeaponPage:SetHeroInfo(arg_3_1)
	self.type_ = self.heroViewProxy_:GetViewDataType()
	self.heroInfo_ = arg_3_1

	if self.heroViewProxy_.showRedPoint then
		manager.redPoint:bindUIandKey(self.weaponstrengthTrs_, RedPointConst.HERO_WEAPON_BREAK_ID .. self.heroInfo_.id)
	end
end

function HeroWeaponPage:UpdateView()
	self.servantInfo_ = self.heroViewProxy_:GetHeroServantInfo(self.heroInfo_.id)

	self:RefreshServant(self.servantInfo_)
	self:RefreshWeapon()
	self:RefreshStrengthText()

	if not isNil(self.servantcontentBtn_) and not isNil(self.servantcontentBtn_.gameObject) then
		LuaForUtil.ActiveHoverEffect(self.servantcontentBtn_.gameObject, not self.heroViewProxy_.isSelf)
	end
end

function HeroWeaponPage:RefreshStrengthText()
	self.weaponstrengthText_.text = HeroData:GetHeroList()[self.heroInfo_.id].weapon_info.level == HeroConst.WEAPON_LV_MAX and GetTips("TIP_DETAIL") or GameSetting.weapon_exp_limit.value[self.weaponInfo_.breakthrough + 1] == self.weaponInfo_.level and self.weaponInfo_.level ~= HeroConst.WEAPON_LV_MAX and GetTips("TIP_BREAK") or GetTips("TIP_STRENGTH")
end

function HeroWeaponPage:AddUIListener()
	self:AddBtnListener(self.weaponstrengthBtn_, nil, function()
		if HeroData:GetHeroList()[self.heroInfo_.id].weapon_info.level == HeroConst.WEAPON_LV_MAX then
			self:Go("/weapon", {
				state = "detail",
				HeroID = self.heroInfo_.id
			})

			return
		end

		self:Go("/weapon", {
			state = "strength",
			HeroID = self.heroInfo_.id
		})
	end)
	self:AddBtnListener(self.servantcontentBtn_, nil, function()
		local var_8_0

		if not self.heroViewProxy_.isSelf then
			do return end

			var_8_0 = {}
		end

		for iter_8_0, iter_8_1 in pairs((WeaponServantData:GetWeaponServantList())) do
			if WeaponServantCfg[iter_8_1.id].race == HeroCfg[self.heroInfo_.id].race then
				table.insert(var_8_0, iter_8_1)
			end
		end

		local var_8_2 = HeroTools.GetHeroServantInfo(self.heroInfo_.id)

		if var_8_2 then
			if self:CheckCanEnterServant() then
				self:Go("/weaponServant", {
					state = "onlydetail",
					HeroID = self.heroInfo_.id,
					id = var_8_2.id
				})
			end
		elseif self:CheckCanEnterServant() then
			self:Go("/weaponServant", {
				state = "onlydetail",
				HeroID = self.heroInfo_.id
			})
		end
	end)
end

function HeroWeaponPage:CheckCanEnterServant()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs((WeaponServantData:GetWeaponServantList())) do
		if WeaponServantCfg[iter_9_1.id].race == HeroCfg[self.heroInfo_.id].race then
			table.insert(var_9_0, iter_9_1)
		end
	end

	if #var_9_0 == 0 then
		ShowTips("NO_SERVANT_CAN_BE_EQUIPED")

		return false
	end

	return true
end

function HeroWeaponPage:OnServantLock(arg_10_1, arg_10_2)
	self.servantInfo_ = HeroTools.GetHeroServantInfo(self.heroInfo_.id)
end

function HeroWeaponPage:InitUI()
	self:BindCfgUI()

	self.servanticonImg_.immediate = true
	self.servantRareController_ = ControllerUtil.GetController(self.servantGo_.transform, "servantrare")
	self.servantController = ControllerUtil.GetController(self.servantGo_.transform, "hasservant")
	self.btnStatus_ = "MERGE"
end

function HeroWeaponPage:RefreshWeapon()
	self.weaponInfo_ = deepClone(self.heroViewProxy_:GetHeroWeaponInfo(self.heroInfo_.id))

	local var_12_0 = self.heroInfo_.id
	local var_12_1, var_12_2 = WeaponTools.AddWeaponExp(self.weaponInfo_.exp, self.weaponInfo_.breakthrough, 0)

	SetActive(self.servantGo_, not self.heroViewProxy_.hideServant)

	self.nameText_.text = HeroCfg[var_12_0].weapon_name
	self.nowlvText_.text = var_12_2
	self.toplvText_.text = "/" .. GameSetting.weapon_exp_limit.value[self.weaponInfo_.breakthrough + 1] or HeroConst.WEAPON_LV_MAX

	if var_12_2 == HeroConst.WEAPON_LV_MAX then
		self:RefreshExpBar(1)

		self.expText_.text = "-/-"
	else
		local var_12_3 = GameLevelSetting[var_12_2].weapon_level_exp

		self:RefreshExpBar(var_12_1 / GameLevelSetting[var_12_2].weapon_level_exp)

		self.expText_.text = var_12_1 .. "/" .. var_12_3
	end

	local var_12_4 = WeaponTools.WeaponAtk(self.weaponInfo_.level, self.weaponInfo_.breakthrough)

	self.atkText_.text = (self.servantInfo_.id == 0 or self.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW) and string.format("%d", var_12_4) or string.format("%d<color=#E78300>+%d</color>", var_12_4, WeaponServantCfg[self.servantInfo_.id].attrib_addition * var_12_4 / 100)

	local var_12_6, var_12_7 = SkillTools.GetAttr(HeroCfg[var_12_0].weapon_break_attribute[self.weaponInfo_.breakthrough + 1])

	self.criText_.text = var_12_7

	self:CheckLocked()
end

function HeroWeaponPage:CheckLocked()
	self.lockController_:SetSelectedState(tostring(not self.heroViewProxy_.isSelf))
end

function HeroWeaponPage:RefreshExpBar(arg_14_1)
	self.expSlider_.value = arg_14_1
end

function HeroWeaponPage:RefreshServantModel()
	if not self.servantInfo_ or not self.servantInfo_.id or self.servantInfo_.id == 0 then
		manager.heroRaiseTrack:PlayServantAnim("Fade")

		return
	end

	manager.heroRaiseTrack:PlayServantAnim("Gray")

	if self.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		manager.heroRaiseTrack:SetWeaponServantID(nil)
	else
		manager.heroRaiseTrack:SetWeaponServantID(self.servantInfo_.id)
	end
end

function HeroWeaponPage:RefreshServant(arg_16_1)
	self.isSelfController_:SetSelectedState(tostring(self.heroViewProxy_.isSelf))

	if not arg_16_1 or arg_16_1.id == 0 then
		self.servantController:SetSelectedState("false")

		return
	end

	self.servantController:SetSelectedState("true")

	self.servantnameText_.text = ItemTools.getItemName(arg_16_1.id)

	self.servantRareController_:SetSelectedState(tostring(WeaponServantCfg[arg_16_1.id].starlevel))

	self.servanticonImg_.spriteSync = SpritePathCfg.ServantIcon438.path .. arg_16_1.id
	self.raceImg_.sprite = getSprite("Atlas/CampItemAtlas", (string.format("icon_group_%d_c", WeaponServantCfg[arg_16_1.id].race)))

	local var_16_0 = HeroTools.GetHeroWeaponAddLevel(self.heroInfo_)

	self.refinetextText_.text = var_16_0 > 0 and string.format(GetTips("SERVANT_PROMOTE_LEVEL"), arg_16_1.stage, var_16_0) or string.format(GetTips("SERVANT_PROMOTE_LEVEL_1"), arg_16_1.stage)
end

function HeroWeaponPage:Hide()
	SetActive(self.gameObject_, false)
	HeroTools.StopTalk()
end

function HeroWeaponPage:Show()
	HeroWeaponPage.super.Show(self)
	SetActive(self.gameObject_, true)
	self:UpdateView()
end

function HeroWeaponPage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		3,
		0,
		0
	}, self.displayGo_)
	self:RefreshServantModel()
end

function HeroWeaponPage:OnEnter(arg_20_1)
	self.heroViewProxy_ = arg_20_1
end

function HeroWeaponPage:Dispose()
	manager.redPoint:unbindUIandKey(self.weaponstrengthTrs_)
	self:RemoveAllListeners()
	HeroWeaponPage.super.Dispose(self)
end

return HeroWeaponPage
