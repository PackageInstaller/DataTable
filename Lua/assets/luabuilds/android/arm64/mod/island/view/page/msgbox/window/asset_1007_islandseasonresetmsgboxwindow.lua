local IslandSeasonResetMsgBoxWindow = class("IslandSeasonResetMsgBoxWindow", import(".IslandCommonMsgboxWindow"))

function IslandSeasonResetMsgBoxWindow:getUIName()
	return "IslandCommonMsgBoxForSeasonReset"
end

function IslandSeasonResetMsgBoxWindow:OnLoaded()
	IslandSeasonResetMsgBoxWindow.super.OnLoaded(self)

	self.emptyTF = self._tf:Find("info_empty")
	self.awardTF = self._tf:Find("info_award")

	setText(self._tf:Find("confirm/Text"), i18n("word_ok"))

	return
end

function IslandSeasonResetMsgBoxWindow:OnShow()
	IslandSeasonResetMsgBoxWindow.super.OnShow(self)
	self:FlushResetInfo()

	return
end

function IslandSeasonResetMsgBoxWindow:FlushBtn(arg_4_1)
	setActive(self.cancelBtn, false)
	setActive(self.confirmBtn, true)

	return
end

function IslandSeasonResetMsgBoxWindow:FlushResetInfo()
	local var_5_0 = self.settings.body
	local var_5_1 = self.settings.body.awards

	setActive(self.emptyTF, #self.settings.body.awards == 0)
	setActive(self.awardTF, #var_5_1 > 0)

	local var_5_2

	if #var_5_1 == 0 then
		var_5_2 = self.emptyTF or self.awardTF
	end

	setText(var_5_2:Find("reset/name/Text"), i18n("island_season_window_pt", pg.island_season[var_5_0.seasonId].name))
	setText(var_5_2:Find("reset/value/Text"), var_5_0.pt)
	setText(var_5_2:Find("rank/name/Text"), i18n("island_season_window_ranking"))
	setText(var_5_2:Find("rank/value"), (var_5_0.rank > 0 or nil) and (var_5_0.rank or i18n("island_season_window_out")))

	if #var_5_1 > 0 then
		setText(var_5_2:Find("award/name/Text"), i18n("island_season_window_award"))
		UIItemList.StaticAlign(var_5_2:Find("award/list"), var_5_2:Find("award/list/tpl"), #var_5_1, function(arg_6_0, arg_6_1, arg_6_2)
			if arg_6_0 == UIItemList.EventUpdate then
				updateCustomDrop(arg_6_2, var_5_1[arg_6_1 + 1])
			end

			return
		end)
	end

	return
end

return IslandSeasonResetMsgBoxWindow
