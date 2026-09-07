local DreamlandHandbookPage = class("DreamlandHandbookPage", import("view.base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2

function DreamlandHandbookPage:getUIName()
	return "DreamlandHandbookUI"
end

function DreamlandHandbookPage:OnLoaded()
	self.closeBtn = self._tf:Find("bg/close")
	self.tags = {
		[var_0_1] = self._tf:Find("bg/tags/area"),
		[var_0_2] = self._tf:Find("bg/tags/ex")
	}
	self.tagTip = {}

	for iter_2_0, iter_2_1 in pairs(self.tags) do
		self.tagTip[iter_2_0] = iter_2_1:Find("tip")
	end

	self.mapContent = self._tf:Find("bg/area/content")
	self.mapNameTxt = self._tf:Find("bg/area/content/name"):GetComponent(typeof(Text))
	self.mapDescTxt = self._tf:Find("bg/area/content/scrollrect/desc"):GetComponent(typeof(Text))
	self.mapGoBtn = self._tf:Find("bg/area/content/btn_go")
	self.mapGetBtn = self._tf:Find("bg/area/content/btn_get")
	self.mapGotBtn = self._tf:Find("bg/area/content/btn_got")
	self.mapAwardList = UIItemList.New(self._tf:Find("bg/area/content/awards/list"), self._tf:Find("bg/area/content/awards/list/award"))
	self.lineUIList = UIItemList.New(self._tf:Find("bg/area/content/scrollrect/desc/lines"), self._tf:Find("bg/area/content/scrollrect/desc/lines/tpl"))
	self.exGoBtn = self._tf:Find("bg/ex/content/btn_go")
	self.exGetBtn = self._tf:Find("bg/ex/content/btn_get")
	self.exGotBtn = self._tf:Find("bg/ex/content/btn_got")
	self.exAwardList = UIItemList.New(self._tf:Find("bg/ex/content/awards/list"), self._tf:Find("bg/ex/content/awards/list/award"))
	self.exContentList = UIItemList.New(self._tf:Find("bg/ex/content/scrollrect/content"), self._tf:Find("bg/ex/content/scrollrect/content/tpl"))
	self.exContent = self._tf:Find("bg/ex/content")
	self.areaList = UIItemList.New(self._tf:Find("bg/area/list"), self._tf:Find("bg/area/list/1"))
	self.exploreList = UIItemList.New(self._tf:Find("bg/ex/list"), self._tf:Find("bg/ex/list/tpl"))

	setText(self._tf:Find("bg/tags/area/Text"), i18n("dreamland_label_area"))
	setText(self._tf:Find("bg/tags/ex/Text"), i18n("dreamland_label_explore"))
	setText(self._tf:Find("bg/ex/content/award_desc"), i18n("dreamland_label_explore_award_tip"))

	self.tipTr = self._tf:Find("tip")
	self.tipTxt = self.tipTr:Find("Text"):GetComponent(typeof(Text))

	return
end

function DreamlandHandbookPage:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	local var_3_0 = Color.New(0.5843138, 0.5843138, 0.5843138, 1)
	local var_3_1 = Color.New(1, 1, 1, 1)

	local function var_3_2(arg_6_0, arg_6_1)
		if arg_6_1 then
			arg_6_0:Find("icon"):GetComponent(typeof(Image)).color = var_3_1 or var_3_0
		end

		if arg_6_1 then
			arg_6_0:Find("Text"):GetComponent(typeof(Text)).color = var_3_1 or var_3_0
		end

		return
	end

	for iter_3_0, iter_3_1 in pairs(self.tags) do
		onToggle(self, iter_3_1, function(arg_7_0)
			self:SwitchPage(iter_3_0)
			var_3_2(iter_3_1, arg_7_0)

			return
		end, SFX_PANEL)
		var_3_2(iter_3_1, false)
	end

	self:bind(DreamlandScene.ON_DATA_UPDATE, function(arg_8_0, arg_8_1)
		self:OnDataUpdate(arg_8_1)

		return
	end)

	return
end

function DreamlandHandbookPage:OnDataUpdate(arg_9_1)
	self.gameData = arg_9_1.data

	if not self:isShowing() then
		return
	end

	if arg_9_1.cmd == DreamlandData.OP_GET_MAP_AWARD then
		self:UpdateAreaPage()
	elseif arg_9_1.cmd == DreamlandData.OP_GET_EXPLORE_AWARD then
		self:UpdateExplorePage()
	end

	self:UpdateTip()

	return
end

function DreamlandHandbookPage:Show(arg_10_1)
	DreamlandHandbookPage.super.Show(self)

	self.gameData = arg_10_1
	self.selectedMapId = 1
	self.selectedExploreId = 1

	self:UpdateTip()
	triggerToggle(self.tags[1], true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function DreamlandHandbookPage:UpdateTip()
	setActive(self.tagTip[var_0_1], self.gameData:ExistAnyMapAward())
	setActive(self.tagTip[var_0_2], self.gameData:ExistAnyExploreAward())

	return
end

function DreamlandHandbookPage:Hide()
	DreamlandHandbookPage.super.Hide(self)
	self:RemoveHideTimer()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function DreamlandHandbookPage:SwitchPage(arg_13_1)
	if arg_13_1 == var_0_1 then
		self:UpdateAreaPage()
	elseif arg_13_1 == var_0_2 then
		self:HideTip()
		self:UpdateExplorePage()

		if self.gameData:MarkExploreState() then
			self:UpdateTip()
		end
	end

	return
end

function DreamlandHandbookPage:InitArea(arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2:GetComponent(typeof(Image))

	var_14_0.sprite = GetSpriteFromAtlas("ui/DlHandBookUI_atlas", "area" .. arg_14_1)

	var_14_0:SetNativeSize()

	local var_14_1 = arg_14_2:Find("selected")

	onToggle(self, arg_14_2, function(arg_15_0)
		if arg_15_0 then
			self:UpdateArea(arg_14_1)
		end

		local var_15_0 = arg_15_0 and not self.gameData:IsUnlockMap(arg_14_1)

		if var_15_0 and not self.initFlag then
			self:ShowTip(i18n("dreamland_area_lock_tip"))
		end

		if var_15_0 then
			setActive(var_14_1, false)
		end

		return
	end, SFX_PANEL)

	return
end

function DreamlandHandbookPage:GetLineCunt(arg_16_1)
	return math.max(math.ceil(arg_16_1.gameObject.transform.sizeDelta.y / self.lineUIList.container:GetComponent(typeof(VerticalLayoutGroup)).spacing), 4)
end

function DreamlandHandbookPage:UpdateArea(arg_17_1)
	local var_17_0 = self.gameData:IsUnlockMap(arg_17_1)

	if not var_17_0 then
		setActive(self.mapContent, false)

		return
	end

	setActive(self.mapContent, true)

	self.selectedMapId = arg_17_1

	local var_17_1 = self.gameData:FindMap(arg_17_1)

	self.mapNameTxt.text = var_17_1.name
	self.mapDescTxt.text = HXSet.hxLan(var_17_1.desc)

	onNextTick(function()
		self.lineUIList:align((self:GetLineCunt(self.mapDescTxt)))

		return
	end)

	local var_17_2 = self.gameData:IsReceiveMapAward(arg_17_1)

	setActive(self.mapGoBtn, not var_17_0)
	setActive(self.mapGetBtn, var_17_0 and not var_17_2)
	setActive(self.mapGotBtn, var_17_0 and var_17_2)

	local var_17_3 = var_17_1.unlock_drop_display

	self.mapAwardList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			self:UpdateDrop(arg_19_2, var_17_3[arg_19_1 + 1], var_17_0 and var_17_2)
		end

		return
	end)
	self.mapAwardList:align(#var_17_1.unlock_drop_display)
	onButton(self, self.mapGetBtn, function()
		if var_17_0 and not var_17_2 then
			self:CheckAwardOverflow(var_17_3, function()
				self:emit(DreamlandMediator.GET_MAP_AWARD, self.gameData:GetActivityId(), arg_17_1)

				return
			end)
		end

		return
	end, SFX_PANEL)

	return
end

function DreamlandHandbookPage:InitAreaPage()
	self.areaTrs = {}

	local var_22_0 = self.gameData:GetAllMapId()

	self.areaList:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			self:InitArea(var_22_0[arg_23_1 + 1], arg_23_2)

			self.areaTrs[var_22_0[arg_23_1 + 1]] = arg_23_2
		end

		return
	end)
	self.areaList:align(#var_22_0)

	return
end

function DreamlandHandbookPage:UpdateAreaPage()
	if not self.isInitAreaPage then
		self:InitAreaPage()

		self.isInitAreaPage = true
	end

	for iter_24_0, iter_24_1 in pairs(self.areaTrs) do
		local var_24_0 = self.gameData:IsUnlockMap(iter_24_0)

		setActive(iter_24_1:Find("tip"), var_24_0 and not self.gameData:IsReceiveMapAward(iter_24_0))
		setActive(iter_24_1:Find("mask"), not var_24_0)
	end

	self.initFlag = true

	triggerToggle(self.areaTrs[self.selectedMapId], true)

	self.initFlag = false

	return
end

function DreamlandHandbookPage:InitExplore(arg_25_1, arg_25_2)
	local var_25_0 = self.gameData:FindMap(arg_25_2)
	local var_25_1 = arg_25_1:Find("num"):GetComponent(typeof(Image))

	var_25_1.sprite = GetSpriteFromAtlas("ui/DlHandBookUI_atlas", "ex_print" .. arg_25_2)

	var_25_1:SetNativeSize()

	local var_25_2 = arg_25_1:Find("Text"):GetComponent(typeof(Text))
	local var_25_3 = Color.New(0.3058824, 0.3058824, 0.3607843)
	local var_25_4 = Color.New(0.145098, 0.3215686, 0.9254902)

	onToggle(self, arg_25_1, function(arg_26_0)
		if arg_26_0 then
			self:UpdateExplore(arg_25_2)
		end

		if arg_26_0 and not self.gameData:IsUnlockMap(arg_25_2) then
			setActive(arg_25_1:Find("selected"), false)
		end

		if arg_26_0 then
			var_25_2.color = var_25_4 or var_25_3
		end

		return
	end, SFX_PANEL)
	onButton(self, arg_25_1:Find("lock"), function(arg_27_0)
		self:ShowTip(i18n("dreamland_area_lock_tip"))

		return
	end, SFX_PANEL)

	return
end

function DreamlandHandbookPage:UpdateExplore(arg_28_1)
	if not self.gameData:IsUnlockMap(arg_28_1) then
		setActive(self.exContent, false)

		return
	end

	self.selectedExploreId = arg_28_1

	setActive(self.exContent, true)

	local var_28_0 = self.gameData:FindMap(arg_28_1)
	local var_28_1 = self.gameData:IsFinishMapExplore(arg_28_1)
	local var_28_2 = self.gameData:IsReceiveExploreAward(arg_28_1)

	setActive(self.exGoBtn, not var_28_1)
	setActive(self.exGetBtn, var_28_1 and not var_28_2)
	setActive(self.exGotBtn, var_28_1 and var_28_2)

	local var_28_3 = var_28_0.explore_drop_display

	self.exAwardList:make(function(arg_29_0, arg_29_1, arg_29_2)
		if arg_29_0 == UIItemList.EventUpdate then
			self:UpdateDrop(arg_29_2, var_28_3[arg_29_1 + 1], var_28_1 and var_28_2)
		end

		return
	end)
	self.exAwardList:align(#var_28_0.explore_drop_display)

	local var_28_4 = self.gameData:GetMainExploreInMap(var_28_0)

	self.exContentList:make(function(arg_30_0, arg_30_1, arg_30_2)
		if arg_30_0 == UIItemList.EventUpdate then
			self:UpdateExploreObj(arg_30_2, arg_30_1 + 1, var_28_4[arg_30_1 + 1])
		end

		return
	end)
	self.exContentList:align(#var_28_4)
	onButton(self, self.exGetBtn, function(arg_31_0)
		if var_28_1 and not var_28_2 then
			self:CheckAwardOverflow(var_28_3, function()
				self:emit(DreamlandMediator.GET_EXPLORE_AWARD, self.gameData:GetActivityId(), arg_28_1)

				return
			end)
		end

		return
	end, SFX_PANEL)

	return
end

function DreamlandHandbookPage:UpdateExploreObj(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = self.gameData:FindExploreObj(arg_33_3)
	local var_33_1 = arg_33_1:Find("1")
	local var_33_2 = arg_33_1:Find("2")
	local var_33_3 = arg_33_2 % 2 == 0 and var_33_2 or var_33_1

	setActive(var_33_1, var_33_3 == var_33_1)
	setActive(var_33_2, var_33_3 == var_33_2)

	local var_33_4 = var_33_3:Find("icon"):GetComponent(typeof(Image))

	LoadSpriteAsync("exploreObj/" .. var_33_0.pic, function(arg_34_0)
		var_33_4.sprite = arg_34_0

		return
	end)

	local var_33_5 = var_33_3:Find("tip")
	local var_33_6 = var_33_5:GetComponent(typeof(Text))
	local var_33_7 = var_33_3:Find("scrollrect/desc"):GetComponent(typeof(Text))
	local var_33_8 = self.gameData:IsRecordExplore(arg_33_3)

	setActive(var_33_3:Find("tipbg"), not var_33_5)

	var_33_7.text = HXSet.hxLan((var_33_8 or nil) and (var_33_0.dispaly_desc or ""))
	var_33_6.text = HXSet.hxLan(var_33_8 and "" or var_33_0.tip_desc)

	setActive(var_33_3:Find("lock"), not var_33_8)

	var_33_4.color = var_33_8 and Color.New(1, 1, 1, 1) or Color.New(1, 1, 1, 0.25)

	return
end

function DreamlandHandbookPage:InitExplorePage()
	self.exploreTrs = {}

	local var_35_0 = self.gameData:GetAllMapId()

	self.exploreList:make(function(arg_36_0, arg_36_1, arg_36_2)
		if arg_36_0 == UIItemList.EventUpdate then
			self:InitExplore(arg_36_2, var_35_0[arg_36_1 + 1])

			self.exploreTrs[var_35_0[arg_36_1 + 1]] = arg_36_2
		end

		return
	end)
	self.exploreList:align(#var_35_0)

	return
end

function DreamlandHandbookPage:UpdateExplorePage()
	if not self.isInitExplorePage then
		self:InitExplorePage()

		self.isInitExplorePage = true
	end

	for iter_37_0, iter_37_1 in pairs(self.exploreTrs) do
		local var_37_0 = self.gameData:IsUnlockMap(iter_37_0)

		setText(iter_37_1:Find("Text"), var_37_0 and self.gameData:FindMap(iter_37_0).name or "")
		setActive(iter_37_1:Find("lock"), not var_37_0)
		setToggleEnabled(iter_37_1, var_37_0)

		iter_37_1:Find("Text"):GetComponent(typeof(Text)).color = Color.New(0.3058824, 0.3058824, 0.3607843)

		setActive(iter_37_1:Find("tip"), self.gameData:IsFinishMapExplore(iter_37_0) and not self.gameData:IsReceiveExploreAward(iter_37_0))
	end

	triggerToggle(self.exploreTrs[self.selectedExploreId], true)

	return
end

function DreamlandHandbookPage:CheckAwardOverflow(arg_38_1, arg_38_2)
	local var_38_0, var_38_1 = Task.StaticJudgeOverflow(false, false, false, true, true, arg_38_1)

	if var_38_0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_ITEM_BOX,
			content = i18n("award_max_warning"),
			items = var_38_1,
			onYes = arg_38_2
		})
	else
		arg_38_2()
	end

	return
end

function DreamlandHandbookPage:UpdateDrop(arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = Drop.New({
		type = arg_39_2[1],
		id = arg_39_2[2],
		count = arg_39_2[3]
	})

	updateDrop(arg_39_1:Find("mask_1"), var_39_0)
	onButton(self, arg_39_1, function()
		self:emit(BaseUI.ON_DROP, var_39_0)

		return
	end, SFX_PANEL)
	setActive(arg_39_1:Find("mask"), arg_39_3)

	return
end

function DreamlandHandbookPage:ShowTip(arg_41_1)
	self.tipTxt.text = arg_41_1

	setActive(self.tipTr, true)
	self:AddHideTimer()

	return
end

function DreamlandHandbookPage:HideTip()
	self:RemoveHideTimer()
	setActive(self.tipTr, false)

	return
end

function DreamlandHandbookPage:AddHideTimer()
	self:RemoveHideTimer()

	self.timer = Timer.New(function()
		self:RemoveHideTimer()
		setActive(self.tipTr, false)

		self.tipTxt.text = ""

		return
	end, 3, 1)

	self.timer:Start()

	return
end

function DreamlandHandbookPage:RemoveHideTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function DreamlandHandbookPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return DreamlandHandbookPage
