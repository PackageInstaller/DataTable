local WorldCollectionLayer = class("WorldCollectionLayer", import("..base.BaseUI"))

function WorldCollectionLayer:getUIName()
	return "WorldCollectionUI"
end

function WorldCollectionLayer:init()
	self.top = self._tf:Find("top")
	self.backBtn = self.top:Find("back_btn")
	self.topToggles = self.top:Find("toggles")
	self.rtMain = self._tf:Find("main")
	self.entranceContainer = self.rtMain:Find("list_bg/map_list/content")
	self.btnGetAll = self.rtMain:Find("list_bg/btn_get_all")
	self.scrollEntrance = GetComponent(self.entranceContainer, "LScrollRect")

	function self.scrollEntrance.onUpdateItem(arg_3_0, arg_3_1)
		arg_3_0 = arg_3_0 + 1

		local var_3_0 = tf(arg_3_1)
		local var_3_1 = self.achEntranceList[arg_3_0]

		self.entranceOjbecDic[arg_3_0] = var_3_0

		setText(var_3_0:Find("icon/deco_id"), self.achEntranceList[arg_3_0].config.serial_number)
		setText(var_3_0:Find("icon/name"), self.achEntranceList[arg_3_0]:GetBaseMap():GetName())
		setActive(var_3_0:Find("icon/tip"), nowWorld():AnyUnachievedAchievement(self.achEntranceList[arg_3_0]))
		onButton(self, var_3_0, function()
			self:UpdateAchievement(arg_3_0)

			return
		end, SFX_PANEL)

		local var_3_2 = var_3_0:Find("icon")

		setAnchoredPosition(var_3_2, {
			y = (1 - arg_3_0 % 2 * 2) * math.abs(var_3_2.anchoredPosition.y)
		})
		setActive(var_3_2:Find("select"), self.selectedIndex == arg_3_0)
		setText(var_3_2:Find("select/gomap/Text"), i18n("world_target_goto"))
		onButton(self, var_3_2:Find("select/gomap"), function()
			self:emit(WorldCollectionMediator.ON_MAP, var_3_1)
			self:closeView()

			return
		end, SFX_PANEL)

		return
	end

	function self.scrollEntrance.onReturnItem(arg_6_0, arg_6_1)
		if self.exited then
			return
		end

		self.entranceOjbecDic[arg_6_0 + 1] = nil

		removeOnButton(arg_6_1)

		return
	end

	self.scrollEntrance.onValueChanged:AddListener(function(arg_7_0)
		self:UpdateJumpBtn()

		return
	end)

	self.entrancePanel = self.rtMain:Find("map")
	self.entranceTitle = self.entrancePanel:Find("target_rect/title")
	self.targetContainer = self.entrancePanel:Find("target_rect/target_list/content")
	self.targetItemList = UIItemList.New(self.targetContainer, self.targetContainer:Find("item"))

	self.targetItemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		arg_8_1 = arg_8_1 + 1

		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = arg_8_1 > #self.achEntranceList[self.selectedIndex].config.normal_target
			local var_8_1 = arg_8_2:Find("bg")

			setActive(var_8_1:Find("normal"), not (arg_8_1 > #self.achEntranceList[self.selectedIndex].config.normal_target))
			setActive(var_8_1:Find("hidden"), var_8_0)

			local var_8_2 = self.targetList[arg_8_1]
			local var_8_3 = self.targetList[arg_8_1]:IsAchieved()
			local var_8_4 = not var_8_0 or var_8_3 or self.showHiddenDesc

			setText(var_8_1:Find("desc"), (not var_8_0 or var_8_3 or self.showHiddenDesc or nil) and (var_8_2.config.target_desc or "???"))
			setText(var_8_1:Find("progress"), var_8_4 and var_8_2:GetProgress() .. "/" .. var_8_2:GetMaxProgress() or "")
			setActive(var_8_1:Find("finish_mark/Image"), var_8_3)

			local var_8_6 = arg_8_2:Find("pop")
			local var_8_7 = var_8_2:GetTriggers()
			local var_8_8 = var_8_4 and #var_8_7 > 1

			if var_8_4 and #var_8_7 > 1 then
				local var_8_10 = var_8_6:Find("Text")

				local function var_8_11(arg_9_0, arg_9_1)
					setText(arg_9_1, var_8_7[arg_9_0]:GetDesc())
					setTextColor(arg_9_1, var_8_7[arg_9_0]:IsAchieved() and Color.New(0.3686274509803922, 0.6078431372549019, 1) or Color.New(0.4745098039215686, 0.4745098039215686, 0.4745098039215686))
					setActive(arg_9_1, true)

					return
				end

				for iter_8_0 = #var_8_7, var_8_6.childCount - 1 do
					setActive(var_8_6:GetChild(iter_8_0), false)
				end

				for iter_8_1 = var_8_6.childCount, #var_8_7 - 1 do
					cloneTplTo(var_8_10, var_8_6)
				end

				for iter_8_2 = 0, #var_8_7 - 1 do
					var_8_11(iter_8_2 + 1, var_8_6:GetChild(iter_8_2))
				end
			end

			triggerToggle(arg_8_2, false)
			setToggleEnabled(arg_8_2, var_8_8)
			setActive(var_8_1:Find("arrow"), var_8_8)
		end

		return
	end)

	self.achAwardRect = self.entrancePanel:Find("award_rect")
	self.achAchieveBtn = self.achAwardRect:Find("btn_achieve")
	self.overviewBtn = self.entrancePanel:Find("btn_overview")
	self.subviewAchAward = WorldAchAwardSubview.New(self._tf, self.event)

	self:bind(WorldAchAwardSubview.ShowDrop, function(arg_10_0, arg_10_1)
		self:emit(WorldCollectionLayer.ON_DROP, arg_10_1)

		return
	end)

	return
end

function WorldCollectionLayer:onBackPressed()
	if self.subviewAchAward:isShowing() then
		self.subviewAchAward:ActionInvoke("Hide")
	else
		WorldCollectionLayer.super.onBackPressed(self)
	end

	return
end

function WorldCollectionLayer:didEnter()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onToggle(self, self.topToggles:Find("all"), function(arg_14_0)
		if arg_14_0 then
			self:UpdateEntranceFilter(false)
		end

		return
	end, SFX_PANEL)
	setText(self.topToggles:Find("all/Text"), i18n("world_target_filter_tip1"))
	setText(self.topToggles:Find("all/Image/Text"), i18n("world_target_filter_tip1"))
	onToggle(self, self.topToggles:Find("unfinish"), function(arg_15_0)
		if arg_15_0 then
			self:UpdateEntranceFilter(true)
		end

		return
	end, SFX_PANEL)
	setText(self.topToggles:Find("unfinish/Text"), i18n("world_target_filter_tip2"))
	setText(self.topToggles:Find("unfinish/Image/Text"), i18n("world_target_filter_tip2"))
	onButton(self, self.rtMain:Find("list_bg/jump_icon_left"), function()
		self:ScrollAndSelectEntrance(self:GetAwardIndex(false))

		return
	end, SFX_PANEL)
	onButton(self, self.rtMain:Find("list_bg/jump_icon_right"), function()
		self:ScrollAndSelectEntrance(self:GetAwardIndex(true))

		return
	end, SFX_PANEL)
	onButton(self, self.btnGetAll, function()
		local var_18_0, var_18_1 = nowWorld():GetFinishAchievements(self.achEntranceList)

		if #var_18_0 > 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("world_target_get_all"),
				onYes = function()
					self:emit(WorldCollectionMediator.ON_ACHIEVE_STAR, var_18_0)

					return
				end
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("without any award")
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.achAchieveBtn, function()
		local var_20_0, var_20_1 = nowWorld():AnyUnachievedAchievement(self.entrance)

		if var_20_0 then
			self:emit(WorldCollectionMediator.ON_ACHIEVE_STAR, {
				{
					id = self.entrance.id,
					star_list = {
						var_20_1.star
					}
				}
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.entrancePanel:Find("page_left"), function()
		self:ScrollAndSelectEntrance(self.selectedIndex - 1)

		return
	end, SFX_PANEL)
	onButton(self, self.entrancePanel:Find("page_right"), function()
		self:ScrollAndSelectEntrance(self.selectedIndex + 1)

		return
	end, SFX_PANEL)
	onButton(self, self.overviewBtn, function()
		self:emit(WorldCollectionMediator.ON_ACHIEVE_OVERVIEW)

		return
	end, SFX_PANEL)
	triggerToggle(self.topToggles:Find("all"), true)

	return
end

function WorldCollectionLayer:willExit()
	self.subviewAchAward:Destroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function WorldCollectionLayer:SetAchievementList(arg_25_1)
	self.baseEntranceList = arg_25_1

	return
end

function WorldCollectionLayer:BuildEntranceScrollPos()
	self.entrancePos = {}
	self.entranceIndexDic = {}

	for iter_26_0, iter_26_1 in ipairs(self.achEntranceList) do
		table.insert(self.entrancePos, self.scrollEntrance:HeadIndexToValue(iter_26_0 - 1))

		self.entranceIndexDic[iter_26_1.id] = iter_26_0

		if nowWorld():AnyUnachievedAchievement(iter_26_1) then
			table.insert(self.achAwardIndexList, iter_26_0)
		end
	end

	return
end

function WorldCollectionLayer:UpdateEntranceFilter(arg_27_1)
	self.achEntranceList = arg_27_1 and underscore.filter(self.baseEntranceList, function(arg_28_0)
		local var_28_0, var_28_1, var_28_2 = nowWorld():CountAchievements(arg_28_0)

		return var_28_2 > var_28_0 + var_28_1
	end) or underscore.rest(self.baseEntranceList, 1)

	self:UpdateGetAllAwardBtn()

	self.achAwardIndexList = {}
	self.entranceOjbecDic = {}

	self.scrollEntrance:SetTotalCount(#self.achEntranceList)
	self:BuildEntranceScrollPos()

	self.contextData.entranceId = defaultValue(self.contextData.entranceId, 0)

	local var_27_0 = defaultValue(self.entranceIndexDic[self.contextData.entranceId], 1)

	if self.achEntranceList[var_27_0] then
		self:ScrollAndSelectEntrance(var_27_0)
	else
		setActive(self.entrancePanel:Find("page_left"), false)
		setActive(self.entrancePanel:Find("page_right"), false)
	end

	return
end

function WorldCollectionLayer:UpdateGetAllAwardBtn()
	local var_29_0, var_29_1 = nowWorld():GetFinishAchievements(self.achEntranceList)

	setActive(self.btnGetAll, pg.gameset.world_target_obtain.key_value <= #var_29_0)

	return
end

function WorldCollectionLayer:FlushEntranceItem(arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
		if not nowWorld():AnyUnachievedAchievement(self.achEntranceList[self.entranceIndexDic[iter_30_1.id]]) then
			if self.entranceOjbecDic[self.entranceIndexDic[iter_30_1.id]] then
				setActive(self.entranceOjbecDic[self.entranceIndexDic[iter_30_1.id]]:Find("icon/tip"), false)
			end

			table.removebyvalue(self.achAwardIndexList, self.entranceIndexDic[iter_30_1.id])
		end
	end

	self:UpdateGetAllAwardBtn()

	return
end

function WorldCollectionLayer:UpdateAchievement(arg_31_1, arg_31_2)
	local var_31_9000

	if arg_31_2 or self.selectedIndex ~= arg_31_1 then
		arg_31_1, self.selectedIndex = self.selectedIndex, arg_31_1

		for iter_31_0, iter_31_1 in ipairs({
			var_31_9000,
			self.selectedIndex
		}) do
			if self.entranceOjbecDic[iter_31_1] then
				setActive(self.entranceOjbecDic[iter_31_1]:Find("icon/select"), self.selectedIndex == iter_31_1)
			end
		end

		self.entrance = self.achEntranceList[self.selectedIndex]

		self:FlushAchievement()
	end

	return
end

function WorldCollectionLayer:GetAwardIndex(arg_32_1)
	if #self.achEntranceList == 0 then
		return nil
	end

	local var_32_0 = self.entrancePos[#self.achEntranceList] - 1

	if arg_32_1 then
		for iter_32_0 = 1, #self.achAwardIndexList do
			if self.scrollEntrance.value + var_32_0 < self.entrancePos[self.achAwardIndexList[iter_32_0]] then
				return self.achAwardIndexList[iter_32_0]
			end
		end

		return nil
	else
		local var_32_1 = self.scrollEntrance.value

		for iter_32_1 = #self.achAwardIndexList, 1, -1 do
			if var_32_1 > self.entrancePos[self.achAwardIndexList[iter_32_1]] then
				return self.achAwardIndexList[iter_32_1]
			end
		end

		return nil
	end

	return
end

function WorldCollectionLayer:ScrollAndSelectEntrance(arg_33_1)
	self:UpdateAchievement(arg_33_1, true)
	self.scrollEntrance:ScrollTo(math.clamp(self.entrancePos[arg_33_1] - (self.entrancePos[#self.achEntranceList] - 1) / 2, 0, 1))

	return
end

function WorldCollectionLayer:UpdateJumpBtn()
	setActive(self.rtMain:Find("list_bg/jump_icon_left"), self:GetAwardIndex(false))
	setActive(self.rtMain:Find("list_bg/jump_icon_right"), self:GetAwardIndex(true))

	return
end

function WorldCollectionLayer:FlushAchievement()
	self:UpdateJumpBtn()

	local var_35_0 = nowWorld()

	self.showHiddenDesc = var_35_0:IsNormalAchievementAchieved(self.entrance)
	self.targetList = var_35_0:GetAchievements(self.entrance)

	self.targetItemList:align(#self.targetList)

	local var_35_1 = self.entrance:GetBaseMap()

	GetImageSpriteFromAtlasAsync("world/targeticon/" .. var_35_1.config.entrance_mapicon, "", self.entranceTitle)
	setText(self.entranceTitle:Find("name"), var_35_1:GetName(self.entrance))
	setText(self.entranceTitle:Find("deco_id"), self.entrance.config.serial_number)

	local var_35_2, var_35_3, var_35_4 = var_35_0:CountAchievements(self.entrance)

	setText(self.entranceTitle:Find("progress_text"), var_35_2 + var_35_3 .. "/" .. var_35_4)

	local var_35_5, var_35_6 = var_35_0:AnyUnachievedAchievement(self.entrance)
	local var_35_7 = self.achAwardRect:Find("award")

	if var_35_6 then
		setActive(self.achAwardRect:Find("get_mask"), var_35_5)
		setActive(self.achAwardRect:Find("got_mask"), false)
	else
		local var_35_8 = self.entrance:GetAchievementAwards()

		var_35_6 = var_35_8[#var_35_8]

		setActive(self.achAwardRect:Find("get_mask"), false)
		setActive(self.achAwardRect:Find("got_mask"), true)
	end

	updateDrop(var_35_7, var_35_6.drop)
	onButton(self, var_35_7, function()
		self:showAchAwardPanel(self.entrance)

		return
	end, SFX_PANEL)
	setText(self.achAwardRect:Find("star_count/Text"), var_35_2 + var_35_3 .. "/" .. var_35_6.star)
	setActive(self.achAchieveBtn, var_35_5)
	setActive(self.entrancePanel:Find("page_left"), self.selectedIndex > 1)
	setActive(self.entrancePanel:Find("page_right"), self.selectedIndex < #self.achEntranceList)

	return
end

function WorldCollectionLayer:flushAchieveUpdate(arg_37_1)
	self:FlushEntranceItem(arg_37_1)
	self:FlushAchievement()

	return
end

function WorldCollectionLayer:showAchAwardPanel(arg_38_1)
	self.subviewAchAward:Load()
	self.subviewAchAward:ActionInvoke("Setup", arg_38_1)
	self.subviewAchAward:ActionInvoke("Show")

	return
end

return WorldCollectionLayer
