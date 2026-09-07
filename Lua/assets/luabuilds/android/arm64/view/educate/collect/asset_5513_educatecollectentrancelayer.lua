local EducateCollectEntranceLayer = class("EducateCollectEntranceLayer", import("..base.EducateBaseUI"))

function EducateCollectEntranceLayer:getUIName()
	return "EducateCollectEntranceUI"
end

function EducateCollectEntranceLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function EducateCollectEntranceLayer:initData()
	local var_3_0 = getProxy(EducateProxy)

	self.memories = var_3_0:GetMemories()
	self.endings = var_3_0:GetAllEndings()

	return
end

function EducateCollectEntranceLayer:findUI()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(EducateCollectEntranceLayer.ON_CLOSE)

		return
	end)

	self.contentTF = self._tf:Find("anim_root/content")
	self.memoryBtn = self.contentTF:Find("memory_btn")
	self.polaroidBtn = self.contentTF:Find("polaroid_btn")
	self.endingBtn = self.contentTF:Find("ending_btn")
	self.reviewBtn = self.contentTF:Find("review_btn")

	return
end

function EducateCollectEntranceLayer:addListener()
	onButton(self, self._tf, function()
		self:_close()

		return
	end, SFX_PANEL)
	onButton(self, self.memoryBtn, function()
		self:emit(EducateCollectEntranceLayer.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateCollectMediatorTemplate,
			viewComponent = EducateMemoryLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.polaroidBtn, function()
		if isActive(self.polaroidBtn:Find("lock")) then
			return
		end

		self:emit(EducateCollectEntranceLayer.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateCollectMediatorTemplate,
			viewComponent = EducatePolaroidLayer
		}))
		setActive(self.polaroidBtn:Find("new"), false)

		return
	end, SFX_PANEL)
	onButton(self, self.endingBtn, function()
		if isActive(self.endingBtn:Find("lock")) then
			return
		end

		self:emit(EducateCollectEntranceLayer.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateCollectMediatorTemplate,
			viewComponent = EducateEndingLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.reviewBtn, function()
		self:emit(EducateCollectEntranceLayer.ON_CLOSE)
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_MEMORTY,
			memoryGroup = EducateConst.REVIEW_GROUP_ID
		})

		return
	end, SFX_PANEL)

	return
end

function EducateCollectEntranceLayer:didEnter()
	setText(self.memoryBtn:Find("Text"), #self.memories .. "/" .. #pg.child_memory.all)
	self:updateMemoryTip()

	local var_12_0, var_12_1 = getProxy(EducateProxy):GetPolaroidGroupCnt()

	setText(self.polaroidBtn:Find("Text"), var_12_0 .. "/" .. var_12_1)
	setActive(self.polaroidBtn:Find("lock"), not EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_POLAROID))
	setActive(self.polaroidBtn:Find("new"), EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_POLAROID))
	setText(self.endingBtn:Find("unlock/Text"), #self.endings .. "/" .. #pg.child_ending.all)

	local var_12_2 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_ENDING) or #self.endings > 0

	setActive(self.endingBtn:Find("unlock"), var_12_2)
	setActive(self.endingBtn:Find("lock"), not var_12_2)
	self:BlurPanel(self._tf)
	EducateGuideSequence.CheckGuide(self.__cname, function()
		return
	end)

	return
end

function EducateCollectEntranceLayer:updateMemoryTip()
	setActive(self.memoryBtn:Find("new"), (underscore.any(pg.child_memory.all, function(arg_15_0)
		return EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_MEMORY, arg_15_0)
	end)))

	return
end

function EducateCollectEntranceLayer:_close()
	self.anim:Play("anim_educate_collectentrance_out")

	return
end

function EducateCollectEntranceLayer:onBackPressed()
	self:_close()

	return
end

function EducateCollectEntranceLayer:willExit()
	self.animEvent:SetEndEvent(nil)
	self:UnOverlayPanel(self._tf)

	return
end

return EducateCollectEntranceLayer
