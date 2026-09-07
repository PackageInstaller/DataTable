local SSSSMedalCollectionView = class("SSSSMedalCollectionView", import("..TemplateMV.MedalCollectionTemplateView"))
local var_0_1 = {
	"qvzhu",
	"qingxvn",
	"zhongxvn",
	"zhanlie",
	"hangmu",
	"jinghua"
}

SSSSMedalCollectionView.INDEX_CONVERT = {
	1,
	4,
	3,
	5,
	6,
	2
}

function SSSSMedalCollectionView:getUIName()
	return "SSSSMedalCollectionUI"
end

function SSSSMedalCollectionView:init()
	self:FindUI()

	self.loader = AutoLoader.New()

	return
end

function SSSSMedalCollectionView:FindUI()
	local var_3_0 = self._tf:Find("Top")

	self.backBtn = var_3_0:Find("BackBtn")
	self.helpBtn = var_3_0:Find("HelpBtn")
	self.progressText = var_3_0:Find("ProgressText")
	self.slots = {}

	for iter_3_0 = 1, 6 do
		self.slots[iter_3_0] = {
			char = self._tf:Find("Desk/Slot" .. iter_3_0 .. "/Char"),
			point = self._tf:Find("Desk/Slot" .. iter_3_0 .. "/Point"),
			pointEffect = self._tf:Find("Desk/Slot" .. iter_3_0 .. "/Dengguang"),
			selected = self._tf:Find("Desk/Slot" .. iter_3_0 .. "/Selected"),
			saoguang = self._tf:Find("Desk/Slot" .. iter_3_0 .. "/Saoguang")
		}
	end

	self.medalTF = self._tf:Find("Desk/Slot8")
	self.infoArea1 = self._tf:Find("Desk/Info/Area1")
	self.infoArea2 = self._tf:Find("Desk/Info/Area2")
	self.infoIcon = self.infoArea1:Find("Unlock/Icon")

	return
end

function SSSSMedalCollectionView:didEnter()
	SSSSMedalCollectionView.super.didEnter(self)
	self:AddListener()

	self.contextData.GKIndex = self.contextData.GKIndex or 1

	self:UpdateView()

	return
end

