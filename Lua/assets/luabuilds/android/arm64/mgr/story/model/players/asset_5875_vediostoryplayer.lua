local VedioStoryPlayer = class("VedioStoryPlayer", import(".StoryPlayer"))

function VedioStoryPlayer:OnReset(arg_1_1, arg_1_2, arg_1_3)
	arg_1_3()

	return
end

local function var_0_1(arg_2_0)
	return PathMgr.getAssetBundle("originsource/cpk/" .. arg_2_0 .. ".cpk")
end

function VedioStoryPlayer:RegisetEvent(arg_3_1, arg_3_2)
	self:CheckAndPlay(arg_3_1, arg_3_1:GetVedioPath(), arg_3_2)

	return
end

function VedioStoryPlayer:CheckAndPlay(arg_4_1, arg_4_2, arg_4_3)
	if not IsUnityEditor and not PathMgr.FileExists(var_0_1(arg_4_2)) then
		arg_4_3()

		return
	end

	self:PlayVedio(arg_4_1, arg_4_2, arg_4_3)

	return
end

function VedioStoryPlayer:PlayVedio(arg_5_1, arg_5_2, arg_5_3)
	LoadAnyAsync("Story/" .. arg_5_2, "", nil, function(arg_6_0)
		if self.stop then
			return
		end

		local var_6_0 = Object.Instantiate(arg_6_0, self.frontTr)
		local var_6_1 = var_6_0.transform:Find("skip_button")

		onButton(self, var_6_1, function()
			self:ClearVedio()
			arg_5_3()

			return
		end, SFX_PANEL)
		var_6_0.transform:Find("cpk"):GetComponent(typeof(CriManaCpkUI)):SetPlayEndHandler(System.Action(function()
			triggerButton(var_6_1)

			return
		end))
		setActive(var_6_1, arg_5_1:GetSkipFlag())

		self._vedioGo = var_6_0

		return
	end)

	return
end

function VedioStoryPlayer:ClearVedio()
	if self._vedioGo then
		Object.Destroy(self._vedioGo)

		self._vedioGo = nil
	end

	return
end

function VedioStoryPlayer:OnClear()
	self:ClearVedio()

	return
end

function VedioStoryPlayer:OnEnd()
	self:ClearVedio()

	return
end

return VedioStoryPlayer
