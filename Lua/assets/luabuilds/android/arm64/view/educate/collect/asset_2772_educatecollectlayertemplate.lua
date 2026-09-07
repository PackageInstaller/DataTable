local EducateCollectLayerTemplate = class("EducateCollectLayerTemplate", import("..base.EducateBaseUI"))

function EducateCollectLayerTemplate:getUIName()
	assert(nil, "getUIName方法必须由子类实现")

	return
end

function EducateCollectLayerTemplate:initConfig()
	assert(nil, "initConfig方法必须由子类实现")

	return
end

function EducateCollectLayerTemplate:init()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(EducateCollectLayerTemplate.ON_CLOSE)

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
	self:initConfig()

	self.onePageCnt = self.pageTF.childCount
	self.pages = math.ceil(#self.config.all / self.onePageCnt)
	self.curPageIndex = 1

	onButton(self, self.closeBtn, function()
		self:playAnimClose()

		return
	end, SFX_PANEL)
	onButton(self, self.nextBtn, function()
		self:playAnimChange()

		self.curPageIndex = self.curPageIndex + 1

		self:updatePage()

		return
	end, SFX_PANEL)
	onButton(self, self.lastBtn, function()
		self:playAnimChange()

		self.curPageIndex = self.curPageIndex - 1

		self:updatePage()

		return
	end, SFX_PANEL)
	self:OverlayPanel(self._tf, {
		groupDelta = 2
	})
	eachChild(self.pageTF, function(arg_8_0)
		local var_8_0 = arg_8_0:Find("lock/unlock_btn/Text")

		var_8_0:GetComponent("RichText"):AddSprite("gold", self._tf:Find("res/gold"):GetComponent(typeof(Image)).sprite)
		setText(var_8_0, i18n("child_could_buy"))

		return
	end)

	return
end

function EducateCollectLayerTemplate:updatePage()
	setActive(self.nextBtn, self.pages ~= 1 and self.curPageIndex < self.pages)
	setActive(self.lastBtn, self.pages ~= 1 and self.curPageIndex > 1)
	setText(self.paginationTF, self.curPageIndex .. "/" .. self.pages)

	for iter_9_0 = 1, self.onePageCnt do
		local var_9_0 = self.pageTF:Find("frame_" .. iter_9_0)

		if self.config[self.config.all[(self.curPageIndex - 1) * self.onePageCnt + iter_9_0]] then
			setActive(var_9_0, true)
			self:updateItem(self.config[self.config.all[(self.curPageIndex - 1) * self.onePageCnt + iter_9_0]], var_9_0)
		else
			setActive(var_9_0, false)
		end
	end

	return
end

function EducateCollectLayerTemplate:updateItem(arg_10_1, arg_10_2)
	assert(nil, "updateItem方法必须由子类实现")

	return
end

function EducateCollectLayerTemplate:playAnimChange()
	assert(nil, "playAnimClose方法必须由子类实现")

	return
end

function EducateCollectLayerTemplate:playAnimClose()
	assert(nil, "playAnimClose方法必须由子类实现")

	return
end

function EducateCollectLayerTemplate:onBackPressed()
	self:playAnimClose()

	return
end

function EducateCollectLayerTemplate:willExit()
	self.animEvent:SetEndEvent(nil)
	self:UnOverlayPanel(self._tf)

	return
end

return EducateCollectLayerTemplate
