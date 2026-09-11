local T0ShowTipsSubtitleData = class("T0ShowTipsSubtitleData", (import("game.views.t0World.Content.T0ChatOptions.T0SubtitleData")))

function T0ShowTipsSubtitleData:Ctor(arg_1_1)
	T0ShowTipsSubtitleData.super.Ctor(self, 0, "", 0, 999)

	self.showTipsKey = arg_1_1
end

function T0ShowTipsSubtitleData:GetContent()
	return GetTips(self.showTipsKey)
end

function T0ShowTipsSubtitleData:GetKey()
	return GetTips("T0_WORLD_HORUS_TIPS_16")
end

return T0ShowTipsSubtitleData
