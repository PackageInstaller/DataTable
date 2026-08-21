local var_0_0 = class("EquipInfoView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.info_ = arg_1_2
	arg_1_0.lockHandler_ = arg_1_3

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.attrItem_ = {}

	for iter_2_0 = 1, 2 do
		local var_2_0 = arg_2_0["attrItem_" .. iter_2_0]

		arg_2_0.attrItem_[iter_2_0] = AttributeItem.New(arg_2_0, var_2_0)
	end

	arg_2_0.skillList_ = {}
	arg_2_0.heroSkillIndex_ = 0
	arg_2_0.heroSkillItems_ = {}
	arg_2_0.raceController_ = arg_2_0.mainController_:GetController("race")
	arg_2_0.tabController_ = arg_2_0.mainController_:GetController("tab")
	arg_2_0.bgController_ = arg_2_0.mainController_:GetController("bg")
	arg_2_0.isSelfController_ = arg_2_0.mainController_:GetController("btnState")
	arg_2_0.emptyController_ = arg_2_0.mainController_:GetController("empty")
	arg_2_0.typeController_ = arg_2_0.headController_:GetController("type")
	arg_2_0.qualityController_ = arg_2_0.headController_:GetController("quality")
	arg_2_0.lockController_ = arg_2_0.headController_:GetController("lock")
	arg_2_0.slotController_ = arg_2_0.headController_:GetController("slot")
	arg_2_0.starController_ = arg_2_0.headController_:GetController("star")
	arg_2_0.posController_ = arg_2_0.equipBg_:GetController("pos")
	arg_2_0.equipSuitItem_ = EquipNewSuitItem.New(arg_2_0.suitGo_)
	arg_2_0.skillScrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.indexSkillItem), arg_2_0.skillListGo_, EquipNewSkillItem)
	arg_2_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btnSkill_, nil, function()
		arg_3_0:ChangeShowView("skill")
	end)
	arg_3_0:AddBtnListener(arg_3_0.btnSuit_, nil, function()
		arg_3_0:ChangeShowView("suit")
	end)
	arg_3_0:AddBtnListener(arg_3_0.btnLock_, nil, function()
		arg_3_0.isLock_ = not arg_3_0.isLock_

		EquipAction.ApplyLockEquip(arg_3_0.info_.equip_id, arg_3_0.isLock_)

		if arg_3_0.lockHandler_ then
			arg_3_0.lockHandler_(arg_3_0.isLock_, arg_3_0.info_.equip_id)
		end

		arg_3_0.lockController_:SetSelectedState(arg_3_0.isLock_ and "lock" or "unlock")
	end)
	arg_3_0:AddBtnListener(arg_3_0.btnChange_, nil, function()
		local var_7_0 = EquipCfg[arg_3_0.info_.prefab_id]

		if arg_3_0.equipFunc_ then
			arg_3_0.equipFunc_()
		elseif arg_3_0.equipedId_ ~= 0 and arg_3_0.equipedId_ == arg_3_0.info_.equip_id then
			arg_3_0:SendUseEquip(arg_3_0.heroId_, 0, var_7_0.pos)
		else
			local var_7_1 = arg_3_0.info_
			local var_7_2 = arg_3_0.info_.equip_id
			local var_7_3 = arg_3_0.heroId_
			local var_7_4 = var_7_0.pos
			local var_7_5 = arg_3_0.info_:GetEquipHero() or 0
			local var_7_6 = HeroCfg[var_7_5]

			if var_7_5 and var_7_6 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = string.format(GetTips("EQUIP_IS_USING"), GetI18NText(var_7_6.name)),
					OkCallback = function()
						arg_3_0:SendUseEquip(var_7_3, var_7_2, var_7_4)
					end
				})
			else
				arg_3_0:SendUseEquip(var_7_3, var_7_2, var_7_4)
			end
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.btnCulture_, nil, function()
		if arg_3_0.handler_.KeepFilter then
			arg_3_0.handler_:KeepFilter()
		end

		if arg_3_0.cultureFunc_ then
			arg_3_0.cultureFunc_()
		elseif arg_3_0.info_ and arg_3_0.info_.prefab_id ~= 0 then
			arg_3_0.info_.id = arg_3_0.info_.prefab_id

			arg_3_0:Go("/equipCultureView", {
				pageIndex = 2,
				equipId = arg_3_0.info_.equip_id,
				proxy = arg_3_0.heroViewProxy_
			})
		else
			ShowTips("NO_EQUIP")
		end
	end)
end

