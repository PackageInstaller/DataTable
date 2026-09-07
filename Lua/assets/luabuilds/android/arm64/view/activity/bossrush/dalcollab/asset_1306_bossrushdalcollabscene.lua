local BossRushDALCollabScene = class("BossRushDALCollabScene", import("view.base.BaseUI"))

function BossRushDALCollabScene:getUIName()
	return "BossRushDALCollabUI"
end

function BossRushDALCollabScene:GetAtalsName()
	return "ui/BossRushDALCollabUI_atlas"
end

function BossRushDALCollabScene:ResUISettings()
	return true
end

function BossRushDALCollabScene:Ctor()
	BossRushDALCollabScene.super.Ctor(self)

	self.loader = AutoLoader.New()

	return
end

function BossRushDALCollabScene:preload(arg_5_1)
	existCall(arg_5_1)
	self.loader:LoadBundle(self:GetAtalsName())

	return
end

function BossRushDALCollabScene:OverlayComponent(arg_6_1)
	if arg_6_1 then
		self:OverlayPanel(self.top)
		self:OverlayPanel(self.right)
		self:OverlayPanel(self.pt)
		self:OverlayPanel(self.battleNodes)
	else
		self:UnOverlayPanel(self.top, self._tf)
		self:UnOverlayPanel(self.right, self._tf)
		self:UnOverlayPanel(self.pt, self._tf)
		self:UnOverlayPanel(self.battleNodes, self._tf)
	end

	return
end

function BossRushDALCollabScene:init()
	self.top = self._tf:Find("Top")
	self.map = self._tf:Find("Map")
	self.right = self._tf:Find("Right")
	self.pt = self._tf:Find("PT")
	self.battleNodes = self._tf:Find("Battle")
	self.seriesNodes = _.map(_.range(self._tf:Find("Battle/Nodes").childCount), function(arg_8_0)
		return self._tf:Find("Battle/Nodes"):GetChild(arg_8_0 - 1)
	end)

	table.Foreach(self.seriesNodes, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1:Find("ship")
		local var_9_1 = var_9_0:GetComponent(typeof(Animation))

		var_9_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			if var_9_1:IsPlaying("anim_BossRushDALCollabUI_ship_out") then
				setActive(self._currentShip, true)
				setActive(self._currentShip:Find("vx_teleport_1"), true)
				setActive(var_9_0:Find("vx_teleport_2"), false)
				self:playAnima(self._currentShip, "anim_BossRushDALCollabUI_ship_in")
				setActive(var_9_0, false)
			elseif var_9_1:IsPlaying("anim_BossRushDALCollabUI_ship_in") then
				if self._openSeriesData then
					self.stageView:ExecuteAction("SetData", self._openSeriesData)
					self.stageView:ExecuteAction("Show")

					self.battleNodes:GetComponent(typeof(CanvasGroup)).interactable = true
					self._openSeriesData = nil
				end

				setActive(var_9_0:Find("vx_teleport_1"), false)

				self._lastShip = var_9_0
			end

			return
		end)

		return
	end)

	self.maps = {}

	for iter_7_0 = 1, 6 do
		self.maps[iter_7_0] = self._tf:Find("Map/map_" .. iter_7_0)
	end

	self.shiftMap = self._tf:Find("Map/Map_1")
	self.shiftMapList = {}

	for iter_7_1 = 1, 6 do
		self.shiftMapList[iter_7_1] = self.shiftMap:Find("map_" .. iter_7_1)
	end

	self.mapAnima = self._tf:Find("Map"):GetComponent(typeof(Animation))
	self.mapDftEvt = self._tf:Find("Map"):GetComponent(typeof(DftAniEvent))
	self.mapFX = self._tf:Find("Map/state_fx")
	self.upgradeBtn = self._tf:Find("Right/Upgrade")
	self.shopBtn = self._tf:Find("Right/Store")
	self.ptLabel = self._tf:Find("PT/pt_text/icon")
	self.ptIcon = self._tf:Find("PT/pt_text/icon/Image")
	self.ptCount = self._tf:Find("PT/pt_text/Text")

	setText(self.ptLabel, i18n("pt_count_tip"))

	self.ActionSequence = {}
	self.upgradeView = BossRushDALUpgradeView.New(self._tf, self.event, self.contextData)

	self.upgradeView:RegisterView(self)

	self.stageView = BossRushDALCollabStageView.New(self._tf, self.event, self.contextData)

	return
end

