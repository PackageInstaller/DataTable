local NewEducateMemoryLayer = class("NewEducateMemoryLayer", import(".NewEducateCollectLayerTemplate"))

function NewEducateMemoryLayer:getUIName()
	return "NewEducateMemoryUI"
end

function NewEducateMemoryLayer:initConfig()
	self.config = pg.child2_memory
	self.allIds = self.contextData.permanentData:GetAllMemoryIds()
	self.unlockIds = self.contextData.permanentData:GetUnlockMemoryIds()

	return
end

function NewEducateMemoryLayer:didEnter()
	self:InitPageInfo()
	setText(self.performTF:Find("review_btn/Text"), i18n("child_btn_review"))
	setText(self.curCntTF, #self.unlockIds)
	setText(self.allCntTF, "/" .. #self.allIds)
	self:UpdatePage()

	return
end

function NewEducateMemoryLayer:UpdateItem(arg_4_1, arg_4_2)
	local var_4_0 = self.config[arg_4_1]
	local var_4_1 = table.contains(self.unlockIds, self.config[arg_4_1].id)

	setActive(arg_4_2:Find("lock"), not var_4_1)
	setActive(arg_4_2:Find("unlock"), var_4_1)
	setActive(arg_4_2:Find("unlock/new"), false)

	if var_4_1 then
		LoadImageSpriteAsync("bg/" .. self.config[arg_4_1].pic, arg_4_2:Find("unlock/mask/Image"))
		setText(arg_4_2:Find("unlock/name"), self.config[arg_4_1].desc)
		onButton(self, arg_4_2, function()
			self:ShowPerformWindow(var_4_0)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_4_2)
		setText(arg_4_2:Find("lock/Text"), i18n("child_collect_lock"))
	end

	return
end

function NewEducateMemoryLayer:ShowPerformWindow(arg_6_1)
	local var_6_0 = self.performTF:Find("Image")

	LoadImageSpriteAsync("bg/" .. arg_6_1.pic, var_6_0)
	setActive(self.performTF, true)
	onButton(self, var_6_0, function()
		setActive(self.performTF, false)

		return
	end, SFX_PANEL)
	onButton(self, self.performTF:Find("review_btn"), function()
		pg.NewStoryMgr.GetInstance():Play(arg_6_1.lua, nil, true)

		return
	end, SFX_PANEL)

	return
end

function NewEducateMemoryLayer:PlayAnimChange()
	self.anim:Stop()
	self.anim:Play("anim_educate_memory_change")

	return
end

function NewEducateMemoryLayer:PlayAnimClose()
	self.anim:Play("anim_educate_memory_out")

	return
end

return NewEducateMemoryLayer
