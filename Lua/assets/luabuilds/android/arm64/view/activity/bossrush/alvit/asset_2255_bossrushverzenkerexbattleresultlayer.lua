local BossRushVerZenkerEXBattleResultLayer = class("BossRushVerZenkerEXBattleResultLayer", import("view.base.BaseUI"))

function BossRushVerZenkerEXBattleResultLayer:getUIName()
	return "BattleResultBossRushVerZenKerEXUI"
end

function BossRushVerZenkerEXBattleResultLayer:init()
	setText(self._tf:Find("TotalScore/Desc"), i18n("series_enemy_total_score"))

	return
end

function BossRushVerZenkerEXBattleResultLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_3_0 = self.contextData.seriesData

	onButton(self, self._tf:Find("Confirm"), function()
		self:emit(BossRushBattleResultMediator.ON_SETTLE)

		return
	end, SFX_PANEL)
	setText(self._tf:Find("Confirm/Text"), i18n("battle_result_confirm"))

	local var_3_1 = var_3_0 and var_3_0:GetFinalResults() or {}
	local var_3_2 = var_3_0 and var_3_0:GetEXScores()
	local var_3_3 = 0

	self.retPaintings = {}

	_.each(_.range(#var_3_2), function(arg_5_0)
		local var_5_0 = self._tf:Find("Paintings"):GetChild(arg_5_0 - 1)
		local var_5_1 = var_5_0:Find("content/text")
		local var_5_2 = var_5_0:Find("content/desc")
		local var_5_3 = var_5_0:Find("mask/painting")

		setActive(var_5_0, arg_5_0 <= #var_3_2)

		if arg_5_0 > #var_3_2 then
			return
		end

		setText(var_5_1, var_3_2[arg_5_0])
		setText(var_5_2, i18n("series_enemy_score") .. " ")

		var_3_3 = var_3_3 + var_3_2[arg_5_0]

		local var_5_4 = (function()
			local var_6_0 = var_3_1[arg_5_0]

			if not var_3_1[arg_5_0] then
				return
			end

			local var_6_1 = (function()
				if var_6_0.mvp ~= 0 then
					return var_6_0.mvp
				end

				return (var_6_0.newShips[1] or nil) and (var_6_0.newShips[1].id or nil)
			end)()

			if not var_6_1 then
				return
			end

			local var_6_2 = getProxy(BayProxy):RawGetShipById(var_6_1)

			if not var_6_2 then
				return
			end

			return var_6_2:getPainting()
		end)() or "changdao"

		self:setPainting(var_5_3, var_5_4)
		table.insert(self.retPaintings, {
			var_5_3,
			var_5_4
		})

		return
	end)
	setText(self._tf:Find("TotalScore/Text"), var_3_3)
	self:loadUI()

	return
end

function BossRushVerZenkerEXBattleResultLayer:setPainting(arg_8_1, arg_8_2, arg_8_3)
	setPaintingPrefabAsync(arg_8_1, arg_8_2, "biandui", arg_8_3)

	return
end

function BossRushVerZenkerEXBattleResultLayer:retPainting(arg_9_1, arg_9_2)
	retPaintingPrefab(arg_9_1, arg_9_2)

	return
end

function BossRushVerZenkerEXBattleResultLayer:onBackPressed()
	triggerButton(self._tf:Find("Confirm"))

	return
end

function BossRushVerZenkerEXBattleResultLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.retPaintings and #self.retPaintings > 0 then
		for iter_11_0, iter_11_1 in ipairs(self.retPaintings) do
			self:retPainting(iter_11_1[1], iter_11_1[2])
		end
	end

	return
end

function BossRushVerZenkerEXBattleResultLayer:loadUI()
	local var_12_0 = getProxy(PlayerProxy)
	local var_12_1 = var_12_0:getRawData()
	local var_12_2 = getProxy(UserProxy):getRawData()
	local var_12_3 = getProxy(ServerProxy).getRawData(var_12_0)[(var_12_2 or nil) and (var_12_2.server or 0)]
	local var_12_4

	if var_12_1 then
		var_12_4 = var_12_1.name or ""

		local var_12_5

		if var_12_3 then
			var_12_5 = var_12_3.name or ""
		end
	end

	local var_12_6 = self._tf:Find("share")

	setText(var_12_6:Find("name/value"), var_12_4)
	setText(var_12_6:Find("server"), i18n("zengke_series_serverinfo"))
	setText(var_12_6:Find("server/value"), var_12_5)
	setText(var_12_6:Find("lv/value"), var_12_1.level)

	return
end

return BossRushVerZenkerEXBattleResultLayer
