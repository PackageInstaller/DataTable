local EducatePolaroidLayer = class("EducatePolaroidLayer", import(".EducateCollectLayerTemplate"))

function EducatePolaroidLayer:getUIName()
	return "EducatePolaroidUI"
end

function EducatePolaroidLayer:initConfig()
	self.config = pg.child_polaroid

	return
end

function EducatePolaroidLayer:initGroups()
	self.groupIds = {}
	self.group2polaroidIds = {}

	for iter_3_0, iter_3_1 in pairs(pg.child_polaroid.get_id_list_by_group) do
		table.insert(self.groupIds, iter_3_0)

		self.group2polaroidIds[iter_3_0] = iter_3_1
	end

	table.sort(self.groupIds)

	return
end

function EducatePolaroidLayer:initUnlockAttr()
	self.unlockAttrs = {}
	self.endings = getProxy(EducateProxy):GetAllEndings()

	underscore.each(self.endings, function(arg_5_0)
		if pg.child_ending[arg_5_0].polaroid_condition ~= 0 and not table.contains(self.unlockAttrs, pg.child_ending[arg_5_0].polaroid_condition) then
			table.insert(self.unlockAttrs, pg.child_ending[arg_5_0].polaroid_condition)
		end

		return
	end)

	return
end

function EducatePolaroidLayer:didEnter()
	self:initGroups()
	self:initShowList()
	onButton(self, self.performTF, function()
		setActive(self.performTF, false)

		return
	end, SFX_PANEL)

	self.pages = math.ceil(#self.groupIds / self.onePageCnt)

	EducateTipHelper.ClearNewTip(EducateTipHelper.NEW_POLAROID)

	local var_6_0 = self.performTF:Find("bg/lock/unlock_btn/Text")

	var_6_0:GetComponent("RichText"):AddSprite("gold", self._tf:Find("res/gold"):GetComponent(typeof(Image)).sprite)
	setText(var_6_0, i18n("child_could_buy"))
	setText(self.windowTF:Find("tip"), i18n("child_buy_polaroid_tip"))

	self.basePrice = pg.gameset.child_polaroid_basic_price.key_value
	self.addPrice = pg.gameset.child_polaroid_add_price.key_value
	self.maxPrice = pg.gameset.child_polaroid_max_price.key_value

	self:Flush()

	return
end

function EducatePolaroidLayer:initShowList()
	self.showIds = {}
	self.selectedIndex = 1
	self.groupsTF = self.performTF:Find("bg/groups")
	self.showList = UIItemList.New(self.groupsTF, self.groupsTF:Find("tpl"))

	self.showList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = self.showIds[arg_9_1 + 1]
			local var_9_1 = self:IsUnlock(self.showIds[arg_9_1 + 1])

			setText(arg_9_2:Find("unlock/unselected/Text"), self.showIds[arg_9_1 + 1])
			setText(arg_9_2:Find("unlock/selected/Text"), self.showIds[arg_9_1 + 1])
			setActive(arg_9_2:Find("lock"), not var_9_1)
			setActive(arg_9_2:Find("unlock"), var_9_1)
			setActive(arg_9_2:Find("unlock/selected"), self.selectedIndex == arg_9_1 + 1)
			setActive(arg_9_2:Find("unlock/unselected"), self.selectedIndex ~= arg_9_1 + 1)
			onButton(self, arg_9_2, function(arg_10_0)
				self.selectedIndex = arg_9_1 + 1

				self:updatePerform(var_9_0, var_9_1)
				self.showList:align(#self.showIds)

				if not var_9_1 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("child_polaroid_lock_tip"))
				end

				return
			end)
		end

		return
	end)

	return
end

function EducatePolaroidLayer:IsUnlock(arg_11_1)
	if self.polaroidData[arg_11_1] then
		return true
	end

	if #self.endings > 0 then
		if self.config[arg_11_1].stage[1] == 2 or self.config[arg_11_1].stage[1] == 3 then
			return true
		elseif self.config[arg_11_1].stage[1] == 4 then
			return table.contains(self.unlockAttrs, self.config[arg_11_1].xingge[1])
		end
	end

	return false
end

function EducatePolaroidLayer:SetData()
	local var_12_0 = getProxy(EducateProxy)

	self.polaroidData = var_12_0:GetPolaroidData()
	self.gameCnt = var_12_0:GetGameCnt()
	self.bugCnt = var_12_0:GetPolaroidBuyCnt()

	self:initUnlockAttr()

	return
end