function var_0_0.RefreshData(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	arg_10_0.handler_ = arg_10_1
	arg_10_0.info_ = arg_10_2
	arg_10_0.lockHandler_ = arg_10_3
	arg_10_0.heroId_ = arg_10_4
	arg_10_0.equipedId_ = arg_10_5

	arg_10_0:RefreshUI()
	arg_10_0:RefreshState()
end

function var_0_0.OnEnter(arg_11_0, arg_11_1)
	arg_11_0.heroViewProxy_ = arg_11_1 or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function var_0_0.RefreshUI(arg_12_0)
	if arg_12_0.info_ and arg_12_0.info_.prefab_id ~= 0 then
		arg_12_0.emptyController_:SetSelectedState("notEmpty")
		arg_12_0:RefreshTitle()
		arg_12_0:RreshRace()
		arg_12_0:RefreshAttr()
		arg_12_0:RefreshSuit()
		arg_12_0:RefreshSkill()
	else
		arg_12_0.emptyController_:SetSelectedState("empty")
	end
end

function var_0_0.CheckLocked(arg_13_0)
	arg_13_0.isSelfController_:SetSelectedState(tostring(not arg_13_0.heroViewProxy_.isSelf))
end

function var_0_0.RefreshTitle(arg_14_0)
	local var_14_0 = EquipCfg[arg_14_0.info_.prefab_id]

	arg_14_0.icon_.sprite = ItemTools.getItemSprite(arg_14_0.info_.prefab_id, nil, true)
	arg_14_0.name_.text = ItemTools.getItemName(arg_14_0.info_.prefab_id)

	local var_14_1 = ItemCfg[arg_14_0.info_.prefab_id].rare
	local var_14_2 = HeroConst.RARE_COLOR[var_14_1]

	arg_14_0.starController_:SetSelectedState(var_14_0.starlevel)
	arg_14_0.qualityController_:SetSelectedState(var_14_0.starlevel)
	arg_14_0.slotController_:SetSelectedIndex(arg_14_0.info_:GetEnchantCount())

	local var_14_3 = arg_14_0.info_:GetMaxLv()

	arg_14_0.level_ = arg_14_0.info_:GetLevel()
	arg_14_0.lv_.text = string.format("%s%s/%s", GetTips("LEVEL"), arg_14_0.level_, var_14_3)
	arg_14_0.isLock_ = arg_14_0.info_.is_lock

	if arg_14_0.info_.equip_id and arg_14_0.info_.equip_id ~= 0 and arg_14_0.heroViewProxy_ and arg_14_0.heroViewProxy_.isSelf then
		arg_14_0.lockController_:SetSelectedState(arg_14_0.isLock_ and "lock" or "unlock")
	else
		arg_14_0.lockController_:SetSelectedState("off")
	end

	local var_14_4 = var_14_0.pos or 0

	arg_14_0.posController_:SetSelectedState(var_14_4)
end

function var_0_0.RreshRace(arg_15_0)
	if arg_15_0.info_.race ~= 0 then
		local var_15_0 = RaceEffectCfg.all
		local var_15_1

		arg_15_0.raceController_:SetSelectedState("on")

		if table.keyof(var_15_0, arg_15_0.info_.race) ~= nil then
			local var_15_2 = RaceEffectCfg[arg_15_0.info_.race]

			arg_15_0.raceText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(var_15_2.name))
			arg_15_0.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", var_15_2.icon2)
		else
			local var_15_3 = arg_15_0.info_.race
			local var_15_4 = HeroCfg[var_15_3]

			arg_15_0.raceText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), HeroTools.GetHeroFullName(var_15_3))
			arg_15_0.raceImage_.sprite = HeroTools.GetSmallHeadSprite(arg_15_0.info_.race)
		end
	else
		arg_15_0.raceController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshAttr(arg_16_0)
	local var_16_0 = EquipTools.CountEquipAttribute(arg_16_0.info_)
	local var_16_1 = 1

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		arg_16_0.attrItem_[var_16_1]:RefreshData(arg_16_0, {
			key = iter_16_0,
			value = iter_16_1,
			race = arg_16_0.info_.race,
			heroId = arg_16_0.heroId_
		}, true)

		var_16_1 = var_16_1 + 1
	end
end

function var_0_0.RefreshSuit(arg_17_0)
	local var_17_0 = arg_17_0.heroId_
	local var_17_1 = EquipCfg[arg_17_0.info_.prefab_id]
	local var_17_2 = var_17_1.suit
	local var_17_3 = 0

	if var_17_0 and var_17_0 ~= 0 and arg_17_0.heroViewProxy_ then
		local var_17_4 = arg_17_0.heroViewProxy_:GetEquipDataList(var_17_0)

		var_17_3 = EquipTools.GetSuitEquiptCount(var_17_4, var_17_2)
	end

	if arg_17_0.info_.suitNumAdd then
		var_17_3 = var_17_3 + arg_17_0.info_.suitNumAdd
	end

	local var_17_5 = {
		equipId = arg_17_0.info_.equip_id,
		id = var_17_2,
		num = var_17_3,
		pos = var_17_1.pos,
		equipPos = var_17_1.pos,
		heroId = arg_17_0.heroId_
	}
	local var_17_6 = arg_17_0.heroViewProxy_ and arg_17_0.heroViewProxy_:GetHeroData(arg_17_0.heroId_) or HeroData:GetHeroData(arg_17_0.heroId_)

	arg_17_0.equipSuitItem_:RefreshData(var_17_6, var_17_5)
