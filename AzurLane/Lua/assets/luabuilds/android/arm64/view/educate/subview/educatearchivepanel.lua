local var_0_0 = class("EducateArchivePanel", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "EducateArchivePanel"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.config = pg.child_attr
	arg_2_0.foldPanelTF = arg_2_0._tf:Find("fold_panel")
	arg_2_0.showBtn = arg_2_0.foldPanelTF:Find("show_btn")
	arg_2_0.showPanelTF = arg_2_0._tf:Find("show_panel")
	arg_2_0.showAnim = arg_2_0.showPanelTF:GetComponent(typeof(Animation))
	arg_2_0.showAnimEvent = arg_2_0.showPanelTF:GetComponent(typeof(DftAniEvent))

	arg_2_0.showAnimEvent:SetEndEvent(function()
		setActive(arg_2_0.showPanelTF, false)

		return
	end)

	arg_2_0.blurBg = arg_2_0.showPanelTF:Find("panel")
	arg_2_0.foldBtn = arg_2_0.showPanelTF:Find("fold_btn")
	arg_2_0.pageSnap = arg_2_0.showPanelTF:Find("panel/event"):GetComponent("HScrollSnap")

	arg_2_0.pageSnap:Init()

	arg_2_0.page1 = arg_2_0.showPanelTF:Find("panel/event/content/page1")

	setText(arg_2_0.page1:Find("title/name_title/name"), i18n("child_archive_name"))
	setText(arg_2_0.page1:Find("attr_title/Text"), i18n("child_attr_name1"))
	setText(arg_2_0.page1:Find("buff_title/Text"), i18n("child_buff_name"))

	arg_2_0.avatarImageTF = arg_2_0.page1:Find("title/avatar")
	arg_2_0.attrsList1 = UIItemList.New(arg_2_0.page1:Find("attrs/content"), arg_2_0.page1:Find("attrs/tpl"))
	arg_2_0.gradientBgTF = arg_2_0.page1:Find("attrs/bg_gradient")
	arg_2_0.buffContentTF = arg_2_0.page1:Find("buff/content")
	arg_2_0.buffItemList = UIItemList.New(arg_2_0.page1:Find("buff/content/content"), arg_2_0.page1:Find("buff/tpl"))
	arg_2_0.buffLockTF = arg_2_0.page1:Find("buff/lock")
	arg_2_0.page2 = arg_2_0.showPanelTF:Find("panel/event/content/page2")

	setText(arg_2_0.page2:Find("attr_title/Text"), i18n("child_attr_name2"))

	arg_2_0.attr3UnlockTF = arg_2_0.page2:Find("attrs/unlock")
	arg_2_0.attr3LockTF = arg_2_0.page2:Find("attrs/lock")
	arg_2_0.attrsList2 = UIItemList.New(arg_2_0.attr3UnlockTF:Find("content"), arg_2_0.attr3UnlockTF:Find("tpl"))
	arg_2_0.attr2UnlockTF = arg_2_0.page2:Find("nature/unlock")
	arg_2_0.attr2LockTF = arg_2_0.page2:Find("nature/lock")
	arg_2_0.natureContent = arg_2_0.attr2UnlockTF:Find("content")
	arg_2_0.avatarTF = arg_2_0.page2:Find("avatar")

	arg_2_0:addListener()
	arg_2_0:initAttrsPanel()
	arg_2_0:OverlayPanel(arg_2_0._tf, {
		groupDelta = -1,
		pbList = {
			arg_2_0.blurBg
		}
	})
	setActive(arg_2_0.foldPanelTF, true)
	setActive(arg_2_0.showPanelTF, false)

	if arg_2_0.contextData and arg_2_0.contextData.isShow then
		if arg_2_0.contextData.isMainEnter then
			onDelayTick(function()
				arg_2_0:showPanel()

				return
			end, 0.396)
		else
			arg_2_0:showPanel()
		end
	end

	return
end

function var_0_0.addListener(arg_5_0)
	onButton(arg_5_0, arg_5_0.showBtn, function()
		arg_5_0:showPanel()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.foldBtn, function()
		arg_5_0:hidePanel()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.showPanel(arg_8_0)
	setActive(arg_8_0.foldPanelTF, false)
	setActive(arg_8_0.showPanelTF, true)

	return
end

function var_0_0.hidePanel(arg_9_0)
	setActive(arg_9_0.foldPanelTF, true)
	arg_9_0.showAnim:Play("anim_educate_archive_show_out")

	return
end

function var_0_0.initAttrsPanel(arg_10_0)
	arg_10_0.attrsList1:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			arg_10_0:updateAttr1Item(arg_11_1, arg_11_2)
		end

		return
	end)
	arg_10_0.buffItemList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			arg_10_0:updateBuffItem(arg_12_1, arg_12_2)
		end

		return
	end)
	arg_10_0.attrsList2:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			arg_10_0:updateAttr2Item(arg_13_1, arg_13_2)
		end

		return
	end)
	arg_10_0:Flush()

	return
