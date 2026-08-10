local var_0_0 = class("PuzzlePiece", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.onClickHandler_ = handler(arg_2_0, arg_2_0.OnClick)

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0.clickListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(arg_4_0.onClickHandler_))
end

function var_0_0.OnClick(arg_5_0)
	if arg_5_0.ID_ ~= arg_5_0.emptyFlag_ and arg_5_0.selectCallBack_ ~= nil then
		arg_5_0.selectCallBack_(arg_5_0.index_)
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.activityID_ = arg_6_3
	arg_6_0.ID_ = arg_6_1
	arg_6_0.index_ = arg_6_2
	arg_6_0.emptyFlag_ = ActivityPuzzleCfg[arg_6_0.activityID_].block
	arg_6_0.size_ = arg_6_4

	arg_6_0:RefreshUI()
	SetActive(arg_6_0.gameObject_, true)
end

function var_0_0.SetID(arg_7_0, arg_7_1)
	arg_7_0.ID_ = arg_7_1

	arg_7_0:RefreshUI()
end

function var_0_0.SetSelectCallBack(arg_8_0, arg_8_1)
	arg_8_0.selectCallBack_ = arg_8_1
end

function var_0_0.RefreshUI(arg_9_0)
	if arg_9_0.ID_ ~= arg_9_0.emptyFlag_ then
		local var_9_0 = ActivityPuzzleCfg[arg_9_0.activityID_].picture_array
		local var_9_1 = ActivityPuzzleCfg[arg_9_0.activityID_].path

		arg_9_0.renderer_.sprite = getSprite(var_9_1, tostring(var_9_0[arg_9_0.ID_]))
	else
		arg_9_0.renderer_.sprite = nil
	end

	arg_9_0.renderer_.size = arg_9_0.size_
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.clickListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)

	arg_10_0.transform_ = nil
	arg_10_0.gameObject_ = nil
	arg_10_0.selectCallBack_ = nil
	arg_10_0.onClickHandler_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.SetActive(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

return var_0_0
