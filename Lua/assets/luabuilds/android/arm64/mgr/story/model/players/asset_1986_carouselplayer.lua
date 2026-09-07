local CarouselPlayer = class("CarouselPlayer", import(".StoryPlayer"))

function CarouselPlayer:OnReset(arg_1_1, arg_1_2, arg_1_3)
	setActive(self.actorPanel, false)
	arg_1_3()

	return
end

function CarouselPlayer:OnEnter(arg_2_1, arg_2_2, arg_2_3)
	self:StartAnimtion(arg_2_1, arg_2_3)

	return
end

function CarouselPlayer:StartAnimtion(arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1:GetBgs()

	assert(var_3_0)
	setActive(self.bgPanel, true)

	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_2 = iter_3_1[1]
		local var_3_3 = iter_3_1[2]

		table.insert(var_3_1, function(arg_4_0)
			self:ReplaceBg(var_3_2, var_3_3, arg_4_0)

			return
		end)
	end

	seriesAsync(var_3_1, arg_3_2)

	return
end

function CarouselPlayer:RegisetEvent(arg_5_1, arg_5_2)
	CarouselPlayer.super.RegisetEvent(self, arg_5_1, arg_5_2)
	triggerButton(self._go)

	return
end

function CarouselPlayer:ReplaceBg(arg_6_1, arg_6_2, arg_6_3)
	self.bgImage.sprite = self:GetBg(arg_6_1)

	self:DelayCall(arg_6_2, arg_6_3)

	return
end

return CarouselPlayer
