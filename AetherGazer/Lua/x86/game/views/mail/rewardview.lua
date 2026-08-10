local var_0_0 = class("RewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/RewardpopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.uiList = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uiListGo_, CommonItemView)
	arg_3_0.rowCountController_ = arg_3_0.conExCollection_:GetController("rowCount")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		var_0_0.super.Back(arg_4_0)
	end)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.itemList_[arg_6_1]
	local var_6_1 = arg_6_0:ConvertToItemData(var_6_0)

	if (ItemCfg[var_6_0.id].sub_type == ItemConst.ITEM_SUB_TYPE.LIMIT_SKIN or ItemCfg[var_6_0.id].sub_type == ItemConst.ITEM_SUB_TYPE.SCENE_NORMAL) and ItemCfg[var_6_0.id].time then
		var_6_1.need_count_down = true
		var_6_1.count_down_use_floor = true
		var_6_1.count_down_time_text = ItemCfg[var_6_0.id].time[2][1] .. GetTips("DAY")
	end

	arg_6_2:SetData(var_6_1)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	arg_7_0:CheckBack()

	if arg_7_1 then
		arg_7_1 = formatRewardCfgList(arg_7_1)
		arg_7_1 = ItemTools.SortRewardItemList(arg_7_1)

		local var_7_0 = #arg_7_1

		arg_7_0.itemList_ = arg_7_1
		arg_7_0.itemPool_ = arg_7_0.itemPool1_
		arg_7_0.listScrollRect_.enabled = var_7_0 > 10

		arg_7_0.uiList:StartScroll(var_7_0)

		if var_7_0 > 5 then
			arg_7_0.rowCountController_:SetSelectedState("2")
			arg_7_0.uiList:SetAlignment(UIListAlignment.Center)
		else
			arg_7_0.rowCountController_:SetSelectedState("1")
			arg_7_0.uiList:SetAlignment(UIListAlignment.Center2)
		end

		arg_7_0:CollectSkinList()
	end
end

function var_0_0.Init(arg_8_0)
	arg_8_0:InitUI()
	arg_8_0:AddUIListener()
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RefreshUI(arg_9_0.params_.list)
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:ShowVitalityBox(function()
		arg_10_0:ShowEquipBox(function()
			arg_10_0:ShowSkinBox(function()
				return
			end)
		end)
	end)
end

function var_0_0.ShowVitalityBox(arg_14_0, arg_14_1)
	if arg_14_0.params_.needShowVitalityBox then
		showVitalitySendMail(arg_14_1)
	else
		arg_14_1()
	end
end

function var_0_0.ShowEquipBox(arg_15_0, arg_15_1)
	if arg_15_0.params_.needShowEquipBox then
		showEquipSendMail(arg_15_1)
	else
		arg_15_1()
	end
end

function var_0_0.CollectSkinList(arg_16_0)
	if not arg_16_0.itemList_ then
		arg_16_0.skinItemList_ = nil

		return
	end

	arg_16_0.skinItemList_ = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.itemList_) do
		if ItemCfg[iter_16_1.id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			table.insert(arg_16_0.skinItemList_, iter_16_1.id)
		end
	end
end

function var_0_0.ShowSkinBox(arg_17_0, arg_17_1)
	if arg_17_0.skinItemList_ and #arg_17_0.skinItemList_ > 0 then
		local var_17_0 = arg_17_0.skinItemList_[1]
		local var_17_1 = SkinCfg[id] or SkinCfg[ItemCfg[var_17_0].param[1]]
		local var_17_2 = var_17_1.id
		local var_17_3 = var_17_1.hero

		table.remove(arg_17_0.skinItemList_, 1)

		if not HeroTools.GetHeroIsUnlock(var_17_3) then
			arg_17_1()

			return
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTipsF("SHOP_BUY_SKIN_TIPS", HeroTools.GetHeroFullName(var_17_3), GetI18NText(var_17_1.name)),
			OkCallback = function()
				HeroAction.SelectSkin(var_17_3, var_17_2)
				HeroAction.ChangeBattleSkin(var_17_3, var_17_2)

				if PlayerData:IsRandomHero() then
					CustomCenterTools.UpdateCacheRandomHeroSkinID(var_17_2)
					CustomCenterAction.SaveRandomHeroSkinList(function()
						return
					end)
					PlayerData:SetForceRandomHeroID(var_17_2)
				else
					PlayerAction.ChangePosterGirlWithCallback(var_17_3, function()
						HomeSceneSettingAction.AutoSwitchMatchSkinScene(var_17_3)
					end)
				end

				arg_17_0:ShowSkinBox(arg_17_1)
			end,
			CancelCallback = function()
				arg_17_0:ShowSkinBox(arg_17_1)
			end
		})
	else
		arg_17_1()
	end
