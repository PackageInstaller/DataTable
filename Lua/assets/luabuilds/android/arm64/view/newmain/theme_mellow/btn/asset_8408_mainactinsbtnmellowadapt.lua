local MainActInsBtnMellowAdapt = class("MainActInsBtnMellowAdapt", import(".MainDifferentStyleSpActBtnAdapt"))

function MainActInsBtnMellowAdapt:GetContainer()
	return self.root:Find("left")
end

function MainActInsBtnMellowAdapt:OnInit()
	local var_2_0 = getProxy(InstagramProxy):ShouldShowTip()

	if not var_2_0 then
		var_2_0 = getProxy(InstagramProxy):ShouldShowTip()
		var_2_0 = var_2_0 or getProxy(InstagramChatProxy):ShouldShowTip()
	end

	setActive(self._tf:Find("tip"), var_2_0)

	self.textTr = self._tf:Find("Text"):GetComponent(typeof(Text))
	self.systemTimeUtil = self.systemTimeUtil or SystemTimeUtil.New()

	self:AddTimer()

	local var_2_1 = self._tf:GetComponent(typeof(Animation))

	if var_2_0 then
		var_2_1:Play("shake")
	else
		var_2_1:Stop()

		self._tf.localEulerAngles = Vector3.zero
	end

	local var_2_2 = getProxy(AppreciateProxy):CanPlayMainMusicPlayer()

	setActive(self._tf:Find("base"), not var_2_2)
	setActive(self._tf:Find("music"), var_2_2)

	return
end

function MainActInsBtnMellowAdapt:AddTimer()
	self.systemTimeUtil:SetUp(function(arg_4_0, arg_4_1, arg_4_2)
		self.textTr.text = arg_4_0 .. ":" .. arg_4_1

		return
	end)

	return
end

function MainActInsBtnMellowAdapt:RemoveTimer()
	if self.systemTimeUtil then
		self.systemTimeUtil:Dispose()

		self.systemTimeUtil = nil
	end

	return
end

function MainActInsBtnMellowAdapt:OnClear()
	self:RemoveTimer()

	return
end

function MainActInsBtnMellowAdapt:OnDisable()
	self:RemoveTimer()

	return
end

return MainActInsBtnMellowAdapt
