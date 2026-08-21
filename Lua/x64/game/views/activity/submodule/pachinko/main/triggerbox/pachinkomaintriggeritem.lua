local var_0_0 = class("PaChinKoMainTriggerItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.collider2D_ = arg_1_0.gameObject_:GetComponent(typeof(BoxCollider2D))
	arg_1_0.lightController_ = arg_1_0.uiControllerEx_:GetController("light")
	arg_1_0.triggerCom_ = arg_1_0.gameObject_:GetComponent(typeof(pachinko.PaChinKoTrigger))

	function arg_1_0.triggerCom_.onTriggerFun()
		arg_1_0:PlayEffect()
		manager.notify:Invoke(PACHINKO_FINISH, arg_1_2)
	end
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.triggerCom_.onTriggerFun = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetWidth(arg_5_0, arg_5_1)
	arg_5_0.uiRectTf_.sizeDelta = Vector2.New(arg_5_1, arg_5_0.uiRectTf_.sizeDelta.y)
	arg_5_0.collider2D_.size = Vector2.New(arg_5_1 - 30, arg_5_0.collider2D_.size.y)

	arg_5_0.lightController_:SetSelectedState("state0")
end

function var_0_0.PlayEffect(arg_6_0)
	arg_6_0.lightController_:SetSelectedState("state1")
end

return var_0_0
