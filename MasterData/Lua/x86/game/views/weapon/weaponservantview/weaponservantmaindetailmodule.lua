local WeaponServantMainDetailModule = class("WeaponServantMainDetailModule", ReduxView)

function WeaponServantMainDetailModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function WeaponServantMainDetailModule:BuildContext()
	local var_2_0 = self.gameObject_:GetComponent("ControllerExCollection")

	self.controller = {
		comps = var_2_0,
		state = {
			btnState = {
				beyond = "beyond",
				name = "btnState",
				callName = "callName",
				unReached = "unReached",
				no = "no",
				detail = "detail",
				comps = var_2_0:GetController("btnState")
			},
			equipBtnState = {
				False = "false",
				name = "equipBtnState",
				True = "true",
				comps = var_2_0:GetController("equipBtnState")
			},
			callNameBtnState = {
				False = "false",
				name = "callNameBtnState",
				True = "true",
				comps = var_2_0:GetController("callNameBtnState")
			},
			star = {
				Star1 = "star1",
				name = "star",
				Star4 = "star4",
				Star5 = "star5",
				Star3 = "star3",
				Star2 = "star2",
				comps = var_2_0:GetController("star")
			}
		}
	}
	self.data = {}
	self.constVar = {
		GACHA_POOL_SYSTEM_LINK_ID = 403,
		curBtnStyle = 1,
		descType = 1,
		rareBg = "",
		subDescColor = "#70767F",
		btnStyleMap = {
			self.controller.state.btnState.beyond,
			self.controller.state.btnState.callName,
			self.controller.state.btnState.detail
		},
		exchangeBtnLang = {
			Equip = GetTips("SERVANT_DETAIL_EQUIP"),
			Exchange = GetTips("TIP_CHANGE"),
			TakeOff = GetTips("SERVANT_DETAIL_UNLOAD"),
			Change = GetTips("TIP_CHANGE")
		},
		lockImg = {
			unlocked = "com_white_icon_26",
			locked = "com_white_icon_25"
		},
		proxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	}
end

function WeaponServantMainDetailModule:InitContext()
	self.data = {
		servantAddLv = 0,
		heroId = 0,
		info = {},
		servantMap = ServantTools.GetServantMap()
	}
end

function WeaponServantMainDetailModule:Init()
	self:BindCfgUI()
	self:BuildContext()
	self:AddUIListener()
end

function WeaponServantMainDetailModule:AddUIListener()
	self:AddBtnListener(self.detailBtn_, nil, function()
		self:OnSwitchDescClick()
	end)
	self:AddBtnListener(self.detailsBtn_, nil, function()
		self:OnServantDetailClick()
	end)
	self:AddBtnListener(self.gachaBtn_, nil, function()
		self:OnGachaBtnClick()
	end)
	self:AddBtnListener(self.callNameBtn_, nil, function()
		self:OnCallNameBtnClick()
	end)
	self:AddBtnListener(self.exchangeBtn_, nil, function()
		self:OnExchangeBtnClick()
	end)
	self:AddBtnListener(self.beyondBtn_, nil, function()
		self:OnBeyondBtnClick()
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		self:OnLockBtnClick()
	end)
	TerminologyTools.AddTerminologyHandler(self, self.descTxt_, nil, nil)
end

function WeaponServantMainDetailModule:OnEnter()
	return
end

function WeaponServantMainDetailModule:OnExit()
	self.constVar.descType = 1
end

function WeaponServantMainDetailModule:Dispose()
	self:RemoveAllListeners()
	WeaponServantMainDetailModule.super.Dispose(self)
end

function WeaponServantMainDetailModule:RegisteCallNameClickCallback(arg_16_1)
	self.constVar.onCallNameClick = arg_16_1
end

