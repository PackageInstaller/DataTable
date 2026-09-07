local IslandAsidePlayer = class("IslandAsidePlayer", import("Mgr.Story.model.animation.StoryAnimtion"))

function IslandAsidePlayer:Ctor(arg_1_1)
	IslandAsidePlayer.super.Ctor(self)

	self.asideUIlist = UIItemList.New(arg_1_1:Find("list"), arg_1_1:Find("list/tpl"))

	return
end

function IslandAsidePlayer:Play(arg_2_1, arg_2_2)
	self.asideUIlist:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			setText(arg_3_2, arg_2_1[arg_3_1 + 1].text)

			GetOrAddComponent(arg_3_2, typeof(CanvasGroup)).alpha = 0
		end

		return
	end)
	self.asideUIlist:align(#arg_2_1)

	local var_2_0 = {}

	self.asideUIlist:eachActive(function(arg_4_0, arg_4_1)
		table.insert(var_2_0, function(arg_5_0)
			self:TweenValueForcanvasGroup(GetOrAddComponent(arg_4_1, typeof(CanvasGroup)), 0, 1, 0.2, arg_2_1[arg_4_0 + 1].delay, arg_5_0)

			return
		end)

		return
	end)
	parallelAsync(var_2_0, function()
		self:Clear()
		self:DelayCall(1, arg_2_2)

		return
	end)

	return
end

function IslandAsidePlayer:Clear()
	self:ClearAnimation()

	return
end

function IslandAsidePlayer:Dispose()
	self:Clear()

	return
end

return IslandAsidePlayer
