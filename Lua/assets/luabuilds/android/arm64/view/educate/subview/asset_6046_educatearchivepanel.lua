local EducateArchivePanel = class("EducateArchivePanel", import("...base.BaseSubView"))

function EducateArchivePanel:getUIName()
	return "EducateArchivePanel"
end

function EducateArchivePanel:OnInit()
	self.config = pg.child_attr
	self.foldPanelTF = self._tf:Find("fold_panel")
	self.showBtn = self.foldPanelTF:Find("show_btn")
	self.showPanelTF = self._tf:Find("show_panel")
	self.showAnim = self.showPanelTF:GetComponent(typeof(Animation))
	self.showAnimEvent = self.showPanelTF:GetComponent(typeof(DftAniEvent))

	self.showAnimEvent:SetEndEvent(function()
		setActive(self.showPanelTF, false)

		return
	end)

	self.blurBg = self.showPanelTF:Find("panel")
	self.foldBtn = self.showPanelTF:Find("fold_btn")
	self.pageSnap = self.showPanelTF:Find("panel/event"):GetComponent("HScrollSnap")

	self.pageSnap:Init()

	self.page1 = self.showPanelTF:Find("panel/event/content/page1")

	setText(self.page1:Find("title/name_title/name"), i18n("child_archive_name"))
	setText(self.page1:Find("attr_title/Text"), i18n("child_attr_name1"))
	setText(self.page1:Find("buff_title/Text"), i18n("child_buff_name"))

	self.avatarImageTF = self.page1:Find("title/avatar")
	self.attrsList1 = UIItemList.New(self.page1:Find("attrs/content"), self.page1:Find("attrs/tpl"))
	self.gradientBgTF = self.page1:Find("attrs/bg_gradient")
	self.buffContentTF = self.page1:Find("buff/content")
	self.buffItemList = UIItemList.New(self.page1:Find("buff/content/content"), self.page1:Find("buff/tpl"))
	self.buffLockTF = self.page1:Find("buff/lock")
	self.page2 = self.showPanelTF:Find("panel/event/content/page2")

	setText(self.page2:Find("attr_title/Text"), i18n("child_attr_name2"))

	self.attr3UnlockTF = self.page2:Find("attrs/unlock")
	self.attr3LockTF = self.page2:Find("attrs/lock")
	self.attrsList2 = UIItemList.New(self.attr3UnlockTF:Find("content"), self.attr3UnlockTF:Find("tpl"))
	self.attr2UnlockTF = self.page2:Find("nature/unlock")
	self.attr2LockTF = self.page2:Find("nature/lock")
	self.natureContent = self.attr2UnlockTF:Find("content")
	self.avatarTF = self.page2:Find("avatar")

	self:addListener()
	self:initAttrsPanel()
	self:OverlayPanel(self._tf, {
		groupDelta = -1,
		pbList = {
			self.blurBg
		}
	})
	setActive(self.foldPanelTF, true)
	setActive(self.showPanelTF, false)

	if self.contextData and self.contextData.isShow then
		if self.contextData.isMainEnter then
			onDelayTick(function()
				self:showPanel()

				return
			end, 0.396)
		else
			self:showPanel()
		end
	end

	return
end

function EducateArchivePanel:addListener()
	onButton(self, self.showBtn, function()
		self:showPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.foldBtn, function()
		self:hidePanel()

		return
	end, SFX_PANEL)

	return
end

function EducateArchivePanel:showPanel()
	setActive(self.foldPanelTF, false)
	setActive(self.showPanelTF, true)

	return
end

function EducateArchivePanel:hidePanel()
	setActive(self.foldPanelTF, true)
	self.showAnim:Play("anim_educate_archive_show_out")

	return
end

function EducateArchivePanel:initAttrsPanel()
	self.attrsList1:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			self:updateAttr1Item(arg_11_1, arg_11_2)
		end

		return
	end)
	self.buffItemList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			self:updateBuffItem(arg_12_1, arg_12_2)
		end

		return
	end)
	self.attrsList2:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			self:updateAttr2Item(arg_13_1, arg_13_2)
		end

		return
	end)
	self:Flush()

	return
end

