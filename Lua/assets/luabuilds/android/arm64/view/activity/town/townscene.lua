local var_0_0 = class("TownScene", import("view.base.BaseUI"))

var_0_0.RANDOM_POS = {
	Vector2.New(111.3, 150),
	Vector2.New(-235.9, 113.2),
	Vector2.New(570, 424.5),
	Vector2.New(-790.3, 569.9),
	Vector2.New(-440.7, -26.8),
	Vector2.New(-1206.2, 2),
	Vector2.New(-705.8, -379),
	Vector2.New(-1021.7, -153.9),
	Vector2.New(-385.6, -479.7),
	Vector2.New(367.1, -749),
	Vector2.New(107.6, -684.9),
	Vector2.New(338.7, 150)
}
var_0_0.STATIC_POS = Vector2.New(-440.7, -26.8)
var_0_0.SDScale = 0.5

function var_0_0.getUIName(arg_1_0)
	return "TownUI"
end

function var_0_0.SetActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1
	arg_2_0.shipIds = arg_2_0.activity:GetShipIds()

	return
end

function var_0_0.init(arg_3_0)
	arg_3_0.mapTF = arg_3_0._tf:Find("map")
	arg_3_0.bgTFs = arg_3_0._tf:Find("map/bg")
	arg_3_0.slotTFs = arg_3_0._tf:Find("map/content")
	arg_3_0.slotTpl = arg_3_0._tf:Find("map/content/tpl")

	setActive(arg_3_0.slotTpl, false)

	local var_3_0 = arg_3_0._tf:Find("ui")

	arg_3_0.topUI = var_3_0:Find("top")
	arg_3_0.goldText = arg_3_0.topUI:Find("gold/Text"):GetComponent(typeof(Text))
	arg_3_0.infoPage = TownInfoPage.New(var_3_0, arg_3_0)

	arg_3_0.infoPage:ExecuteAction("Flush")

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0.topUI:Find("back"), function()
		arg_4_0:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.topUI:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.town_help.tip
		})

		return
	end, SFX_PANEL)
	onScroll(arg_4_0, arg_4_0.mapTF, function(arg_7_0)
		return
	end)

	arg_4_0.timeCfg = arg_4_0.activity:getConfig("config_client").endingtime
	arg_4_0.spineRoles = {}

	arg_4_0:UpdateShips()

	arg_4_0.timer = Timer.New(function()
		arg_4_0:OnUpdateTime()

		return
	end, 1, -1)

	arg_4_0.timer:Start()
	arg_4_0:OnUpdateTime()
	seriesAsync({
		function(arg_9_0)
			local var_9_0 = pg.activity_town_level[arg_4_0.activity:GetTownLevel()].unlock_story

			if var_9_0 ~= "" then
				if not pg.NewStoryMgr.GetInstance():IsPlayed(var_9_0) then
					pg.NewStoryMgr.GetInstance():Play(var_9_0, arg_9_0)

					goto label_9_0
				end
			end

			arg_9_0()

			::label_9_0::

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_4_0.activity:getConfig("config_client").story[1][1]

			if (function()
				return underscore.all(arg_4_0.activity:getConfig("config_client").beforestory, function(arg_12_0)
					return pg.NewStoryMgr.GetInstance():IsPlayed(arg_12_0[1])
				end)
			end)() then
				if not pg.NewStoryMgr.GetInstance():IsPlayed(var_10_0) then
					pg.NewStoryMgr.GetInstance():Play(var_10_0, arg_10_0)

					goto label_10_0
				end
			end

			arg_10_0()

			::label_10_0::

			return
		end,
		function(arg_13_0)
			if not pg.NewStoryMgr.GetInstance():IsPlayed("NG0046") then
				pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0046")
			end

			return
		end
	}, function()
		return
	end)
	arg_4_0.activity:SetBubbleTipTag(true)

	return
end

function var_0_0.GetRandomPos(arg_15_0)
	for iter_15_0 = 1, #var_0_0.RANDOM_POS do
		table.insert({}, iter_15_0)
	end

	shuffle({})

	for iter_15_1 = 1, 8 do
		table.insert({}, var_0_0.RANDOM_POS[({})[iter_15_1]])
	end

	return {}
end

function var_0_0.OnUpdateTime(arg_16_0)
	arg_16_0:UpdateBg()
	arg_16_0:UpdateGold()
	arg_16_0:UpdateBubbles()
	arg_16_0.infoPage:ExecuteAction("OnUpdateTime")

	return
end

function var_0_0.GetBgName(arg_17_0, arg_17_1)
	local var_17_0 = pg.TimeMgr.GetInstance():GetServerHour()

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.timeCfg) do
		if var_17_0 >= iter_17_1[1][1] and var_17_0 < iter_17_1[1][2] then
			return iter_17_1[2]
		end
	end

	return "day"
end

function var_0_0.UpdateBg(arg_18_0)
	local var_18_0 = arg_18_0:GetBgName()

	eachChild(arg_18_0.bgTFs, function(arg_19_0)
		setActive(arg_19_0, arg_19_0.name == var_18_0)

		return
	end)

	return
end

function var_0_0.UpdateGold(arg_20_0)
	arg_20_0.gold = arg_20_0.activity:GetTotalGold()
	arg_20_0.goldText.text = TownActivity.GoldToShow(arg_20_0.gold)

	return
end