function WeaponServantMainDetailModule:OnRenderServant(arg_17_1, arg_17_2)
	if not arg_17_1 then
		return
	end

	self:InitContext(self.data)

	self.data.info = arg_17_1

	local var_17_0 = 0

	self.data.heroId = arg_17_2

	if arg_17_2 and arg_17_2 > 0 then
		var_17_0 = HeroTools.GetHeroWeaponAddLevel((self:GetHeroInfo(arg_17_2)))
	end

	self.data.servantAddLv = var_17_0
	self.stageTxt_.text = var_17_0 > 0 and string.format(GetTips("SERVANT_PROMOTE_LEVEL"), arg_17_1.stage, var_17_0) or string.format(GetTips("SERVANT_PROMOTE_LEVEL_1"), arg_17_1.stage)

	local var_17_1 = arg_17_1.id
	local var_17_2 = WeaponServantCfg[arg_17_1.id]

	self.nameTxt_.text = ItemTools.getItemName(ItemCfg[arg_17_1.id].id)
	self.servantImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponServant/Icon/" .. var_17_1)
	self.gradeImg_.sprite = getSprite("Atlas/Com_DynamicAtlas", "ui_pop_grade_0" .. 6 - ItemCfg[arg_17_1.id].rare)

	self:SwitchControllerState(self.controller.state.star.name, string.format("star%d", ItemCfg[arg_17_1.id].rare))

	local var_17_3 = string.format("com_white_icon_group_%d_c", var_17_2.race)

	self.groupImg_.sprite = getSprite("Atlas/SystemGroupAtlas", var_17_3)
	self.groupTitleImg_.sprite = getSprite("Atlas/SystemGroupAtlas", var_17_3)
	self.groupTitleTxt_.text = string.format(GetTips("EQUIP_RACE"), GetI18NText(RaceEffectCfg[var_17_2.race].name))
	self.lockImg_.sprite = arg_17_1.locked == 1 and getSprite("Atlas/SystemCommonAtlas", self.constVar.lockImg.locked) or getSprite("Atlas/SystemCommonAtlas", self.constVar.lockImg.unlocked)
	self.attackRatioTxt_.text = table.concat({
		"+",
		var_17_2.attrib_addition,
		"%"
	})

	local var_17_4, var_17_5, var_17_6 = SkillTools.GetAttr(var_17_2.attribute)

	self.subAttrNameTxt_.text = var_17_4
	self.subAttrTxt_.text = "+" .. var_17_5
	self.subAttrIconImg_.sprite = var_17_6

	self:RenderEquipStatus()
	self:RefreshEffectText()
	self:RefreshRecommend()
	self:RenderBtnLogic()
	self:RenderLockObj()
end

function WeaponServantMainDetailModule:SwitchControllerState(arg_18_1, arg_18_2)
	if self.controller.state[arg_18_1] then
		self.controller.state[arg_18_1].comps:SetSelectedState(arg_18_2)
	end
end

function WeaponServantMainDetailModule:GetHeroInfo(arg_19_1)
	if self.constVar.proxy and arg_19_1 and arg_19_1 ~= 0 then
		return self.constVar.proxy:GetHeroData(arg_19_1)
	else
		return nil
	end
end

function WeaponServantMainDetailModule:GetServantInfo(arg_20_1)
	if self.constVar.proxy and arg_20_1 and arg_20_1 ~= 0 then
		return self.constVar.proxy:GetHeroServantInfo(arg_20_1)
	else
		return nil
	end
end

function WeaponServantMainDetailModule:RefreshEffectText()
	local var_21_0 = ""
	local var_21_1 = WeaponServantCfg[self.data.info.id].desc

	if self.constVar.descType == 1 then
		var_21_0 = self.constVar.proxy:GetServantEffect(self.data.info.id, nil, true)
		self.detailTxt_.text = GetTips("SERVANT_DETAIL_FULL")
	else
		var_21_0 = self.constVar.proxy:GetServantEffect(self.data.info.id, self.data.info.stage + self.data.servantAddLv)
		self.detailTxt_.text = GetTips("SERVANT_DETAIL_SIMPLE")
	end

	self.descTxt_.text = table.concat({
		var_21_0,
		"\n<color=",
		self.constVar.subDescColor,
		">",
		var_21_1,
		"</color>"
	})
end

function WeaponServantMainDetailModule:RefreshRecommend()
	local var_22_0 = 0

	if WeaponServantCfg[self.data.info.id].effect[1] > 0 then
		var_22_0 = WeaponEffectCfg[WeaponServantCfg[self.data.info.id].effect[1]].spec_char[1]
	end

	if var_22_0 ~= nil and var_22_0 > 0 then
		SetActive(self.recommendObj_, true)

		self.heroImg_.sprite = HeroTools.GetSmallHeadSprite(var_22_0)
	else
		SetActive(self.recommendObj_, false)
	end
