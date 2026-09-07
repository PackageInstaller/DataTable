local EducateSiteDetailPanel = class("EducateSiteDetailPanel", import("...base.BaseSubView"))

function EducateSiteDetailPanel:getUIName()
	return "EducateSiteDetailUI"
end

function EducateSiteDetailPanel:OnInit()
	setActive(self._tf, false)

	self.anim = self._tf:Find("adapt"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("adapt"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		setActive(self._tf, false)

		if self.contextData.onExit then
			self.contextData.onExit()
		end

		return
	end)

	self.windowTF = self._tf:Find("adapt/window")
	self.closeBtn = self.windowTF:Find("close_btn")
	self.nameTF = self.windowTF:Find("name_bg/name")
	self.picTF = self.windowTF:Find("pic")
	self.descTF = self.windowTF:Find("desc")
	self.optionsTF = self.windowTF:Find("options/content")
	self.optionTpl = self.windowTF:Find("option_tpl")

	setText(self.optionTpl:Find("limit/Text"), i18n("child_option_limit"))
	setText(self.optionTpl:Find("type_2/awards/polaroid/Text"), i18n("child_random_polaroid_drop"))
	setActive(self.optionTpl, false)

	self.optionUIList = UIItemList.New(self.optionsTF, self.optionTpl)
	self.performTF = self._tf:Find("perform")
	self.performName = self.performTF:Find("name")

	self:addListener()
	self:OverlayPanel(self._tf, {
		groupDelta = -2
	})

	return
end

function EducateSiteDetailPanel:addListener()
	onButton(self, self._tf:Find("bg"), function()
		self:onClose()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:onClose()

		return
	end, SFX_PANEL)
	self.optionUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:updateOptionItem(arg_7_1, arg_7_2)
		end

		return
	end)

	self.optionIds = {}

	return
end

function EducateSiteDetailPanel:checkSpecEvent(arg_8_1, arg_8_2)
	local var_8_0 = getProxy(EducateProxy):GetEventProxy():GetSiteSpecEvents(arg_8_1)

	if #var_8_0 > 0 then
		self:emit(EducateMapMediator.ON_SPECIAL_EVENT_TRIGGER, {
			siteId = arg_8_1,
			id = var_8_0[1].id,
			callback = arg_8_2
		})
	else
		arg_8_2()
	end

	return
end

