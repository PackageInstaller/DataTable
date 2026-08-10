local var_0_0 = class("CultureGravureEquipPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero/HeroCultureGravurepopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()

	arg_3_0.equipPreviewList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.previewListGo_, CultureGravureEquipPopItem)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnConfirm_, nil, function()
		if arg_5_0.params_.index and arg_5_0.params_.index ~= 0 then
			if CultureGravureAction.EquipByEquiptID(arg_5_0.heroId_, arg_5_0.selectId_) then
				arg_5_0:UpdateData(arg_5_0.params_.index)
				arg_5_0:Back()
				ShowTips("EQUIP_BIND")
			else
				ShowTips("ERROR_NO_EQUIP")
			end
		else
			CultureGravureAction.EquipByList(arg_5_0.heroId_, arg_5_0.params_.recommendIdList)
			arg_5_0:Back()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnBack_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.heroId_ = arg_8_0.params_.heroId
	arg_8_0.stateList_ = arg_8_0.params_.stateList
	arg_8_0.equiptDataList_ = {}

	arg_8_0:UpdateData(arg_8_0.params_.index)
	arg_8_0.equipPreviewList_:StartScroll(#arg_8_0.equiptDataList_)
end

function var_0_0.UpdateData(arg_9_0, arg_9_1)
	local var_9_0 = HeroTools.GetHeroEquipS(arg_9_0.heroId_)
	local var_9_1 = arg_9_0.params_.recommendIdList

	if arg_9_1 and arg_9_1 ~= 0 then
		local var_9_2 = {
			equipedData = EquipData:GetEquipData(var_9_0[arg_9_1].equip_id)
		}
		local var_9_3 = CultureGravureAction.GetRecommendEquip(arg_9_0.heroId_, var_9_1[arg_9_1]).id

		var_9_2.recommendData = EquipData:GetEquipData(var_9_3)
		var_9_2.state = arg_9_0.stateList_[arg_9_1]

		table.insert(arg_9_0.equiptDataList_, var_9_2)

		arg_9_0.selectId_ = var_9_1[arg_9_1]
	else
		local var_9_4 = CultureGravureAction.GetRecommendEquipList(arg_9_0.heroId_, var_9_1)

		for iter_9_0 = 1, 6 do
			local var_9_5 = {
				equipedData = EquipData:GetEquipData(var_9_0[iter_9_0].equip_id),
				recommendData = EquipData:GetEquipData(var_9_4[iter_9_0].equip_id),
				state = arg_9_0.stateList_[iter_9_0]
			}

			table.insert(arg_9_0.equiptDataList_, var_9_5)
		end
	end
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.params_.index ~= 0 and arg_10_0.params_.index or arg_10_1

	arg_10_2:SetData(arg_10_0.equiptDataList_[arg_10_1], var_10_0)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.equipPreviewList_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
