local CGStoryPlayer = class("CGStoryPlayer", import(".StoryPlayer"))

function CGStoryPlayer:OnReset(arg_1_1, arg_1_2, arg_1_3)
	setActive(self.frontTr, false)

	self.color = self.mainImg.color
	self.mainImg.color = Color.New(1, 1, 1, 0)

	arg_1_3()

	return
end

function CGStoryPlayer:OnInit(arg_2_1, arg_2_2, arg_2_3)
	seriesAsync({
		function(arg_3_0)
			gcAll(true)
			onNextTick(arg_3_0)

			return
		end,
		function(arg_4_0)
			self:LoadCGUI(arg_4_0)

			return
		end,
		function(arg_5_0)
			self:PlayCGAnimation(arg_2_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			self:ClearCGUI()
			arg_6_0()

			return
		end
	}, arg_2_3)

	return
end

function CGStoryPlayer:LoadCGUI(arg_7_1)
	if self.cgUI and not IsNil(self.cgUI) then
		arg_7_1()

		return
	end

	LoadAndInstantiateAsync("ui", "StoryCGPlayerUI", function(arg_8_0)
		self.cgUI = arg_8_0
		self.cgTF = arg_8_0.transform

		self.cgTF:SetParent(self._tf, false)

		self.cgPlayer = ReFluxCGPlayer.New(arg_8_0)

		arg_7_1()

		return
	end, true, true)

	return
end

function CGStoryPlayer:PlayCGAnimation(arg_9_1, arg_9_2)
	self.cgPlayer:Play(arg_9_1:GetBgs(), arg_9_2)

	return
end

function CGStoryPlayer:RegisetEvent(arg_10_1, arg_10_2)
	CGStoryPlayer.super.RegisetEvent(self, arg_10_1, arg_10_2)
	triggerButton(self._go)

	return
end

function CGStoryPlayer:ClearCGUI()
	if self.cgUI == nil then
		return
	end

	if self.cgUI and not IsNil(self.cgUI) then
		Object.Destroy(self.cgUI)
	end

	if self.cgPlayer then
		self.cgPlayer:Dispose()

		self.cgPlayer = nil
	end

	self.cgUI = nil
	self.cgTF = nil
	self.mainImg.color = self.color

	gcAll()

	return
end

function CGStoryPlayer:OnClear()
	self:ClearCGUI()

	return
end

function CGStoryPlayer:OnEnd()
	self:ClearCGUI()

	return
end

return CGStoryPlayer
