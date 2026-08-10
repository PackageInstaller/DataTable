local var_0_0 = class("EquipAttributeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.levelText_ = {}

	for iter_3_0 = 1, 6 do
		arg_3_0.levelText_[iter_3_0] = arg_3_0["lv_" .. iter_3_0]
	end
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
		if arg_4_0.clickFunc_ then
			arg_4_0.clickFunc_({
				id = arg_4_0.attrID_,
				num = arg_4_0.skillSum_
			})
		end
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.attrID_ = arg_6_1
	arg_6_0.data_ = arg_6_2
	arg_6_0.isAdd_ = arg_6_3

	arg_6_0:RefreshAttr()
end

function var_0_0.RefreshAttr(arg_7_0)
	local var_7_0 = 0
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.data_) do
		local var_7_2 = iter_7_1.pos
		local var_7_3 = iter_7_1.level

		var_7_0 = var_7_0 + var_7_3
		var_7_1[var_7_2] = (var_7_1[var_7_2] or 0) + var_7_3
	end

	for iter_7_2 = 1, 6 do
		arg_7_0.levelText_[iter_7_2].text = var_7_1[iter_7_2] and var_7_1[iter_7_2] or ""
	end

	local var_7_4 = arg_7_0.isAdd_ and 1 or 0
	local var_7_5 = EquipSkillCfg[arg_7_0.attrID_]
	local var_7_6 = var_7_0 + var_7_4

	arg_7_0.skillSum_ = var_7_6 >= var_7_5.lvmax and var_7_5.lvmax or var_7_6
	arg_7_0.icon_.sprite = getEquipSkillSprite(arg_7_0.attrID_)
	arg_7_0.name_.text = GetI18NText(var_7_5.name)
	arg_7_0.desc_.text = GetCfgDescriptionWithValue(var_7_5.desc[1], var_7_5.upgrade / var_7_5.percent * arg_7_0.skillSum_)

	if arg_7_0.isAdd_ then
		arg_7_0.level_.text = "<color=#FF9500>" .. var_7_6 .. "</color>/" .. var_7_5.lvmax
	else
		arg_7_0.level_.text = var_7_6 .. "/" .. var_7_5.lvmax
	end
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickFunc_ = arg_8_1
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
