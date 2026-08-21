local var_0_0 = class("BloodVisualCardView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.selectController_ = arg_2_0.controller_:GetController("select")
	arg_2_0.needPointController_ = arg_2_0.controller_:GetController("needPoint")
	arg_2_0.useController_ = arg_2_0.controller_:GetController("used")
	arg_2_0.stateController_ = arg_2_0.controller_:GetController("card")
	arg_2_0.skillController_ = arg_2_0.controller_:GetController("skill")
	arg_2_0.useFramController_ = arg_2_0.useExController_:GetController("used")
	arg_2_0.grayController_ = arg_2_0.useExController_:GetController("deplete")
	arg_2_0.tipsController_ = arg_2_0.controller_:GetController("tips")
	arg_2_0.lockController_ = arg_2_0.controller_:GetController("lock")
	arg_2_0.noneController_ = arg_2_0.controller_:GetController("none")
	arg_2_0.useNumController_ = arg_2_0.controller_:GetController("useNum")
	arg_2_0.cardCellControllerList_ = arg_2_0.cellContent_:GetComponentsInChildren(typeof(ControllerExSpace.ControllerExCollection)):ToTable()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickCallBack then
			arg_3_0.clickCallBack(arg_3_0.id_, arg_3_0.index_)
		end

		manager.notify:Invoke(BLOOD_CARD_BUILD_SELECTED, arg_3_0.id_, arg_3_0)
	end)
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0.powerText_.text = arg_5_0.cfg_.power
	arg_5_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_Com/CORGUI_3_10_BloodCardUI/" .. arg_5_0.cfg_.illustration)

	arg_5_0.needPointController_:SetSelectedState(arg_5_0.cfg_.need_point)

	if arg_5_0.cfg_.kind == 99 then
		if arg_5_0.isEnemy_ then
			arg_5_0.stateController_:SetSelectedState("redGold")
		else
			arg_5_0.stateController_:SetSelectedState("blueGold")
		end

		arg_5_0.useFramController_:SetSelectedState("gold")
	else
		if arg_5_0.isEnemy_ then
			arg_5_0.stateController_:SetSelectedState("red")
		else
			arg_5_0.stateController_:SetSelectedState("blue")
		end

		arg_5_0.useFramController_:SetSelectedState("normal")
	end

	if #arg_5_0.cfg_.effect_list > 0 then
		arg_5_0.skillController_:SetSelectedState("true")
	else
		arg_5_0.skillController_:SetSelectedState("false")
	end

	arg_5_0:RefreshUIEffetContent()
end

function var_0_0.SetState(arg_6_0, arg_6_1)
	arg_6_0.stateController_:SetSelectedState(arg_6_1)
end

function var_0_0.RefreshUIEffetContent(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.cardCellControllerList_) do
		iter_7_1:GetController("middle"):SetSelectedState("false")
		iter_7_1:GetController("grid"):SetSelectedState("false")
		iter_7_1:GetController("skill"):SetSelectedState("false")
	end

	arg_7_0.cardCellControllerList_[13]:GetController("middle"):SetSelectedState("true")

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.cfg_.c_grid_list) do
		highlightIndex = arg_7_0:ConverPosToIndex(13, iter_7_3[2], iter_7_3[1], 5, 5)

		if highlightIndex ~= -1 then
			arg_7_0.cardCellControllerList_[highlightIndex]:GetController("grid"):SetSelectedState("true")
		end
	end

	if arg_7_0.cfg_.s_grid_list ~= "" then
		for iter_7_4, iter_7_5 in ipairs(arg_7_0.cfg_.s_grid_list) do
			highlightIndex = arg_7_0:ConverPosToIndex(13, iter_7_5[2], iter_7_5[1], 5, 5)

			if highlightIndex ~= -1 then
				arg_7_0.cardCellControllerList_[highlightIndex]:GetController("skill"):SetSelectedState("true")
			end
		end
	end
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.id_ = arg_8_2
	arg_8_0.index_ = arg_8_1
	arg_8_0.cfg_ = BloodCardGameCardCfg[arg_8_0.id_]
	arg_8_0.isEnemy_ = arg_8_3

	arg_8_0.tipsController_:SetSelectedState("false")
	arg_8_0:RefreshUI()
end

function var_0_0.SetNone(arg_9_0, arg_9_1)
	arg_9_0.noneController_:SetSelectedState(tostring(arg_9_1))
end

function var_0_0.SetUsed(arg_10_0, arg_10_1)
	arg_10_0.useController_:SetSelectedState(tostring(arg_10_1))
end

function var_0_0.SetGray(arg_11_0, arg_11_1)
	arg_11_0.grayController_:SetSelectedState(tostring(arg_11_1))
	arg_11_0.lockController_:SetSelectedState(tostring(arg_11_1))
end

function var_0_0.SetClickCallBack(arg_12_0, arg_12_1)
	arg_12_0.clickCallBack = arg_12_1
end

function var_0_0.SetUseNum(arg_13_0, arg_13_1)
	arg_13_0.useNumController_:SetSelectedState(tostring(arg_13_1))
end

function var_0_0.SelectCard(arg_14_0, arg_14_1)
	arg_14_0.selectController_:SetSelectedState(tostring(arg_14_1 == arg_14_0.id_))
end

function var_0_0.SetOwnNum(arg_15_0, arg_15_1)
	arg_15_0.ownNumText_.text = "x" .. arg_15_1
end

function var_0_0.ShowDescTips(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.tipsTitle_.text = arg_16_0.cfg_.name
	arg_16_0.tipsDesc_.text = arg_16_0.cfg_.desc

	arg_16_0.tipsController_:SetSelectedState(tostring(arg_16_1 == arg_16_0.id_ and arg_16_0.index_ == arg_16_2))
end

function var_0_0.Dispose(arg_17_0)
	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.PlayAni(arg_18_0, arg_18_1)
	arg_18_0.animator_:Play(arg_18_1)
	arg_18_0.animator_:Update(0)
end

function var_0_0.ConverPosToIndex(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	row = math.ceil(arg_19_1 / arg_19_5)
	col = arg_19_1 % arg_19_5
	newCol = col + arg_19_3 * (arg_19_0.isEnemy_ and -1 or 1)
	newRow = row + arg_19_2 * (arg_19_0.isEnemy_ and -1 or 1)

	if newRow >= 1 and arg_19_4 >= newRow and newCol >= 1 and arg_19_5 >= newCol then
		return (newRow - 1) * arg_19_5 + newCol
	else
		return -1
	end
end

return var_0_0