function var_0_0.UpdateBubbles(arg_21_0)
	arg_21_0.bubblesPosList = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.shipIds) do
		if iter_21_1 > 0 then
			local var_21_0 = getProxy(BayProxy)

			if var_21_0:RawGetShipById(iter_21_1) then
				local var_21_1 = arg_21_0.activity:GetBubbleCntByPos(iter_21_0)
				local var_21_2 = arg_21_0.slotTFs:Find(iter_21_0 .. "/bubble")

				setActive(var_21_2, var_21_1 > 0)

				if var_21_1 > 0 then
					table.insert(arg_21_0.bubblesPosList, iter_21_0)
					eachChild(var_21_2, function(arg_22_0)
						setActive(arg_22_0, tonumber(arg_22_0.name) == var_21_1)

						return
					end)
				end
			end
		end
	end

	return
end

function var_0_0.UpdateShips(arg_23_0)
	arg_23_0:CleanSpines()

	arg_23_0.randomPos = Clone(var_0_0.RANDOM_POS)

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.shipIds) do
		arg_23_0:UpdateShip(iter_23_0, iter_23_1)
	end

	arg_23_0:UpdateBubbles()

	return
end

function var_0_0.UpdateShip(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.slotTFs:Find(arg_24_1)

	if var_24_0 then
		setActive(var_24_0, false)
	end

	local var_24_1 = arg_24_2 > 0 and getProxy(BayProxy):RawGetShipById(arg_24_2)

	if not var_24_1 then
		return
	end

	var_24_0 = var_24_0 or cloneTplTo(arg_24_0.slotTpl, arg_24_0.slotTFs, arg_24_1)

	if arg_24_0.activity:GetBubbleCntByPos(arg_24_1) > 0 and table.contains(arg_24_0.randomPos, var_0_0.STATIC_POS) then
		setAnchoredPosition(var_24_0, var_0_0.STATIC_POS)
		table.removebyvalue(arg_24_0.randomPos, var_0_0.STATIC_POS)
	else
		local var_24_2 = arg_24_0.randomPos[#arg_24_0.randomPos]

		setAnchoredPosition(var_24_0, arg_24_0.randomPos[#arg_24_0.randomPos])
		table.removebyvalue(arg_24_0.randomPos, var_24_2)
	end

	onButton(arg_24_0, var_24_0:Find("bubble"), function()
		if not arg_24_0.bubblesPosList or #arg_24_0.bubblesPosList <= 0 then
			return
		end

		if arg_24_0.activity:HasMaxGold() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("town_gold_tip"),
				onYes = function()
					arg_24_0:emit(TownMediator.CLICK_BUBBLE, arg_24_0.bubblesPosList)

					return
				end
			})
		else
			arg_24_0:emit(TownMediator.CLICK_BUBBLE, arg_24_0.bubblesPosList)
		end

		return
	end, SFX_PANEL)

	local var_24_3 = SpineRole.New()

	var_24_3:SetData(var_24_1:getPrefab())
	var_24_3:Load(function()
		var_24_3:SetName("model")
		var_24_3:SetLocalScale(Vector2.New(var_0_0.SDScale, var_0_0.SDScale))
		var_24_3:SetSizeDelta(Vector2.New(200, 500))
		var_24_3:SetParent(var_24_0)
		var_24_3:SetAction("stand")
		go.transform:SetAsFirstSibling()
		setActive(var_24_0, true)

		return
	end, true)

	arg_24_0.spineRoles[arg_24_1] = var_24_3

	return
end

function var_0_0.CleanSpines(arg_28_0)
	table.Foreach(arg_28_0.spineRoles, function(arg_29_0, arg_29_1)
		arg_29_1:Dispose()

		return
	end)

	arg_28_0.spineRoles = {}

	return
end

function var_0_0.UpdateInfoPage(arg_30_0)
	arg_30_0.infoPage:ExecuteAction("SetActivity", arg_30_0.activity)
	arg_30_0.infoPage:ExecuteAction("Flush")

	return
end

function var_0_0.OnExpUpdate(arg_31_0)
	arg_31_0.infoPage:ExecuteAction("SetActivity", arg_31_0.activity)
	arg_31_0.infoPage:ExecuteAction("OnExpUpdate")

	return
end

function var_0_0.OnTownUpgrade(arg_32_0, arg_32_1)
	arg_32_0.infoPage:ExecuteAction("OnTownUpgrade", arg_32_1)

	return
end

function var_0_0.OnPlaceUpgrade(arg_33_0, arg_33_1)
	arg_33_0.infoPage:ExecuteAction("OnPlaceUpgrade", arg_33_1)

	return
end

function var_0_0.willExit(arg_34_0)
	arg_34_0.infoPage:Destroy()

	arg_34_0.infoPage = nil

	if arg_34_0.timer then
		arg_34_0.timer:Stop()

		arg_34_0.timer = nil
	end

	arg_34_0:CleanSpines()

	return
end

function var_0_0.ShowEntranceTip(arg_35_0)
	local var_35_0 = arg_35_0 or getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN)

	if not var_35_0 or var_35_0:isEnd() then
		return false
	end

	return var_0_0.ShowMainTip(var_35_0) or var_35_0:ShowBubbleTip()
end

function var_0_0.ShowMainTip(arg_36_0)
	local var_36_0 = arg_36_0 or getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN)

	if not var_36_0 or var_36_0:isEnd() then
		return false
	end

	return var_36_0:CanCostGold() or var_36_0:HasEmptySlot()
end

return var_0_0
