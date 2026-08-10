local var_0_0 = class("ChooseCharacterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamHreoTaskPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.characterScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexCharacter), arg_4_0.characteruilistUilist_, CharacterItem)
	arg_4_0.recomendScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexRecommendClass), arg_4_0.recuilistUilist_, DormRecommendBigItem)
end

function var_0_0.RegisterEvent(arg_5_0)
	arg_5_0:RegistEventListener(DORM_REFRESH_DISPATCH_LIST, function()
		arg_5_0.characterScroll_:Refresh()
		arg_5_0.recomendScroll_:Refresh()
		arg_5_0:UpdateSuccess()
		arg_5_0:UpdataDispatchNum()
		arg_5_0:UpdataNeedFatigue()
	end)
	arg_5_0:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function()
		arg_5_0.characterScroll_:Refresh()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RegisterEvent()
	arg_8_0:UpdateItemData()
	arg_8_0:UpdataRecItem()
	arg_8_0:UpdataDispatchNum()
	arg_8_0:UpdataNeedFatigue()
	arg_8_0.characterScroll_:StartScroll(#arg_8_0.itemList_)
	arg_8_0.recomendScroll_:StartScroll(#arg_8_0.reList_)
	arg_8_0:UpdateSuccess()

	arg_8_0.tasknmaeText_.text = GetI18NText(BackHomeCanteenTaskCfg[CanteenEntrustData:GetCurDispatchTask().id].name)
end

function var_0_0.indexCharacter(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:RegistCallBack(function(arg_10_0, arg_10_1)
		local var_10_0 = DormData:GetHeroTemplateInfo(arg_10_0)

		if CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_10_0) == true or var_10_0.jobType then
			ShowTips("CANTEEN_TASK_CANT_CHOOSE")

			return
		end

		local var_10_1, var_10_2 = BackHomeTools.CheckHeroIsLockForAnyFeatureWithTips(arg_10_0)

		if var_10_1 then
			ShowTips(var_10_2)

			return
		end

		if DormData:GetHeroFatigue(arg_10_0) < GameSetting.dorm_canteen_work_fatigue.value[1] / 100 then
			ShowTips("CANTEEN_HERO_FATIGUE_NULL")

			return
		end

		if #CanteenEntrustData:GetDispatchCharacterList() <= DormConst.CANTEEN_TRUST_CHARACTER_NUM and CanteenEntrustData:CheckDispatchCharacterList(arg_10_0) == false then
			CanteenEntrustData:InsertToDispatchCharacterList(arg_10_0)
			arg_10_1:SetSelectedState("select")
		elseif CanteenEntrustData:CheckDispatchCharacterList(arg_10_0) == true then
			CanteenEntrustData:RemoveDispatchCharacterList(arg_10_0)
			arg_10_1:SetSelectedState("normal")
		end

		manager.notify:Invoke(DORM_REFRESH_DISPATCH_LIST)
	end)
	arg_9_2:RegistFullListCallBack(function(arg_11_0, arg_11_1)
		if #CanteenEntrustData:GetDispatchCharacterList() == BackHomeCanteenTaskCfg[CanteenEntrustData:GetCurDispatchTask().id].need[2] then
			if not CanteenEntrustData:CheckDispatchCharacterList(arg_11_0) then
				if not CanteenEntrustData:CheckDispatchCharacterArchiveList(arg_11_0) then
					arg_11_1:SetSelectedState("full")
				else
					arg_11_1:SetSelectedState("normal")
				end
			else
				arg_11_1:SetSelectedState("select")
			end
		elseif not CanteenEntrustData:CheckDispatchCharacterList(arg_11_0) then
			arg_11_1:SetSelectedState("normal")
		else
			arg_11_1:SetSelectedState("select")
		end
	end)
	arg_9_2:RefreshUI(arg_9_0.itemList_[arg_9_1])
end

function var_0_0.indexRecommendClass(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:RefreshUI(arg_12_0.reList_[arg_12_1])
end

function var_0_0.AddUIListener(arg_13_0)
	arg_13_0:AddBtnListener(arg_13_0.battlebtnBtn_, nil, function()
		local var_14_0 = CanteenEntrustData:GetCurDispatchTask()
		local var_14_1 = CanteenEntrustData:GetDispatchCharacterList()

		if #var_14_1 < BackHomeCanteenTaskCfg[var_14_0.id].need[1] then
			ShowTips(string.format(GetTips("CANTEEN_TASK_NOT_CHOOSE"), BackHomeCanteenTaskCfg[var_14_0.id].need[1]))

			return false
		end

		local var_14_2 = 0

		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			var_14_2 = var_14_2 + DormData:GetHeroFatigue(iter_14_1)
		end

		if var_14_2 < arg_13_0.fatigue then
			ShowTips("CANTEEN_TASK_FATIGUE_NOT_ENOUGH")

			return false
		end

		CanteenEntrustData:ConfirmEntrustList(arg_13_0.params_.roomID)
		JumpTools.OpenPageByJump("/dormTaskDispatchView")
	end)
	arg_13_0:AddBtnListener(arg_13_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_13_0:AddBtnListener(arg_13_0.quickBtn_, nil, function()
		local var_16_0 = CanteenEntrustData:GetEntrustList()[CanteenEntrustData:GetCurDispatchTask().pos]
		local var_16_1 = CanteenTools.AutoSelectEntrustHero(var_16_0, CanteenEntrustData:GetDispatchCharacterList())

		if var_16_1 then
			CanteenEntrustData:SetDispatchCharacterList(var_16_1)
		else
			ShowTips("DORM_CANTEEN_TASK_CANT_FIT")
		end

		manager.notify:Invoke(DORM_REFRESH_DISPATCH_LIST)
	end)
end

function var_0_0.UpdateItemData(arg_17_0)
	arg_17_0.itemList_ = DormHeroTools:GetUnLockBackHomeHeroIDList()

	CommonTools.UniversalSortEx(arg_17_0.itemList_, {
		map = function(arg_18_0)
			if BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_18_0) then
				return 0
			else
				return 1
			end
		end
	}, {
		ascend = true,
		map = function(arg_19_0)
			local var_19_0 = DormData:GetHeroTemplateInfo(arg_19_0)

			if (CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_19_0) or var_19_0.jobType ~= nil) == false or BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(heroID) then
				return 1
			else
				return 2
			end
		end
	}, {
		map = function(arg_20_0)
			return DormData:GetHeroFatigue(arg_20_0)
		end
	}, {
		map = function(arg_21_0)
			return (DormData:GetHeroArchiveID(arg_21_0))
		end
	}, {
		map = function(arg_22_0)
			return arg_22_0
		end
	})
end

function var_0_0.UpdataRecItem(arg_23_0)
	local var_23_0 = CanteenEntrustData:GetCurDispatchTask().pos

	arg_23_0.reList_ = {}

	local var_23_1 = CanteenEntrustData:GetEntrustList()[var_23_0]

	for iter_23_0 = 1, #var_23_1.tags do
		local var_23_2 = {
			type = var_23_1.tags[iter_23_0].type,
			tag = var_23_1.tags[iter_23_0].tag
		}

		table.insert(arg_23_0.reList_, var_23_2)
	end

	arg_23_0.recomendScroll_:StartScroll(#arg_23_0.reList_)

	arg_23_0.recuilistUilist_:GetComponent("ScrollRectEx").horizontal = false
end

function var_0_0.UpdateSuccess(arg_24_0)
	local var_24_0 = CanteenEntrustData:CalculateEntrustSuccess()

	arg_24_0.successnumText_.text = var_24_0 .. "%"
end

function var_0_0.UpdataDispatchNum(arg_25_0)
	local var_25_0 = CanteenEntrustData:GetCurDispatchTask().id
	local var_25_1 = BackHomeCanteenTaskCfg[var_25_0].need[2]
	local var_25_2 = #CanteenEntrustData:GetDispatchCharacterList()

	arg_25_0.numText_.text = string.format("%d<size=28><color=#767878>/%d</color></size>", var_25_2, var_25_1)
end

function var_0_0.UpdataNeedFatigue(arg_26_0)
	local var_26_0 = CanteenEntrustData:GetDispatchCharacterList()
	local var_26_1 = 0

	if var_26_0 then
		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			var_26_1 = var_26_1 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustTotalFatigueReduce, iter_26_1)
		end

		if var_26_1 > 100 then
			var_26_1 = 100
		end
	end

	local var_26_2 = BackHomeCanteenTaskCfg[CanteenEntrustData:GetCurDispatchTask().id]

	arg_26_0.fatigue = math.ceil(var_26_2.cost * (100 - var_26_1) / 100)
	arg_26_0.resourcetextText_.text = arg_26_0.fatigue
end

function var_0_0.OnExit(arg_27_0)
	CanteenEntrustData:ClearDispatchCharacterList()
	arg_27_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_28_0)
	if arg_28_0.characterScroll_ then
		arg_28_0.characterScroll_:Dispose()
	end

	if arg_28_0.recomendScroll_ then
		arg_28_0.recomendScroll_:Dispose()
	end

	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
