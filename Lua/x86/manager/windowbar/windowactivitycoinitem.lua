local var_0_0 = class("WindowActivityCoinItem", import("game.extend.ReduxView"))

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.currencyType_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
	arg_2_0:RefreshUI()

	arg_2_0.isCanAdd_ = true
	arg_2_0.isCanClick_ = false
	arg_2_0.type_ = "black"
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeSet_ = {
		"black",
		"hyaline"
	}
	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(nil, nil, "OnClick")
	arg_4_0:AddBtnListener(arg_4_0.buttonIcon_, nil, function()
		manager.notify:Invoke(WINDOW_BAR_INFO, arg_4_0.currencyType_, arg_4_0.gameObject_)
		arg_4_0:OnClick()
	end)
end

function var_0_0.OnClick(arg_6_0)
	if arg_6_0.materialType_ then
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_6_0.materialType_
		})
	end
end

function var_0_0.SetCanAdd(arg_7_0, arg_7_1)
	if arg_7_0.isCanAdd_ == arg_7_1 then
		return
	end

	arg_7_0.isCanAdd_ = arg_7_1

	SetActive(arg_7_0.add_, arg_7_1)
end

function var_0_0.SetCanClick(arg_8_0, arg_8_1)
	arg_8_0.isCanClick_ = arg_8_1
end

function var_0_0.SetType(arg_9_0, arg_9_1)
	if table.indexof(arg_9_0.typeSet_, arg_9_1) then
		arg_9_0.type_ = arg_9_1

		arg_9_0.typeCon_:SetSelectedState(arg_9_0.type_)
	end
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.materialType_ = nil

	if arg_10_0.activity_id and ActivityCfg[arg_10_0.activity_id] and ActivityTools.GetActivityType(arg_10_0.activity_id) == ActivityTemplateConst.ACTIVITY_PUSH_BOX then
		local var_10_0 = PushBoxTool:GetFatigueID(arg_10_0.activity_id)

		arg_10_0.icon_.sprite = ItemTools.getItemLittleSprite(var_10_0)

		local var_10_1 = PushBoxTool:GetFatigueMax(arg_10_0.activity_id)

		arg_10_0.text_.text = ActivityPushBoxData:GetFatigue(arg_10_0.activity_id) .. "/" .. var_10_1
		arg_10_0.materialType_ = var_10_0

		return
	end

	arg_10_0.icon_.sprite = nil
	arg_10_0.text_.text = ""
end

function var_0_0.SetActivityId(arg_11_0, arg_11_1)
	arg_11_0.activity_id = arg_11_1

	arg_11_0:RefreshUI()
end

function var_0_0.SetActive(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)

	if arg_12_1 then
		arg_12_0:RegistEventListener(ACTIVITY_ICON_CHANGE, handler(arg_12_0, arg_12_0.RefreshUI))
		arg_12_0:RefreshUI()
		arg_12_0.transform_:SetAsLastSibling()
	else
		arg_12_0:RemoveAllEventListener()
	end
end

function var_0_0.UnBindListener(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)

	arg_14_0.transform_ = nil
	arg_14_0.gameObject_ = nil
end

return var_0_0