end

function var_0_0.RefreshSkill(arg_18_0)
	arg_18_0.skillList_ = arg_18_0.info_:GetTotalSkill()

	arg_18_0.skillScrollHelper_:StartScroll(#arg_18_0.skillList_)
end

function var_0_0.indexSkillItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.skillList_[arg_19_1]

	var_19_0.level = arg_19_0.level_
	var_19_0.hideMaxLevel = true

	arg_19_2:RegistCallBack(function(arg_20_0)
		if arg_19_0.skillClickFunc then
			if arg_19_0.lastSkillSelect_ then
				arg_19_0.lastSkillSelect_:ShowSelect(false)
			end

			arg_19_0.lastSkillSelect_ = arg_19_2

			arg_19_2:ShowSelect(true)
			arg_19_0.skillClickFunc(arg_19_2, arg_20_0, arg_19_0.isLeftPop_)
		end
	end)
	arg_19_2:RefreshData(var_19_0)
end

function var_0_0.RegisterSkillClick(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.skillClickFunc = arg_21_1
	arg_21_0.isLeftPop_ = arg_21_2
end

function var_0_0.RegistHeroButton(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.equipFunc_ = arg_22_1
	arg_22_0.cultureFunc_ = arg_22_2
end

function var_0_0.DeSelect(arg_23_0)
	if arg_23_0.lastSkillSelect_ then
		arg_23_0.lastSkillSelect_:ShowSelect(false)

		arg_23_0.lastSkillSelect_ = nil
	end
end

function var_0_0.RefreshState(arg_24_0)
	arg_24_0.selectType_ = arg_24_0.handler_.rightInfoType or "suit"

	arg_24_0:ChangeShowView(arg_24_0.selectType_)

	if arg_24_0.equipedId_ == 0 then
		arg_24_0.textBtnChange_.text = GetTips("TIP_EQUIP")
		arg_24_0.imgLeftBtn_.sprite = getSprite("Atlas/SystemCommonAtlas", "com_white_icon_30")
	elseif arg_24_0.equipedId_ == arg_24_0.info_.equip_id and not arg_24_0.equipFunc_ then
		arg_24_0.textBtnChange_.text = GetTips("TIP_UNLOAD")
		arg_24_0.imgLeftBtn_.sprite = getSprite("Atlas/SystemCommonAtlas", "com_white_icon_31")
	else
		arg_24_0.textBtnChange_.text = GetTips("TIP_CHANGE")
		arg_24_0.imgLeftBtn_.sprite = getSprite("Atlas/SystemCommonAtlas", "com_white_icon_05")
	end
end

function var_0_0.ChangeShowView(arg_25_0, arg_25_1)
	if arg_25_0.changeFunc then
		arg_25_0.changeFunc(arg_25_1)
	end

	arg_25_0:ChangeSelect(arg_25_1)
end

function var_0_0.ChangeSelect(arg_26_0, arg_26_1)
	arg_26_0.selectType_ = arg_26_1

	arg_26_0.tabController_:SetSelectedState(arg_26_1)
end

function var_0_0.RegisterChange(arg_27_0, arg_27_1)
	arg_27_0.changeFunc = arg_27_1
end

function var_0_0.ShowRaceAdd(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.attrItem_) do
		iter_28_1:ShowAdd(arg_28_1)
	end
end

function var_0_0.SendUseEquip(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	HeroAction.EquipSwap(arg_29_1, arg_29_2, arg_29_3)
end

function var_0_0.OnEquipLock(arg_30_0, arg_30_1)
	if arg_30_1 then
		ShowTips("ERROR_EQUIP_LOCKED_SUCCESS")
	else
		ShowTips("ERROR_EQUIP_UNLOCKED_SUCCESS")
	end
end

function var_0_0.Dispose(arg_31_0)
	arg_31_0.equipSuitItem_:Dispose()

	if arg_31_0.skillScrollHelper_ then
		arg_31_0.skillScrollHelper_:Dispose()

		arg_31_0.skillScrollHelper_ = nil
	end

	if arg_31_0.attrItem_ then
		for iter_31_0, iter_31_1 in pairs(arg_31_0.attrItem_) do
			iter_31_1:Dispose()
		end

		arg_31_0.attrItem_ = nil
	end

	arg_31_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_31_0)
end

return var_0_0
