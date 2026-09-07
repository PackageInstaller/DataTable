local LivingAreaCoverPage = class("LivingAreaCoverPage", import("...base.BaseSubView"))

function LivingAreaCoverPage:getUIName()
	return "LivingAreaCoverUI"
end

function LivingAreaCoverPage:OnLoaded()
	self.tpl = self._tf:Find("bg/tpl")

	setActive(self.tpl, false)

	self.frameTF = self._tf:Find("bg/frame")
	self.contentTF = self.frameTF:Find("view/content")
	self.unlockTF = self.contentTF:Find("unlock")

	setText(self.unlockTF:Find("title/Text"), i18n("word_unlock"))

	self.unlockUIList = UIItemList.New(self.unlockTF:Find("list"), self.tpl)
	self.lockTF = self.contentTF:Find("lock")

	setText(self.lockTF:Find("title/Text"), i18n("word_lock"))

	self.lockUIList = UIItemList.New(self.lockTF:Find("list"), self.tpl)

	return
end

function LivingAreaCoverPage:OnInit()
	onButton(self, self._tf, function()
		self:CheckSet()

		return
	end, SFX_PANEL)
	onButton(self, self.frameTF:Find("close"), function()
		self:CheckSet()

		return
	end, SFX_PANEL)
	self.unlockUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:updateItem(arg_6_1, arg_6_2, "unlock")
		end

		return
	end)
	self.lockUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:updateItem(arg_7_1, arg_7_2, "lock")
		end

		return
	end)

	return
end

function LivingAreaCoverPage:updateItem(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_1 + 1
	local var_8_1 = arg_8_3 == "unlock"
	local var_8_2

	if arg_8_3 == "unlock" then
		var_8_2 = self.unlockList[arg_8_1 + 1] or self.lockList[arg_8_1 + 1]
	end

	LoadImageSpriteAsync(var_8_2:GetIcon(), arg_8_2:Find("icon"), true)
	setText(arg_8_2:Find("lock/Image/Text"), var_8_2:GetUnlockText())
	setActive(arg_8_2:Find("lock"), not var_8_1)
	setActive(arg_8_2:Find("selected"), var_8_1)
	onButton(self, arg_8_2, function()
		if not var_8_1 then
			return
		end

		if self.selectedIdx ~= var_8_0 then
			if var_8_2:IsNew() then
				var_8_2:ClearNew()
				getProxy(LivingAreaCoverProxy):UpdateCover(var_8_2)
			end

			self.selectedIdx = var_8_0

			self.unlockUIList:align(#self.unlockList)

			if self.contextData and self.contextData.onSelected then
				self.contextData.onSelected(var_8_2)
			end
		end

		return
	end, SFX_CONFIRM)
	setActive(arg_8_2:Find("new"), var_8_2:IsNew())
	setActive(arg_8_2:Find("selected"), var_8_1 and self.selectedIdx == arg_8_1 + 1)

	return
end

function LivingAreaCoverPage:Show()
	LivingAreaCoverPage.super.Show(self)

	local var_10_0 = getProxy(LivingAreaCoverProxy)

	self.coverId = var_10_0:GetCoverId()
	self.unlockList = var_10_0:GetUnlockList()
	self.lockList = var_10_0:GetLockList()

	self:Sort()

	self.selectedIdx = 1

	self.unlockUIList:align(#self.unlockList)
	self.lockUIList:align(#self.lockList)
	quickPlayAnimation(self._tf, "anim_dorm3d_areacover_in")

	return
end

function LivingAreaCoverPage:Sort()
	table.sort(self.unlockList, CompareFuncs({
		function(arg_12_0)
			return arg_12_0.id == self.coverId and 0 or 1
		end,
		function(arg_13_0)
			return arg_13_0.id
		end
	}))
	table.sort(self.lockList, CompareFuncs({
		function(arg_14_0)
			return arg_14_0.id
		end
	}))

	return
end

function LivingAreaCoverPage:CheckSet()
	if self.unlockList[self.selectedIdx].id ~= self.coverId then
		pg.m02:sendNotification(GAME.CHANGE_LIVINGAREA_COVER, {
			coverId = self.unlockList[self.selectedIdx].id,
			callback = function()
				self:Hide()

				return
			end
		})
	else
		self:Hide()
	end

	return
end

function LivingAreaCoverPage:Hide()
	if self:isShowing() and not self.inExitAnim then
		self.inExitAnim = nil

		quickPlayAnimation(self._tf, "anim_dorm3d_areacover_out")
		onDelayTick(function()
			self.inExitAnim = nil

			if self.contextData and self.contextData.onHide then
				self.contextData.onHide()
			end

			LivingAreaCoverPage.super.Hide(self)

			return
		end, 0.2)
	end

	return
end

function LivingAreaCoverPage:OnDestroy()
	self:Hide()

	return
end

return LivingAreaCoverPage