end

function var_0_0.Dispose(arg_22_0)
	if arg_22_0.uiList ~= nil then
		arg_22_0.uiList:Dispose()

		arg_22_0.uiList = nil
	end

	if arg_22_0.itemPool1_ ~= nil then
		arg_22_0.itemPool1_:Dispose()

		arg_22_0.itemPool1_ = nil
	end

	if arg_22_0.backTimer_ then
		arg_22_0.backTimer_:Stop()

		arg_22_0.backTimer_ = nil
	end

	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.DisablebgBtn(arg_23_0)
	arg_23_0.bgBtn_.enabled = false
end

function var_0_0.ConvertToItemData(arg_24_0, arg_24_1)
	local var_24_0 = rewardToItemTemplate(arg_24_1, nil, true)

	var_24_0.number = var_24_0.number or arg_24_1.number
	var_24_0.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.ADVANCED

	return var_24_0
end

function var_0_0.CheckBack(arg_25_0)
	if not manager.guide:IsPlaying() then
		if arg_25_0.backTimer_ then
			arg_25_0.backTimer_:Stop()

			arg_25_0.backTimer_ = nil
		end

		local var_25_0 = GameSetting.reward_pop_view_time.value[1]

		arg_25_0.bgBtn_.enabled = false
		arg_25_0.backTimer_ = Timer.New(function()
			arg_25_0.bgBtn_.enabled = true
		end, var_25_0, 1)

		arg_25_0.backTimer_:Start()
	end
end

function var_0_0.Back(arg_27_0, arg_27_1)
	if manager.guide:IsPlaying() then
		var_0_0.super.Back(arg_27_0)

		return
	end

	if arg_27_0:IsAnimEnd() then
		var_0_0.super.Back(arg_27_0)

		if arg_27_1 then
			arg_27_1()
		end
	else
		arg_27_0:StopAllAnim()
	end
end

local function var_0_1(arg_28_0)
	if arg_28_0 == nil then
		return true
	end

	if arg_28_0:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.999 then
		return true
	end

	return false
end

local function var_0_2(arg_29_0)
	if arg_29_0 == nil then
		return
	end

	arg_29_0:Update(99999)
end

function var_0_0.IsAnimEnd(arg_30_0)
	if #arg_30_0.params_.list == 0 then
		return true
	end

	if not var_0_1(arg_30_0.animator_) then
		return false
	end

	local var_30_0, var_30_1 = arg_30_0.uiList:GetHeadAndTail()

	if var_30_0 == 0 then
		return false
	end

	local var_30_2 = arg_30_0.uiList:GetItemByIndex(var_30_0)

	return var_0_1(var_30_2.animator_)
end

function var_0_0.StopAllAnim(arg_31_0)
	var_0_2(arg_31_0.animator_)

	local var_31_0 = arg_31_0.uiList:GetItemList()

	for iter_31_0, iter_31_1 in pairs(var_31_0) do
		var_0_2(iter_31_1.animator_)
	end
end

local function var_0_3(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.id
	local var_32_1 = arg_32_1.id
	local var_32_2 = ItemCfg[var_32_0]
	local var_32_3 = ItemCfg[var_32_1]
	local var_32_4 = var_32_2.rare
	local var_32_5 = var_32_3.rare

	if var_32_4 ~= var_32_5 then
		return var_32_5 < var_32_4
	end

	local var_32_6 = var_32_2.type
	local var_32_7 = var_32_3.type

	if var_32_6 ~= var_32_7 then
		return var_32_7 < var_32_6
	elseif var_32_6 == ItemConst.ITEM_TYPE.EQUIP then
		local var_32_8 = 0
		local var_32_9 = 0
		local var_32_10 = EquipCfg[var_32_0].starlevel
		local var_32_11 = EquipCfg[var_32_1].starlevel

		if var_32_10 == var_32_11 then
			return var_32_1 < var_32_0
		else
			return var_32_11 < var_32_10
		end
	else
		return var_32_1 < var_32_0
	end
end

return var_0_0
