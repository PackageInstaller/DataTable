local BossRushEXBattleResultLayer = class("BossRushEXBattleResultLayer", import("view.base.BaseUI"))

function BossRushEXBattleResultLayer:getUIName()
	return "BattleResultBossRushEXUI"
end

function BossRushEXBattleResultLayer:init()
	setText(self._tf:Find("TotalScore/Desc"), i18n("series_enemy_total_score"))

	return
end

function BossRushEXBattleResultLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_3_0 = self.contextData.seriesData

	onButton(self, self._tf:Find("Confirm"), function()
		self:emit(BossRushBattleResultMediator.ON_SETTLE)

		return
	end, SFX_PANEL)

	local var_3_1 = var_3_0 and var_3_0:GetFinalResults() or {}
	local var_3_2 = var_3_0 and var_3_0:GetEXScores()
	local var_3_3 = 0

	self.retPaintings = {}

	_.each(_.range(#var_3_2), function(arg_5_0)
		local var_5_0 = self._tf:Find("List"):GetChild(arg_5_0 - 1)
		local var_5_1 = self._tf:Find("Paintings"):GetChild(arg_5_0 - 1)
		local var_5_2 = var_5_0:Find("content/text")
		local var_5_3 = var_5_0:Find("content/desc")
		local var_5_4 = var_5_1:Find("mask/painting")

		setActive(var_5_0, arg_5_0 <= #var_3_2)
		setActive(var_5_1, arg_5_0 <= #var_3_2)

		if arg_5_0 > #var_3_2 then
			return
		end

		setText(var_5_2, var_3_2[arg_5_0])
		setText(var_5_3, i18n("series_enemy_score") .. " ")

		var_3_3 = var_3_3 + var_3_2[arg_5_0]

		local var_5_5 = (function()
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

		self:setPainting(var_5_4, var_5_5)
		table.insert(self.retPaintings, {
			var_5_4,
			var_5_5
		})

		return
	end)
	setText(self._tf:Find("TotalScore/Text"), var_3_3)
	self:loadUI()

	return
end

function BossRushEXBattleResultLayer:shareEx()
	return
end

function BossRushEXBattleResultLayer:setPainting(arg_9_1, arg_9_2, arg_9_3)
	setPaintingPrefabAsync(arg_9_1, arg_9_2, "biandui", arg_9_3)

	return
end

function BossRushEXBattleResultLayer:retPainting(arg_10_1, arg_10_2)
	retPaintingPrefab(arg_10_1, arg_10_2)

	return
end

function BossRushEXBattleResultLayer:onBackPressed()
	triggerButton(self._tf:Find("Confirm"))

	return
end

function BossRushEXBattleResultLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.retPaintings and #self.retPaintings > 0 then
		for iter_12_0, iter_12_1 in ipairs(self.retPaintings) do
			self:retPainting(iter_12_1[1], iter_12_1[2])
		end
	end

	return
end

function BossRushEXBattleResultLayer:loadUI()
	PoolMgr.GetInstance():GetUI("ShareUI", false, function(arg_14_0)
		setParent(arg_14_0.transform, self._tf)

		local var_14_0 = arg_14_0.transform:Find("deck")

		setActive(arg_14_0.transform:Find("panel"), false)
		setActive(arg_14_0.transform:Find("panel_pink"), false)
		GetComponent(arg_14_0.transform:Find("deck/logo"), "Image"):SetNativeSize()

		local var_14_1 = pg.share_template[pg.ShareMgr.TypeBossRushEX]

		assert(pg.share_template[pg.ShareMgr.TypeBossRushEX], "share_template not exist: " .. pg.ShareMgr.TypeBossRushEX)

		local var_14_2 = getProxy(PlayerProxy)
		local var_14_3 = var_14_2:getRawData()
		local var_14_4 = getProxy(UserProxy):getRawData()
		local var_14_5 = getProxy(ServerProxy).getRawData(var_14_2)[(var_14_4 or nil) and (var_14_4.server or 0)]
		local var_14_6

		if var_14_3 then
			var_14_6 = var_14_3.name or ""

			local var_14_7

			if var_14_5 then
				var_14_7 = var_14_5.name or ""
			end
		end

		local var_14_8 = pg.ShareMgr.ANCHORS_TYPE[var_14_1.deck] or {
			0.5,
			0.5,
			0.5,
			0.5
		}

		var_14_0.anchorMin = Vector2(var_14_8[1], var_14_8[2])
		var_14_0.anchorMax = Vector2(var_14_8[3], var_14_8[4])

		setText(var_14_0:Find("name/value"), var_14_6)
		setText(var_14_0:Find("server/value"), var_14_7)
		setText(var_14_0:Find("lv/value"), var_14_3.level)

		if PLATFORM_CODE == PLATFORM_CHT or PLATFORM_CODE == PLATFORM_CH then
			setActive(var_14_0:Find("code_bg"), true)
		else
			setActive(var_14_0:Find("code_bg"), false)
		end

		var_14_0.anchoredPosition3D = Vector3(var_14_1.qrcode_location[1], var_14_1.qrcode_location[2], -100)
		var_14_0.anchoredPosition = Vector2(var_14_1.qrcode_location[1], var_14_1.qrcode_location[2])

		return
	end)

	return
end

return BossRushEXBattleResultLayer
