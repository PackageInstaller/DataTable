local var_0_0 = class("WeaponServantMainDetailModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.BuildContext(arg_2_0)
	local var_2_0 = arg_2_0.gameObject_:GetComponent("ControllerExCollection")

	arg_2_0.controller = {
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
	arg_2_0.data = {}
	arg_2_0.constVar = {
		GACHA_POOL_SYSTEM_LINK_ID = 403,
		curBtnStyle = 1,
		descType = 1,
		rareBg = "",
		subDescColor = "#70767F",
		btnStyleMap = {
			arg_2_0.controller.state.btnState.beyond,
			arg_2_0.controller.state.btnState.callName,
			arg_2_0.controller.state.btnState.detail
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

function var_0_0.InitContext(arg_3_0)
	arg_3_0.data = {
		servantAddLv = 0,
		heroId = 0,
		info = {},
		servantMap = ServantTools.GetServantMap()
	}
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BuildContext()
	arg_4_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.detailBtn_, nil, function()
		arg_5_0:OnSwitchDescClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.detailsBtn_, nil, function()
		arg_5_0:OnServantDetailClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.gachaBtn_, nil, function()
		arg_5_0:OnGachaBtnClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.callNameBtn_, nil, function()
		arg_5_0:OnCallNameBtnClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.exchangeBtn_, nil, function()
		arg_5_0:OnExchangeBtnClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.beyondBtn_, nil, function()
		arg_5_0:OnBeyondBtnClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.lockBtn_, nil, function()
		arg_5_0:OnLockBtnClick()
	end)
	TerminologyTools.AddTerminologyHandler(arg_5_0, arg_5_0.descTxt_, nil, nil)
end

function var_0_0.OnEnter(arg_13_0)
	return
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0.constVar.descType = 1
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.RegisteCallNameClickCallback(arg_16_0, arg_16_1)
	arg_16_0.constVar.onCallNameClick = arg_16_1
end

function var_0_0.OnRenderServant(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_1 then
		return
	end

	arg_17_0:InitContext(arg_17_0.data)

	arg_17_0.data.info = arg_17_1

	local var_17_0 = arg_17_1.stage
	local var_17_1 = 0

	arg_17_0.data.heroId = arg_17_2

	if arg_17_2 and arg_17_2 > 0 then
		local var_17_2 = arg_17_0:GetHeroInfo(arg_17_2)

		var_17_1 = HeroTools.GetHeroWeaponAddLevel(var_17_2)
	end

	arg_17_0.data.servantAddLv = var_17_1

	if var_17_1 > 0 then
		arg_17_0.stageTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL"), var_17_0, var_17_1)
	else
		arg_17_0.stageTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_1"), var_17_0)
	end

	local var_17_3 = arg_17_1.id
	local var_17_4 = WeaponServantCfg[var_17_3]
	local var_17_5 = ItemCfg[var_17_3]

	arg_17_0.nameTxt_.text = ItemTools.getItemName(var_17_5.id)
	arg_17_0.servantImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponServant/Icon/" .. var_17_3)

	local var_17_6 = var_17_5.rare

	arg_17_0.gradeImg_.sprite = getSprite("Atlas/Com_DynamicAtlas", "ui_pop_grade_0" .. 6 - var_17_6)

	arg_17_0:SwitchControllerState(arg_17_0.controller.state.star.name, string.format("star%d", var_17_6))

	local var_17_7 = string.format("com_white_icon_group_%d_c", var_17_4.race)

	arg_17_0.groupImg_.sprite = getSprite("Atlas/SystemGroupAtlas", var_17_7)
	arg_17_0.groupTitleImg_.sprite = getSprite("Atlas/SystemGroupAtlas", var_17_7)
	arg_17_0.groupTitleTxt_.text = string.format(GetTips("EQUIP_RACE"), GetI18NText(RaceEffectCfg[var_17_4.race].name))

	if arg_17_1.locked == 1 then
		arg_17_0.lockImg_.sprite = getSprite("Atlas/SystemCommonAtlas", arg_17_0.constVar.lockImg.locked)
	else
		arg_17_0.lockImg_.sprite = getSprite("Atlas/SystemCommonAtlas", arg_17_0.constVar.lockImg.unlocked)
	end

	arg_17_0.attackRatioTxt_.text = table.concat({
		"+",
		var_17_4.attrib_addition,
		"%"
	})

	local var_17_8, var_17_9, var_17_10 = SkillTools.GetAttr(var_17_4.attribute)

	arg_17_0.subAttrNameTxt_.text = var_17_8
	arg_17_0.subAttrTxt_.text = "+" .. var_17_9
	arg_17_0.subAttrIconImg_.sprite = var_17_10

	arg_17_0:RenderEquipStatus()
	arg_17_0:RefreshEffectText()
	arg_17_0:RefreshRecommend()
	arg_17_0:RenderBtnLogic()
	arg_17_0:RenderLockObj()
end

function var_0_0.SwitchControllerState(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.controller.state[arg_18_1]

	if var_18_0 then
		var_18_0.comps:SetSelectedState(arg_18_2)
	end
end

function var_0_0.GetHeroInfo(arg_19_0, arg_19_1)
	if arg_19_0.constVar.proxy and arg_19_1 and arg_19_1 ~= 0 then
		return arg_19_0.constVar.proxy:GetHeroData(arg_19_1)
	else
		return nil
	end
end

function var_0_0.GetServantInfo(arg_20_0, arg_20_1)
	if arg_20_0.constVar.proxy and arg_20_1 and arg_20_1 ~= 0 then
		return arg_20_0.constVar.proxy:GetHeroServantInfo(arg_20_1)
	else
		return nil
	end
end

function var_0_0.RefreshEffectText(arg_21_0)
	local var_21_0 = arg_21_0.constVar.descType
	local var_21_1 = ""
	local var_21_2 = arg_21_0.data.info
	local var_21_3 = WeaponServantCfg[var_21_2.id].desc

	if var_21_0 == 1 then
		var_21_1 = arg_21_0.constVar.proxy:GetServantEffect(var_21_2.id, nil, true)
		arg_21_0.detailTxt_.text = GetTips("SERVANT_DETAIL_FULL")
	else
		var_21_1 = arg_21_0.constVar.proxy:GetServantEffect(var_21_2.id, var_21_2.stage + arg_21_0.data.servantAddLv)
		arg_21_0.detailTxt_.text = GetTips("SERVANT_DETAIL_SIMPLE")
	end

	arg_21_0.descTxt_.text = table.concat({
		var_21_1,
		"\n<color=",
		arg_21_0.constVar.subDescColor,
		">",
		var_21_3,
		"</color>"
	})
end

function var_0_0.RefreshRecommend(arg_22_0)
	local var_22_0 = arg_22_0.data.info
	local var_22_1 = WeaponServantCfg[var_22_0.id].effect[1]
	local var_22_2 = 0

	if var_22_1 > 0 then
		var_22_2 = WeaponEffectCfg[var_22_1].spec_char[1]
	end

	if var_22_2 ~= nil and var_22_2 > 0 then
		SetActive(arg_22_0.recommendObj_, true)

		arg_22_0.heroImg_.sprite = HeroTools.GetSmallHeadSprite(var_22_2)
	else
		SetActive(arg_22_0.recommendObj_, false)
	end
end

function var_0_0.RenderEquipStatus(arg_23_0)
	local var_23_0 = arg_23_0.data.info

	if var_23_0.uid then
		local var_23_1 = arg_23_0.data.servantMap[var_23_0.uid]

		if var_23_1 then
			SetActive(arg_23_0.equipObj_, true)

			arg_23_0.equipHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(var_23_1)
			arg_23_0.equipHeroTxt_.text = string.format(GetTips("SERVANT_EQUIPED"), GetI18NText(HeroCfg[var_23_1].name))
		else
			SetActive(arg_23_0.equipObj_, false)
		end
	else
		SetActive(arg_23_0.equipObj_, false)
	end
end

function var_0_0.RenderLockObj(arg_24_0)
	local var_24_0 = arg_24_0.data.info

	if var_24_0.uid and var_24_0.uid ~= 0 then
		SetActive(arg_24_0.lockImg_.gameObject, true)
	else
		SetActive(arg_24_0.lockImg_.gameObject, false)
	end
end

function var_0_0.OnSwitchDescClick(arg_25_0)
	arg_25_0.constVar.descType = (arg_25_0.constVar.descType + 1) % 2

	arg_25_0:RefreshEffectText()
end

function var_0_0.OnServantDetailClick(arg_26_0)
	if arg_26_0.data.info then
		if arg_26_0.constVar.curBtnStyle == 3 then
			local var_26_0 = false

			if arg_26_0.data.info.isCustom then
				var_26_0 = true
			elseif not arg_26_0.data.info.uid then
				var_26_0 = true
			elseif ServantTools.IsSleepServant(arg_26_0.data.info.id) then
				var_26_0 = true
			end

			local var_26_1 = {
				disableTabList = {
					[2] = var_26_0
				},
				disableOrigin = arg_26_0.data.info.isCustom or false
			}

			JumpTools.OpenPageByJump("/showServantDetailsView", {
				servantData = arg_26_0.data.info,
				heroId = arg_26_0.data.heroId,
				openContext = var_26_1
			})
		elseif arg_26_0:CheckCanCallName() then
			arg_26_0:OnCallNameBtnClick()
		end
	end
end

function var_0_0.OnGachaBtnClick(arg_27_0)
	local var_27_0 = arg_27_0.data.info
	local var_27_1 = var_27_0.id

	if ServantTools.IsSleepServant(var_27_1) then
		arg_27_0:OnServantDetailClick()

		return
	end

	local var_27_2 = ServantTools.GetSleepyServantByServant(var_27_0.id)

	DrawAction.SetPollUpIDIgnoreFail(DrawConst.WEAPON_SERVANT_POOL_ID, var_27_2)
end

function var_0_0.OnCallNameBtnClick(arg_28_0)
	local var_28_0 = arg_28_0.data.info.id

	if ServantTools.IsSleepServant(var_28_0) then
		arg_28_0:JumpToCallName()

		return
	end

	local var_28_1 = WeaponServantCfg[var_28_0]
	local var_28_2, var_28_3 = arg_28_0:MaterialEnough(var_28_0)

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

	if arg_28_0.data.heroId and arg_28_0.data.heroId ~= 0 then
		local var_28_7 = arg_28_0:GetHeroInfo(arg_28_0.data.heroId)

		if var_28_7 then
			var_28_6 = var_28_7.servant_uid or 0
		end
	end

	local function var_28_8(arg_29_0, arg_29_1)
		if arg_29_0.locked ~= arg_29_1.locked then
			return arg_29_0.locked < arg_29_1.locked
		end

		return arg_29_0.uid < arg_29_1.uid
	end

	table.sort(var_28_5, var_28_8)

	local var_28_9 = 1

	if var_28_6 ~= 0 then
		for iter_28_2, iter_28_3 in ipairs(var_28_5) do
			if iter_28_3.uid == var_28_6 then
				var_28_9 = iter_28_2

				break
			end
		end
	end

	local var_28_10 = var_28_5[var_28_9].locked == 1
	local var_28_11 = var_28_10
	local var_28_12 = var_28_5[var_28_9].uid
	local var_28_13 = ItemTools.getItemName(var_28_5[var_28_9].id)

	if var_28_11 then
		local var_28_14

		if var_28_10 then
			var_28_14 = string.format(GetTips("SERVANT_MATERIAL_LOCKED"), var_28_13)
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = var_28_14,
			OkCallback = function()
				arg_28_0:Go("/weaponServantWakeUp", {
					race = arg_28_0:GetCurServantRace(),
					servantID = var_28_0,
					uid = var_28_12,
					HeroId = arg_28_0.data.heroId
				})
			end,
			CancelCallback = function()
				return
			end
		})
	else
		arg_28_0:Go("/weaponServantWakeUp", {
			race = arg_28_0:GetCurServantRace(),
			servantID = var_28_0,
			uid = var_28_12,
			HeroId = arg_28_0.data.heroId
		})
	end
end

function var_0_0.JumpToCallName(arg_32_0)
	ServantTools.JumpToCallName(arg_32_0.data.heroId, arg_32_0.data.info.id)
end

function var_0_0.OnExchangeBtnClick(arg_33_0)
	if not arg_33_0:CheckRaceSame() then
		if arg_33_0.data.heroId then
			ShowTips("ERROR_SERVANT_RACE_NO_MATCH")
		end

		return
	end

	local var_33_0 = arg_33_0.data.info.uid
	local var_33_1 = arg_33_0.data.heroId
	local var_33_2 = arg_33_0:GetHeroInfo(var_33_1)
	local var_33_3 = arg_33_0.data.servantMap

	if var_33_2 and var_33_0 == var_33_2.servant_uid then
		ServantAction.ServantReplace(var_33_1, 0)

		return
	end

	if var_33_3[var_33_0] then
		local var_33_4 = var_33_3[var_33_0]

		ShowMessageBox({
			title = "Warning",
			content = string.format(GetTips("SERVANT_IS_USING"), GetI18NText(HeroCfg[var_33_4].name)),
			OkCallback = function()
				ServantAction.ServantReplace(var_33_1, var_33_0)
			end
		})

		return
	end

	ServantAction.ServantReplace(var_33_1, var_33_0)
end

function var_0_0.OnBeyondBtnClick(arg_35_0)
	if arg_35_0.data.info then
		if ServantTools.IsSleepServant(arg_35_0.data.info.id) then
			ServantTools.JumpToCallName(arg_35_0.data.heroId, arg_35_0.data.info.id)
		else
			JumpTools.OpenPageByJump("/showServantDetailsView", {
				servantData = arg_35_0.data.info,
				heroId = arg_35_0.data.heroId,
				openContext = {
					tabIndex = 2
				}
			})
		end
	end
end

function var_0_0.OnLockBtnClick(arg_36_0)
	if arg_36_0.data.info.uid and arg_36_0.data.info.uid ~= 0 then
		ServantAction.ServantLock(arg_36_0.data.info.uid)
	end
end

function var_0_0.SwitchBtnStyle(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.controller.state.btnState

	arg_37_0.constVar.curBtnStyle = arg_37_1

	arg_37_0:SwitchControllerState(var_37_0.name, arg_37_0.constVar.btnStyleMap[arg_37_1])
	arg_37_0:RenderBtnLogic()
end

function var_0_0.RenderBtnLogic(arg_38_0)
	if arg_38_0.constVar.curBtnStyle == 1 then
		arg_38_0:RenderBeyondBtnState()
	end

	if arg_38_0.constVar.curBtnStyle == 2 then
		SetActive(arg_38_0.callNameToken_, true)

		arg_38_0.gachaBtnIcon_.sprite = getSprite("Atlas/Hero_servantAtlas", "icon_detection")
		arg_38_0.gachaBtnTxt_.text = GetTips("SERVANT_MAIN_PAGE_GACHA")

		arg_38_0:RenderCallNameBtn()
	else
		arg_38_0:SwitchControllerState(arg_38_0.controller.state.callNameBtnState.name, arg_38_0.controller.state.callNameBtnState.True)
	end

	if arg_38_0.constVar.curBtnStyle == 3 then
		local var_38_0 = arg_38_0.data.info

		if var_38_0 and ServantTools.IsSleepServant(var_38_0.id) then
			arg_38_0:SwitchControllerState(arg_38_0.controller.state.btnState.name, arg_38_0.constVar.btnStyleMap[2])
			SetActive(arg_38_0.callNameToken_, false)

			arg_38_0.gachaBtnIcon_.sprite = getSprite("Atlas/SystemCommonAtlas", "com_white_icon_08")
			arg_38_0.gachaBtnTxt_.text = GetTips("TIP_DETAIL")
		else
			arg_38_0:SwitchControllerState(arg_38_0.controller.state.btnState.name, arg_38_0.constVar.btnStyleMap[3])
		end

		arg_38_0.upBtnTxt_.text = GetTips("SERVANT_MAIN_PAGE_DETAIL")
	end

	if arg_38_0.constVar.curBtnStyle == 4 then
		arg_38_0:SwitchControllerState(arg_38_0.controller.state.btnState.name, arg_38_0.controller.state.btnState.no)
	end
end

function var_0_0.RenderCallNameBtn(arg_39_0)
	local var_39_0 = {}
	local var_39_1 = arg_39_0:GetCurServantRace()

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
		var_39_7 = "<color='#FF0000'>" .. tostring(var_39_0[2][2]) .. "</color>"
	end

	arg_39_0.costmoneyText_.text = var_39_7

	if var_39_3 >= var_39_0[1][2] and var_39_4 >= var_39_0[2][2] then
		arg_39_0:SwitchControllerState(arg_39_0.controller.state.callNameBtnState.name, arg_39_0.controller.state.callNameBtnState.True)
	else
		arg_39_0:SwitchControllerState(arg_39_0.controller.state.callNameBtnState.name, arg_39_0.controller.state.callNameBtnState.False)
	end
end

function var_0_0.RenderBeyondBtnState(arg_40_0)
	local var_40_0 = arg_40_0.data.info

	if var_40_0 == nil then
		return
	end

	local var_40_1 = var_40_0.isRecommend
	local var_40_2 = arg_40_0.controller.state.btnState

	if var_40_1 then
		if arg_40_0:CheckCanCallName() then
			arg_40_0:SwitchControllerState(var_40_2.name, var_40_2.detail)

			arg_40_0.upBtnTxt_.text = GetTips("SERVANT_MAIN_PAGE_CALLNAME")
		else
			arg_40_0:SwitchControllerState(var_40_2.name, var_40_2.unReached)
		end
	else
		arg_40_0:SwitchControllerState(var_40_2.name, var_40_2.beyond)

		local var_40_3 = var_40_0.uid
		local var_40_4 = arg_40_0.data.servantMap[var_40_3]

		if arg_40_0.data.heroId then
			if not var_40_4 then
				local var_40_5 = arg_40_0:GetServantInfo(arg_40_0.data.heroId)

				if var_40_5 and var_40_5.id ~= 0 then
					arg_40_0.exchangeEquipTxt_.text = arg_40_0.constVar.exchangeBtnLang.Change
				else
					arg_40_0.exchangeEquipTxt_.text = arg_40_0.constVar.exchangeBtnLang.Equip
				end
			elseif arg_40_0.data.heroId == var_40_4 then
				arg_40_0.exchangeEquipTxt_.text = arg_40_0.constVar.exchangeBtnLang.TakeOff
			else
				arg_40_0.exchangeEquipTxt_.text = arg_40_0.constVar.exchangeBtnLang.Exchange
			end
		end

		local var_40_6 = arg_40_0:CheckRaceSame()
		local var_40_7 = arg_40_0.controller.state.equipBtnState.False

		if var_40_6 then
			var_40_7 = arg_40_0.controller.state.equipBtnState.True
		end

		arg_40_0:SwitchControllerState(arg_40_0.controller.state.equipBtnState.name, var_40_7)

		if ServantTools.IsSleepServant(var_40_0.id) then
			arg_40_0.beyondBtnTxt_.text = GetTips("SERVANT_MAIN_PAGE_CALLNAME")
		else
			arg_40_0.beyondBtnTxt_.text = GetTips("PROMOTE")
		end
	end
end

function var_0_0.MaterialEnough(arg_41_0, arg_41_1)
	local var_41_0 = WeaponServantCfg[arg_41_1]
	local var_41_1 = {}

	for iter_41_0, iter_41_1 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
		if iter_41_1[1] == var_41_0.race then
			var_41_1 = iter_41_1[2]
		end
	end

	local var_41_2 = WeaponServantData:GetWeaponServantById(var_41_1[1][1])
	local var_41_3 = 0

	if var_41_2 then
		var_41_3 = #var_41_2
	end

	local var_41_4 = ItemTools.getItemNum(var_41_1[2][1])

	return var_41_3 >= var_41_1[1][2], var_41_4 >= var_41_1[2][2]
end

function var_0_0.CheckRaceSame(arg_42_0)
	if not arg_42_0.data.heroId then
		return false
	end

	if arg_42_0.data.heroId == 0 then
		return false
	end

	return arg_42_0:GetCurServantRace() == HeroCfg[arg_42_0.data.heroId].race
end

function var_0_0.GetCurServantRace(arg_43_0)
	local var_43_0 = arg_43_0.data.info

	return WeaponServantCfg[var_43_0.id].race
end

function var_0_0.CheckCanCallName(arg_44_0)
	local var_44_0 = arg_44_0.data.info

	if WeaponServantCfg[var_44_0.id].summon_blocked == 1 then
		return false
	end

	local var_44_1, var_44_2 = arg_44_0:MaterialEnough(var_44_0.id)

	return var_44_1
end

return var_0_0
