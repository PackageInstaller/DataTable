local MainActInsBtn = class("MainActInsBtn", import(".MainBaseSpcailActBtn"))

function MainActInsBtn:GetContainer()
	return self.root
end

function MainActInsBtn:InShowTime()
	return true
end

function MainActInsBtn:GetUIName()
	return "MainUIInsBtn"
end

function MainActInsBtn:OnClick()
	self.event:emit(NewMainMediator.SKIP_INS)

	return
end

function MainActInsBtn:OnRegister()
	self.initX = getAnchoredPosition(self._tf).x

	return
end

function MainActInsBtn:OnInit()
	self.animator = self._tf:Find("icon"):GetComponent(typeof(Animator))

	local var_6_0 = getProxy(InstagramProxy):ShouldShowTip()

	if not var_6_0 then
		var_6_0 = getProxy(InstagramChatProxy):ShouldShowTip()
		var_6_0 = var_6_0 or getProxy(InstagramProxy):ShouldShowTip()
	end

	self.animator.enabled = var_6_0

	setActive(self._tf:Find("Tip"), var_6_0)

	self._tf.localScale = self.isScale and Vector3(0.85, 0.85, 1) or Vector3(1, 1, 1)

	setAnchoredPosition(self._tf, {
		x = (self.isOverflow or nil) and (self.initX - 200 or self.initX),
		y = self.isScale and -950 or -752.5
	})

	return
end

return MainActInsBtn
