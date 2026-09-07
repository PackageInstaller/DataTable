local StoryPerformPlayer = class("StoryPerformPlayer", import(".BasePerformPlayer"))

function StoryPerformPlayer:Ctor(arg_1_1)
	StoryPerformPlayer.super.Ctor(self, arg_1_1)

	self.bgTF = self._tf:Find("bg")
	self.nameTF = self.bgTF:Find("name")
	self.imageCom = self.bgTF:Find("picture"):GetComponent(typeof(Image))

	return
end

function StoryPerformPlayer:Play(arg_2_1, arg_2_2, arg_2_3)
	self:Show()

	if self._anim then
		self._anim:Play()
	end

	if arg_2_3 then
		setText(self.nameTF, arg_2_3)
	end

	local var_2_0 = arg_2_1.param[1] or ""
	local var_2_1 = arg_2_1.param[2] or 3

	setActive(self.bgTF, false)
	LoadAnyAsync("educatepicture/" .. var_2_0, "", typeof(Sprite), function(arg_3_0)
		self.imageCom.sprite = arg_3_0

		setActive(self.bgTF, true)

		self.timer = Timer.New(function()
			if arg_2_2 then
				arg_2_2()
			end

			return
		end, var_2_1)

		self.timer:Start()

		return
	end)

	return
end

function StoryPerformPlayer:Clear()
	self.imageCom.sprite = nil

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	setText(self.nameTF, "")
	self:Hide()

	return
end

return StoryPerformPlayer
