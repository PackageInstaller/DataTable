local var_0_0 = class("EntityBubbleBase", BaseView)

function var_0_0.UIName(arg_1_0)
	return nil
end

function var_0_0.Ctor(arg_2_0, ...)
	arg_2_0.gameObject_ = GameObject.Instantiate(Asset.Load(arg_2_0:UIName()), manager.ui.uiMain.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:BindCfgUI()

	arg_2_0.follow = arg_2_0.transform_:GetComponent("UIFollow")

	arg_2_0:InitUI()
	arg_2_0:RegisterEvents()
	arg_2_0:SetData(...)
end

function var_0_0.InitUI(arg_3_0)
	return
end

function var_0_0.RegisterEvents(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0:RemoveAllListeners()
	arg_5_0:RemoveAllEventListener()
	GameObject.Destroy(arg_5_0.gameObject_)
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetData(arg_6_0)
	return
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.SetFollowEntity(arg_8_0, arg_8_1, arg_8_2)
	DormLuaBridge.SetUIFollow(arg_8_0.transform_, arg_8_1, arg_8_2)
end

function var_0_0.SetFollowTransform(arg_9_0, arg_9_1)
	arg_9_0.follow.origin = arg_9_1
end

return var_0_0
