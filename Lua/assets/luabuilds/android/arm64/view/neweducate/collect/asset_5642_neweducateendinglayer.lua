local NewEducateEndingLayer = class("NewEducateEndingLayer", import(".NewEducateCollectLayerTemplate"))

function NewEducateEndingLayer:getUIName()
	return "NewEducateEndingUI"
end

function NewEducateEndingLayer:initConfig()
	self.config = pg.child2_ending
	self.allIds = self.contextData.permanentData:GetAllEndingIds()
	self.unlockIds = self.contextData.permanentData:GetActivatedEndings()
	self.finishedIds = self.contextData.permanentData:GetFinishedEndings()
	self.char = getProxy(NewEducateProxy):GetChar(self.contextData.permanentData.id)

	return
end

function NewEducateEndingLayer:didEnter()
	onButton(self, self._tf:Find("anim_root/close"), function()
		self:PlayAnimClose()

		return
	end, SFX_PANEL)
	self:InitPageInfo()
	setText(self.performTF:Find("review_btn/Text"), i18n("child_btn_review"))
	setText(self.curCntTF, #self.unlockIds)
	setText(self.allCntTF, "/" .. #self.allIds)

	self.toggleTF = self.windowTF:Find("toggle")

	setText(self.toggleTF:Find("on/Text"), i18n("child2_endings_toggle_on"))
	setText(self.toggleTF:Find("off/Text"), i18n("child2_endings_toggle_off"))

	self.tpl = self.windowTF:Find("condition_tpl")

	onToggle(self, self.toggleTF, function(arg_5_0)
		self:UpdatePage()

		return
	end, SFX_PANEL)
	self:UpdatePage()

	return
end

function NewEducateEndingLayer:UpdateItem(arg_6_1, arg_6_2)
	local var_6_0 = self.config[arg_6_1]
	local var_6_1 = table.contains(self.unlockIds, self.config[arg_6_1].id)

	setActive(arg_6_2:Find("unlock"), var_6_1)
	setActive(arg_6_2:Find("lock"), not var_6_1)
	setActive(arg_6_2:Find("finished"), table.contains(self.finishedIds, var_6_0.id))
	setText(arg_6_2:Find("name"), (var_6_1 or nil) and (var_6_0.name or "???"))

	if var_6_1 then
		LoadImageSpriteAsync("bg/" .. var_6_0.pic, arg_6_2:Find("unlock/mask/Image"))
		onButton(self, arg_6_2, function()
			self:ShowPerformWindow(var_6_0)

			return
		end, SFX_PANEL)
	end

	local var_6_3

	do
		removeOnButton(arg_6_2)

		var_6_3 = {}
	end

	if self.toggleTF:GetComponent(typeof(Toggle)).isOn then
		setActive(arg_6_2:Find("lock"), true)
		setActive(arg_6_2:Find("lock/icon"), not var_6_1)
		setActive(arg_6_2:Find("mask"), var_6_1)

		var_6_3 = var_6_0.condition_desc
	else
		setActive(arg_6_2:Find("mask"), false)
	end

	self:UpdateConditions(var_6_3, arg_6_2:Find("lock/conditions"))

	return
end

function NewEducateEndingLayer:UpdateConditions(arg_8_1, arg_8_2)
	local var_8_0 = 0

	for iter_8_0 = 1, #arg_8_1 do
		local var_8_1 = arg_8_1[iter_8_0]

		var_8_0 = var_8_0 + 1

		local var_8_2 = iter_8_0 <= arg_8_2.childCount and arg_8_2:GetChild(iter_8_0 - 1) or cloneTplTo(self.tpl, arg_8_2)
		local var_8_3 = self.char:LogicalOperator({
			operator = "||",
			conditions = arg_8_1[iter_8_0][1]
		})

		setActive(var_8_2:Find("icon/unlock"), var_8_3)
		setTextColor(var_8_2:Find("Text"), Color.NewHex(var_8_3 and "F59F48" or "888888"))
		setText(var_8_2:Find("Text"), var_8_1[2])
	end

	for iter_8_1 = 1, arg_8_2.childCount do
		setActive(arg_8_2:GetChild(iter_8_1 - 1), iter_8_1 <= var_8_0)
	end

	return
end

function NewEducateEndingLayer:ShowPerformWindow(arg_9_1)
	local var_9_0 = self.performTF:Find("Image")

	LoadImageSpriteAsync("bg/" .. arg_9_1.pic, var_9_0)
	setActive(self.performTF, true)
	onButton(self, var_9_0, function()
		setActive(self.performTF, false)

		return
	end, SFX_PANEL)
	onButton(self, self.performTF:Find("review_btn"), function()
		pg.NewStoryMgr.GetInstance():Play(arg_9_1.performance, nil, true)

		return
	end, SFX_PANEL)

	return
end

function NewEducateEndingLayer:PlayAnimChange()
	self.anim:Stop()
	self.anim:Play("anim_educate_ending_change")

	return
end

function NewEducateEndingLayer:PlayAnimClose()
	self.anim:Play("anim_educate_ending_out")

	return
end

return NewEducateEndingLayer
