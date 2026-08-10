local var_0_0 = class("DormInfomationTrainSetHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormModifierEnterPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

local function var_0_1(arg_3_0, arg_3_1)
	return function(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0.originalDataIdx
		local var_4_1 = arg_4_0.archives_id
		local var_4_2 = arg_4_1.archives_id
		local var_4_3 = nullable(var_4_0, var_4_1) or 0
		local var_4_4 = nullable(var_4_0, var_4_2) or 0
		local var_4_5

		if arg_3_1 then
			var_4_5 = var_4_4 < var_4_3
		else
			var_4_5 = var_4_3 < var_4_4
		end

		if var_4_5 then
			return true
		elseif var_4_3 == var_4_4 then
			return var_4_1 < var_4_2
		end

		return false
	end
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()

	arg_5_0.removeOpSortFunc = var_0_1(arg_5_0, true)
end

function var_0_0.BuildContext(arg_6_0)
	arg_6_0.tempPosStore = {}
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()
	arg_7_0:InitView()
end

function var_0_0.InitView(arg_8_0)
	arg_8_0.holder = {}

	for iter_8_0 = 1, 5 do
		table.insert(arg_8_0.holder, DormInfomationHeroItem.New(arg_8_0["heroItem" .. iter_8_0]))
		arg_8_0.holder[iter_8_0]:SetState(true)
	end

	arg_8_0.characterScroll = LuaList.New(handler(arg_8_0, arg_8_0.IndexItem), arg_8_0.heroList_, DormInfomationHeroItem)
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.maskBtn_, nil, function()
		arg_9_0:Save()
	end)
	arg_9_0:AddBtnListener(arg_9_0.okBtn_, nil, function()
		arg_9_0:Save()
	end)
	arg_9_0:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function()
		arg_9_0:Refresh()
	end)
end

function var_0_0.SetHeroInPos(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.tempPosStore[arg_13_1] = arg_13_2
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:BuildContext()

	arg_14_0.state = arg_14_0.params_.state
	arg_14_0.editTempRemoveList = {}

	if arg_14_0.state == "train" then
		arg_14_0:RenderTrainSelectHero()
		arg_14_0:RenderTrainHero()
	elseif arg_14_0.state == "dorm" then
		arg_14_0:RenderDormSelectHero()
		arg_14_0:RenderDormHero()
	end

	arg_14_0:RecordOriginalDataIndex()
end

function var_0_0.RecordOriginalDataIndex(arg_15_0)
	arg_15_0.originalDataIdx = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.holder) do
		local var_15_0 = iter_15_1.heroID

		if var_15_0 then
			arg_15_0.originalDataIdx[DormData:GetHeroArchiveID(var_15_0)] = iter_15_0
		end
	end

	arg_15_0.originalStatus = {}

	for iter_15_2, iter_15_3 in pairs(arg_15_0.dataList) do
		local var_15_1 = DormData:GetHeroArchiveID(iter_15_3)
		local var_15_2 = DormData:GetHeroInfo(var_15_1):GetHeroState()

		arg_15_0.originalStatus[var_15_1] = var_15_2
	end
end

function var_0_0.RecordTempRemove(arg_16_0, arg_16_1)
	local var_16_0 = DormData:GetHeroArchiveID(arg_16_1)

	arg_16_0.editTempRemoveList[var_16_0] = arg_16_1

	arg_16_0:RefreshAllRemovedFromTrainingHeroState()
end

function var_0_0.CancelTempRemove(arg_17_0, arg_17_1)
	arg_17_0.editTempRemoveList[DormData:GetHeroArchiveID(arg_17_1)] = nil

	arg_17_0:RefreshAllRemovedFromTrainingHeroState()
end