end

function var_0_0.updateAttr1Item(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.char:GetAttrGroupByType(EducateChar.ATTR_TYPE_MAJOR)[arg_14_1 + 1][1]

	GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. var_14_0, arg_14_2:Find("icon_bg/icon"), true)
	setScrollText(arg_14_2:Find("name_mask/name"), arg_14_0.config[var_14_0].name)

	local var_14_1, var_14_2 = arg_14_0.char:GetAttrInfo(var_14_0)

	setText(arg_14_2:Find("grade/Text"), var_14_1)
	setText(arg_14_2:Find("value"), var_14_2)
	setImageColor(arg_14_0.gradientBgTF:GetChild(arg_14_1), Color.NewHex(EducateConst.GRADE_2_COLOR[var_14_1][1]))
	setImageColor(arg_14_2:Find("grade"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_14_1][2]))

	return
end

function var_0_0.updateBuffItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.buffList[arg_15_1 + 1]

	LoadImageSpriteAsync("educateprops/" .. arg_15_0.buffList[arg_15_1 + 1]:getConfig("icon"), arg_15_2:Find("icon"))
	setText(arg_15_2:Find("time/Text"), arg_15_0.buffList[arg_15_1 + 1]:GetReaminWeek() .. i18n("word_week"))
	onButton(arg_15_0, arg_15_2, function()
		arg_15_0:showBuffBox(var_15_0.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.showBuffBox(arg_17_0, arg_17_1)
	arg_17_0:emit(EducateBaseUI.EDUCATE_ON_ITEM, {
		drop = {
			number = 1,
			type = EducateConst.DROP_TYPE_BUFF,
			id = arg_17_1
		}
	})

	return
end

function var_0_0.updateAttr2Item(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.char:GetAttrGroupByType(EducateChar.ATTR_TYPE_MINOR)[arg_18_1 + 1][1]

	GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. var_18_0, arg_18_2:Find("icon"), true)
	setText(arg_18_2:Find("name"), arg_18_0.config[var_18_0].name)
	setText(arg_18_2:Find("value"), arg_18_0.char:GetAttrById(var_18_0))

	return
end

function var_0_0.updateNature(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.char:GetAttrGroupByType(EducateChar.ATTR_TYPE_PERSONALITY)) do
		local var_19_0 = arg_19_0.natureContent:GetChild(iter_19_0 - 1)

		var_19_0.name = iter_19_1[1]

		setScrollText(var_19_0:Find("Text"), arg_19_0.config[iter_19_1[1]].name .. " " .. iter_19_1[2])
	end

	return
end

function var_0_0.Flush(arg_20_0)
	if not arg_20_0:GetLoaded() then
		return
	end

	arg_20_0.educateProxy = getProxy(EducateProxy)
	arg_20_0.char = arg_20_0.educateProxy:GetCharData()

	arg_20_0.attrsList1:align(#arg_20_0.char:GetAttrGroupByType(EducateChar.ATTR_TYPE_MAJOR))

	arg_20_0.buffList = arg_20_0.educateProxy:GetBuffList()

	arg_20_0.buffItemList:align(#arg_20_0.buffList)
	arg_20_0.attrsList2:align(#arg_20_0.char:GetAttrGroupByType(EducateChar.ATTR_TYPE_MINOR))

	local var_20_0 = arg_20_0.char:GetPaintingName()

	setImageSprite(arg_20_0.avatarImageTF, LoadSprite("educateavatar/" .. var_20_0), true)
	arg_20_0:updateNature()
	setImageSprite(arg_20_0.avatarTF:Find("mask/Image"), LoadSprite("squareicon/" .. var_20_0), true)
	setText(arg_20_0.page1:Find("title/name/Text"), arg_20_0.char:GetName())

	local var_20_1 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_BUFF)

	setActive(arg_20_0.buffContentTF, var_20_1)
	setActive(arg_20_0.buffLockTF, not var_20_1)

	local var_20_2 = EducateHelper.IsShowNature()

	setActive(arg_20_0.attr2UnlockTF, var_20_2)
	setActive(arg_20_0.attr2LockTF, not var_20_2)

	local var_20_3 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_ATTR_3)

	setActive(arg_20_0.attr3UnlockTF, var_20_3)
	setActive(arg_20_0.attr3LockTF, not var_20_3)
	setActive(arg_20_0.showPanelTF:Find("pagination"), var_20_3)
	setActive(arg_20_0.page2, var_20_3)

	arg_20_0.pageSnap.enabled = var_20_3

	return
end

function var_0_0.OnDestroy(arg_21_0)
	arg_21_0:UnOverlayPanel(arg_21_0._tf)

	return
end

return var_0_0
