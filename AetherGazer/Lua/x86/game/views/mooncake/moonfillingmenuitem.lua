local var_0_0 = class("MoonFillingMenuItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selecteController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
	arg_2_0.materialList_ = {}
	arg_2_0.fillingItem_ = MoonCakeItem.New(arg_2_0.fillingItemGo_)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_3_0.maxTimes_ <= 0 then
			ShowTips("MID_AUTUMN_FESTIVAL_FILLING_MAKING_INSUFFICIENT_RAW_MATERIALS")

			return
		end

		if arg_3_0.chooseHandler_ then
			arg_3_0.chooseHandler_(arg_3_0.fillingID_)
		end
	end)
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.materialList_) do
		iter_5_1:Dispose()
	end

	arg_5_0.materialList_ = nil

	arg_5_0.fillingItem_:Dispose()

	arg_5_0.fillingItem_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.activityID_ = arg_6_2
	arg_6_0.fillingID_ = arg_6_1

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = MoonCakeFillingCfg[arg_7_0.fillingID_].patties

	arg_7_0.fillingItem_:SetData(var_7_0)
	arg_7_0.fillingItem_:SetType(MoonCakeConst.ITEM_STYLE.MAKE)

	arg_7_0.maxTimes_ = MoonCakeTools.GetFillingMultiTimes(arg_7_0.fillingID_)

	if arg_7_0.maxTimes_ > 0 then
		arg_7_0.fillingItem_:SetMakeTimes(arg_7_0.maxTimes_)
	end

	arg_7_0.fillingItem_:SetEnough(arg_7_0.maxTimes_ > 0)
	arg_7_0:RefreshMaterial()
end

function var_0_0.RefreshMaterial(arg_8_0)
	local var_8_0 = MoonCakeFillingCfg[arg_8_0.fillingID_].recipe

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if not arg_8_0.materialList_[iter_8_0] then
			local var_8_1 = Object.Instantiate(arg_8_0.materialGo_, arg_8_0.materialContentTrans_)

			arg_8_0.materialList_[iter_8_0] = MoonCakeItem.New(var_8_1)
		end

		local var_8_2 = ItemTools.getItemNum(iter_8_1[1])

		arg_8_0.materialList_[iter_8_0]:SetData(iter_8_1[1])
		arg_8_0.materialList_[iter_8_0]:SetEnough(var_8_2 >= iter_8_1[2])
	end

	for iter_8_2 = #var_8_0 + 1, #arg_8_0.materialList_ do
		arg_8_0.materialList_[iter_8_2]:SetActive(false)
	end
end

function var_0_0.SetSelect(arg_9_0, arg_9_1)
	arg_9_0.selecteController_:SetSelectedState(arg_9_0.ID_ == arg_9_1 and "true" or "false")
end

function var_0_0.SetChooseHandler(arg_10_0, arg_10_1)
	arg_10_0.chooseHandler_ = arg_10_1
end

return var_0_0
