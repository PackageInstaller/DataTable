local SixthAnniversaryIslandScene = class("SixthAnniversaryIslandScene", import("..base.BaseUI"))

SixthAnniversaryIslandScene.optionsPath = {
	"top/btn_home"
}
SixthAnniversaryIslandScene.SHOP = "SixthAnniversaryIslandScene.SHOP"

function SixthAnniversaryIslandScene:getUIName()
	return "SixthAnniversaryIslandUI"
end

function SixthAnniversaryIslandScene:setActivity(arg_2_1)
	self.activity = arg_2_1

	return
end

function SixthAnniversaryIslandScene:setNodeIds(arg_3_1)
	self.ids = arg_3_1

	return
end

function SixthAnniversaryIslandScene:setPlayer(arg_4_1)
	self.player = arg_4_1

	setText(self.rtResPanel:Find("tpl/Text"), self.player:getResById(350) or 0)

	return
end

function SixthAnniversaryIslandScene:setResDrop(arg_5_1, arg_5_2)
	self.resDrop = arg_5_1
	self.resDailyNumber = arg_5_2

	setText(self.rtResPanel:Find("tpl_2/Text"), arg_5_1.count or 0)

	return
end

function SixthAnniversaryIslandScene:init()
	self.rtTop = self._tf:Find("top")

	pg.UIMgr.GetInstance():OverlayPanel(self.rtTop)

	self.effectObjs = {}
	self.proxy = getProxy(SixthAnniversaryIslandProxy)

	local var_6_0 = pg.TimeMgr.GetInstance()
	local var_6_1 = self._tf:Find("map/content")

	self.nodeItemList = UIItemList.New(var_6_1, var_6_1:Find("node"))

	self.nodeItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = self.ids[arg_7_1]
			local var_7_1 = self.proxy:GetNode(self.ids[arg_7_1])

			arg_7_2.name = var_7_1.id

			local var_7_2, var_7_3 = unpack(var_7_1:getConfig("address"))

			setAnchoredPosition(arg_7_2, {
				x = var_7_2,
				y = var_7_3
			})

			local var_7_4 = var_7_1:getConfig("type")

			eachChild(arg_7_2:Find("main/type"), function(arg_8_0)
				setActive(arg_8_0, arg_8_0.name == tostring(var_7_4))

				return
			end)
			setLocalScale(arg_7_2, Vector3(0, 0, 1))
			setActive(arg_7_2:Find("name"), var_7_1:getConfig("icon_name") ~= "")
			onToggle(self, arg_7_2, function(arg_9_0)
				if arg_9_0 then
					self.selectId = var_7_0
					self.contextData.lastNodeId = var_7_0
				end

				return
			end)
			setActive(arg_7_2:Find("click"), true)
			onButton(self, arg_7_2:Find("click"), function()
				local var_10_0 = self.proxy:GetNode(var_7_0)

				triggerToggle(arg_7_2, var_10_0:CanToggleOn())

				if var_10_0:CanTrigger() then
					self.isAutoPlayStory = false

					self:triggerNode(var_7_0)
				elseif var_10_0:IsRefresh() and var_10_0:IsCompleted() then
					local var_10_1 = var_6_0:GetNextTime(0, 0, 0) - var_6_0:GetServerTime()
					local var_10_2 = 3
					local var_10_3

					var_10_3 = Timer.New(function()
						if self.exited then
							var_10_3:Stop()

							var_10_3 = nil
						end

						if var_10_2 == 0 then
							setActive(arg_7_2:Find("main/time"), false)
						else
							setText(arg_7_2:Find("main/time/Text"), i18n("islandnode_tips1") .. var_6_0:DescCDTime(var_10_1))

							var_10_1 = var_10_1 - 1
							var_10_2 = var_10_2 - 1
						end

						return
					end, 1, 3)

					;(nil).func()
					var_10_3:Start()
					setActive(arg_7_2:Find("main/time"), true)
				end

				return
			end, SFX_CONFIRM)
			self:refreshNode(var_7_0)
		end

		return
	end)

	local var_6_2 = self.rtTop:Find("panel/content/mask/scroll_rect")

	self.panelItemList = UIItemList.New(var_6_2, var_6_2:Find("tpl"))

	self.panelItemList:make(function(arg_12_0, arg_12_1, arg_12_2)
		arg_12_1 = arg_12_1 + 1

		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0 = self.proxy:GetNode(self.dailyIds[arg_12_1])

			arg_12_2.name = var_12_0.id

			GetImageSpriteFromAtlasAsync("ui/sixthanniversaryislandui_atlas", var_12_0:getConfig("icon"), arg_12_2:Find("Image"))
			setActive(arg_12_2:Find("mask"), not var_12_0:RedDotHint())
			onButton(self, arg_12_2, function()
				self:focus(var_12_0.id, LeanTweenType.easeInOutSine)

				return
			end, SFX_PANEL)
		end

		return
	end)
	triggerToggle(self.rtTop:Find("panel/toggle"), false)

	local var_6_3 = self._tf:Find("top/focus")

	self.floatItemList = UIItemList.New(var_6_3, var_6_3:Find("main_mark"))

	self.floatItemList:make(function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1 = arg_14_1 + 1

		if arg_14_0 == UIItemList.EventUpdate then
			arg_14_2.name = self.mainIds[arg_14_1]

			onButton(self, arg_14_2, function()
				self:focus(self.mainIds[arg_14_1], LeanTweenType.easeInOutSine)

				return
			end, SFX_PANEL)
		end

		return
	end)

	self.rtResPanel = self.rtTop:Find("res")
	self.rtMap = self._tf:Find("map")

	self.rtMap:GetComponent(typeof(ScrollRect)).onValueChanged:AddListener(function()
		self:onDragFunction()

		return
	end)

	local var_6_4, var_6_5, var_6_6 = getSizeRate()

	self.delta = Vector2(var_6_5 - 100, var_6_6 - 100) / 2
	self.extendLimit = Vector2(self.rtMap.rect.width - self._tf.rect.width, self.rtMap.rect.height - self._tf.rect.height) / 2
	self.displayDic = {}

	onButton(self, self.rtTop:Find("btn_back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	setActive(self.rtTop:Find("btn_now"), false)
	onButton(self, self.rtTop:Find("btns/btn_shop"), function()
		self:emit(SixthAnniversaryIslandMediator.GO_SHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.rtTop:Find("btns/btn_note"), function()
		self:emit(SixthAnniversaryIslandMediator.OPEN_NOTE)

		return
	end, SFX_PANEL)
	onButton(self, self.rtTop:Find("btns/btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("island_help")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.rtResPanel:Find("tpl"), function()
		self:emit(SixthAnniversaryIslandMediator.OPEN_RES, {
			id = 350,
			type = 1
		}, "")

		return
	end, SFX_PANEL)
	onButton(self, self.rtResPanel:Find("tpl_2"), function()
		self:emit(SixthAnniversaryIslandMediator.OPEN_RES, Clone(self.resDrop), i18n("island_game_limit_help", self.resDailyNumber))

		return
	end, SFX_PANEL)

	return
end

function SixthAnniversaryIslandScene:onDragFunction()
	SixthAnniversaryIslandScene.screenPoints = SixthAnniversaryIslandScene.screenPoints or {
		Vector2(-self.delta.x, self.delta.y),
		Vector2(self.delta.x, self.delta.y),
		Vector2(self.delta.x, -self.delta.y),
		Vector2(-self.delta.x, -self.delta.y)
	}

	for iter_23_0, iter_23_1 in ipairs(self.mainIds) do
		local var_23_0 = self._tf:InverseTransformPoint(self.nodeItemList.container:Find(iter_23_1).position)
		local var_23_1

		for iter_23_2, iter_23_3 in ipairs(SixthAnniversaryIslandScene.screenPoints) do
			local var_23_2, var_23_3, var_23_4 = LineLine(Vector2.zero, Vector2(var_23_0.x, var_23_0.y), iter_23_3, SixthAnniversaryIslandScene.screenPoints[iter_23_2 % 4 + 1])

			if var_23_2 then
				var_23_1 = var_23_0 * var_23_3

				break
			end
		end

		local var_23_5 = self.floatItemList.container:Find(iter_23_1)
		local var_23_6 = var_23_5:GetComponent(typeof(CanvasGroup))

		var_23_6.interactable = tobool(var_23_1)
		var_23_6.blocksRaycasts = tobool(var_23_1)
		var_23_6.alpha = tobool(var_23_1) and 1 or 0

		if var_23_1 then
			setAnchoredPosition(var_23_5, var_23_1 * (1 - 50 / var_23_1:Magnitude()))

			local var_23_7 = math.rad2Deg * math.atan2(var_23_1.y, var_23_1.x) - 45

			setLocalEulerAngles(var_23_5:Find("arrow"), {
				z = var_23_7
			})
			setLocalEulerAngles(var_23_5:Find("arrow_shadow"), {
				z = var_23_7
			})
		end
	end

	return
end

function SixthAnniversaryIslandScene:focus(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = self.nodeItemList.container:Find(arg_24_1)

	if not arg_24_3 then
		triggerToggle(var_24_0, self.proxy:GetNode(arg_24_1):CanToggleOn())
	end

	local var_24_1 = var_24_0.anchoredPosition * -1

	var_24_1.x = math.clamp((var_24_0.anchoredPosition * -1).x, -self.extendLimit.x, self.extendLimit.x)
	var_24_1.y = math.clamp(var_24_1.y, -self.extendLimit.y, self.extendLimit.y)

	if self.twFocusId then
		LeanTween.cancel(self.twFocusId)

		self.twFocusId = nil
	end

	if arg_24_2 then
		local var_24_2 = {}

		table.insert(var_24_2, function(arg_25_0)
			SetCompomentEnabled(self.rtMap, typeof(ScrollRect), false)

			self.twFocusId = LeanTween.move(self.rtMap, Vector3(var_24_1.x, var_24_1.y), (self.rtMap.anchoredPosition - var_24_1).magnitude > 0 and (self.rtMap.anchoredPosition - var_24_1).magnitude / (40 * math.sqrt((self.rtMap.anchoredPosition - var_24_1).magnitude)) or 0):setEase(arg_24_2):setOnUpdate(System.Action_float(function(arg_26_0)
				self:onDragFunction()

				return
			end)):setOnComplete(System.Action(arg_25_0)).uniqueId

			return
		end)
		seriesAsync(var_24_2, function()
			SetCompomentEnabled(self.rtMap, typeof(ScrollRect), true)

			return
		end)
	else
		self.rtMap.anchoredPosition = var_24_1

		self:onDragFunction()
	end

	return
end

function SixthAnniversaryIslandScene:triggerNode(arg_28_1)
	local var_28_0 = getProxy(SixthAnniversaryIslandProxy):GetNode(arg_28_1)

	if var_28_0:IsNew() then
		self:emit(SixthAnniversaryIslandMediator.MARK_NODE_AFTER_NEW, arg_28_1)
	end

	if var_28_0:IsCompleted() then
		if var_28_0:getConfig("type") == 5 then
			self:emit(SixthAnniversaryIslandMediator.INTO_ENTRANCE, var_28_0:getConfig("params")[1])
		end
	else
		self:triggerEvent(var_28_0)
	end

	return
end

function SixthAnniversaryIslandScene:triggerEvent(arg_29_1)
	assert(arg_29_1.eventId and arg_29_1.eventId ~= 0)

	local var_29_1 = IslandEvent.New({
		id = arg_29_1.eventId
	})

	switch(var_29_1:getConfig("type"), {
		[3] = function()
			local var_30_0 = {}
			local var_30_1 = var_29_1:getConfig("story")

			if var_30_1 and var_30_1 ~= "" then
				table.insert(var_30_0, function(arg_31_0)
					if self.isAutoPlayStory then
						pg.NewStoryMgr.GetInstance():ForceAutoPlay(var_30_1, arg_31_0)
					else
						pg.NewStoryMgr.GetInstance():ForceManualPlay(var_30_1, arg_31_0)
					end

					return
				end)
				table.insert(var_30_0, function(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
					self.isAutoPlayStory = arg_32_3

					arg_32_0(arg_32_2)

					return
				end)
			end

			seriesAsync(var_30_0, function(arg_33_0)
				self:emit(SixthAnniversaryIslandMediator.OPEN_QTE_GAME, var_29_1:getConfig("params")[1], function(arg_34_0)
					self:emit(SixthAnniversaryIslandMediator.TRIGGER_NODE_EVENT, arg_29_1.id, arg_34_0 or 0)

					return
				end)

				return
			end)

			return
		end
	}, function()
		local var_35_0 = {}
		local var_35_1 = var_29_1:getConfig("story")

		if var_35_1 and var_35_1 ~= "" then
			table.insert(var_35_0, function(arg_36_0)
				if self.isAutoPlayStory then
					pg.NewStoryMgr.GetInstance():ForceAutoPlay(var_35_1, arg_36_0, true)
				else
					pg.NewStoryMgr.GetInstance():ForceManualPlay(var_35_1, arg_36_0, true)
				end

				return
			end)
			table.insert(var_35_0, function(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
				self.isAutoPlayStory = arg_37_3

				arg_37_0(arg_37_2)

				return
			end)
		end

		seriesAsync(var_35_0, function(arg_38_0)
			self:emit(SixthAnniversaryIslandMediator.TRIGGER_NODE_EVENT, arg_29_1.id, arg_38_0 or 0)

			return
		end)

		return
	end)

	return
end

function SixthAnniversaryIslandScene:afterTriggerEvent(arg_39_1)
	local var_39_0 = self.proxy:GetNode(arg_39_1)

	if var_39_0:IsCompleted() then
		underscore.each(self.ids, function(arg_40_0)
			self:refreshNode(arg_40_0)

			return
		end)
		self:refreshDailyPanel()
	else
		self:refreshNode(arg_39_1)
	end

	if var_39_0:CanTrigger() then
		triggerToggle(self.nodeItemList.container:Find(arg_39_1), var_39_0:CanToggleOn())
		self:triggerNode(arg_39_1)
	end

	return
end

function SixthAnniversaryIslandScene:refreshNode(arg_41_1)
	local var_41_0 = self.nodeItemList.container:Find(arg_41_1)
	local var_41_1 = getProxy(SixthAnniversaryIslandProxy):GetNode(arg_41_1)
	local var_41_2 = var_41_1:IsVisual()

	setActive(var_41_0:Find("click"), var_41_2)

	local var_41_3 = var_41_2 and var_41_1:GetScale() or 0
	local var_41_4 = Vector3(var_41_3, var_41_3, 1)

	if var_41_0.localScale ~= var_41_4 then
		LeanTween.cancel(var_41_0)
		LeanTween.scale(var_41_0, var_41_4, 0.3):setEase(LeanTweenType.easeInOutSine)
	end

	if var_41_2 and not self.displayDic[arg_41_1] then
		self.displayDic[arg_41_1] = true

		local var_41_5 = var_41_1:getConfig("icon")

		if var_41_5 == "" then
			SetCompomentEnabled(var_41_0:Find("main"), typeof(Image), false)
			SetCompomentEnabled(var_41_0:Find("selected_back/light"), typeof(Image), false)
		else
			GetSpriteFromAtlasAsync("ui/sixthanniversaryislandui_atlas", var_41_5, function(arg_42_0)
				setImageSprite(var_41_0:Find("main"), arg_42_0)
				setImageSprite(var_41_0:Find("main/mask"), arg_42_0)

				return
			end)
			GetImageSpriteFromAtlasAsync("ui/sixthanniversaryislandui_atlas", var_41_5 .. "_light", var_41_0:Find("selected_back/light"))
		end

		if var_41_1:getConfig("icon_name") ~= "" then
			GetImageSpriteFromAtlasAsync("ui/sixthanniversaryislandui_atlas", var_41_1:getConfig("icon_name"), var_41_0:Find("name/Image"), true)
		end

		local var_41_6 = var_41_1:GetEffectName()

		if var_41_6 ~= "" then
			pg.PoolMgr.GetInstance():GetUI(var_41_6, true, function(arg_43_0)
				table.insert(self.effectObjs, {
					name = var_41_6,
					go = arg_43_0
				})
				setParent(arg_43_0, var_41_0:Find("click"), false)

				return
			end)
		end
	end

	setActive(var_41_0:Find("main/type"), var_41_1:RedDotHint())

	local var_41_7 = var_41_1:IsRefresh() and var_41_1:IsCompleted()

	setActive(var_41_0:Find("name"), not var_41_7 and not var_41_1:IsTreasure())
	setActive(var_41_0:Find("main/mask"), var_41_7)
	setActive(var_41_0:Find("main/time"), false)
	setActive(var_41_0:Find("main/new"), var_41_1:IsNew())

	local var_41_8 = GetOrAddComponent(var_41_0:Find("main"), typeof("LOutLine"))

	ReflectionHelp.RefSetField(typeof("LOutLine"), "OutlineWidth", var_41_8, var_41_7 and 0 or 3)
	ReflectionHelp.RefCallMethod(typeof("LOutLine"), "_Refresh", var_41_8)
	triggerToggle(var_41_0, self.selectId == arg_41_1 and var_41_1:CanToggleOn())

	return
end

function SixthAnniversaryIslandScene:refreshDailyPanel()
	self.dailyIds = underscore.select(self.ids, function(arg_45_0)
		local var_45_0 = self.proxy:GetNode(arg_45_0)

		return (var_45_0:IsRefresh() or var_45_0:IsFlowerField()) and var_45_0:IsVisual()
	end)

	self.panelItemList:align(#self.dailyIds)

	self.mainIds = underscore.select(self.ids, function(arg_46_0)
		local var_46_0 = self.proxy:GetNode(arg_46_0)

		return var_46_0:IsMain() and var_46_0:IsVisual()
	end)

	self.floatItemList:align(#self.mainIds)
	self:onDragFunction()

	return
end

function SixthAnniversaryIslandScene:focusList(arg_47_1, arg_47_2, arg_47_3)
	for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
		if self.proxy:GetNode(iter_47_1):IsVisual() then
			self:focus(iter_47_1, arg_47_2, arg_47_3)

			return true
		end
	end

	return false
end

function SixthAnniversaryIslandScene:didEnter()
	self.nodeItemList:align(#self.ids)
	self:refreshDailyPanel()
	self:updateTaskTip()

	local var_48_0 = {}

	if self.contextData.nodeIds and #self.contextData.nodeIds > 0 then
		table.insert(var_48_0, function(arg_49_0)
			if not self:focusList(self.contextData.nodeIds) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("islandnode_tips8"))
				arg_49_0()
			end

			self.contextData.nodeIds = nil

			return
		end)
	elseif self.contextData.checkMain then
		table.insert(var_48_0, function(arg_50_0)
			local var_50_0 = getProxy(SixthAnniversaryIslandProxy)
			local var_50_1 = underscore.filter(underscore.map(self.ids, function(arg_51_0)
				return var_50_0:GetNode(arg_51_0)
			end), function(arg_52_0)
				return arg_52_0:IsMain() and not arg_52_0:IsCompleted()
			end)
			local var_50_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2):GetTotalBuildingLevel()

			if #var_50_1 > 0 and underscore.all(var_50_1, function(arg_53_0)
				return not arg_53_0:IsUnlock() and arg_53_0:getConfig("open_need")[1] > var_50_2
			end) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("islandnode_tips9"))
			end

			arg_50_0()

			return
		end)
	end

	self.contextData.checkMain = nil

	local var_48_1 = {
		1001,
		1002,
		1003,
		1004,
		1005
	}

	if self.contextData.lastNodeId then
		table.insert(var_48_1, 1, self.contextData.lastNodeId)
	end

	table.insert(var_48_0, function(arg_54_0)
		if not self:focusList(var_48_1) then
			arg_54_0()
		end

		return
	end)
	seriesAsync(var_48_0, function()
		self:focusList({
			1050,
			1051,
			1052,
			1053
		}, nil, true)

		return
	end)
	pg.NewStoryMgr.GetInstance():Play("HAIDAORICHANG2", function()
		if self.contextData.wraps then
			switch(self.contextData.wraps, {
				[SixthAnniversaryIslandScene.SHOP] = function()
					self:emit(SixthAnniversaryIslandMediator.GO_SHOP)

					return
				end
			})

			self.contextData.wraps = nil
		end

		return
	end)

	return
end

function SixthAnniversaryIslandScene:updateTaskTip()
	setActive(self.rtTop:Find("btns/btn_note/tip"), getProxy(ActivityTaskProxy):getActTaskTip(ActivityConst.ISLAND_TASK_ID))

	return
end

function SixthAnniversaryIslandScene:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.rtTop, self._tf)
	self.rtMap:GetComponent(typeof(ScrollRect)).onValueChanged:RemoveAllListeners()

	local var_59_0 = pg.PoolMgr.GetInstance()

	for iter_59_0, iter_59_1 in ipairs(self.effectObjs) do
		var_59_0:ReturnUI(iter_59_1.name, iter_59_1.go)
	end

	return
end

return SixthAnniversaryIslandScene