function BossRushDALCollabScene:SetUpgradeActvity(arg_11_1)
	self.upgradeView:SetData(arg_11_1)

	return
end

function BossRushDALCollabScene:SetActivity(arg_12_1)
	self.activity = arg_12_1

	return
end

function BossRushDALCollabScene:SetPTActivity(arg_13_1)
	self.ptActivity = arg_13_1

	return
end

function BossRushDALCollabScene:onBackPressed()
	if self.upgradeView:isShowing() then
		self.upgradeView:Hide()
	elseif self.stageView:isShowing() then
		self.stageView:Hide()
	else
		BossRushDALCollabScene.super.onBackPressed(self)
	end

	return
end

function BossRushDALCollabScene:didEnter()
	onButton(self, self.top:Find("back_btn"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self.top:Find("option"), function()
		self:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(self, self.upgradeBtn, function()
		self.upgradeView:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(self, self.top:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = {
				{
					info = i18n("dal_chapter_tip")
				}
			}
		})

		return
	end, SFX_PANEL)
	onButton(self, self.shopBtn, function()
		local var_20_0 = getProxy(ActivityProxy):getActivityById(self.activity:getConfig("config_client").shopID)

		if not var_20_0 or var_20_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self:emit(BossRushDALCollabMediator.GO_SHOPS_LAYER, {
			warp = NewShopsScene.TYPE_ACTIVITY,
			actId = var_20_0 and var_20_0.id
		})

		return
	end, SFX_PANEL)
	self:PlayBGM()
	self:playAnima(self._tf, "anim_BossRushDALCollabUI_in")
	self:OverlayComponent(true)

	return
end

function BossRushDALCollabScene:getBGM()
	if not pg.voice_bgm[self.__cname] then
		return nil
	end

	return pg.voice_bgm[self.__cname].bgm
end

function BossRushDALCollabScene:UpdateView()
	setActive(self.battleNodes, true)
	self:UpdateBattle()
	self:UpdateMap()
	self:updateActivityRes()

	return
end

function BossRushDALCollabScene:playAnima(arg_23_1, arg_23_2, arg_23_3)
	arg_23_1:GetComponent(typeof(Animation)):Play(arg_23_2)

	if arg_23_3 then
		arg_23_1:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			arg_23_3()

			return
		end)
	end

	return
end

function BossRushDALCollabScene:PlayMapShiftAnima(arg_25_1, arg_25_2, arg_25_3)
	for iter_25_0, iter_25_1 in pairs(self.maps) do
		setImageSprite(iter_25_1, GetSpriteFromAtlas("ui/dalcollabbossrushsceneui_atlas", "map_" .. iter_25_0 .. arg_25_2), true)
	end

	for iter_25_2, iter_25_3 in pairs(self.shiftMapList) do
		setImageSprite(iter_25_3, GetSpriteFromAtlas("ui/dalcollabbossrushsceneui_atlas", "map_" .. iter_25_2 .. arg_25_1), true)
	end

	setActive(self.shiftMap, true)
	self.mapAnima:Play("anim_BossRushDALCollabUI_Map")

	return
end

function BossRushDALCollabScene:updateActivityRes()
	setText(self.ptCount, "x" .. self.ptActivity.data1)
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = tonumber(self.ptActivity:getConfig("config_id"))
	}):getIcon(), "", self.ptIcon, true)

	return
end