function SSSSMedalCollectionView:AddListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ssss_medal_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.infoArea1, function()
		local var_8_0 = self.allIDList[2 * SSSSMedalCollectionView.INDEX_CONVERT[self.contextData.GKIndex] - 1]

		if not table.contains(self.activeIDList, self.allIDList[2 * SSSSMedalCollectionView.INDEX_CONVERT[self.contextData.GKIndex] - 1]) and table.contains(self.activatableIDList, var_8_0) then
			self:emit(MedalCollectionTemplateMediator.MEMORYBOOK_UNLOCK, {
				id = var_8_0,
				actId = self.activityData.id
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.infoArea2, function()
		local var_9_0 = self.allIDList[2 * SSSSMedalCollectionView.INDEX_CONVERT[self.contextData.GKIndex]]

		if not table.contains(self.activeIDList, self.allIDList[2 * SSSSMedalCollectionView.INDEX_CONVERT[self.contextData.GKIndex]]) and table.contains(self.activatableIDList, var_9_0) then
			self:emit(MedalCollectionTemplateMediator.MEMORYBOOK_UNLOCK, {
				id = var_9_0,
				actId = self.activityData.id
			})
		end

		return
	end, SFX_PANEL)

	for iter_5_0 = 1, 6 do
		onButton(self, self._tf:Find("Desk/Slot" .. iter_5_0 .. "/Click"), function()
			self.contextData.GKIndex = iter_5_0

			self:UpdateView()

			return
		end, SFX_PANEL)
	end

	return
end

function SSSSMedalCollectionView:UpdateAfterSubmit(arg_11_1)
	SSSSMedalCollectionView.super.UpdateAfterSubmit(self, arg_11_1)

	local var_11_0 = table.indexof(SSSSMedalCollectionView.INDEX_CONVERT, (math.floor((table.indexof(self.allIDList, arg_11_1) + 1) / 2)))

	SetCompomentEnabled(self.slots[var_11_0].char, typeof(Image), false)
	self:UpdateView()
	setActive(self.slots[var_11_0].saoguang, false)
	setActive(self.slots[var_11_0].saoguang, true)

	return
end

function SSSSMedalCollectionView:UpdateAfterFinalMedal()
	SSSSMedalCollectionView.super.UpdateAfterFinalMedal(self)
	self:UpdateView()

	return
end

function SSSSMedalCollectionView:UpdateView()
	for iter_13_0 = 1, 6 do
		local var_13_0 = 0
		local var_13_1 = false
		local var_13_2 = SSSSMedalCollectionView.INDEX_CONVERT[iter_13_0]

		_.each({
			self.allIDList[2 * SSSSMedalCollectionView.INDEX_CONVERT[iter_13_0] - 1],
			self.allIDList[2 * SSSSMedalCollectionView.INDEX_CONVERT[iter_13_0]]
		}, function(arg_14_0)
			if table.contains(self.activeIDList, arg_14_0) then
				var_13_0 = var_13_0 + 1
			elseif table.contains(self.activatableIDList, arg_14_0) then
				var_13_1 = true
			end

			return
		end)
		self.loader:GetSpriteQuiet("ui/SSSSMedalCollectionUI_atlas", var_13_0 == 2 and "point_green" or "point_red", self.slots[iter_13_0].point)
		SetCompomentEnabled(self.slots[iter_13_0].point, typeof(Animator), false)
		setActive(self.slots[iter_13_0].pointEffect, var_13_1)

		if not var_13_1 then
			setImageColor(self.slots[iter_13_0].point, Color(1, 1, 1))
		end

		setActive(self.slots[iter_13_0].char, var_13_0 ~= 0)

		if var_13_0 == 1 then
			self.loader:GetSpriteQuiet("ui/SSSSMedalCollectionUI_atlas", "baimo_" .. var_0_1[var_13_2], self.slots[iter_13_0].char)
		elseif var_13_0 == 2 then
			self.loader:GetSpriteQuiet("ui/SSSSMedalCollectionUI_atlas", "wancheng_" .. var_0_1[var_13_2], self.slots[iter_13_0].char)
		end

		setActive(self.slots[iter_13_0].selected, iter_13_0 == self.contextData.GKIndex)
	end

	local var_13_3 = #self.activeIDList == #self.allIDList and self.activityData.data1 == 1

	setActive(self.medalTF:Find("Lock"), not (#self.activeIDList == #self.allIDList and self.activityData.data1 == 1))
	setActive(self.medalTF:Find("Unlock"), var_13_3)
	self:UpdateInfo()
	setText(self.progressText, i18n("ssssmedal_tip", #self.activeIDList))

	return
end

function SSSSMedalCollectionView:UpdateInfo()
	local var_15_0 = SSSSMedalCollectionView.INDEX_CONVERT[self.contextData.GKIndex]

	;(function()
		local var_16_0 = self.allIDList[2 * var_15_0 - 1]
		local var_16_1 = table.contains(self.activeIDList, self.allIDList[2 * var_15_0 - 1])
		local var_16_2 = not var_16_1 and table.contains(self.activatableIDList, var_16_0)
		local var_16_3 = not var_16_1 and not var_16_2
		local var_16_4 = self.infoArea1

		setActive(self.infoArea1:Find("Lock"), not var_16_1 and not var_16_2)
		setActive(var_16_4:Find("Unlockable"), var_16_2)
		setActive(var_16_4:Find("Unlock"), var_16_1)

		if var_16_1 then
			setText(var_16_4:Find("Unlock/TextName"), i18n("ssssmedal_name") .. i18n("ssssmedal_name" .. var_15_0))
			setText(var_16_4:Find("Unlock/TextDetail"), i18n("ssssmedal_belonging") .. i18n("ssssmedal_belonging" .. (var_15_0 == 6 and 2 or 1)))
			self.loader:GetSpriteQuiet("ui/SSSSMedalCollectionUI_atlas", "icon_" .. var_0_1[var_15_0], self.infoIcon)
		elseif var_16_3 then
			setText(var_16_4:Find("Lock/BG/TextTip"), self.activityData:getConfig("config_client").unlock_desc[2 * var_15_0 - 1])
		end

		return
	end)()
	;(function()
		local var_17_0 = self.allIDList[2 * var_15_0]
		local var_17_1 = table.contains(self.activeIDList, self.allIDList[2 * var_15_0])
		local var_17_2 = not var_17_1 and table.contains(self.activatableIDList, var_17_0)
		local var_17_3 = not var_17_1 and not var_17_2
		local var_17_4 = self.infoArea2

		setActive(self.infoArea2:Find("Lock"), not var_17_1 and not var_17_2)
		setActive(var_17_4:Find("Unlockable"), var_17_2)
		setActive(var_17_4:Find("Unlock"), var_17_1)

		if var_17_1 then
			setText(var_17_4:Find("Unlock"), i18n("ssssmedal_desc" .. var_15_0))
		elseif var_17_3 then
			setText(var_17_4:Find("Lock"), self.activityData:getConfig("config_client").unlock_desc[2 * var_15_0])
		end

		return
	end)()

	return
end

function SSSSMedalCollectionView:willExit()
	self.loader:Clear()

	return
end

return SSSSMedalCollectionView
