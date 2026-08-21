local var_0_0 = class("EducateSiteDetailPanel", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "EducateSiteDetailUI"
end

function var_0_0.OnInit(arg_2_0)
	setActive(arg_2_0._tf, false)

	arg_2_0.anim = arg_2_0._tf:Find("adapt"):GetComponent(typeof(Animation))
	arg_2_0.animEvent = arg_2_0._tf:Find("adapt"):GetComponent(typeof(DftAniEvent))

	arg_2_0.animEvent:SetEndEvent(function()
		setActive(arg_2_0._tf, false)

		if arg_2_0.contextData.onExit then
			arg_2_0.contextData.onExit()
		end

		return
	end)

	arg_2_0.windowTF = arg_2_0._tf:Find("adapt/window")
	arg_2_0.closeBtn = arg_2_0.windowTF:Find("close_btn")
	arg_2_0.nameTF = arg_2_0.windowTF:Find("name_bg/name")
	arg_2_0.picTF = arg_2_0.windowTF:Find("pic")
	arg_2_0.descTF = arg_2_0.windowTF:Find("desc")
	arg_2_0.optionsTF = arg_2_0.windowTF:Find("options/content")
	arg_2_0.optionTpl = arg_2_0.windowTF:Find("option_tpl")

	setText(arg_2_0.optionTpl:Find("limit/Text"), i18n("child_option_limit"))
	setText(arg_2_0.optionTpl:Find("type_2/awards/polaroid/Text"), i18n("child_random_polaroid_drop"))
	setActive(arg_2_0.optionTpl, false)

	arg_2_0.optionUIList = UIItemList.New(arg_2_0.optionsTF, arg_2_0.optionTpl)
	arg_2_0.performTF = arg_2_0._tf:Find("perform")
	arg_2_0.performName = arg_2_0.performTF:Find("name")

	arg_2_0:addListener()
	arg_2_0:OverlayPanel(arg_2_0._tf, {
		groupDelta = -2
	})

	return
end

function var_0_0.addListener(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("bg"), function()
		arg_4_0:onClose()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.closeBtn, function()
		arg_4_0:onClose()

		return
	end, SFX_PANEL)
	arg_4_0.optionUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_4_0:updateOptionItem(arg_7_1, arg_7_2)
		end

		return
	end)

	arg_4_0.optionIds = {}

	return
end

