local FireworksPtPage = class("FireworksPtPage", import(".TemplatePage.PtTemplatePage"))

function FireworksPtPage:OnInit()
	FireworksPtPage.super.OnInit(self)

	self.fireworkNameText = self.bg:Find("firework_text")
	self.fireworkNumText = self.bg:Find("firework_text/num_text")
	self.ptText = self.bg:Find("pt_text")
	self.fireBtn = self.bg:Find("fire_btn")
	self.fireworkPanel = self.bg:Find("frame")
	self.dots = {
		self.fireworkPanel:Find("dots/1"),
		self.fireworkPanel:Find("dots/2"),
		self.fireworkPanel:Find("dots/3")
	}
	self.fireworkPages = {
		self.fireworkPanel:Find("content/1"),
		self.fireworkPanel:Find("content/2"),
		self.fireworkPanel:Find("content/3")
	}
	self.nextPageBtn = self.fireworkPanel:Find("right_btn")
	self.lastPageBtn = self.fireworkPanel:Find("left_btn")

	return
end

function FireworksPtPage:OnDataSetting()
	FireworksPtPage.super.OnDataSetting(self)

	self.fireworkActID = self.activity:getConfig("config_client").fireworkActID
	self.ptID = pg.activity_template[self.fireworkActID].config_data[2][1]
	self.ptConsume = pg.activity_template[self.fireworkActID].config_data[2][2]
	self.fireworkIds = pg.activity_template[self.fireworkActID].config_data[3]

	return
end

function FireworksPtPage:OnFirstFlush()
	FireworksPtPage.super.OnFirstFlush(self)
	onButton(self, self.fireBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SPRING_FESTIVAL_BACKHILL_2023, {
			openFireworkLayer = true
		})

		return
	end, SFX_PANEL)
	onButton(self, self.nextPageBtn, function()
		self:UpdateFrieworkPanel(self.pageIndex + 1)

		return
	end, SFX_PANEL)
	onButton(self, self.lastPageBtn, function()
		self:UpdateFrieworkPanel(self.pageIndex - 1)

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	setText(self.fireworkNameText, i18n("activity_yanhua_tip1"))
	self:UpdataPageIndex()

	return
end

function FireworksPtPage:UpdataPageIndex()
	self.fireworkAct = getProxy(ActivityProxy):getActivityById(self.fireworkActID)

	assert(self.fireworkAct and not self.fireworkAct:isEnd(), "烟花活动(type92)已结束")

	self.unlockCount = self.fireworkAct:getData1()
	self.unlockIds = self.fireworkAct:getData1List()

	for iter_8_0 = #self.fireworkPages, 1, -1 do
		local var_8_0 = 0

		eachChild(self.fireworkPages[iter_8_0], function(arg_9_0)
			if table.contains(self.unlockIds, (tonumber(arg_9_0.name))) then
				var_8_0 = var_8_0 + 1
			end

			return
		end)

		if 0 ~= self.fireworkPages[iter_8_0].childCount then
			self.pageIndex = iter_8_0
		end
	end

	if #self.unlockIds == #self.fireworkIds then
		self.pageIndex = 1
	end

	return
end

function FireworksPtPage:OnUpdateFlush()
	FireworksPtPage.super.OnUpdateFlush(self)
	self:UpdateFrieworkPanel(self.pageIndex)

	if #self.unlockIds == 0 then
		if pg.activity_template[self.fireworkActID].config_client.story and type(pg.activity_template[self.fireworkActID].config_client.story) == "table" then
			for iter_10_0, iter_10_1 in ipairs(pg.activity_template[self.fireworkActID].config_client.story) do
				if iter_10_1[1] == 0 then
					pg.NewStoryMgr.GetInstance():Play(iter_10_1[2])
				end
			end
		end
	end

	return
end

function FireworksPtPage:UpdateFrieworkPanel(arg_11_1)
	self.fireworkAct = getProxy(ActivityProxy):getActivityById(self.fireworkActID)

	assert(self.fireworkAct and not self.fireworkAct:isEnd(), "烟花活动(type92)已结束")

	self.unlockCount = self.fireworkAct:getData1()
	self.unlockIds = self.fireworkAct:getData1List()

	for iter_11_0 = #self.fireworkPages, 1, -1 do
		eachChild(self.fireworkPages[iter_11_0], function(arg_12_0)
			local var_12_0 = tonumber(arg_12_0.name)

			if table.contains(self.unlockIds, var_12_0) then
				setActive(arg_12_0, false)
			else
				setActive(arg_12_0, true)
				onButton(self, arg_12_0, function()
					self:OnUnlockClick(var_12_0)

					return
				end, SFX_PANEL)
			end

			return
		end)
	end

	local var_11_0 = #self.fireworkPages

	if #self.fireworkPages < arg_11_1 or arg_11_1 < 1 then
		return
	end

	self.pageIndex = arg_11_1

	for iter_11_1, iter_11_2 in ipairs(self.fireworkPages) do
		setActive(iter_11_2, tonumber(iter_11_2.name) == arg_11_1)
	end

	for iter_11_3, iter_11_4 in ipairs(self.dots) do
		setActive(iter_11_4, tonumber(iter_11_4.name) == arg_11_1)
	end

	setButtonEnabled(self.nextPageBtn, arg_11_1 ~= var_11_0)
	setButtonEnabled(self.lastPageBtn, arg_11_1 ~= 1)
	setText(self.fireworkNumText, #self.unlockIds .. "/" .. #self.fireworkIds)

	self.ptNum = getProxy(PlayerProxy):getRawData():getResource(self.ptID)

	setText(self.ptText, self.ptNum)

	return
end

function FireworksPtPage:OnUnlockClick(arg_14_1)
	if self.unlockCount <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("activity_yanhua_tip6"))

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("activity_yanhua_tip4", self.ptConsume),
		onYes = function()
			if self.ptNum < self.ptConsume then
				pg.TipsMgr.GetInstance():ShowTips(i18n("activity_yanhua_tip5"))
			else
				self:emit(ActivityMediator.EVENT_OPERATION, {
					cmd = 1,
					activity_id = self.fireworkActID,
					arg1 = arg_14_1
				})
			end

			return
		end
	})

	return
end

return FireworksPtPage
