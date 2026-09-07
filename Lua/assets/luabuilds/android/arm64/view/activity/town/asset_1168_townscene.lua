local TownScene = class("TownScene", import("view.base.BaseUI"))

TownScene.RANDOM_POS = {
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
TownScene.STATIC_POS = Vector2.New(-440.7, -26.8)
TownScene.SDScale = 0.5

function TownScene:getUIName()
	return "TownUI"
end

function TownScene:SetActivity(arg_2_1)
	self.activity = arg_2_1
	self.shipIds = self.activity:GetShipIds()

	return
end

function TownScene:init()
	self.mapTF = self._tf:Find("map")
	self.bgTFs = self._tf:Find("map/bg")
	self.slotTFs = self._tf:Find("map/content")
	self.slotTpl = self._tf:Find("map/content/tpl")

	setActive(self.slotTpl, false)

	local var_3_0 = self._tf:Find("ui")

	self.topUI = var_3_0:Find("top")
	self.goldText = self.topUI:Find("gold/Text"):GetComponent(typeof(Text))
	self.infoPage = TownInfoPage.New(var_3_0, self)

	self.infoPage:ExecuteAction("Flush")

	return
end

function TownScene:didEnter()
	onButton(self, self.topUI:Find("back"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self.topUI:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.town_help.tip
		})

		return
	end, SFX_PANEL)
	onScroll(self, self.mapTF, function(arg_7_0)
		return
	end)

	self.timeCfg = self.activity:getConfig("config_client").endingtime
	self.spineRoles = {}

	self:UpdateShips()

	self.timer = Timer.New(function()
		self:OnUpdateTime()

		return
	end, 1, -1)

	self.timer:Start()
	self:OnUpdateTime()
	seriesAsync({
		function(arg_9_0)
			local var_9_0 = pg.activity_town_level[self.activity:GetTownLevel()].unlock_story

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
			local var_10_0 = self.activity:getConfig("config_client").story[1][1]

			if (function()
				return underscore.all(self.activity:getConfig("config_client").beforestory, function(arg_12_0)
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
	self.activity:SetBubbleTipTag(true)

	return
end

function TownScene:GetRandomPos()
	local var_15_0 = {}

	for iter_15_0 = 1, #TownScene.RANDOM_POS do
		table.insert(var_15_0, iter_15_0)
	end

	shuffle(var_15_0)

	local var_15_1 = {}

	for iter_15_1 = 1, 8 do
		table.insert(var_15_1, TownScene.RANDOM_POS[var_15_0[iter_15_1]])
	end

	return var_15_1
end

function TownScene:OnUpdateTime()
	self:UpdateBg()
	self:UpdateGold()
	self:UpdateBubbles()
	self.infoPage:ExecuteAction("OnUpdateTime")

	return
end

function TownScene:GetBgName(arg_17_1)
	local var_17_0 = pg.TimeMgr.GetInstance():GetServerHour()

	for iter_17_0, iter_17_1 in ipairs(self.timeCfg) do
		if var_17_0 >= iter_17_1[1][1] and var_17_0 < iter_17_1[1][2] then
			return iter_17_1[2]
		end
	end

	return "day"
end

function TownScene:UpdateBg()
	local var_18_0 = self:GetBgName()

	eachChild(self.bgTFs, function(arg_19_0)
		setActive(arg_19_0, arg_19_0.name == var_18_0)

		return
	end)

	return
end

function TownScene:UpdateGold()
	self.gold = self.activity:GetTotalGold()
	self.goldText.text = TownActivity.GoldToShow(self.gold)

	return
end

function TownScene:UpdateBubbles()
	self.bubblesPosList = {}

	for iter_21_0, iter_21_1 in ipairs(self.shipIds) do
		if iter_21_1 > 0 then
			if getProxy(BayProxy):RawGetShipById(iter_21_1) then
				local var_21_0 = self.activity:GetBubbleCntByPos(iter_21_0)
				local var_21_1 = self.slotTFs:Find(iter_21_0 .. "/bubble")

				setActive(var_21_1, var_21_0 > 0)

				if var_21_0 > 0 then
					table.insert(self.bubblesPosList, iter_21_0)
					eachChild(var_21_1, function(arg_22_0)
						setActive(arg_22_0, tonumber(arg_22_0.name) == var_21_0)

						return
					end)
				end
			end
		end
	end

	return
end

function TownScene:UpdateShips()
	self:CleanSpines()

	self.randomPos = Clone(TownScene.RANDOM_POS)

	for iter_23_0, iter_23_1 in ipairs(self.shipIds) do
		self:UpdateShip(iter_23_0, iter_23_1)
	end

	self:UpdateBubbles()

	return
end

function TownScene:UpdateShip(arg_24_1, arg_24_2)
	local var_24_0 = self.slotTFs:Find(arg_24_1)

	if var_24_0 then
		setActive(var_24_0, false)
	end

	local var_24_1 = arg_24_2 > 0 and getProxy(BayProxy):RawGetShipById(arg_24_2)

	if not var_24_1 then
		return
	end

	var_24_0 = var_24_0 or cloneTplTo(self.slotTpl, self.slotTFs, arg_24_1)

	if self.activity:GetBubbleCntByPos(arg_24_1) > 0 and table.contains(self.randomPos, TownScene.STATIC_POS) then
		setAnchoredPosition(var_24_0, TownScene.STATIC_POS)
		table.removebyvalue(self.randomPos, TownScene.STATIC_POS)
	else
		local var_24_2 = self.randomPos[#self.randomPos]

		setAnchoredPosition(var_24_0, self.randomPos[#self.randomPos])
		table.removebyvalue(self.randomPos, var_24_2)
	end

	onButton(self, var_24_0:Find("bubble"), function()
		if not self.bubblesPosList or #self.bubblesPosList <= 0 then
			return
		end

		if self.activity:HasMaxGold() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("town_gold_tip"),
				onYes = function()
					self:emit(TownMediator.CLICK_BUBBLE, self.bubblesPosList)

					return
				end
			})
		else
			self:emit(TownMediator.CLICK_BUBBLE, self.bubblesPosList)
		end

		return
	end, SFX_PANEL)

	local var_24_3 = SpineRole.New()

	var_24_3:SetData(var_24_1:getPrefab())
	var_24_3:Load(function()
		var_24_3:SetName("model")
		var_24_3:SetLocalScale(Vector2.New(TownScene.SDScale, TownScene.SDScale))
		var_24_3:SetSizeDelta(Vector2.New(200, 500))
		var_24_3:SetParent(var_24_0)
		var_24_3:SetAction("stand")
		go.transform:SetAsFirstSibling()
		setActive(var_24_0, true)

		return
	end, true)

	self.spineRoles[arg_24_1] = var_24_3

	return
end

function TownScene:CleanSpines()
	table.Foreach(self.spineRoles, function(arg_29_0, arg_29_1)
		arg_29_1:Dispose()

		return
	end)

	self.spineRoles = {}

	return
end

function TownScene:UpdateInfoPage()
	self.infoPage:ExecuteAction("SetActivity", self.activity)
	self.infoPage:ExecuteAction("Flush")

	return
end

function TownScene:OnExpUpdate()
	self.infoPage:ExecuteAction("SetActivity", self.activity)
	self.infoPage:ExecuteAction("OnExpUpdate")

	return
end

function TownScene:OnTownUpgrade(arg_32_1)
	self.infoPage:ExecuteAction("OnTownUpgrade", arg_32_1)

	return
end

function TownScene:OnPlaceUpgrade(arg_33_1)
	self.infoPage:ExecuteAction("OnPlaceUpgrade", arg_33_1)

	return
end

function TownScene:willExit()
	self.infoPage:Destroy()

	self.infoPage = nil

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:CleanSpines()

	return
end

function TownScene:ShowEntranceTip()
	local var_35_0 = self or getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN)

	if not var_35_0 or var_35_0:isEnd() then
		return false
	end

	return TownScene.ShowMainTip(var_35_0) or var_35_0:ShowBubbleTip()
end

function TownScene:ShowMainTip()
	local var_36_0 = self or getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN)

	if not var_36_0 or var_36_0:isEnd() then
		return false
	end

	return var_36_0:CanCostGold() or var_36_0:HasEmptySlot()
end

return TownScene