function EducateSiteDetailPanel:showSpecEvent(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = EducateHelper.GetCommonShowDrops(arg_9_3)

	local function var_9_1()
		if #var_9_0 > 0 then
			self:emit(EducateBaseUI.EDUCATE_ON_AWARD, {
				items = var_9_0,
				removeFunc = function()
					self:checkSpecEvent(arg_9_1, arg_9_4)

					return
				end
			})
		else
			self:checkSpecEvent(arg_9_1, arg_9_4)
		end

		setActive(self.performTF, false)

		return
	end

	if #pg.child_event_special[arg_9_2].performance > 0 then
		setActive(self.performTF, true)
		pg.PerformMgr.GetInstance():PlayGroup(pg.child_event_special[arg_9_2].performance, var_9_1, (EducateHelper.GetDialogueShowDrops(arg_9_3)))
	elseif var_9_1 then
		var_9_1()
	end

	return
end

function EducateSiteDetailPanel:showSiteDetailById(arg_12_1)
	if self.siteId == arg_12_1 then
		return
	end

	self.siteId = arg_12_1
	self.config = pg.child_site[self.siteId]

	self:checkSpecEvent(self.siteId, function()
		self:showDetailPanel()

		return
	end)

	return
end

function EducateSiteDetailPanel:addTaskProgress()
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in ipairs((getProxy(EducateProxy):GetTaskProxy():GetSiteEnterAddTasks(self.siteId))) do
		if iter_14_1:IsMind() then
			table.insert(var_14_0, {
				progress = 1,
				task_id = iter_14_1.id
			})
		end

		if iter_14_1:IsTarget() then
			table.insert(var_14_1, {
				progress = 1,
				task_id = iter_14_1.id
			})
		end

		if iter_14_1:IsMain() then
			table.insert(var_14_2, {
				progress = 1,
				task_id = iter_14_1.id
			})
		end
	end

	if #var_14_0 > 0 then
		self:emit(EducateMapMediator.ON_ADD_TASK_PROGRESS, {
			system = EducateTask.SYSTEM_TYPE_MIND,
			progresses = var_14_0
		})
	end

	if #var_14_1 > 0 then
		self:emit(EducateMapMediator.ON_ADD_TASK_PROGRESS, {
			system = EducateTask.SYSTEM_TYPE_TARGET,
			progresses = var_14_1
		})
	end

	if #var_14_2 > 0 then
		self:emit(EducateMapMediator.ON_ADD_TASK_PROGRESS, {
			system = EducateTask.STSTEM_TYPE_MAIN,
			progresses = var_14_2
		})
	end

	return
end

local function var_0_1(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1[2] == -1 then
		LoadImageSpriteAtlasAsync("ui/educatecommonui_atlas", "res_-1", findTF(arg_15_0, "Image"), true)
		setText(findTF(arg_15_0, "Text"), i18n("child_random_ops_drop"))
	else
		local var_15_0 = ""
		local var_15_1 = ""

		if arg_15_1[1] == EducateConst.DROP_TYPE_ATTR then
			var_15_0 = "attr_"
			var_15_1 = pg.child_attr[arg_15_1[2]].name
		elseif arg_15_1[1] == EducateConst.DROP_TYPE_RES then
			var_15_0 = "res_"
			var_15_1 = pg.child_resource[arg_15_1[2]].name
		end

		LoadImageSpriteAtlasAsync("ui/educatecommonui_atlas", var_15_0 .. arg_15_1[2], findTF(arg_15_0, "Image"), true)
		setText(findTF(arg_15_0, "Text"), var_15_1 .. "+" .. arg_15_1[3])
	end

	return
end

local function var_0_2(arg_16_0, arg_16_1)
	local var_16_0 = ""

	if arg_16_1[1] == EducateConst.DROP_TYPE_ATTR then
		var_16_0 = "attr_"
	elseif arg_16_1[1] == EducateConst.DROP_TYPE_RES then
		var_16_0 = "res_"
	end

	LoadImageSpriteAtlasAsync("ui/educatecommonui_atlas", var_16_0 .. arg_16_1[2], findTF(arg_16_0, "Image"), true)
	setText(findTF(arg_16_0, "Text"), "-" .. arg_16_1[3])

	return
end

function EducateSiteDetailPanel:updateOptionItem(arg_17_1, arg_17_2)
	GetOrAddComponent(arg_17_2, "CanvasGroup").alpha = 1
	arg_17_2.name = tostring(arg_17_1 + 1)

	local var_17_0 = self.optionVOs[arg_17_1 + 1]

	setActive(arg_17_2:Find("limit"), self.optionVOs[arg_17_1 + 1]:IsShowLimit())

	local var_17_1 = self.optionVOs[arg_17_1 + 1]:GetType()

	for iter_17_0 = 1, 3 do
		setActive(arg_17_2:Find("type_" .. iter_17_0), iter_17_0 == var_17_1)
	end

	local var_17_2 = arg_17_2:Find("type_" .. var_17_1)
	local var_17_3 = not self.optionVOs[arg_17_1 + 1]:IsCountLimit() and true or self.optionVOs[arg_17_1 + 1]:CanTrigger()

	setGray(arg_17_2, not var_17_3)
	switch(var_17_1, {
		[EducateSiteOption.TYPE_SHOP] = function()
			setText(var_17_2:Find("name/Text"), var_17_0:getConfig("name"))
			onButton(self, arg_17_2, function()
				self:emit(EducateMapMediator.ON_OPEN_SHOP, var_17_0:GetLinkId())

				return
			end, SFX_PANEL)

			return
		end,
		[EducateSiteOption.TYPE_EVENT] = function()
			setText(var_17_2:Find("name"), shortenString(var_17_0:getConfig("name") .. var_17_0:GetCntText(), 12))

			local var_20_0 = var_17_0:IsShowPolaroid()

			setActive(var_17_2:Find("awards/polaroid"), var_20_0)

			local var_20_1 = var_20_0 and 2 or 3
			local var_20_2 = var_17_0:GetResults()
			local var_20_3 = UIItemList.New(var_17_2:Find("awards/normal"), var_17_2:Find("awards/normal/tpl"))

			var_20_3:make(function(arg_21_0, arg_21_1, arg_21_2)
				if arg_21_0 == UIItemList.EventUpdate then
					var_0_1(arg_21_2, var_20_2[arg_21_1 + 1])
				end

				return
			end)
			var_20_3:align(var_20_1 < #var_20_2 and var_20_1 or #var_20_2)

			local var_20_4 = var_17_0:GetCost()
			local var_20_5 = UIItemList.New(var_17_2:Find("costs"), var_17_2:Find("costs/tpl"))

			var_20_5:make(function(arg_22_0, arg_22_1, arg_22_2)
				if arg_22_0 == UIItemList.EventUpdate then
					var_0_2(arg_22_2, var_20_4[arg_22_1 + 1], "-")
				end

				return
			end)
			var_20_5:align(#var_20_4)
			onButton(self, arg_17_2, function()
				if not var_17_3 then
					return
				end

				self:emit(EducateMapMediator.ON_MAP_SITE_OPERATE, {
					siteId = self.siteId,
					optionVO = var_17_0
				})

				return
			end, SFX_PANEL)

			return
		end,
		[EducateSiteOption.TYPE_SITE] = function()
			setText(var_17_2:Find("name/Text"), var_17_0:getConfig("name"))
			onButton(self, arg_17_2, function()
				local var_25_0 = var_17_0:GetLinkId()

				assert(pg.child_site[var_25_0], "child_site不存在id:" .. var_25_0)
				table.insert(self.siteQueue, var_25_0)
				self:showSiteDetailById(var_25_0)

				return
			end, SFX_PANEL)

			return
		end
	})

	return
end

function EducateSiteDetailPanel:showDetailPanel()
	self:addTaskProgress()
	setActive(self.windowTF, true)
	setText(self.nameTF, self.config.name)
	setText(self.descTF, self.config.desc)
	LoadImageSpriteAsync("educatesite/" .. self.config.pic, self.picTF, true)

	self.optionVOs = getProxy(EducateProxy):GetOptionsBySiteId(self.siteId)

	self.optionUIList:align(#self.optionVOs)

	return
end

function EducateSiteDetailPanel:showSitePerform(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	local var_27_0 = EducateHelper.GetDialogueShowDrops(arg_27_4)
	local var_27_1 = EducateHelper.GetDialogueShowDrops(arg_27_5)
	local var_27_2 = table.mergeArray(EducateHelper.GetCommonShowDrops(arg_27_4), EducateHelper.GetCommonShowDrops(arg_27_5))
	local var_27_3 = {}
	local var_27_4 = pg.child_site_option_branch[arg_27_2].performance
	local var_27_5 = pg.child_site_option[arg_27_1].name

	table.insert(var_27_3, function(arg_28_0)
		pg.PerformMgr.GetInstance():PlayGroupNoHide(var_27_4, arg_28_0, var_27_0, var_27_5)

		return
	end)

	if arg_27_3 and #arg_27_3 > 0 then
		for iter_27_0, iter_27_1 in ipairs(arg_27_3) do
			local var_27_6 = pg.child_event[iter_27_1].performance

			table.insert(var_27_3, function(arg_29_0)
				pg.PerformMgr.GetInstance():PlayGroupNoHide(var_27_6, arg_29_0, var_27_1)

				return
			end)
		end
	end

	setText(self.performName, pg.child_site_option[arg_27_1].name)
	setActive(self.performTF, true)
	pg.PerformMgr.GetInstance():Show()
	seriesAsync(var_27_3, function()
		setActive(self.performTF, false)

		if #var_27_2 > 0 then
			self:emit(EducateBaseUI.EDUCATE_ON_AWARD, {
				items = var_27_2
			})
		end

		pg.PerformMgr.GetInstance():Hide()
		self:showDetailPanel()

		return
	end)

	return
end

function EducateSiteDetailPanel:Hide()
	self.anim:Play("anim_educate_sitedatail_out")

	return
end

function EducateSiteDetailPanel:Show(arg_32_1)
	if not self:GetLoaded() then
		return
	end

	self.siteId = arg_32_1
	self.config = pg.child_site[self.siteId]

	assert(self.config, "child_site不存在id:" .. self.siteId)
	setActive(self._tf, true)
	setActive(self.windowTF, false)

	self.siteQueue = {
		self.siteId
	}

	self:checkSpecEvent(self.siteId, function()
		self:showDetailPanel()

		if self.contextData.onEnter then
			self.contextData.onEnter()
		end

		return
	end)
	EducateTipHelper.ClearNewTip(EducateTipHelper.NEW_SITE, self.siteId)

	return
end

function EducateSiteDetailPanel:onClose()
	if #self.siteQueue > 1 then
		table.remove(self.siteQueue, #self.siteQueue)
		self:showSiteDetailById(self.siteQueue[#self.siteQueue])
	else
		self:Hide()
	end

	return
end

function EducateSiteDetailPanel:OnDestroy()
	self.animEvent:SetEndEvent(nil)
	self:UnOverlayPanel(self._tf)

	return
end

return EducateSiteDetailPanel
