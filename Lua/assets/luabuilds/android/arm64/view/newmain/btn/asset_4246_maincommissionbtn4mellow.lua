local MainCommissionBtn4Mellow = class("MainCommissionBtn4Mellow", import(".MainCommissionBtn"))

function MainCommissionBtn4Mellow:Ctor(arg_1_1, arg_1_2, arg_1_3)
	MainCommissionBtn4Mellow.super.Ctor(self, arg_1_1, arg_1_2, 0)

	self.animationPlayer = arg_1_1:GetComponent(typeof(Animation))

	return
end

function MainCommissionBtn4Mellow:OnClick()
	self.animationPlayer:Play("anim_newmain_extend_show")
	self:emit(NewMainMediator.OPEN_COMMISION)

	return
end

function MainCommissionBtn4Mellow:ResetCommissionBtn()
	self.animationPlayer:Play("anim_newmain_extend_hide")

	return
end

function MainCommissionBtn4Mellow:Flush(arg_4_1)
	if not arg_4_1 and not getProxy(ContextProxy):getCurrentContext():getContextByMediator(CommissionInfoMediator) then
		self:ResetCommissionBtn()
	end

	return
end

return MainCommissionBtn4Mellow
