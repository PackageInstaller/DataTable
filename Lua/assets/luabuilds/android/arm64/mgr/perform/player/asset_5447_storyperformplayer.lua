local StoryPerformPlayer = class("StoryPerformPlayer", import(".BasePerformPlayer"))

function StoryPerformPlayer:Ctor(arg_1_1)
	StoryPerformPlayer.super.Ctor(self, arg_1_1)

	self.noDrawGraphicCom = self._tf.parent:GetComponent("NoDrawingGraphic")

	return
end

function StoryPerformPlayer:Play(arg_2_1, arg_2_2)
	self:Show()

	self.noDrawGraphicCom.enabled = false

	pg.NewStoryMgr.GetInstance():Play(arg_2_1.param or "", function()
		self.noDrawGraphicCom.enabled = true

		if arg_2_2 then
			arg_2_2()
		end

		return
	end, true)

	return
end

function StoryPerformPlayer:Clear()
	self:Hide()

	return
end

return StoryPerformPlayer