end

function WeaponServantMainDetailModule:RenderEquipStatus()
	if self.data.info.uid then
		if self.data.servantMap[self.data.info.uid] then
			SetActive(self.equipObj_, true)

			self.equipHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(self.data.servantMap[self.data.info.uid])
			self.equipHeroTxt_.text = string.format(GetTips("SERVANT_EQUIPED"), GetI18NText(HeroCfg[self.data.servantMap[self.data.info.uid]].name))
		else
			SetActive(self.equipObj_, false)
		end
	else
		SetActive(self.equipObj_, false)
	end
end

function WeaponServantMainDetailModule:RenderLockObj()
	if self.data.info.uid and self.data.info.uid ~= 0 then
		SetActive(self.lockImg_.gameObject, true)
	else
		SetActive(self.lockImg_.gameObject, false)
	end
end

function WeaponServantMainDetailModule:OnSwitchDescClick()
	self.constVar.descType = (self.constVar.descType + 1) % 2

	self:RefreshEffectText()
end

function WeaponServantMainDetailModule:OnServantDetailClick()
	if self.data.info then
		if self.constVar.curBtnStyle == 3 then
			local var_26_0 = false

			if self.data.info.isCustom then
				var_26_0 = true
			elseif not self.data.info.uid then
				var_26_0 = true
			elseif ServantTools.IsSleepServant(self.data.info.id) then
				var_26_0 = true
			end

			local var_26_1 = {
				disableTabList = {
					[2] = var_26_0
				}
			}

			var_26_1.disableOrigin = self.data.info.isCustom or false

			JumpTools.OpenPageByJump("/showServantDetailsView", {
				servantData = self.data.info,
				heroId = self.data.heroId,
				openContext = var_26_1
			})
		elseif self:CheckCanCallName() then
			self:OnCallNameBtnClick()
		end
	end
end

function WeaponServantMainDetailModule:OnGachaBtnClick()
	if ServantTools.IsSleepServant(self.data.info.id) then
		self:OnServantDetailClick()

		return
	end

	DrawAction.SetPollUpIDIgnoreFail(DrawConst.WEAPON_SERVANT_POOL_ID, (ServantTools.GetSleepyServantByServant(self.data.info.id)))
end

function WeaponServantMainDetailModule:OnCallNameBtnClick()
	local var_28_0 = self.data.info.id

	if ServantTools.IsSleepServant(self.data.info.id) then
		self:JumpToCallName()

		return
	end

	local var_28_1 = WeaponServantCfg[var_28_0]
	local var_28_2, var_28_3 = self:MaterialEnough(var_28_0)

	if not var_28_2 then
		ShowTips("SERVANT_MERGE_MATERIAL_NOT_ENOUGH")

		return
	end

	if not var_28_3 then
		ShowTips("ERROR_ITEM_NOT_ENOUGH_GOLD")

		return
	end

	local var_28_4 = {}

	for iter_28_0, iter_28_1 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
		if iter_28_1[1] == var_28_1.race then
			var_28_4 = iter_28_1[2]
		end
	end

	local var_28_5 = WeaponServantData:GetWeaponServantById(var_28_4[1][1])
	local var_28_6 = 0

	if self.data.heroId and self.data.heroId ~= 0 then
		local var_28_7 = self:GetHeroInfo(self.data.heroId)

		if var_28_7 and not var_28_7.servant_uid then
			::label_28_0::

			var_28_6 = 0
		end
	end

	table.sort(var_28_5, function(arg_29_0, arg_29_1)
		if arg_29_0.locked ~= arg_29_1.locked then
			return arg_29_0.locked < arg_29_1.locked
		end

		return arg_29_0.uid < arg_29_1.uid
	end)

	local var_28_8 = 1

	if var_28_6 ~= 0 then
		for iter_28_2, iter_28_3 in ipairs(var_28_5) do
			if iter_28_3.uid == var_28_6 then
				var_28_8 = iter_28_2

				break
			end
		end
	end

	local var_28_9 = var_28_5[var_28_8].locked == 1
	local var_28_10 = var_28_5[var_28_8].uid

	if var_28_5[var_28_8].locked == 1 then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = (var_28_9 or nil) and string.format(GetTips("SERVANT_MATERIAL_LOCKED"), (ItemTools.getItemName(var_28_5[var_28_8].id))),
			OkCallback = function()
				self:Go("/weaponServantWakeUp", {
					race = self:GetCurServantRace(),
					servantID = var_28_0,
					uid = var_28_10,
					HeroId = self.data.heroId
				})
			end,
			CancelCallback = function()
				return
			end
		})
	else
		self:Go("/weaponServantWakeUp", {
			race = self:GetCurServantRace(),
			servantID = var_28_0,
			uid = var_28_5[var_28_8].uid,
			HeroId = self.data.heroId
		})
	end
