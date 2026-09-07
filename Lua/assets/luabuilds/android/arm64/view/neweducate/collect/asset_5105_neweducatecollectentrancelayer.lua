local NewEducateCollectEntranceLayer = class("NewEducateCollectEntranceLayer", import("view.base.BaseUI"))

function NewEducateCollectEntranceLayer:getUIName()
	return "NewEducateCollectEntranceUI"
end

function NewEducateCollectEntranceLayer:getGroupName()
	return "NewEducateBaseUI"
end

function NewEducateCollectEntranceLayer:init()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(NewEducateCollectEntranceLayer.ON_CLOSE)

		return
	end)

	self.contentTF = self._tf:Find("anim_root/content")
	self.contentTF.offsetMin = Vector2(self.contextData.isSelect and 208 or 0, 0)
	self.contentTF.offsetMax = Vector2(0, 0)
	self.memoryBtn = self.contentTF:Find("memory_btn")
	self.polaroidBtn = self.contentTF:Find("polaroid_btn")
	self.polaroidBtn2 = self.contentTF:Find("polaroid_btn2")
	self.buffBtn = self.contentTF:Find("buff_btn")
	self.endingBtn = self.contentTF:Find("ending_btn")
	self.reviewBtn = self.contentTF:Find("review_btn")
	self.leftTF = self._tf:Find("anim_root/left")
	self.togglesTF = self.leftTF:Find("toggles")
	self.ids = {
		0
	}
	self.ids = table.mergeArray(self.ids, pg.child2_data.all)
	self.toggleList = UIItemList.New(self.togglesTF, self.togglesTF:Find("tpl"))

	return
end

