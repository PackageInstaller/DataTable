local T0LuaSubtitleData = class("T0LuaSubtitleData")

function T0LuaSubtitleData:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.formID = arg_1_1
	self.file = arg_1_2
	self.displayStartTime = arg_1_3
	self.displayEndTime = arg_1_4
	self.onEndDisplayCallback = arg_1_5
end

function T0LuaSubtitleData:IsShow()
	return not self:IsWaiting() and Time.time < self.displayEndTime
end

function T0LuaSubtitleData:IsWaiting()
	return Time.time < self.displayStartTime
end

function T0LuaSubtitleData:OnEndDisplay()
	if self.onEndDisplayCallback then
		LuaExchangeHelper.ActionInvoke(self.onEndDisplayCallback)
	end
end

function T0LuaSubtitleData:OnDispose()
	self.onEndDisplayCallback = nil
end

function T0LuaSubtitleData:GetContent()
	return HeroVoiceDescCfg.Get(self.formID, (HeroTools.FindMatchSkinVoiceID(self.formID, self.file)))
end

function T0LuaSubtitleData:GetKey()
	return T0WorldTools.GetCharacterShowName(self.formID)
end

return T0LuaSubtitleData
