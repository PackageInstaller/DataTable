local var_0_0 = class("EquipMoreAttributeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Equip/EquipMoreAttributesUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.lvText_ = {}
	arg_4_0.starCon_ = {}
	arg_4_0.raceCon_ = {}
	arg_4_0.activeGo_ = {}
	arg_4_0.raceIcon_ = {}
	arg_4_0.equipIcon_ = {}

	for iter_4_0 = 1, 6 do
		arg_4_0.lvText_[iter_4_0] = arg_4_0["lvText_" .. iter_4_0]
		arg_4_0.starCon_[iter_4_0] = ControllerUtil.GetController(arg_4_0["item_" .. iter_4_0].transform, "star")
		arg_4_0.raceCon_[iter_4_0] = ControllerUtil.GetController(arg_4_0["item_" .. iter_4_0].transform, "race")
		arg_4_0.activeGo_[iter_4_0] = arg_4_0["activeGo_" .. iter_4_0]
		arg_4_0.raceIcon_[iter_4_0] = arg_4_0["raceIcon_" .. iter_4_0]
		arg_4_0.equipIcon_[iter_4_0] = arg_4_0["equipIcon_" .. iter_4_0]
	end

	arg_4_0.attributeList_ = {}
	arg_4_0.attributeInfo_ = {}
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, EquipAttributeItem)
	arg_4_0.equipHeroSkillView_ = EquipNewSkillInfoView.New(arg_4_0.equipHeroSkillGo_)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.attributeList_[arg_5_1]

	arg_5_2:RefreshUI(var_5_0, arg_5_0.attributeInfo_[var_5_0], arg_5_0.isAdd_)
	arg_5_2:RegistCallBack(function(arg_6_0)
		SetActive(arg_5_0.maskGo_, true)
		SetActive(arg_5_0.equipHeroSkillGo_, true)
		arg_5_0.equipHeroSkillView_:RefreshData(arg_5_0, arg_6_0)
	end)
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.maskBtn_, nil, function()
		arg_7_0:HideInfoView()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.equipList_ = arg_10_0.params_.equipList
	arg_10_0.heroID_ = arg_10_0.params_.heroID
	arg_10_0.isAdd_ = arg_10_0.params_.isAdd
	arg_10_0.attributeList_ = {}
	arg_10_0.attributeInfo_ = {}

	arg_10_0:HideInfoView()
	arg_10_0:RefreshUI()
end

function var_0_0.HideInfoView(arg_11_0)
	SetActive(arg_11_0.maskGo_, false)
	SetActive(arg_11_0.equipHeroSkillGo_, false)
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0:RefreshEquip()
	arg_12_0:RefreshList()
end

function var_0_0.RefreshEquip(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.equipList_) do
		local var_13_1 = iter_13_1.prefab_id
		local var_13_2 = EquipCfg[var_13_1]
		local var_13_3 = var_13_2.pos

		table.insert(var_13_0, var_13_3)

		local var_13_4 = iter_13_1:GetLevel()

		arg_13_0.lvText_[var_13_3].text = GetTips("LEVEL") .. tostring(var_13_4)

		arg_13_0.starCon_[var_13_3]:SetSelectedState(var_13_2.starlevel)

		if iter_13_1.race ~= 0 then
			if table.keyof(RaceEffectCfg.all, iter_13_1.race) ~= nil then
				arg_13_0.raceIcon_[var_13_3].sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", iter_13_1.race))
			else
				arg_13_0.raceIcon_[var_13_3].sprite = HeroTools.GetSmallHeadSprite(iter_13_1.race)
			end

			arg_13_0.raceCon_[var_13_3]:SetSelectedState("0")
		else
			arg_13_0.raceCon_[var_13_3]:SetSelectedState("0")
		end

		SetSpriteWithoutAtlasAsync(arg_13_0.equipIcon_[var_13_3], SpritePathCfg.EquipIcon_s.path .. ItemCfg[var_13_1].icon)

		for iter_13_2, iter_13_3 in ipairs(var_13_2.effect) do
			if iter_13_3 and var_13_4 >= var_13_2.effect_unlock_level[iter_13_2] then
				if not arg_13_0.attributeInfo_[iter_13_3[1]] then
					arg_13_0.attributeInfo_[iter_13_3[1]] = {}

					table.insert(arg_13_0.attributeList_, iter_13_3[1])
				end

				table.insert(arg_13_0.attributeInfo_[iter_13_3[1]], {
					pos = var_13_2.pos,
					level = iter_13_3[2]
				})
			end
		end

		for iter_13_4, iter_13_5 in ipairs(iter_13_1.enchant) do
			for iter_13_6, iter_13_7 in ipairs(iter_13_5) do
				if iter_13_7 and iter_13_7.id then
					if not arg_13_0.attributeInfo_[iter_13_7.id] then
						arg_13_0.attributeInfo_[iter_13_7.id] = {}

						table.insert(arg_13_0.attributeList_, iter_13_7.id)
					end

					table.insert(arg_13_0.attributeInfo_[iter_13_7.id], {
						pos = var_13_2.pos,
						level = iter_13_7.num
					})
				end
			end
		end
	end

	for iter_13_8 = 1, 6 do
		SetActive(arg_13_0.activeGo_[iter_13_8], table.indexof(var_13_0, iter_13_8) ~= false)
	end
end

function var_0_0.RefreshList(arg_14_0)
	local var_14_0 = HeroCfg[arg_14_0.heroID_].equip_skill

	table.sort(arg_14_0.attributeList_, function(arg_15_0, arg_15_1)
		local var_15_0 = table.indexof(var_14_0, arg_15_0)
		local var_15_1 = table.indexof(var_14_0, arg_15_1)

		if var_15_0 and var_15_1 then
			return var_15_0 < var_15_1
		elseif var_15_0 or var_15_1 then
			return var_15_0 ~= false
		else
			return arg_15_0 < arg_15_1
		end
	end)
	arg_14_0.scrollHelper_:StartScroll(#arg_14_0.attributeList_)
end

function var_0_0.OnExit(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()
	arg_17_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