function var_0_0.checkSpecEvent(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = getProxy(EducateProxy):GetEventProxy():GetSiteSpecEvents(arg_8_1)

	if #var_8_0 > 0 then
		arg_8_0:emit(EducateMapMediator.ON_SPECIAL_EVENT_TRIGGER, {
			siteId = arg_8_1,
			id = var_8_0[1].id,
			callback = arg_8_2
		})
	else
		arg_8_2()
	end

	return
end

function var_0_0.showSpecEvent(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = EducateHelper.GetCommonShowDrops(arg_9_3)

	if #pg.child_event_special[arg_9_2].performance > 0 then
		setActive(arg_9_0.performTF, true)
		pg.PerformMgr.GetInstance():PlayGroup(pg.child_event_special[arg_9_2].performance, function()
			if #var_9_0 > 0 then
				arg_9_0:emit(EducateBaseUI.EDUCATE_ON_AWARD, {
					items = var_9_0,
					removeFunc = function()
						arg_9_0:checkSpecEvent(arg_9_1, arg_9_4)

						return
					end
				})
			else
				arg_9_0:checkSpecEvent(arg_9_1, arg_9_4)
			end

			setActive(arg_9_0.performTF, false)

			return
		end, (EducateHelper.GetDialogueShowDrops(arg_9_3)))
	elseif function()
		if #var_9_0 > 0 then
			arg_9_0:emit(EducateBaseUI.EDUCATE_ON_AWARD, {
				items = var_9_0,
				removeFunc = function()
					arg_9_0:checkSpecEvent(arg_9_1, arg_9_4)

					return
				end
			})
		else
			arg_9_0:checkSpecEvent(arg_9_1, arg_9_4)
		end

		setActive(arg_9_0.performTF, false)

		return
	end then
		(function()
			if #var_9_0 > 0 then
				arg_9_0:emit(EducateBaseUI.EDUCATE_ON_AWARD, {
					items = var_9_0,
					removeFunc = function()
						arg_9_0:checkSpecEvent(arg_9_1, arg_9_4)

						return
					end
				})
			else
				arg_9_0:checkSpecEvent(arg_9_1, arg_9_4)
			end

			setActive(arg_9_0.performTF, false)

			return
		end)()
	end

	return
end

function var_0_0.showSiteDetailById(arg_12_0, arg_12_1)
	if arg_12_0.siteId == arg_12_1 then
		return
	end

	arg_12_0.siteId = arg_12_1
	arg_12_0.config = pg.child_site[arg_12_0.siteId]

	arg_12_0:checkSpecEvent(arg_12_0.siteId, function()
		arg_12_0:showDetailPanel()

		return
	end)

	return
end

function var_0_0.addTaskProgress(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs((getProxy(EducateProxy):GetTaskProxy():GetSiteEnterAddTasks(arg_14_0.siteId))) do
		if iter_14_1:IsMind() then
			table.insert({}, {
				progress = 1,
				task_id = iter_14_1.id
			})
		end

		if iter_14_1:IsTarget() then
			table.insert({}, {
				progress = 1,
				task_id = iter_14_1.id
			})
		end

		if iter_14_1:IsMain() then
			table.insert({}, {
				progress = 1,
				task_id = iter_14_1.id
			})
		end
	end

	if #{} > 0 then
		arg_14_0:emit(EducateMapMediator.ON_ADD_TASK_PROGRESS, {
			system = EducateTask.SYSTEM_TYPE_MIND,
			progresses = {}
		})
	end

	if #{} > 0 then
		arg_14_0:emit(EducateMapMediator.ON_ADD_TASK_PROGRESS, {
			system = EducateTask.SYSTEM_TYPE_TARGET,
			progresses = {}
		})
	end

	if #{} > 0 then
		arg_14_0:emit(EducateMapMediator.ON_ADD_TASK_PROGRESS, {
			system = EducateTask.STSTEM_TYPE_MAIN,
			progresses = {}
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

function var_0_0.updateOptionItem(arg_17_0, arg_17_1, arg_17_2)
	GetOrAddComponent(arg_17_2, "CanvasGroup").alpha = 1
	arg_17_2.name = tostring(arg_17_1 + 1)

	local var_17_0 = arg_17_0.optionVOs[arg_17_1 + 1]

	setActive(arg_17_2:Find("limit"), arg_17_0.optionVOs[arg_17_1 + 1]:IsShowLimit())

	local var_17_1 = var_17_0:GetType()

	for iter_17_0 = 1, 3 do
		setActive(arg_17_2:Find("type_" .. iter_17_0), iter_17_0 == var_17_1)
	end

	local var_17_2 = arg_17_2:Find("type_" .. var_17_1)

	setGray(arg_17_2, not (not var_17_0:IsCountLimit() and true or var_17_0:CanTrigger()))
	switch(var_17_1, {
		[EducateSiteOption.TYPE_SHOP] = function()
			setText(var_17_2:Find("name/Text"), var_17_0:getConfig("name"))
			onButton(arg_17_0, arg_17_2, function()
				arg_17_0:emit(EducateMapMediator.ON_OPEN_SHOP, var_17_0:GetLinkId())

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
			var_20_5:align(#var_17_0:GetCost())
			onButton(arg_17_0, arg_17_2, function()
				if not var_0 then
					return
				end

				arg_17_0:emit(EducateMapMediator.ON_MAP_SITE_OPERATE, {
					siteId = arg_17_0.siteId,
					optionVO = var_17_0
				})

				return
			end, SFX_PANEL)

			return
		end,
		[EducateSiteOption.TYPE_SITE] = function()
			setText(var_17_2:Find("name/Text"), var_17_0:getConfig("name"))
			onButton(arg_17_0, arg_17_2, function()
				local var_25_0 = var_17_0:GetLinkId()

				assert(pg.child_site[var_25_0], "child_site不存在id:" .. var_25_0)
				table.insert(arg_17_0.siteQueue, var_25_0)
				arg_17_0:showSiteDetailById(var_25_0)

				return
			end, SFX_PANEL)

			return
		end
	})

	return
end

function var_0_0.showDetailPanel(arg_26_0)
	arg_26_0:addTaskProgress()
	setActive(arg_26_0.windowTF, true)
	setText(arg_26_0.nameTF, arg_26_0.config.name)
	setText(arg_26_0.descTF, arg_26_0.config.desc)
	LoadImageSpriteAsync("educatesite/" .. arg_26_0.config.pic, arg_26_0.picTF, true)

	arg_26_0.optionVOs = getProxy(EducateProxy):GetOptionsBySiteId(arg_26_0.siteId)

	arg_26_0.optionUIList:align(#arg_26_0.optionVOs)

	return
end

function var_0_0.showSitePerform(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	local var_27_0 = EducateHelper.GetDialogueShowDrops(arg_27_4)
	local var_27_1 = EducateHelper.GetDialogueShowDrops(arg_27_5)
	local var_27_2 = table.mergeArray(EducateHelper.GetCommonShowDrops(arg_27_4), EducateHelper.GetCommonShowDrops(arg_27_5))
	local var_27_3 = pg.child_site_option_branch[arg_27_2].performance
	local var_27_4 = pg.child_site_option[arg_27_1].name

	table.insert({}, function(arg_28_0)
		pg.PerformMgr.GetInstance():PlayGroupNoHide(var_27_3, arg_28_0, var_27_0, var_27_4)

		return
	end)

	if arg_27_3 and #arg_27_3 > 0 then
		for iter_27_0, iter_27_1 in ipairs(arg_27_3) do
			local var_27_5 = pg.child_event[iter_27_1].performance

			table.insert({}, function(arg_29_0)
				pg.PerformMgr.GetInstance():PlayGroupNoHide(var_27_5, arg_29_0, var_27_1)

				return
			end)
		end
	end

	setText(arg_27_0.performName, pg.child_site_option[arg_27_1].name)
	setActive(arg_27_0.performTF, true)
	pg.PerformMgr.GetInstance():Show()
	seriesAsync({}, function()
		setActive(arg_27_0.performTF, false)

		if #var_27_2 > 0 then
			arg_27_0:emit(EducateBaseUI.EDUCATE_ON_AWARD, {
				items = var_27_2
			})
		end

		pg.PerformMgr.GetInstance():Hide()
		arg_27_0:showDetailPanel()

		return
	end)

	return
end

function var_0_0.Hide(arg_31_0)
	arg_31_0.anim:Play("anim_educate_sitedatail_out")

	return
end

function var_0_0.Show(arg_32_0, arg_32_1)
	if not arg_32_0:GetLoaded() then
		return
	end

	arg_32_0.siteId = arg_32_1
	arg_32_0.config = pg.child_site[arg_32_0.siteId]

	assert(arg_32_0.config, "child_site不存在id:" .. arg_32_0.siteId)
	setActive(arg_32_0._tf, true)
	setActive(arg_32_0.windowTF, false)

	arg_32_0.siteQueue = {
		arg_32_0.siteId
	}

	arg_32_0:checkSpecEvent(arg_32_0.siteId, function()
		arg_32_0:showDetailPanel()

		if arg_32_0.contextData.onEnter then
			arg_32_0.contextData.onEnter()
		end

		return
	end)
	EducateTipHelper.ClearNewTip(EducateTipHelper.NEW_SITE, arg_32_0.siteId)

	return
end

function var_0_0.onClose(arg_34_0)
	if #arg_34_0.siteQueue > 1 then
		table.remove(arg_34_0.siteQueue, #arg_34_0.siteQueue)
		arg_34_0:showSiteDetailById(arg_34_0.siteQueue[#arg_34_0.siteQueue])
	else
		arg_34_0:Hide()
	end

	return
end

function var_0_0.OnDestroy(arg_35_0)
	arg_35_0.animEvent:SetEndEvent(nil)
	arg_35_0:UnOverlayPanel(arg_35_0._tf)

	return
end

return var_0_0
