local SubPageStoryPlayer = class("SubPageStoryPlayer", import(".StoryPlayer"))

function SubPageStoryPlayer:OnEnter(arg_1_1, arg_1_2, arg_1_3)
	seriesAsync({
		function(arg_2_0)
			self:OpenPage(arg_1_1, arg_2_0)

			return
		end
	}, arg_1_3)

	return
end

function SubPageStoryPlayer:OpenPage(arg_3_1, arg_3_2)
	self.page = arg_3_1:GetSubPageCls().New(pg.NewStoryMgr.GetInstance()._tf)

	self.page:ExecuteAction("Show", arg_3_2)

	return
end

function SubPageStoryPlayer:RegisetEvent(arg_4_1, arg_4_2)
	SubPageStoryPlayer.super.RegisetEvent(self, arg_4_1, arg_4_2)

	if self.page then
		self.page:Destroy()
	end

	self.page = nil

	triggerButton(self._go)

	return
end

return SubPageStoryPlayer