end

function WeaponServantMainDetailModule:JumpToCallName()
	ServantTools.JumpToCallName(self.data.heroId, self.data.info.id)
end

function WeaponServantMainDetailModule:OnExchangeBtnClick()
	if not self:CheckRaceSame() then
		if self.data.heroId then
			ShowTips("ERROR_SERVANT_RACE_NO_MATCH")
		end

		return
	end

	local var_33_0 = self.data.info.uid
	local var_33_1 = self.data.heroId
	local var_33_2 = self:GetHeroInfo(self.data.heroId)

	if var_33_2 and var_33_0 == var_33_2.servant_uid then
		ServantAction.ServantReplace(self.data.heroId, 0)

		return
	end

	if self.data.servantMap[var_33_0] then
		ShowMessageBox({
			title = "Warning",
			content = string.format(GetTips("SERVANT_IS_USING"), GetI18NText(HeroCfg[self.data.servantMap[var_33_0]].name)),
			OkCallback = function()
				ServantAction.ServantReplace(var_33_1, var_33_0)
			end
		})

		return
	end

	ServantAction.ServantReplace(self.data.heroId, var_33_0)
end

function WeaponServantMainDetailModule:OnBeyondBtnClick()
	if self.data.info then
		if ServantTools.IsSleepServant(self.data.info.id) then
			ServantTools.JumpToCallName(self.data.heroId, self.data.info.id)
		else
			JumpTools.OpenPageByJump("/showServantDetailsView", {
				servantData = self.data.info,
				heroId = self.data.heroId,
				openContext = {
					tabIndex = 2
				}
			})
		end
	end
end

function WeaponServantMainDetailModule:OnLockBtnClick()
	if self.data.info.uid and self.data.info.uid ~= 0 then
		ServantAction.ServantLock(self.data.info.uid)
	end
end

function WeaponServantMainDetailModule:SwitchBtnStyle(arg_37_1)
	self.constVar.curBtnStyle = arg_37_1

	self:SwitchControllerState(self.controller.state.btnState.name, self.constVar.btnStyleMap[arg_37_1])
	self:RenderBtnLogic()
end

function WeaponServantMainDetailModule:RenderBtnLogic()
	if self.constVar.curBtnStyle == 1 then
		self:RenderBeyondBtnState()
	end

	if self.constVar.curBtnStyle == 2 then
		SetActive(self.callNameToken_, true)

		self.gachaBtnIcon_.sprite = getSprite("Atlas/Hero_servantAtlas", "icon_detection")
		self.gachaBtnTxt_.text = GetTips("SERVANT_MAIN_PAGE_GACHA")

		self:RenderCallNameBtn()
	else
		self:SwitchControllerState(self.controller.state.callNameBtnState.name, self.controller.state.callNameBtnState.True)
	end

	if self.constVar.curBtnStyle == 3 then
		if self.data.info and ServantTools.IsSleepServant(self.data.info.id) then
			self:SwitchControllerState(self.controller.state.btnState.name, self.constVar.btnStyleMap[2])
			SetActive(self.callNameToken_, false)

			self.gachaBtnIcon_.sprite = getSprite("Atlas/SystemCommonAtlas", "com_white_icon_08")
			self.gachaBtnTxt_.text = GetTips("TIP_DETAIL")
		else
			self:SwitchControllerState(self.controller.state.btnState.name, self.constVar.btnStyleMap[3])
		end

		self.upBtnTxt_.text = GetTips("SERVANT_MAIN_PAGE_DETAIL")
	end

	if self.constVar.curBtnStyle == 4 then
		self:SwitchControllerState(self.controller.state.btnState.name, self.controller.state.btnState.no)
	end