function EducateArchivePanel:updateAttr1Item(arg_14_1, arg_14_2)
	local var_14_0 = self.char:GetAttrGroupByType(EducateChar.ATTR_TYPE_MAJOR)[arg_14_1 + 1][1]

	GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. var_14_0, arg_14_2:Find("icon_bg/icon"), true)
	setScrollText(arg_14_2:Find("name_mask/name"), self.config[var_14_0].name)

	local var_14_1, var_14_2 = self.char:GetAttrInfo(var_14_0)

	setText(arg_14_2:Find("grade/Text"), var_14_1)
	setText(arg_14_2:Find("value"), var_14_2)
	setImageColor(self.gradientBgTF:GetChild(arg_14_1), Color.NewHex(EducateConst.GRADE_2_COLOR[var_14_1][1]))
	setImageColor(arg_14_2:Find("grade"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_14_1][2]))

	return
end

function EducateArchivePanel:updateBuffItem(arg_15_1, arg_15_2)
	local var_15_0 = self.buffList[arg_15_1 + 1]

	LoadImageSpriteAsync("educateprops/" .. self.buffList[arg_15_1 + 1]:getConfig("icon"), arg_15_2:Find("icon"))
	setText(arg_15_2:Find("time/Text"), self.buffList[arg_15_1 + 1]:GetReaminWeek() .. i18n("word_week"))
	onButton(self, arg_15_2, function()
		self:showBuffBox(var_15_0.id)

		return
	end, SFX_PANEL)

	return
end

function EducateArchivePanel:showBuffBox(arg_17_1)
	self:emit(EducateBaseUI.EDUCATE_ON_ITEM, {
		drop = {
			number = 1,
			type = EducateConst.DROP_TYPE_BUFF,
			id = arg_17_1
		}
	})

	return
end

function EducateArchivePanel:updateAttr2Item(arg_18_1, arg_18_2)
	local var_18_0 = self.char:GetAttrGroupByType(EducateChar.ATTR_TYPE_MINOR)[arg_18_1 + 1][1]

	GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. var_18_0, arg_18_2:Find("icon"), true)
	setText(arg_18_2:Find("name"), self.config[var_18_0].name)
	setText(arg_18_2:Find("value"), self.char:GetAttrById(var_18_0))

	return
end

function EducateArchivePanel:updateNature()
	for iter_19_0, iter_19_1 in ipairs(self.char:GetAttrGroupByType(EducateChar.ATTR_TYPE_PERSONALITY)) do
		local var_19_0 = self.natureContent:GetChild(iter_19_0 - 1)

		var_19_0.name = iter_19_1[1]

		setScrollText(var_19_0:Find("Text"), self.config[iter_19_1[1]].name .. " " .. iter_19_1[2])
	end

	return
end

function EducateArchivePanel:Flush()
	if not self:GetLoaded() then
		return
	end

	self.educateProxy = getProxy(EducateProxy)
	self.char = self.educateProxy:GetCharData()

	self.attrsList1:align(#self.char:GetAttrGroupByType(EducateChar.ATTR_TYPE_MAJOR))

	self.buffList = self.educateProxy:GetBuffList()

	self.buffItemList:align(#self.buffList)
	self.attrsList2:align(#self.char:GetAttrGroupByType(EducateChar.ATTR_TYPE_MINOR))

	local var_20_0 = self.char:GetPaintingName()

	setImageSprite(self.avatarImageTF, LoadSprite("educateavatar/" .. var_20_0), true)
	self:updateNature()
	setImageSprite(self.avatarTF:Find("mask/Image"), LoadSprite("squareicon/" .. var_20_0), true)
	setText(self.page1:Find("title/name/Text"), self.char:GetName())

	local var_20_1 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_BUFF)

	setActive(self.buffContentTF, var_20_1)
	setActive(self.buffLockTF, not var_20_1)

	local var_20_2 = EducateHelper.IsShowNature()

	setActive(self.attr2UnlockTF, var_20_2)
	setActive(self.attr2LockTF, not var_20_2)

	local var_20_3 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_ATTR_3)

	setActive(self.attr3UnlockTF, var_20_3)
	setActive(self.attr3LockTF, not var_20_3)
	setActive(self.showPanelTF:Find("pagination"), var_20_3)
	setActive(self.page2, var_20_3)

	self.pageSnap.enabled = var_20_3

	return
end

function EducateArchivePanel:OnDestroy()
	self:UnOverlayPanel(self._tf)

	return
end

return EducateArchivePanel
