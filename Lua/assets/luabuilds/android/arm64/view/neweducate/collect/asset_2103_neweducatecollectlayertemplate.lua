local NewEducateCollectLayerTemplate = class("NewEducateCollectLayerTemplate", import("view.base.BaseUI"))

function NewEducateCollectLayerTemplate:getUIName()
	assert(nil, "getUIName方法必须由子类实现")

	return
end

function NewEducateCollectLayerTemplate:getGroupName()
	return "NewEducateBaseUI"
end

function NewEducateCollectLayerTemplate:initConfig()
	assert(nil, "initConfig方法必须由子类实现")

	return
end

function NewEducateCollectLayerTemplate:init()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(NewEducateCollectLayerTemplate.ON_CLOSE)

		return
	end)

	self.closeBtn = self._tf:Find("anim_root/bg")
	self.windowTF = self._tf:Find("anim_root/window")
	self.curCntTF = self.windowTF:Find("collect/cur")
	self.allCntTF = self.windowTF:Find("collect/all")
	self.pageTF = self.windowTF:Find("page")
	self.nextBtn = self.windowTF:Find("next_btn")
	self.lastBtn = self.windowTF:Find("last_btn")
	self.paginationTF = self.windowTF:Find("pagination")
	self.performTF = self._tf:Find("anim_root/perform")

	setActive(self.performTF, false)
	onButton(self, self.closeBtn, function()
		self:PlayAnimClose()

		return
	end, SFX_PANEL)
	onButton(self, self.nextBtn, function()
		self:PlayAnimChange()

		self.curPageIndex = self.curPageIndex + 1

		self:UpdatePage()

		return
	end, SFX_PANEL)
	onButton(self, self.lastBtn, function()
		self:PlayAnimChange()

		self.curPageIndex = self.curPageIndex - 1

		self:UpdatePage()

		return
	end, SFX_PANEL)
	self:OverlayPanel(self._tf, {
		groupDelta = 2
	})

	return
end

function NewEducateCollectLayerTemplate:InitPageInfo()
	self:initConfig()

	self.onePageCnt = self.pageTF.childCount
	self.pages = math.ceil(#self.allIds / self.onePageCnt)
	self.curPageIndex = 1

	return
end

function NewEducateCollectLayerTemplate:UpdatePage()
	setActive(self.nextBtn, self.pages ~= 1 and self.curPageIndex < self.pages)
	setActive(self.lastBtn, self.pages ~= 1 and self.curPageIndex > 1)
	setText(self.paginationTF, self.curPageIndex .. "/" .. self.pages)

	for iter_10_0 = 1, self.onePageCnt do
		local var_10_0 = self.pageTF:Find("frame_" .. iter_10_0)

		if self.allIds[(self.curPageIndex - 1) * self.onePageCnt + iter_10_0] then
			setActive(var_10_0, true)
			self:UpdateItem(self.allIds[(self.curPageIndex - 1) * self.onePageCnt + iter_10_0], var_10_0)
		else
			setActive(var_10_0, false)
		end
	end

	return
end

function NewEducateCollectLayerTemplate:UpdateItem(arg_11_1, arg_11_2)
	assert(nil, "updateItem方法必须由子类实现")

	return
end

function NewEducateCollectLayerTemplate:PlayAnimChange()
	assert(nil, "playAnimClose方法必须由子类实现")

	return
end

function NewEducateCollectLayerTemplate:onBackPressed()
	self:PlayAnimClose()

	return
end

function NewEducateCollectLayerTemplate:willExit()
	self.animEvent:SetEndEvent(nil)
	self:UnOverlayPanel(self._tf)

	return
end

return NewEducateCollectLayerTemplate
