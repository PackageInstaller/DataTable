local MainCommissionBtn = class("MainCommissionBtn", import(".MainBaseBtn"))

function MainCommissionBtn:Ctor(arg_1_1, arg_1_2, arg_1_3)
	MainCommissionBtn.super.Ctor(self, arg_1_1, arg_1_2)

	self.animTime = arg_1_3 or 0.2

	self:bind(NewMainMediator.REMOVE_LAYERS, function(arg_2_0, arg_2_1)
		self:OnRemoveLayer(arg_2_1.context)

		return
	end)

	return
end

function MainCommissionBtn:IsFixed()
	return true
end

function MainCommissionBtn:OnClick()
	if LeanTween.isTweening(self._tf.gameObject) then
		return
	end

	LeanTween.moveX(self._tf, -1 * self._tf.rect.width, self.animTime):setOnComplete(System.Action(function()
		self:emit(NewMainMediator.OPEN_COMMISION)

		return
	end))

	return
end

function MainCommissionBtn:OnRemoveLayer(arg_6_1)
	if arg_6_1.mediator == CommissionInfoMediator then
		self:ResetCommissionBtn()
	end

	return
end

function MainCommissionBtn:ResetCommissionBtn()
	self._tf.localPosition = Vector3(0, self._tf.localPosition.y, 0)

	return
end

function MainCommissionBtn:Flush(arg_8_1)
	self:ResetCommissionBtn()

	return
end

return MainCommissionBtn
