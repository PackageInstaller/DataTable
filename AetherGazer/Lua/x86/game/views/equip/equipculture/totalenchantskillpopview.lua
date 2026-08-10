local var_0_0 = class("TotalEnchantSkillPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_equip/Develop/EnchantTotalPopUPUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.skillScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.skillListGo_, EnchantSkillItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnBack_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.heroViewProxy_ = arg_7_0.params_.proxy or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_7_0.heroId_ = arg_7_0.params_.heroId
	arg_7_0.equipId_ = arg_7_0.params_.equipId

	arg_7_0:RefreshSkill()
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.skillList_[arg_8_1]

	arg_8_2:RefreshData(var_8_0, true)
end

function var_0_0.RefreshSkill(arg_9_0)
	arg_9_0.skillList_ = {}

	if arg_9_0.heroId_ then
		local var_9_0 = arg_9_0.heroViewProxy_:GetEquipDataList(arg_9_0.heroId_)
		local var_9_1 = arg_9_0.heroViewProxy_:GetHeroData(arg_9_0.heroId_)
		local var_9_2, var_9_3, var_9_4 = EquipTools.CountHeroTotalSkill(var_9_0, var_9_1, true)

		for iter_9_0, iter_9_1 in pairs(var_9_2) do
			table.insert(arg_9_0.skillList_, {
				unlockLevel = 0,
				total = true,
				id = iter_9_0,
				num = iter_9_1,
				isAdd = var_9_3,
				location = var_9_4[iter_9_0]
			})
		end

		local var_9_5 = HeroCfg[arg_9_0.heroId_].equip_skill

		table.sort(arg_9_0.skillList_, function(arg_10_0, arg_10_1)
			local var_10_0 = table.indexof(var_9_5, arg_10_0.id)
			local var_10_1 = table.indexof(var_9_5, arg_10_1.id)

			if var_10_0 and var_10_1 then
				return var_10_0 < var_10_1
			end

			return arg_10_0.id < arg_10_1.id
		end)
	else
		local var_9_6 = EquipData:GetEquipData(arg_9_0.equipId_)
		local var_9_7 = var_9_6:GetTotalSkill()

		for iter_9_2, iter_9_3 in ipairs(var_9_7) do
			if not iter_9_3.unlockLevel or var_9_6:GetLevel() >= iter_9_3.unlockLevel then
				table.insert(arg_9_0.skillList_, {
					total = true,
					id = iter_9_3.id,
					num = iter_9_3.num,
					unlockLevel = iter_9_3.unlockLevel
				})
			end
		end
	end

	arg_9_0.skillScroll_:StartScroll(#arg_9_0.skillList_)
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
	arg_11_0.skillScroll_:Dispose()
end

return var_0_0
