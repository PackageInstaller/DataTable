local var_0_0 = class("ActivitySkinDrawItemOld", ReduxView)

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

	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		ShowPopItem(POP_ITEM, {
			arg_4_0.itemID_
		})
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.id_ = arg_7_2[1]
	arg_7_0.iconID_ = arg_7_2[2]
	arg_7_0.activityID_ = arg_7_1
	arg_7_0.cfg_ = ActivityLimitedDrawPoolCfg[arg_7_0.id_]

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.itemID_ = arg_8_0.cfg_.reward[1][1]
	arg_8_0.icon_.sprite = ItemTools.getItemSprite(arg_8_0.iconID_)
	arg_8_0.data_ = ActivitySkinDrawDataOld:GetDrawInfo(arg_8_0.activityID_, arg_8_0.id_)

	local var_8_0 = arg_8_0.data_ and arg_8_0.data_.num or arg_8_0.cfg_.total

	arg_8_0.typeCon_:SetSelectedState(var_8_0 > 0 and "false" or "true")
end

function var_0_0.SetValue(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
