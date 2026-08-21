local var_0_0 = class("StoreEquipInfo", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.raceController_ = arg_1_0.controllerEx_:GetController("race")
	arg_1_0.switchController_ = arg_1_0.controllerEx_:GetController("tab")
	arg_1_0.cultureController_ = arg_1_0.controllerEx_:GetController("btnState")
	arg_1_0.storeHeadInfoView_ = StoreHeadInfo.New(arg_1_0.itemHeadGo_)
	arg_1_0.attributeItemList_ = {}

	for iter_1_0 = 1, 2 do
		arg_1_0.attributeItemList_[iter_1_0] = AttributeItem.New(arg_1_0, arg_1_0[string.format("attributeItem%s_", iter_1_0)])
	end

	arg_1_0.suitUIList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexSuitItem), arg_1_0.suitUIListGo_, EquipNewSuitItem)
	arg_1_0.skillUIList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexSkillItem), arg_1_0.skillUIListGo_, EquipNewSkillItem)
	arg_1_0.selectType_ = StoreConst.EQUIP_FILTER_TYPE.SUIT
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.storeHeadInfoView_:OnEnter()
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.storeHeadInfoView_:OnExit()
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.attributeItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.attributeItemList_ = nil

	arg_4_0.storeHeadInfoView_:Dispose()

	arg_4_0.storeHeadInfoView_ = nil

	arg_4_0.suitUIList_:Dispose()

	arg_4_0.suitUIList_ = nil

	arg_4_0.skillUIList_:Dispose()

	arg_4_0.skillUIList_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.suitBtn_, nil, function()
		if arg_5_0.selectType_ ~= StoreConst.EQUIP_FILTER_TYPE.SUIT then
			arg_5_0.selectType_ = StoreConst.EQUIP_FILTER_TYPE.SUIT

			arg_5_0:RefreshTypePanel()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.skillBtn_, nil, function()
		if arg_5_0.selectType_ ~= StoreConst.EQUIP_FILTER_TYPE.SKILL then
			arg_5_0.selectType_ = StoreConst.EQUIP_FILTER_TYPE.SKILL

			arg_5_0:RefreshTypePanel()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.cultureBtn_, nil, function()
		ShowPopItem(nil, arg_5_0.itemData_, {
			page = 2
		})
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.itemData_ = arg_9_1

	arg_9_0.storeHeadInfoView_:SetData(arg_9_1)

	local var_9_0 = arg_9_1.id
	local var_9_1 = arg_9_1.number
	local var_9_2 = arg_9_1.timeVlaid
	local var_9_3 = ItemCfg[var_9_0]
	local var_9_4 = var_9_3.type
	local var_9_5 = var_9_3.sub_type

	arg_9_0:RefreshAttribute()
	arg_9_0:RefreshRace()
	arg_9_0:GetSuitData()
	arg_9_0:RefreshSuit()
	arg_9_0:GetSkillData()
	arg_9_0:RefreshSkill()

	if not arg_9_2 then
		arg_9_0.selectType_ = StoreConst.EQUIP_FILTER_TYPE.SUIT
	end

	arg_9_0:RefreshTypePanel()
end

function var_0_0.RefreshAttribute(arg_10_0)
	local var_10_0 = arg_10_0.itemData_.equip_id
	local var_10_1 = EquipData:GetEquipData(var_10_0)
	local var_10_2 = EquipTools.CountEquipAttribute(var_10_1)
	local var_10_3 = 1

	for iter_10_0, iter_10_1 in pairs(var_10_2) do
		arg_10_0.attributeItemList_[var_10_3]:RefreshData(arg_10_0, {
			key = iter_10_0,
			value = iter_10_1,
			race = arg_10_0.itemData_.race,
			heroId = arg_10_0.bintHeroID
		}, true)

		var_10_3 = var_10_3 + 1
	end
end

function var_0_0.RefreshRace(arg_11_0)
	local var_11_0 = arg_11_0.itemData_.bindHeroID

	if var_11_0 ~= 0 then
		arg_11_0.raceController_:SetSelectedState("on")

		local var_11_1 = HeroCfg[var_11_0]

		arg_11_0.raceText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), HeroTools.GetHeroFullName(var_11_0))
		arg_11_0.raceImage_.sprite = HeroTools.GetSmallHeadSprite(var_11_0)

		return
	end

	local var_11_2 = arg_11_0.itemData_.race

	if var_11_2 ~= 0 then
		arg_11_0.raceController_:SetSelectedState("on")

		local var_11_3 = RaceEffectCfg[var_11_2]

		arg_11_0.raceText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(var_11_3.name))
		arg_11_0.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", var_11_3.icon2)

		return
	end

	arg_11_0.raceController_:SetSelectedState("off")
end

function var_0_0.RefreshTypePanel(arg_12_0)
	if arg_12_0.selectType_ == StoreConst.EQUIP_FILTER_TYPE.SUIT then
		arg_12_0.switchController_:SetSelectedState("suit")
	else
		arg_12_0.switchController_:SetSelectedState("skill")
	end
end

function var_0_0.GetSuitData(arg_13_0)
	arg_13_0.suitList_ = {}

	local var_13_0 = arg_13_0.itemData_
	local var_13_1 = var_13_0.equipedHeroID
	local var_13_2 = EquipCfg[var_13_0.id]
	local var_13_3 = var_13_2.suit
	local var_13_4, var_13_5 = EquipTools.GetHeroEquipSuitPos(var_13_1, var_13_3, var_13_2.pos)
	local var_13_6 = HeroData:GetHeroData(var_13_1)
	local var_13_7 = {
		id = var_13_3,
		num = var_13_5,
		pos = var_13_4,
		equipPos = var_13_2.pos,
		equipHero = var_13_6
	}

	table.insert(arg_13_0.suitList_, var_13_7)
end

function var_0_0.RefreshSuit(arg_14_0)
	arg_14_0.suitUIList_:StartScroll(#arg_14_0.suitList_)
end

function var_0_0.GetSkillData(arg_15_0)
	local var_15_0 = arg_15_0.itemData_.equip_id

	arg_15_0.skillList_ = EquipData:GetEquipData(var_15_0):GetTotalSkill()
end

function var_0_0.RefreshSkill(arg_16_0)
	arg_16_0.skillUIList_:StartScroll(#arg_16_0.skillList_)
end

function var_0_0.IndexSuitItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:RefreshData(arg_17_0.suitList_[arg_17_1].equipHero, arg_17_0.suitList_[arg_17_1])
end

function var_0_0.IndexSkillItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.skillList_[arg_18_1]

	var_18_0.level = arg_18_0.itemData_.equipLevel
	var_18_0.hideMaxLevel = true

	arg_18_2:RegistCallBack(function(arg_19_0)
		JumpTools.OpenPageByJump("equipSkillInfo", {
			equipSkillData = {
				id = var_18_0.id,
				skillLevel = var_18_0.num,
				selectItem = arg_18_2
			}
		})
	end)
	arg_18_2:RefreshData(var_18_0)
end

return var_0_0