function var_0_0.RenderDormSelectHero(arg_18_0)
	arg_18_0.dataList = arg_18_0:GetDormHeroList()

	arg_18_0:SortHeroList()
	arg_18_0.characterScroll:StartScroll(#arg_18_0.dataList)
end

function var_0_0.SortHeroList(arg_19_0)
	local var_19_0 = {
		[DormEnum.DormHeroState.InCanteenJob] = "canteen",
		[DormEnum.DormHeroState.InCanteenEntrust] = "task",
		[DormEnum.DormHeroState.InPublicDorm] = "lobby",
		[DormEnum.DormHeroState.InIdolTraineeCamp] = "idolCamp"
	}
	local var_19_1 = {
		[DormEnum.DormHeroState.InCanteenJob] = true,
		[DormEnum.DormHeroState.InCanteenEntrust] = true,
		[DormEnum.DormHeroState.InPublicDorm] = true,
		[DormEnum.DormHeroState.InPrivateDorm] = true,
		[DormEnum.DormHeroState.InIdolTraineeCamp] = true
	}

	if arg_19_0.state == "train" then
		DormTools.SortTrainHeroList(arg_19_0.dataList)
	elseif arg_19_0.state == "dorm" then
		DormTools.SortDormHeroList(arg_19_0.dataList)
	end
end

function var_0_0.RenderDormHero(arg_20_0)
	local var_20_0 = DormData:GetHeroInfoList()
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		if iter_20_1:GetHeroState() == DormEnum.DormHeroState.InPublicDorm then
			table.insert(var_20_1, iter_20_1.hero_id)
		end
	end

	for iter_20_2 = 1, 5 do
		if var_20_1[iter_20_2] then
			arg_20_0.holder[iter_20_2]:SetData({
				heroID = var_20_1[iter_20_2]
			})
			arg_20_0.holder[iter_20_2]:RegistCallBack(function(arg_21_0)
				arg_20_0:OnHolderHeroItemClick(arg_21_0, iter_20_2)
			end)
		else
			arg_20_0.holder[iter_20_2]:SetData(nil)
			arg_20_0.holder[iter_20_2]:RegistCallBack(function()
				arg_20_0:OnHolderHeroItemClick(nil)
			end)
		end
	end
end

function var_0_0.RenderTrainHero(arg_23_0)
	local var_23_0 = IdolTraineeData:GetHeroPosList()

	for iter_23_0 = 1, 5 do
		if var_23_0[iter_23_0] then
			if arg_23_0:CheckIsSameHero(var_23_0[iter_23_0], arg_23_0.tempPosStore[iter_23_0]) then
				var_23_0[iter_23_0] = arg_23_0.tempPosStore[iter_23_0] or var_23_0[iter_23_0]
			end

			arg_23_0:SetHeroInPos(iter_23_0, var_23_0[iter_23_0])
			arg_23_0.holder[iter_23_0]:SetData({
				heroID = var_23_0[iter_23_0]
			})
			arg_23_0.holder[iter_23_0]:RegistCallBack(function(arg_24_0)
				arg_23_0:OnHolderHeroItemClick(var_23_0[iter_23_0], iter_23_0)
			end)
		elseif arg_23_0.tempPosStore[iter_23_0] then
			arg_23_0.holder[iter_23_0]:SetData({
				heroID = arg_23_0.tempPosStore[iter_23_0]
			})
			arg_23_0.holder[iter_23_0]:RegistCallBack(function(arg_25_0)
				arg_23_0:OnHolderHeroItemClick(arg_23_0.tempPosStore[iter_23_0], iter_23_0)
			end)
		else
			arg_23_0.holder[iter_23_0]:SetData(nil)
			arg_23_0.holder[iter_23_0]:RegistCallBack(function()
				arg_23_0:OnHolderHeroItemClick(nil)
			end)
		end
	end
end

function var_0_0.CheckIsSameHero(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 == nil or arg_27_2 == nil then
		return false
	end

	return DormData:GetHeroArchiveID(arg_27_1) == DormData:GetHeroArchiveID(arg_27_2)
end

function var_0_0.RenderTrainSelectHero(arg_28_0)
	arg_28_0.dataList = IdolTraineeData:GetIdolHeroList()

	arg_28_0:SortHeroList()
	arg_28_0.characterScroll:StartScroll(#arg_28_0.dataList)
end

local function var_0_2(arg_29_0)
	if not arg_29_0 then
		return true
	end

	local var_29_0 = DormData:GetHeroTemplateInfo(arg_29_0)

	if var_29_0 then
		local var_29_1 = var_29_0:GetHeroState()

		if var_29_1 == DormEnum.DormHeroState.InCanteenEntrust or var_29_1 == DormEnum.DormHeroState.InCanteenJob then
			return true
		end

		return false
	end
end

function var_0_0.IndexItem(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.dataList[arg_30_1]

	arg_30_2:SetState(false)
	arg_30_2:SetShowMaskCallback(var_0_2)
	arg_30_2:SetData({
		heroID = var_30_0
	})
	arg_30_2:RefreshState()
	arg_30_2:RegistCallBack(function(arg_31_0)
		local var_31_0

		if arg_30_0.state == "train" then
			var_31_0 = arg_30_0:OnHeroItemClick(arg_31_0)
		elseif arg_30_0.state == "dorm" then
			var_31_0 = arg_30_0:OnDormHeroItemClick(arg_31_0)
		end

		if var_31_0 then
			arg_30_0:CancelTempRemove(arg_31_0)
		end
	end)
end

function var_0_0.OnDormHeroItemClick(arg_32_0, arg_32_1)
	local var_32_0 = DormData:GetHeroInfoList()
	local var_32_1 = {}
	local var_32_2 = 1

	for iter_32_0, iter_32_1 in pairs(var_32_0) do
		if iter_32_1:GetHeroState() == DormEnum.DormHeroState.InPublicDorm then
			if arg_32_0:CheckIsSameHero(iter_32_1.hero_id, arg_32_1) then
				arg_32_0:OnHolderHeroItemClick(iter_32_1.hero_id, var_32_2)

				return false
			end

			table.insert(var_32_1, iter_32_1.hero_id)

			var_32_2 = var_32_2 + 1
		end
	end

	if #var_32_1 == 5 then
		return false
	end

	local var_32_3 = DormData:GetHeroTemplateInfo(arg_32_1)

	if var_32_3 then
		local var_32_4 = var_32_3:GetHeroState()

		if var_32_4 == DormEnum.DormHeroState.InCanteenJob or var_32_4 == DormEnum.DormHeroState.InCanteenEntrust then
			ShowTips(GetTips("BACKHOME_HERO_OCCUPYED"))

			return false
		end
	end

	table.insert(var_32_1, arg_32_1)
	DormAction:DeployHeroInRoom(DormConst.PUBLIC_DORM_ID, var_32_1, DormEnum.DormDeployType.Place)
	arg_32_0:Refresh()

	return true
end

function var_0_0.OnHeroItemClick(arg_33_0, arg_33_1)
	local var_33_0 = -1
	local var_33_1 = IdolTraineeData:GetHeroPosList()

	for iter_33_0 = 1, 5 do
		local var_33_2 = DormData:GetHeroArchiveID(var_33_1[iter_33_0])
		local var_33_3 = DormData:GetHeroArchiveID(arg_33_1)

		if var_33_1[iter_33_0] and var_33_1[iter_33_0] > 0 and var_33_2 == var_33_3 then
			arg_33_0:OnHolderHeroItemClick(arg_33_1, iter_33_0)

			return false
		end

		if arg_33_0.tempPosStore[iter_33_0] == arg_33_1 then
			IdolTraineeCampBridge.SetHeroStateNil(arg_33_1)
			arg_33_0:OnHolderHeroItemClick(arg_33_1, iter_33_0)

			return false
		end
	end

	for iter_33_1 = 1, 5 do
		if not arg_33_0.tempPosStore[iter_33_1] then
			var_33_0 = iter_33_1

			break
		end
	end

	if var_33_0 == -1 then
		return false
	end

	local var_33_4 = DormData:GetHeroTemplateInfo(arg_33_1)

	if var_33_4 then
		local var_33_5 = var_33_4:GetHeroState()

		if var_33_5 == DormEnum.DormHeroState.InCanteenJob or var_33_5 == DormEnum.DormHeroState.InCanteenEntrust then
			ShowTips(GetTips("BACKHOME_HERO_OCCUPYED"))

			return false
		end
	end

	if var_33_0 ~= -1 then
		arg_33_0:SetHeroInPos(var_33_0, arg_33_1)
		IdolTraineeCampBridge.SetPosOfHero(arg_33_1, var_33_0, true)
	end

	arg_33_0:Refresh()

	return true
end

local function var_0_3(arg_34_0)
	local var_34_0 = arg_34_0.editTempRemoveList
	local var_34_1 = arg_34_0.removeOpSortFunc
	local var_34_2 = {}

	for iter_34_0, iter_34_1 in pairs(var_34_0) do
		local var_34_3 = DormData:GetHeroTemplateInfo(iter_34_1)

		table.insert(var_34_2, var_34_3)
	end

	CommonTools.UniversalSortEx(var_34_2, {
		map = function(arg_35_0)
			local var_35_0 = arg_35_0.archives_id

			if arg_34_0.originalStatus[var_35_0] ~= DormEnum.DormHeroState.InIdolTraineeCamp then
				return 1
			end

			return 0
		end
	}, {
		ascend = true,
		lessOp = var_34_1
	})

	return var_34_2
end

function var_0_0.RefreshAllRemovedFromTrainingHeroState(arg_36_0)
	local var_36_0 = var_0_3(arg_36_0)

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		iter_36_1:EnsureNotInPublicHall()
	end

	for iter_36_2, iter_36_3 in ipairs(var_36_0) do
		local var_36_1 = arg_36_0.originalStatus[iter_36_3.archives_id]

		if var_36_1 == DormEnum.DormHeroState.OutDorm or var_36_1 == DormEnum.DormHeroState.InPrivateDorm then
			iter_36_3:OutDorm()
		else
			iter_36_3:BackToDorm()
		end
	end

	manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
end

function var_0_0.OnHolderHeroItemClick(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1 == nil then
		return
	end

	if arg_37_0.state == "train" then
		IdolTraineeCampBridge.SetHeroStateNil(arg_37_1)
		arg_37_0:RecordTempRemove(arg_37_1)
		arg_37_0:SetHeroInPos(arg_37_2, nil)
	elseif arg_37_0.state == "dorm" then
		local var_37_0 = DormData:GetHeroInfoList()
		local var_37_1 = {}

		for iter_37_0, iter_37_1 in pairs(var_37_0) do
			if iter_37_1:GetHeroState() == DormEnum.DormHeroState.InPublicDorm and iter_37_1.hero_id ~= arg_37_1 then
				table.insert(var_37_1, iter_37_1.hero_id)
			end
		end

		DormAction:DeployHeroInRoom(DormConst.PUBLIC_DORM_ID, var_37_1, DormEnum.DormDeployType.Place)
	end

	arg_37_0:Refresh()
end

function var_0_0.Refresh(arg_38_0)
	if arg_38_0.state == "train" then
		arg_38_0:RenderTrainHero()
	elseif arg_38_0.state == "dorm" then
		arg_38_0:RenderDormHero()
	end

	arg_38_0.characterScroll:Refresh()
end

function var_0_0.Save(arg_39_0)
	if arg_39_0.state == "train" then
		arg_39_0:SaveTrainList()
	elseif arg_39_0.state == "dorm" then
		arg_39_0:SaveDormList()
	end
end

function var_0_0.SaveDormList(arg_40_0)
	manager.notify:Invoke(DORM_REGENERATE_HERO)
	JumpTools.Back()
end

function var_0_0.SaveTrainList(arg_41_0)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in pairs(arg_41_0.tempPosStore) do
		table.insert(var_41_0, {
			hero_id = iter_41_1,
			pos = iter_41_0
		})
	end

	IdolTraineeAction.RequestSetHeroPos(var_41_0, function()
		BackHomeAction:GetAllDetailInfo(function()
			return
		end)
		manager.notify:Invoke(DORM_REGENERATE_HERO)
		JumpTools.Back()
	end)
end

function var_0_0.OnExit(arg_44_0)
	arg_44_0.editTempRemoveList = nil
end

function var_0_0.GetDormHeroList()
	local var_45_0 = DormHeroTools:GetBackHomeCanUseHeroList(DormConst.PUBLIC_DORM_ID)

	CommonTools.UniversalSortEx(var_45_0, {
		ascend = true,
		map = function(arg_46_0)
			local var_46_0 = DormData:GetHeroTemplateInfo(arg_46_0):GetHeroState()

			if var_46_0 == DormEnum.DormHeroState.InPublicDorm then
				return 1
			elseif var_46_0 == DormEnum.DormHeroState.OutDorm then
				return 2
			elseif var_46_0 == DormEnum.DormHeroState.InPrivateDorm then
				return 3
			elseif var_46_0 == DormEnum.DormHeroState.InCanteenJob then
				local var_46_1 = DormData:GetHeroTemplateInfo(arg_46_0).jobType

				if var_46_1 == DormNpcTools.BackHomeNpcType.cook then
					return 4
				elseif var_46_1 == DormNpcTools.BackHomeNpcType.waiter then
					return 5
				elseif var_46_1 == DormNpcTools.BackHomeNpcType.cashier then
					return 6
				end
			elseif var_46_0 == DormEnum.DormHeroState.InCanteenEntrust then
				return 7
			elseif var_46_0 == DormEnum.DormHeroState.InIdolTraineeCamp then
				return 8
			end
		end
	}, {
		ascend = true,
		map = function(arg_47_0)
			return (DormData:GetHeroTemplateInfo(arg_47_0):GetFatigue())
		end
	}, {
		map = function(arg_48_0)
			return (DormData:GetHeroArchiveID(arg_48_0))
		end
	}, {
		map = function(arg_49_0)
			return arg_49_0
		end
	})

	return var_45_0
end

function var_0_0.Dispose(arg_50_0)
	arg_50_0.characterScroll:Dispose()

	for iter_50_0 = 1, 5 do
		arg_50_0.holder[iter_50_0]:Dispose()
	end

	arg_50_0.holder = nil

	var_0_0.super.Dispose(arg_50_0)
end

return var_0_0
