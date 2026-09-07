local WorldBossInfoAndRankPanel = class("WorldBossInfoAndRankPanel", import("view.base.BaseSubView"))

function WorldBossInfoAndRankPanel:getUIName()
	return "WorldBossInfoAndRankUI"
end

function WorldBossInfoAndRankPanel:OnLoaded()
	self.toggleRank = self._tf:Find("rank")
	self.toggleInfo = self._tf:Find("info")
	self.myRankTF = self._tf:Find("rank_panel/tpl")
	self.rankList = UIItemList.New(self._tf:Find("rank_panel/list"), self.myRankTF)
	self.maxRankCnt = pg.gameset.joint_boss_fighter_max.key_value
	self.rankCnt1 = self._tf:Find("rank_panel/cnt/Text"):GetComponent(typeof(Text))
	self.rankTF = self._tf:Find("rank_panel")
	self.maskTF = self._tf:Find("rank_panel/mask")
	self.maskTxt = self._tf:Find("rank_panel/mask/Text"):GetComponent(typeof(Text))
	self.infoTitle = self._tf:Find("info_panel/title/Text"):GetComponent(typeof(Text))
	self.infoSkillList = UIItemList.New(self._tf:Find("info_panel/scrollrect/content"), self._tf:Find("info_panel/scrollrect/content/tpl"))

	return
end

function WorldBossInfoAndRankPanel:SetCallback(arg_3_1, arg_3_2)
	self.callback = arg_3_1
	self.flushRankCallback = arg_3_2

	return
end

function WorldBossInfoAndRankPanel:OnInit()
	self._tf:SetSiblingIndex(2)
	onToggle(self, self.toggleInfo, function(arg_5_0)
		if arg_5_0 then
			self:ResetInfoLayout()
		end

		return
	end)

	return
end

function WorldBossInfoAndRankPanel:Flush(arg_6_1, arg_6_2)
	self.boss = arg_6_1
	self.proxy = arg_6_2

	self:FlushRank()
	self:FlushInfo()

	if not self.boss:IsFullHp() then
		triggerToggle(self.toggleRank, true)
	else
		triggerToggle(self.toggleInfo, true)
		self:ResetInfoLayout()
	end

	return
end

function WorldBossInfoAndRankPanel:FlushInfo()
	self.infoTitle.text = self.boss.config.name

	local var_7_0 = self.boss.config.description

	self.infoSkillList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			GetSpriteFromAtlasAsync("ui/WorldBossUI_atlas", "color_" .. var_7_0[arg_8_1 + 1][2], function(arg_9_0)
				arg_8_2:Find("color"):GetComponent(typeof(Image)).sprite = arg_9_0

				return
			end)
			setText(arg_8_2:Find("color/Text"), var_7_0[arg_8_1 + 1][1])
		end

		return
	end)
	self.infoSkillList:align(#self.boss.config.description)

	return
end

function WorldBossInfoAndRankPanel:ResetInfoLayout()
	local var_10_0 = 28
	local var_10_1 = self.boss.config.description

	onNextTick(function()
		if self.exited then
			return
		end

		self.infoSkillList:each(function(arg_12_0, arg_12_1)
			local var_12_0 = "　"
			local var_12_1, var_12_2 = math.modf(arg_12_1:Find("color/Text").sizeDelta.x / var_10_0)

			for iter_12_0 = 1, var_12_1 do
				var_12_0 = var_12_0 .. "　"
			end

			if var_12_2 > 0 then
				var_12_0 = var_12_0 .. "<size=" .. math.ceil(var_10_0 * var_12_2) .. ">　</size>"
			end

			setText(arg_12_1:Find("Text"), var_12_0 .. var_10_1[arg_12_0 + 1][3])

			return
		end)

		return
	end)

	return
end

function WorldBossInfoAndRankPanel:FlushRank()
	if not self.boss then
		return
	end

	local var_13_0 = self.proxy:GetRank(self.boss.id)
	local var_13_1 = 0

	if not var_13_0 then
		self:emit(WorldBossMediator.ON_RANK_LIST, self.boss.id)
	else
		self.rankList:make(function(arg_14_0, arg_14_1, arg_14_2)
			if arg_14_0 == UIItemList.EventUpdate then
				self:UpdateRankTF(arg_14_2, var_13_0[arg_14_1 + 1], arg_14_1 + 1)
			end

			return
		end)
		self.rankList:align(math.min(#var_13_0, 3))
		self:UpdateSelfRank(var_13_0)

		var_13_1 = #var_13_0
	end

	self.rankCnt1.text = var_13_1 .. "<color=#A2A2A2>/" .. self.maxRankCnt .. "</color>"

	if self.flushRankCallback then
		self.flushRankCallback(var_13_1, self.maxRankCnt)
	end

	self:AddWaitResultTimer()

	return
end

function WorldBossInfoAndRankPanel:AddWaitResultTimer()
	self:RemoveWaitTimer()

	local var_15_0 = self.boss:ShouldWaitForResult()

	setActive(self.maskTF, var_15_0)

	if var_15_0 then
		local var_15_1 = self.boss:GetWaitForResultTime()

		self.waitTimer = Timer.New(function()
			local var_16_0 = var_15_1 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_16_0 < 0 then
				self:AddWaitResultTimer()

				if self.callback then
					self.callback(false)
				end
			else
				self.maskTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_16_0)
			end

			return
		end, 1, -1)

		self.waitTimer:Start()

		if self.callback then
			self.callback(true)
		end
	end

	return
end

function WorldBossInfoAndRankPanel:RemoveWaitTimer()
	if self.waitTimer then
		self.waitTimer:Stop()

		self.waitTimer = nil
	end

	return
end

function WorldBossInfoAndRankPanel:UpdateRankTF(arg_18_1, arg_18_2, arg_18_3)
	setText(arg_18_1:Find("name"), arg_18_2.name)
	setText(arg_18_1:Find("value/Text"), arg_18_2.damage)
	setText(arg_18_1:Find("number"), arg_18_2.number or arg_18_3)
	setActive(arg_18_1:Find("value/view"), not arg_18_2.isSelf)
	onButton(self, arg_18_1:Find("value/view"), function()
		self:emit(WorldBossMediator.FETCH_RANK_FORMATION, arg_18_2.id, self.boss.id)

		return
	end, SFX_PANEL)

	return
end

function WorldBossInfoAndRankPanel:UpdateSelfRank(arg_20_1)
	local var_20_0

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		if iter_20_1.isSelf then
			var_20_0 = iter_20_1
			var_20_0.number = iter_20_0

			break
		end
	end

	if var_20_0 then
		self:UpdateRankTF(self.myRankTF, var_20_0)
	end

	return
end

function WorldBossInfoAndRankPanel:OnDestroy()
	self:RemoveWaitTimer()

	return
end

return WorldBossInfoAndRankPanel
