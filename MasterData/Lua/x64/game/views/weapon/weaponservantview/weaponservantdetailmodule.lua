local WeaponServantDetailModule = class("WeaponServantDetailModule", ReduxView)

function WeaponServantDetailModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function WeaponServantDetailModule:BuildContext()
	self.controller = {
		comps = self.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			btnState = {
				beyond = "beyond",
				name = "btnState",
				equipped = "equipped",
				detail = "detail"
			}
		}
	}
	self.data = {}
	self.constVar = {
		rareBg = "",
		subDescColor = "#70767F",
		lockImg = {
			unlocked = "com_white_icon_26",
			locked = "com_white_icon_25"
		},
		proxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	}
end

function WeaponServantDetailModule:InitContext()
	self.data = {
		servantAddLv = 0,
		heroId = 0,
		descType = 1,
		info = {}
	}
end

function WeaponServantDetailModule:Init()
	self:BindCfgUI()
	self:BuildContext()
	self:AddUIListener()
end

function WeaponServantDetailModule:AddUIListener()
	self:AddBtnListener(self.detailBtn_, nil, function()
		self:OnSwitchDescClick()
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		self:OnLockBtnClick()
	end)
	self:RegistEventListener(SERVANT_LOCK, handler(self, self.OnServantLock))
end

function WeaponServantDetailModule:OnEnter()
	return
end

function WeaponServantDetailModule:OnExit()
	return
end

function WeaponServantDetailModule:Dispose()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	WeaponServantDetailModule.super.Dispose(self)
end

function WeaponServantDetailModule:OnRenderModule(arg_11_1)
	self:InitContext()

	local var_11_0 = clone(arg_11_1.servantData)

	self.data.info = var_11_0

	local var_11_1 = 0

	self.data.heroId = arg_11_1.heroId

	if arg_11_1.heroId and arg_11_1.heroId > 0 then
		var_11_1 = HeroTools.GetHeroWeaponAddLevel((self:GetHeroInfo(arg_11_1.heroId)))
	end

	self.data.servantAddLv = var_11_1
	self.stageTxt_.text = var_11_1 > 0 and string.format(GetTips("SERVANT_PROMOTE_LEVEL"), var_11_0.stage, var_11_1) or string.format(GetTips("SERVANT_PROMOTE_LEVEL_1"), var_11_0.stage)
	self.nameTxt_.text = ItemTools.getItemName(ItemCfg[var_11_0.id].id)

	local var_11_2 = string.format("com_white_icon_group_%d_c", WeaponServantCfg[var_11_0.id].race)

	self.groupImg_.sprite = getSprite("Atlas/SystemGroupAtlas", var_11_2)
	self.groupTitleImg_.sprite = getSprite("Atlas/SystemGroupAtlas", var_11_2)
	self.groupTitleTxt_.text = string.format(GetTips("EQUIP_RACE"), GetI18NText(RaceEffectCfg[WeaponServantCfg[var_11_0.id].race].name))

	self:RenderLock()
	self:RefreshEffectText()
	self:RefreshRecommend()

	self.attackRatioTxt_.text = table.concat({
		"+",
		WeaponServantCfg[var_11_0.id].attrib_addition,
		"%"
	})

	local var_11_3, var_11_4, var_11_5 = SkillTools.GetAttr(WeaponServantCfg[var_11_0.id].attribute)

	self.subAttrNameTxt_.text = var_11_3
	self.subAttrTxt_.text = "+" .. var_11_4
	self.subAttrIconImg_.sprite = var_11_5

	self:RenderEquipStatus()
	self:RenderLockObj()
end

function WeaponServantDetailModule:RenderLock()
	self.lockImg_.sprite = self.data.info.locked == 1 and getSprite("Atlas/SystemCommonAtlas", self.constVar.lockImg.locked) or getSprite("Atlas/SystemCommonAtlas", self.constVar.lockImg.unlocked)
end

function WeaponServantDetailModule:RenderLockObj()
	if self.data.info.uid then
		SetActive(self.lockImg_.gameObject, true)
	else
		SetActive(self.lockImg_.gameObject, false)
	end
end

function WeaponServantDetailModule:SwitchControllerState(arg_14_1, arg_14_2)
	local var_14_0 = self.controller.comps:GetController(arg_14_1)

	if var_14_0 then
		var_14_0:SetSelectedState(arg_14_2)
	end
end

function WeaponServantDetailModule:GetHeroInfo(arg_15_1)
	return self.constVar.proxy:GetHeroData(arg_15_1)
end

function WeaponServantDetailModule:RefreshEffectText()
	local var_16_0 = ""
	local var_16_1 = GetI18NText(WeaponServantCfg[self.data.info.id].desc)

	if self.data.descType == 1 then
		var_16_0 = self.constVar.proxy:GetServantEffect(self.data.info.id, nil, true)
		self.detailTxt_.text = GetTips("SERVANT_DETAIL_FULL")
	else
		var_16_0 = self.constVar.proxy:GetServantEffect(self.data.info.id, self.data.info.stage + self.data.servantAddLv)
		self.detailTxt_.text = GetTips("SERVANT_DETAIL_SIMPLE")
	end

	self.descTxt_.text = table.concat({
		GetI18NText(var_16_0),
		"\n<color=",
		self.constVar.subDescColor,
		">",
		var_16_1,
		"</color>"
	})
end

function WeaponServantDetailModule:RefreshRecommend()
	local var_17_0 = 0

	if WeaponServantCfg[self.data.info.id].effect[1] > 0 then
		var_17_0 = WeaponEffectCfg[WeaponServantCfg[self.data.info.id].effect[1]].spec_char[1]
	end

	if var_17_0 ~= nil and var_17_0 > 0 then
		SetActive(self.recommendObj_, true)

		self.heroImg_.sprite = HeroTools.GetSmallHeadSprite(var_17_0)
	else
		SetActive(self.recommendObj_, false)
	end
end

function WeaponServantDetailModule:RenderEquipStatus()
	if self.data.info.uid then
		if ServantTools.GetServantMap()[self.data.info.uid] then
			SetActive(self.equipObj_, true)

			self.equipHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(ServantTools.GetServantMap()[self.data.info.uid])
			self.equipHeroTxt_.text = string.format(GetTips("SERVANT_EQUIPED"), GetI18NText(HeroCfg[ServantTools.GetServantMap()[self.data.info.uid]].name))
		else
			SetActive(self.equipObj_, false)
		end
	else
		SetActive(self.equipObj_, false)
	end
end

function WeaponServantDetailModule:OnSwitchDescClick()
	self.data.descType = (self.data.descType + 1) % 2

	self:RefreshEffectText()
end

function WeaponServantDetailModule:OnLockBtnClick()
	if self.data.info.uid and self.data.info.uid ~= 0 then
		ServantAction.ServantLock(self.data.info.uid)
	end
end

function WeaponServantDetailModule:OnServantLock(arg_21_1, arg_21_2)
	if self.data.info.uid and self.data.info.uid ~= 0 and arg_21_1 == self.data.info.uid then
		self.data.info.locked = arg_21_2

		self:RenderLock()
	end
end

return WeaponServantDetailModule
