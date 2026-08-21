local var_0_0 = class("NewHeroArchiveHeroFillterItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickHandler_ then
			if arg_4_0.lock_ then
				if arg_4_0.type_ == 1 then
					ShowTips(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_RACE"))
				elseif arg_4_0.type_ == 2 then
					ShowTips(GetTips("HERO_HEART_CHAIN_SUPER_PLOT_UNLOCK_RACE"))
				end

				return
			end

			arg_4_0.clickHandler_(arg_4_0.id_, arg_4_0.index)
		end
	end)
end

function var_0_0.SetClickCallBack(arg_6_0, arg_6_1)
	arg_6_0.clickHandler_ = arg_6_1
end

function var_0_0.OnTop(arg_7_0)
	return
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.data_ = arg_8_1
	arg_8_0.id_ = arg_8_1.id
	arg_8_0.index_ = arg_8_2

	arg_8_0:RefreshUI(1)
end

function var_0_0.ResetData(arg_9_0)
	arg_9_0.data_ = nil
end

function var_0_0.RefreshUI(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	arg_10_0.type_ = arg_10_1

	if arg_10_1 == 1 then
		var_10_0 = ArchiveData:GetContinuousHeartArchiveListByType(arg_10_0.id_)
	elseif arg_10_1 == 2 then
		var_10_0 = ArchiveData:GetContinuousSuperHeartArchiveListByType(arg_10_0.id_)
	end

	if table.isEmpty(var_10_0) then
		arg_10_0.stateController:SetSelectedState("lock")

		arg_10_0.lock_ = true
	elseif arg_10_0.index_ == arg_10_2 then
		arg_10_0.stateController:SetSelectedState("selected")

		arg_10_0.lock_ = false
	elseif arg_10_0.index_ ~= arg_10_2 then
		arg_10_0.stateController:SetSelectedState("unselected")

		arg_10_0.lock_ = false
	end

	arg_10_0.img_.sprite = getSprite("Atlas/CampItemAtlas", arg_10_0.data_.icon)
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
