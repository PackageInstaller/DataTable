local NewEducateCpkHandler = class("NewEducateCpkHandler")

function NewEducateCpkHandler:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._anim = self._tf:GetComponent(typeof(Animation))
	self.bgTF = self._tf:Find("bg")
	self.nameTF = self.bgTF:Find("name")
	self.sliderTF = self.bgTF:Find("slider")
	self.cpkPlayer = self.bgTF:Find("cpk/usm"):GetComponent(typeof(CriManaCpkUI))

	self.cpkPlayer:SetMaxFrameDrop(CriWare.CriManaMovieMaterialBase.MaxFrameDrop.Infinite)

	self.cpkCoverTF = self.bgTF:Find("cpk_cover")
	self.frameRate = Application.targetFrameRate or 60

	return
end

function NewEducateCpkHandler:SetCriManaCpkUIParam(arg_2_1)
	self.cpkPlayer.cpkPath = string.lower("OriginSource/cpk/" .. arg_2_1 .. ".cpk")
	self.cpkPlayer.movieName = string.lower(arg_2_1 .. ".bytes")

	return
end

function NewEducateCpkHandler:Play(arg_3_1, arg_3_2, arg_3_3)
	setActive(self._go, true)

	if self._anim then
		self._anim:Play()
	end

	self.cpkPlayer:StopCpk()
	setText(self.nameTF, arg_3_3 or "")
	self:SetCriManaCpkUIParam(arg_3_1)
	self.cpkPlayer:SetCpkTotalTimeCallback(function(arg_4_0)
		self.totalTime = arg_4_0

		self:OnStartCpk()

		return
	end)
	self.cpkPlayer:SetPlayEndHandler(function()
		existCall(arg_3_2)
		self:OnEndCpk()

		return
	end)
	self.cpkPlayer:PlayCpk()

	return
end

function NewEducateCpkHandler:OnStartCpk()
	setSlider(self.sliderTF, 0, 1, 0)

	self.passTime = 0
	self.timer = Timer.New(function()
		self.passTime = self.passTime + 1 / self.frameRate

		setSlider(self.sliderTF, 0, 1, self.passTime / self.totalTime)

		return
	end, 1 / self.frameRate, -1)

	self.timer:Start()

	return
end

function NewEducateCpkHandler:OnEndCpk()
	setSlider(self.sliderTF, 0, 1, 1)

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	self.cpkPlayer:SetPlayEndHandler(nil)

	return
end

function NewEducateCpkHandler:SetUIParam(arg_9_1)
	setAnchoredPosition(self.bgTF, arg_9_1 and {
		x = 146,
		y = -45
	} or {
		x = 0,
		y = 0
	})

	GetComponent(self.bgTF, typeof(Image)).enabled = not arg_9_1

	return
end

function NewEducateCpkHandler:Reset()
	setActive(self._go, false)

	return
end

function NewEducateCpkHandler:Destroy()
	return
end

return NewEducateCpkHandler