function EducatePolaroidLayer:Flush()
	self:SetData()

	local var_13_0, var_13_1 = getProxy(EducateProxy):GetPolaroidGroupCnt()

	setText(self.curCntTF, var_13_0)
	setText(self.allCntTF, "/" .. var_13_1)
	self:updatePage()

	if isActive(self.performTF) then
		self:updatePerform(self.showIds[self.selectedIndex], (self:IsUnlock(self.showIds[self.selectedIndex])))
		self.showList:align(#self.showIds)
	end

	return
end

function EducatePolaroidLayer:updatePage()
	setActive(self.nextBtn, self.pages ~= 1 and self.curPageIndex < self.pages)
	setActive(self.lastBtn, self.pages ~= 1 and self.curPageIndex > 1)
	setText(self.paginationTF, self.curPageIndex .. "/" .. self.pages)

	for iter_14_0 = 1, self.onePageCnt do
		local var_14_0 = self.pageTF:Find("frame_" .. iter_14_0)

		if self.groupIds[(self.curPageIndex - 1) * self.onePageCnt + iter_14_0] then
			setActive(var_14_0, true)
			self:updateItem(self.groupIds[(self.curPageIndex - 1) * self.onePageCnt + iter_14_0], var_14_0)
		else
			setActive(var_14_0, false)
		end
	end

	return
end

function EducatePolaroidLayer:updateItem(arg_15_1, arg_15_2)
	local var_15_0 = self.group2polaroidIds[arg_15_1]

	table.sort(self.group2polaroidIds[arg_15_1], CompareFuncs({
		function(arg_16_0)
			return self.polaroidData[arg_16_0] and 0 or 1
		end,
		function(arg_17_0)
			return self.polaroidData[arg_17_0] and self.polaroidData[arg_17_0]:GetTimeWeight() or 1
		end,
		function(arg_18_0)
			return arg_18_0
		end
	}))

	local var_15_1 = self.config[self.group2polaroidIds[arg_15_1][1]]

	setActive(arg_15_2:Find("lock"), not self.polaroidData[self.group2polaroidIds[arg_15_1][1]])
	setActive(arg_15_2:Find("unlock"), self.polaroidData[self.group2polaroidIds[arg_15_1][1]])

	if self.polaroidData[self.group2polaroidIds[arg_15_1][1]] then
		LoadImageSpriteAsync("educatepolaroid/" .. self.config[self.group2polaroidIds[arg_15_1][1]].pic, arg_15_2:Find("unlock/mask/Image"))
		setText(arg_15_2:Find("unlock/name"), self.config[self.group2polaroidIds[arg_15_1][1]].title)
		onButton(self, arg_15_2, function()
			self:showPerformWindow(var_15_0)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_15_2)
		setText(arg_15_2:Find("lock/desc/Text"), self.config[self.group2polaroidIds[arg_15_1][1]].condition)

		local var_15_3 = arg_15_2:Find("lock/unlock_btn")

		setActive(var_15_3, self.gameCnt > 1)
		onButton(self, var_15_3, function()
			self:OnClickBuyBtn(var_15_1)

			return
		end, SFX_PANEL)
	end

	return
end

function EducatePolaroidLayer:showPerformWindow(arg_21_1, arg_21_2)
	self.showIds = arg_21_1

	self.showList:align(#self.showIds)
	triggerButton(self.groupsTF:GetChild(0))
	setActive(self.performTF, true)

	return
end

function EducatePolaroidLayer:updatePerform(arg_22_1, arg_22_2)
	local var_22_0 = self.config[arg_22_1]

	LoadImageSpriteAsync("educatepolaroid/" .. self.config[arg_22_1].pic, self.performTF:Find("bg/icon/Image"))
	setActive(self.performTF:Find("bg/icon/lock"), not arg_22_2)
	setText(self.performTF:Find("bg/Text"), (arg_22_2 or nil) and (var_22_0.title or ""))
	setActive(self.performTF:Find("bg/lock"), not arg_22_2)

	if not arg_22_2 then
		setText(self.performTF:Find("bg/lock/desc/Text"), var_22_0.condition)

		local var_22_2 = self.performTF:Find("bg/lock/unlock_btn")

		setActive(var_22_2, self.gameCnt > 1)
		onButton(self, var_22_2, function()
			self:OnClickBuyBtn(var_22_0)

			return
		end, SFX_PANEL)
	end

	return
end

function EducatePolaroidLayer:OnClickBuyBtn(arg_24_1)
	local var_24_0 = math.min(self.maxPrice, self.basePrice + self.bugCnt * self.addPrice)

	self:emit(EducateBaseUI.EDUCATE_ON_MSG_TIP, {
		content = i18n("child_polaroid_buy", var_24_0, arg_24_1.title),
		onYes = function()
			self:emit(EducateCollectMediatorTemplate.UNLOCK, {
				type = EducateBuyCollectCommand.TYPE.POLAROID,
				id = arg_24_1.id,
				cost = var_24_0
			})

			return
		end
	})

	return
end

function EducatePolaroidLayer:playAnimChange()
	self.anim:Stop()
	self.anim:Play("anim_educate_Polaroid_change")

	return
end

function EducatePolaroidLayer:playAnimClose()
	self.anim:Play("anim_educate_Polaroid_out")

	return
end

return EducatePolaroidLayer