function BossRushDALCollabScene:UpdateMap()
	local var_27_0 = self.activity:GetCollabSeriesDataList()

	if var_27_0[6]:IsPass() and var_27_0[6]:GetDefeated(self.activity) then
		setActive(self.mapFX:Find("state_3"), true)
		setActive(self.mapFX:Find("state_4"), true)
		setActive(self.mapFX:Find("state_4/6_3"), true)

		for iter_27_0, iter_27_1 in pairs(self.maps) do
			if iter_27_0 ~= 1 and iter_27_0 ~= 6 then
				setActive(self.mapFX:Find("state_4/" .. iter_27_0), false)
			end

			setActive(iter_27_1, true)
			setImageSprite(iter_27_1, GetSpriteFromAtlas("ui/dalcollabbossrushsceneui_atlas", "map_" .. iter_27_0), true)
		end
	elseif var_27_0[6]:IsPlayerUnlock(self.activity) and (not var_27_0[6]:IsPass() or not var_27_0[6]:GetDefeated(self.activity)) then
		setActive(self.mapFX:Find("state_4"), true)

		for iter_27_2, iter_27_3 in pairs(self.maps) do
			setActive(iter_27_3, true)

			if iter_27_2 == 6 then
				local var_27_1

				if var_27_0[6]:GetBossHpRate() > 0.5 then
					var_27_1 = "_1"

					setActive(self.mapFX:Find("state_4/6_1"), true)
				else
					setActive(self.mapFX:Find("state_4/6_2"), true)

					var_27_1 = "_2"
				end

				setImageSprite(iter_27_3, GetSpriteFromAtlas("ui/dalcollabbossrushsceneui_atlas", "map_" .. iter_27_2 .. var_27_1), true)
			else
				setImageSprite(iter_27_3, GetSpriteFromAtlas("ui/dalcollabbossrushsceneui_atlas", "map_" .. iter_27_2 .. "_3"), true)
			end
		end
	else
		setActive(self.mapFX:Find("state_2"), true)
		setActive(self.mapFX:Find("state_1"), true)
		setActive(self.mapFX:Find("state_3"), true)

		for iter_27_4, iter_27_5 in pairs(self.maps) do
			if iter_27_4 == 6 then
				setActive(iter_27_5, false)
			else
				setActive(iter_27_5, true)

				local var_27_4 = not var_27_0[iter_27_4]:GetDefeated(self.activity) and "_1" or var_27_0[iter_27_4]:GetBossTimeStamp() ~= 0 and "" or var_27_0[iter_27_4]:GetBossHpRate() > 0.5 and "_1" or "_2"

				setImageSprite(iter_27_5, GetSpriteFromAtlas("ui/dalcollabbossrushsceneui_atlas", "map_" .. iter_27_4 .. nil), true)

				if iter_27_4 ~= 1 then
					if var_27_4 == "" then
						setActive(self.mapFX:Find("state_3/" .. iter_27_4), true)
					elseif var_27_4 == "_1" then
						setActive(self.mapFX:Find("state_1/" .. iter_27_4), true)
					elseif var_27_4 == "_2" then
						setActive(self.mapFX:Find("state_2/" .. iter_27_4), true)
					end
				end
			end
		end
	end

	return
end

