local AgoraDecorationPreview = class("AgoraDecorationPreview", import("Mod.Island.Core.View.IslandASynLoadSubView"))

function AgoraDecorationPreview:GetUIName()
	return "IslandAgoraPreviewDecorationUI"
end

function AgoraDecorationPreview:OnInit(arg_2_1)
	self.backBtn = self._tf:Find("top/back")

	onButton(self, self.backBtn, function()
		self:Op("GoBackLastExitPoint")

		return
	end, SFX_CANCEL)
	setText(self._tf:Find("top/title/Text"), i18n("island_agora_furniure_preview"))

	return
end

function AgoraDecorationPreview:Execute(arg_4_1, ...)
	if not self[arg_4_1] then
		return
	end

	AgoraDecorationPreview.super.Execute(self, arg_4_1, ...)

	return
end

return AgoraDecorationPreview
