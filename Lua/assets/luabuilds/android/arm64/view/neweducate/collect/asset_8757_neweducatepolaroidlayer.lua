local NewEducatePolaroidLayer = class("NewEducatePolaroidLayer", import(".NewEducateCollectLayerTemplate"))

function NewEducatePolaroidLayer:getUIName()
	return "NewEducatePolaroidUI"
end

function NewEducatePolaroidLayer:initConfig()
	self.config = pg.child2_polaroid
	self.allIds = self.contextData.permanentData:GetAllPolaroidGroups()
	self.unlockIds = self.contextData.permanentData:GetUnlockPolaroidGroups()
	self.polaroidGroup2Ids = self.contextData.permanentData:GetPolaroidGroup2Ids()
	self.polaroids = self.contextData.permanentData:GetPolaroids()

	return
end

function NewEducatePolaroidLayer:didEnter()
	self:InitPageInfo()
	setText(self.curCntTF, #self.unlockIds)
	setText(self.allCntTF, "/" .. #self.allIds)
	onButton(self, self.performTF, function()
		setActive(self.performTF, false)

		return
	end, SFX_PANEL)
	self:InitShowList()
	self:UpdatePage()

	return
end

function NewEducatePolaroidLayer:InitShowList()
	self.showIds = {}
	self.selectedIndex = 1
	self.groupsTF = self.performTF:Find("bg/groups")
	self.showList = UIItemList.New(self.groupsTF, self.groupsTF:Find("tpl"))

	self.showList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = self.showIds[arg_6_1 + 1]
			local var_6_1 = self:IsUnlock(self.showIds[arg_6_1 + 1])

			setText(arg_6_2:Find("unlock/unselected/Text"), self.showIds[arg_6_1 + 1])
			setText(arg_6_2:Find("unlock/selected/Text"), self.showIds[arg_6_1 + 1])
			setActive(arg_6_2:Find("lock"), not var_6_1)
			setActive(arg_6_2:Find("unlock"), var_6_1)
			setActive(arg_6_2:Find("unlock/selected"), self.selectedIndex == arg_6_1 + 1)
			setActive(arg_6_2:Find("unlock/unselected"), self.selectedIndex ~= arg_6_1 + 1)
			onButton(self, arg_6_2, function(arg_7_0)
				if var_6_1 then
					self.selectedIndex = arg_6_1 + 1

					self:UpdatePerform(var_6_0)
					self.showList:align(#self.showIds)
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("child_polaroid_lock_tip"))
				end

				return
			end)
		end

		return
	end)

	return
end

function NewEducatePolaroidLayer:IsUnlock(arg_8_1)
	return true
end

function NewEducatePolaroidLayer:UpdateItem(arg_9_1, arg_9_2)
	local var_9_0 = self.polaroidGroup2Ids[arg_9_1]

	table.sort(self.polaroidGroup2Ids[arg_9_1], CompareFuncs({
		function(arg_10_0)
			return table.contains(self.polaroids, arg_10_0) and 0 or 1
		end,
		function(arg_11_0)
			return arg_11_0
		end
	}))

	local var_9_1 = table.contains(self.unlockIds, arg_9_1)

	setActive(arg_9_2:Find("lock"), not var_9_1)
	setActive(arg_9_2:Find("unlock"), var_9_1)

	if var_9_1 then
		LoadImageSpriteAsync("neweducateicon/" .. self.config[self.polaroidGroup2Ids[arg_9_1][1]].pic, arg_9_2:Find("unlock/mask/Image"), true)
		setText(arg_9_2:Find("unlock/name"), self.config[self.polaroidGroup2Ids[arg_9_1][1]].title)
		onButton(self, arg_9_2, function()
			self:ShowPerformWindow(var_9_0)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_9_2)
		setText(arg_9_2:Find("lock/Text"), self.config[self.polaroidGroup2Ids[arg_9_1][1]].condition)
	end

	return
end

function NewEducatePolaroidLayer:ShowPerformWindow(arg_13_1, arg_13_2)
	self.showIds = arg_13_1

	self.showList:align(#self.showIds)
	triggerButton(self.groupsTF:GetChild(0))
	setActive(self.performTF, true)

	return
end

function NewEducatePolaroidLayer:UpdatePerform(arg_14_1)
	LoadImageSpriteAsync("neweducateicon/" .. self.config[arg_14_1].pic_2, self.performTF:Find("bg/mask/Image"), true)
	setText(self.performTF:Find("bg/Text"), self.config[arg_14_1].title)

	return
end

function NewEducatePolaroidLayer:PlayAnimChange()
	self.anim:Stop()
	self.anim:Play("anim_educate_Polaroid_change")

	return
end

function NewEducatePolaroidLayer:PlayAnimClose()
	self.anim:Play("anim_educate_Polaroid_out")

	return
end

return NewEducatePolaroidLayer