function BossRushDALCollabScene:UpdateBattle()
	local var_28_0 = self.activity
	local var_28_1 = self.activity:GetActiveSeriesIds()
	local var_28_2 = {}

	for iter_28_0, iter_28_1 in pairs((self.activity:GetCollabSeriesDataList())) do
		table.insert(var_28_2, iter_28_1)
	end

	table.sort(var_28_2, function(arg_29_0, arg_29_1)
		return arg_29_0:GetTrafficPerH() > arg_29_1:GetTrafficPerH()
	end)
	table.Foreach(self.seriesNodes, function(arg_30_0, arg_30_1)
		local var_30_0 = var_28_0:GetCollabSeriesData(var_28_1[arg_30_0])
		local var_30_1 = var_30_0:IsPlayerUnlock(var_28_0)
		local var_30_2 = var_30_0:IsPass()
		local var_30_3 = var_30_0:GetDefeated(self.activity)

		if var_28_1[arg_30_0] == 6 and not var_30_1 then
			setActive(arg_30_1, false)
		end

		setActive(arg_30_1:Find("lock"), not var_30_1)
		setActive(arg_30_1:Find("clear"), var_30_1 and var_30_2 and var_30_3)
		setActive(arg_30_1:Find("active"), var_30_1 and (not var_30_2 or not var_30_3))

		local var_30_4 = table.indexof(var_28_2, var_30_0)

		if not var_30_1 then
			setText(arg_30_1:Find("lock/name"), var_30_0:GetSeriesCode())
		elseif var_30_0:IsPass() and var_30_3 then
			setText(arg_30_1:Find("clear/current/name/text"), var_30_0:GetSeriesCode())
			setText(arg_30_1:Find("clear/common/name"), var_30_0:GetSeriesCode())
			setActive(arg_30_1:Find("clear/common"), true)
			setActive(arg_30_1:Find("clear/current"), false)
		else
			setText(arg_30_1:Find("active/current/name/text"), var_30_0:GetSeriesCode())
			setText(arg_30_1:Find("active/common/name"), var_30_0:GetSeriesCode())

			local var_30_5 = var_30_0:GetBossHpRate() * 100 .. "%"

			setText(arg_30_1:Find("active/common/value"), var_30_0:IsPass() and "HOLD" or var_30_5)
			setText(arg_30_1:Find("active/current/value"), var_30_0:IsPass() and "HOLD" or var_30_5)
			setActive(arg_30_1:Find("active/common"), true)
			setActive(arg_30_1:Find("active/current"), false)

			arg_30_1:Find("active/current/progress"):GetComponent(typeof(Image)).fillAmount = var_30_0:IsPass() and 1 or var_30_0:GetBossHpRate()
		end

		local function var_30_6(arg_31_0)
			if var_30_4 > 3 then
				setActive(arg_31_0, false)
			else
				setActive(arg_31_0, true)
				table.Foreach(_.map(_.range(arg_31_0.childCount), function(arg_32_0)
					return arg_31_0:GetChild(arg_32_0 - 1)
				end), function(arg_33_0, arg_33_1)
					setActive(arg_33_1, arg_33_0 <= 4 - var_30_4)

					return
				end)
			end

			return
		end

		var_30_6(arg_30_1:Find("active/common/bullets"))
		var_30_6(arg_30_1:Find("clear/common/bullets"))
		onButton(self, arg_30_1, function()
			if not var_30_1 then
				local var_34_0 = var_30_0:GetPreSeriesId()
				local var_34_2 = 1
				local var_34_3 = var_30_0:GetPreSeriesId()
				local var_34_4 = CollabrateBossRushSeriesData.New({
					id = var_34_3[1]
				}):GetSeriesCode()

				while var_34_2 < #var_34_3 do
					var_34_2 = var_34_2 + 1
					var_34_4 = var_34_4 .. "、" .. CollabrateBossRushSeriesData.New({
						id = var_34_3[var_34_2]
					}):GetSeriesCode()
				end

				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_unlock", var_34_4))

				return
			end

			local function var_34_5()
				self._openSeriesData = var_30_0

				PlayerPrefs.SetInt("DAL_ship_position", arg_30_0)

				if not self:updateShipPosition() then
					self.stageView:ExecuteAction("SetData", var_30_0)
					self.stageView:ExecuteAction("Show")

					self.battleNodes:GetComponent(typeof(CanvasGroup)).interactable = true
				end

				return
			end

			local var_34_6 = var_30_0:GetInitStory()

			if var_34_6 then
				self:PlayStory(var_34_6, var_34_5)
			else
				var_34_5()
			end

			return
		end, SFX_PANEL)

		return
	end)
	self:updateShipPosition()
	self:addbubbleMsgBoxList({
		function(arg_36_0)
			self:checkAllStory()
			arg_36_0()

			return
		end,
		function(arg_37_0)
			local var_37_0 = self.activity:getConfig("config_client").first_story
			local var_37_1 = self.activity:getConfig("config_client").first_guide

			if first_guide then
				self:PlayStory(var_37_0, function()
					pg.SystemGuideMgr.GetInstance():PlayByGuideId(var_37_1, nil, arg_37_0)

					return
				end)
			else
				self:PlayStory(var_37_0, arg_37_0)
			end

			return
		end
	})

	return
end

function BossRushDALCollabScene:updateCurrent(arg_39_1)
	table.Foreach(self.seriesNodes, function(arg_40_0, arg_40_1)
		setActive(arg_40_1:Find("clear/common"), arg_39_1 ~= arg_40_1)
		setActive(arg_40_1:Find("clear/current"), arg_39_1 == arg_40_1)
		setActive(arg_40_1:Find("active/common"), arg_39_1 ~= arg_40_1)
		setActive(arg_40_1:Find("active/current"), arg_39_1 == arg_40_1)

		if arg_39_1 == arg_40_1 then
			self:playAnima(arg_39_1, "anim_BossRushDALCollabUI_battle_in")
		end

		return
	end)

	return
end

function BossRushDALCollabScene:updateShipPosition()
	local var_41_0 = PlayerPrefs.GetInt("DAL_ship_position", 1)
	local var_41_1 = self.activity:GetActiveSeriesIds()

	table.Foreach(self.seriesNodes, function(arg_42_0, arg_42_1)
		local var_42_0 = arg_42_1:Find("ship")

		var_42_0:GetComponent(typeof(Animation)):Stop()

		if var_41_0 == var_41_1[arg_42_0] then
			self:updateCurrent(arg_42_1)

			self._currentShip = var_42_0
		elseif var_42_0 ~= self._lastShip then
			setActive(arg_42_1:Find("ship"), false)
		end

		return
	end)

	if self._lastShip then
		if self._lastShip ~= self._currentShip then
			self:playAnima(self._lastShip, "anim_BossRushDALCollabUI_ship_out")
			setActive(self._lastShip:Find("vx_teleport_2"), true)

			self.battleNodes:GetComponent(typeof(CanvasGroup)).interactable = false
		end
	else
		setActive(self._currentShip, true)
		setActive(self._currentShip:Find("vx_teleport_1"), true)
		self:playAnima(self._currentShip, "anim_BossRushDALCollabUI_ship_in")
	end

	return self._lastShip ~= self._currentShip
