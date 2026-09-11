local PaChinKoMainTriggerItem = class("PaChinKoMainTriggerItem", ReduxView)

function PaChinKoMainTriggerItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.collider2D_ = self.gameObject_:GetComponent(typeof(BoxCollider2D))
	self.lightController_ = self.uiControllerEx_:GetController("light")
	self.triggerCom_ = self.gameObject_:GetComponent(typeof(pachinko.PaChinKoTrigger))

	function self.triggerCom_.onTriggerFun()
		self:PlayEffect()
		manager.notify:Invoke(PACHINKO_FINISH, arg_1_2)
	end
end

function PaChinKoMainTriggerItem:Dispose()
	self.triggerCom_.onTriggerFun = nil

	PaChinKoMainTriggerItem.super.Dispose(self)
end

function PaChinKoMainTriggerItem:AddListeners()
	return
end

function PaChinKoMainTriggerItem:SetWidth(arg_5_1)
	self.uiRectTf_.sizeDelta = Vector2.New(arg_5_1, self.uiRectTf_.sizeDelta.y)
	self.collider2D_.size = Vector2.New(arg_5_1 - 30, self.collider2D_.size.y)

	self.lightController_:SetSelectedState("state0")
end

function PaChinKoMainTriggerItem:PlayEffect()
	self.lightController_:SetSelectedState("state1")
end

return PaChinKoMainTriggerItem
