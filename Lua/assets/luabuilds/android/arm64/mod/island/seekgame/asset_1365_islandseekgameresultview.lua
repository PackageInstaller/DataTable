local IslandSeekGameResultView = class("IslandSeekGameResultView", import("Mod.Island.Core.View.IslandASynLoadSubView"))

function IslandSeekGameResultView:Ctor(arg_1_1, arg_1_2)
	self.uiName = arg_1_2

	IslandSeekGameResultView.super.Ctor(self, arg_1_1)

	return
end

function IslandSeekGameResultView:GetUIName()
	return self.uiName
end

function IslandSeekGameResultView:FirstFlush()
	self.animation = self._tf:GetComponent(typeof(Animation))

	local var_3_0 = self._tf:GetComponent(typeof(DftAniEvent))

	setText(self._tf:Find("Text"), i18n("island_seek_game_tip"))
	onButton(self, self._tf, function()
		if self.clickableTime then
			if self.clickableTime > pg.TimeMgr.GetInstance():GetServerTime() then
				return
			end
		end

		if self.playAnimation then
			return
		end

		self.playAnimation = true

		self:GetView():RestartGame()
		self.animation:Play("anim_IslandSeekGameUI_out")

		return
	end, SFX_PANEL)
	var_3_0:SetEndEvent(function(arg_5_0)
		self:Hide()

		self.playAnimation = false

		return
	end)

	self.aniDft = var_3_0

	return
end

function IslandSeekGameResultView:Flush()
	self.animation:Play("anim_IslandSeekGameUI_in")

	self.clickableTime = pg.island_set.seek_game_reset_cd.key_value_int + pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function IslandSeekGameResultView:OnDestroy()
	if self.aniDft then
		self.aniDft:SetEndEvent(nil)
	end

	return
end

return IslandSeekGameResultView