function NewEducateCollectEntranceLayer:didEnter()
	self:BlurPanel(self._tf)
	onButton(self, self._tf, function()
		self:_close()

		return
	end, SFX_PANEL)
	onButton(self, self.memoryBtn, function()
		if self.contextData.id == 0 then
			self:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
				mediator = EducateCollectMediatorTemplate,
				viewComponent = EducateMemoryLayer
			}))
		else
			self:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
				mediator = NewEducateCollectMediatorTemplate,
				viewComponent = NewEducateMemoryLayer,
				data = {
					permanentData = self.permanentData
				}
			}))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.polaroidBtn, function()
		if self.contextData.id == 0 then
			self:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
				mediator = EducateCollectMediatorTemplate,
				viewComponent = EducatePolaroidLayer
			}))
			setActive(self.polaroidBtn:Find("new"), false)
		else
			self:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
				mediator = NewEducateCollectMediatorTemplate,
				viewComponent = NewEducatePolaroidLayer,
				data = {
					permanentData = self.permanentData
				}
			}))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.polaroidBtn2, function()
		self:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
			mediator = NewEducateCollectMediatorTemplate,
			viewComponent = NewEducatePolaroidLayer,
			data = {
				permanentData = self.permanentData
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.endingBtn:Find("unlock"), function()
		if self.contextData.id == 0 then
			if isActive(self.endingBtn:Find("lock")) then
				return
			end

			self:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
				mediator = EducateCollectMediatorTemplate,
				viewComponent = EducateEndingLayer
			}))
		else
			self:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
				mediator = NewEducateCollectMediatorTemplate,
				viewComponent = NewEducateEndingLayer,
				data = {
					permanentData = self.permanentData
				}
			}))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.reviewBtn, function()
		if self.contextData.id == 0 then
			self:emit(NewEducateCollectEntranceLayer.ON_CLOSE)
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
				page = WorldMediaCollectionScene.PAGE_MEMORTY,
				memoryGroup = EducateConst.REVIEW_GROUP_ID
			})
		else
			local var_11_0 = pg.child2_data[self.contextData.id].memory_group

			self:emit(NewEducateCollectEntranceLayer.ON_CLOSE)
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
				page = WorldMediaCollectionScene.PAGE_MEMORTY,
				memoryGroup = var_11_0
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.buffBtn, function()
		self:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
			mediator = NewEducateCollectMediatorTemplate,
			viewComponent = NewEducateBuffLayer,
			data = {
				permanentData = self.permanentData
			}
		}))

		return
	end, SFX_PANEL)
	self.toggleList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventInit then
			local var_13_0 = self.ids[arg_13_1 + 1]

			arg_13_2.name = self.ids[arg_13_1 + 1]

			LoadImageSpriteAsync("qicon/" .. (var_13_0 == 0 and "linghangyuan1_1" or pg.child2_data[var_13_0].head), arg_13_2:Find("icon"))
			onToggle(self, arg_13_2, function(arg_14_0)
				if arg_14_0 then
					self.contextData.id = var_13_0

					if self.contextData.id == 0 then
						self:FlushTBView()
					else
						self:FlushView(self.contextData.id)
					end
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.toggleList:align(#self.ids)
	setActive(self.leftTF, self.contextData.isSelect)

	if self.contextData.isSelect then
		triggerToggle(self.togglesTF:Find(tostring(self.contextData.id)), true)
	else
		self:FlushView(self.contextData.id)
	end

	return
end

function NewEducateCollectEntranceLayer:FlushView(arg_15_1)
	self.permanentData = getProxy(NewEducateProxy):GetChar(arg_15_1):GetPermanentData()

	setText(self.memoryBtn:Find("Text"), #self.permanentData:GetUnlockMemoryIds() .. "/" .. #self.permanentData:GetAllMemoryIds())
	setActive(self.memoryBtn:Find("new"), false)

	local var_15_0 = self.permanentData:IsTarotType()
	local var_15_1 = #self.permanentData:GetUnlockPolaroidGroups()
	local var_15_2 = #self.permanentData:GetAllPolaroidGroups()

	setText(self.polaroidBtn:Find("Text"), var_15_1 .. "/" .. var_15_2)
	setText(self.polaroidBtn2:Find("Text"), var_15_1 .. "/" .. var_15_2)
	setActive(self.polaroidBtn:Find("new"), false)
	setActive(self.polaroidBtn2:Find("new"), false)
	setActive(self.polaroidBtn, not var_15_0)
	setActive(self.polaroidBtn2, var_15_0)
	setActive(self.buffBtn, var_15_0)

	if var_15_0 then
		setText(self.buffBtn:Find("Text"), self.permanentData:GetAllUnlockBuffCnt() .. "/" .. self.permanentData:GetAllBuffCnt())
	end

	setText(self.endingBtn:Find("unlock/Text"), #self.permanentData:GetActivatedEndings() .. "/" .. #self.permanentData:GetAllEndingIds())

	local var_15_3 = NewEducateConst.LOCK_ENDING and self.permanentData:GetGameCnt()

	setActive(self.endingBtn:Find("unlock"), not var_15_3)
	setActive(self.endingBtn:Find("lock"), var_15_3)

	return
end

function NewEducateCollectEntranceLayer:FlushTBView()
	local var_16_0 = getProxy(EducateProxy)
	local var_16_1 = var_16_0:GetAllEndings()

	setText(self.memoryBtn:Find("Text"), #var_16_0:GetMemories() .. "/" .. #pg.child_memory.all)
	self:UpdateMemoryTip()

	local var_16_2, var_16_3 = var_16_0:GetPolaroidGroupCnt()

	setText(self.polaroidBtn:Find("Text"), var_16_2 .. "/" .. var_16_3)
	setActive(self.polaroidBtn:Find("lock"), not EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_POLAROID))
	setActive(self.polaroidBtn:Find("new"), EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_POLAROID))
	setActive(self.polaroidBtn, true)
	setActive(self.polaroidBtn2, false)
	setActive(self.buffBtn, false)
	setText(self.endingBtn:Find("unlock/Text"), #var_16_1 .. "/" .. #pg.child_ending.all)

	local var_16_4 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_ENDING) or #var_16_1 > 0

	setActive(self.endingBtn:Find("unlock"), var_16_4)
	setActive(self.endingBtn:Find("lock"), not var_16_4)

	return
end

function NewEducateCollectEntranceLayer:UpdateMemoryTip()
	setActive(self.memoryBtn:Find("new"), (underscore.any(pg.child_memory.all, function(arg_18_0)
		return EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_MEMORY, arg_18_0)
	end)))

	return
end

function NewEducateCollectEntranceLayer:_close()
	self.anim:Play("anim_educate_collectentrance_out")

	return
end

function NewEducateCollectEntranceLayer:onBackPressed()
	self:_close()

	return
end

function NewEducateCollectEntranceLayer:willExit()
	self.animEvent:SetEndEvent(nil)
	self:UnOverlayPanel(self._tf)

	return
end

return NewEducateCollectEntranceLayer