end

function BossRushDALCollabScene:checkAllStory()
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in pairs((self.activity:GetCollabSeriesDataList())) do
		if table.contains(self.activity:GetPassCounts(), iter_43_0) then
			for iter_43_2, iter_43_3 in ipairs((iter_43_1:GetStorys())) do
				table.insert(var_43_0, iter_43_3)
			end
		end
	end

	local var_43_1 = 1

	local function var_43_2()
		var_43_1 = var_43_1 + 1

		local var_44_0
		local var_44_1 = self.activity:getConfig("config_client").storys_unlock_story

		if var_43_0[var_43_1] == nil and var_44_1 then
			local var_44_2 = pg.NewStoryMgr.GetInstance()

			var_44_0 = true

			for iter_44_0, iter_44_1 in ipairs(var_44_1[2]) do
				var_44_0 = var_44_0 and var_44_2:IsPlayed(iter_44_1)
			end

			var_44_0 = var_44_0 and not var_44_2:IsPlayed(var_44_1[1])
		end

		if var_44_0 then
			self:PlayStory(var_44_1[1], function()
				setActive(self.shiftMap:Find("map_6"), false)
				self:PlayMapShiftAnima("", "_3")

				return
			end)
		else
			self:PlayStory(var_43_0[var_43_1], var_43_2)
		end

		return
	end

	self:PlayStory(var_43_0[1], var_43_2)

	return
end

function BossRushDALCollabScene:GetFinalStoryName()
	local var_46_0 = Clone(self.activity:GetCollabSeriesDataList()[6]:getConfig("story_worldboss"))

	table.sort(var_46_0, function(arg_47_0, arg_47_1)
		return arg_47_0[2] < arg_47_1[2]
	end)

	return var_46_0[1][1]
end

function BossRushDALCollabScene:PlayStory(arg_48_1, arg_48_2)
	if not arg_48_1 then
		return
	end

	local var_48_0 = pg.NewStoryMgr.GetInstance()

	if var_48_0:IsPlayed(arg_48_1) then
		return existCall(arg_48_2)
	end

	if arg_48_1 == self:GetFinalStoryName() then
		var_48_0:Play(arg_48_1, function()
			self:PlayMapShiftAnima("_3", "")

			return
		end)
	else
		var_48_0:Play(arg_48_1, arg_48_2)
	end

	return
end

function BossRushDALCollabScene:UpdateTasks(arg_50_1)
	if _.any(arg_50_1, function(arg_51_0)
		return self.storyTask and self.storyTask.id == arg_51_0
	end) then
		self.storyTask.submitTime = 1

		self:UpdateView()
	end

	return
end

function BossRushDALCollabScene:addbubbleMsgBoxList(arg_52_1)
	local var_52_0 = #self.ActionSequence == 0

	table.insertto(self.ActionSequence, arg_52_1)

	if not var_52_0 then
		return
	end

	self:resumeBubble()

	return
end

function BossRushDALCollabScene:addbubbleMsgBox(arg_53_1)
	local var_53_0 = #self.ActionSequence == 0

	table.insert(self.ActionSequence, arg_53_1)

	if not var_53_0 then
		return
	end

	self:resumeBubble()

	return
end

function BossRushDALCollabScene:resumeBubble()
	if #self.ActionSequence == 0 then
		return
	end

	local function var_54_1()
		if self.ActionSequence[1] then
			self.ActionSequence[1](function()
				table.remove(self.ActionSequence, 1)
				var_54_1()

				return
			end)
		end

		return
	end

	;(nil)()

	return
end

function BossRushDALCollabScene:CleanBubbleMsgbox()
	table.clean(self.ActionSequence)

	return
end

function BossRushDALCollabScene:willExit()
	self:OverlayComponent(false)
	self.stageView:Destroy()
	self.upgradeView:Destroy()
	self.loader:Clear()
	BossRushDALCollabScene.super.willExit(self)

	return
end

return BossRushDALCollabScene