end

function WeaponServantMainDetailModule:RenderCallNameBtn()
	local var_39_0 = {}
	local var_39_1 = self:GetCurServantRace()

	for iter_39_0, iter_39_1 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
		if iter_39_1[1] == var_39_1 then
			var_39_0 = iter_39_1[2]
		end
	end

	local var_39_2 = WeaponServantData:GetWeaponServantById(var_39_0[1][1])
	local var_39_3 = 0

	if var_39_2 then
		var_39_3 = #var_39_2
	end

	local var_39_4 = ItemTools.getItemNum(var_39_0[2][1])
	local var_39_5 = tostring(var_39_3)

	if var_39_3 < var_39_0[1][2] then
		var_39_5 = "<color='#FF0000'>" .. var_39_5 .. "</color>"
	end

	local var_39_6 = var_39_5 .. "/" .. tostring(var_39_0[1][2])
	local var_39_7 = tostring(var_39_0[2][2])

	if var_39_4 < var_39_0[2][2] then
		self.costmoneyText_.text = "<color='#FF0000'>" .. tostring(var_39_0[2][2]) .. "</color>"
	end

	if var_39_3 >= var_39_0[1][2] and var_39_4 >= var_39_0[2][2] then
		self:SwitchControllerState(self.controller.state.callNameBtnState.name, self.controller.state.callNameBtnState.True)
	else
		self:SwitchControllerState(self.controller.state.callNameBtnState.name, self.controller.state.callNameBtnState.False)
	end
end

function WeaponServantMainDetailModule:RenderBeyondBtnState()
	if self.data.info == nil then
		return
	end

	if self.data.info.isRecommend then
		if self:CheckCanCallName() then
			self:SwitchControllerState(self.controller.state.btnState.name, self.controller.state.btnState.detail)

			self.upBtnTxt_.text = GetTips("SERVANT_MAIN_PAGE_CALLNAME")
		else
			self:SwitchControllerState(self.controller.state.btnState.name, self.controller.state.btnState.unReached)
		end
	else
		self:SwitchControllerState(self.controller.state.btnState.name, self.controller.state.btnState.beyond)

		if self.data.heroId then
			if not self.data.servantMap[self.data.info.uid] then
				local var_40_0 = self:GetServantInfo(self.data.heroId)

				self.exchangeEquipTxt_.text = var_40_0 and var_40_0.id ~= 0 and self.constVar.exchangeBtnLang.Change or self.constVar.exchangeBtnLang.Equip
			else
				self.exchangeEquipTxt_.text = self.data.heroId == self.data.servantMap[self.data.info.uid] and self.constVar.exchangeBtnLang.TakeOff or self.constVar.exchangeBtnLang.Exchange
			end
		end

		self:SwitchControllerState(self.controller.state.equipBtnState.name, (self:CheckRaceSame() or nil) and self.controller.state.equipBtnState.True)

		self.beyondBtnTxt_.text = ServantTools.IsSleepServant(self.data.info.id) and GetTips("SERVANT_MAIN_PAGE_CALLNAME") or GetTips("PROMOTE")
	end
end

function WeaponServantMainDetailModule:MaterialEnough(arg_41_1)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
		if iter_41_1[1] == WeaponServantCfg[arg_41_1].race then
			var_41_0 = iter_41_1[2]
		end
	end

	local var_41_1 = WeaponServantData:GetWeaponServantById(var_41_0[1][1])

	return (var_41_1 or nil) and #var_41_1 >= var_41_0[1][2], ItemTools.getItemNum(var_41_0[2][1]) >= var_41_0[2][2]
end

function WeaponServantMainDetailModule:CheckRaceSame()
	if not self.data.heroId then
		return false
	end

	if self.data.heroId == 0 then
		return false
	end

	return self:GetCurServantRace() == HeroCfg[self.data.heroId].race
end

function WeaponServantMainDetailModule:GetCurServantRace()
	return WeaponServantCfg[self.data.info.id].race
end

function WeaponServantMainDetailModule:CheckCanCallName()
	if WeaponServantCfg[self.data.info.id].summon_blocked == 1 then
		return false
	end

	local var_44_0, var_44_1 = self:MaterialEnough(self.data.info.id)

	return var_44_0
end

return WeaponServantMainDetailModule
