local IcecreamPTPage = class("IcecreamPTPage", import(".TemplatePage.PtTemplatePage"))

IcecreamPTPage.FADE_TIME = 0.5
IcecreamPTPage.SHOW_TIME = 1
IcecreamPTPage.FADE_OUT_TIME = 0.5
IcecreamPTPage.Menu_Ani_Open_Time = 0.5
IcecreamPTPage.Menu_Ani_Close_Time = 0.3
IcecreamPTPage.PosList = {
	188,
	70,
	-55,
	-178
}
IcecreamPTPage.Icecream_Save_Tag_Pre = "Icecream_Tag_"

function IcecreamPTPage:OnDataSetting()
	IcecreamPTPage.super.OnDataSetting(self)

	self.specialPhaseList = self.activity:getConfig("config_data")
	self.selectedList = self:getSelectedList()
	self.curSelectOrder = 0
	self.curSelectIndex = 0

	return
end

function IcecreamPTPage:OnFirstFlush()
	IcecreamPTPage.super.OnFirstFlush(self)
	self:findUI()
	self:initMainPanel()
	self:addListener()
	self:initSD()

	return
end

function IcecreamPTPage:OnUpdateFlush()
	IcecreamPTPage.super.OnUpdateFlush(self)

	local var_3_0, var_3_1, var_3_2 = self.ptData:GetLevelProgress()

	setText(self.step, var_3_0)

	if isActive(self.specialTF) then
		setActive(self.specialTF, false)
	end

	self:updateIcecream()
	self:updateMainSelectPanel()
	setActive(self.openBtn, self:isFinished())
	setActive(self.shareBtn, self:isFinished())

	return
end

function IcecreamPTPage:OnDestroy()
	if self.spine then
		self.spine.transform.localScale = Vector3.one

		pg.PoolMgr.GetInstance():ReturnSpineChar("salatuojia_8", self.spine)

		self.spine = nil
	end

	if self.shareGo then
		PoolMgr.GetInstance():ReturnUI("IcecreamSharePage", self.shareGo)

		self.shareGo = nil
	end

	return
end

function IcecreamPTPage:findUI()
	self.shareBtn = self.bg:Find("Logo/share_btn")
	self.icecreamTF = self.bg:Find("Icecream")
	self.openBtn = self.bg:Find("open_btn")
	self.helpBtn = self.bg:Find("help_btn")
	self.specialTF = self._tf:Find("Special")
	self.backBG = self.specialTF:Find("BG")
	self.menuTF = self.specialTF:Find("Menu")
	self.mainPanel = self.menuTF:Find("MainPanel")
	self.mainToggleTFList = {}

	for iter_5_0 = 1, 4 do
		self.mainToggleTFList[iter_5_0] = self.mainPanel:GetChild(iter_5_0 - 1)
	end

	self.secondPanel = self.menuTF:Find("SecondList")
	self.selectBtn = self.menuTF:Find("SelectBtn")
	self.mainPanelCG = GetComponent(self.mainPanel, "CanvasGroup")
	self.secondPanelCG = GetComponent(self.secondPanel, "CanvasGroup")
	self.selectBtnImg = GetComponent(self.selectBtn, "Image")
	self.resTF = self._tf:Find("Res")
	self.iconTable = {
		["1"] = {
			self.resTF:Find("1/1"),
			self.resTF:Find("1/2"),
			(self.resTF:Find("1/3"))
		},
		["21"] = {
			self.resTF:Find("2/1/1"),
			self.resTF:Find("2/1/2"),
			(self.resTF:Find("2/1/3"))
		},
		["22"] = {
			self.resTF:Find("2/2/1"),
			self.resTF:Find("2/2/2"),
			(self.resTF:Find("2/2/3"))
		},
		["23"] = {
			self.resTF:Find("2/3/1"),
			self.resTF:Find("2/3/2"),
			(self.resTF:Find("2/3/3"))
		},
		["3"] = {
			self.resTF:Find("3/1"),
			self.resTF:Find("3/2"),
			(self.resTF:Find("3/3"))
		},
		["4"] = {
			self.resTF:Find("4/1"),
			self.resTF:Find("4/2"),
			(self.resTF:Find("4/3"))
		}
	}
	self.icecreamResTF = self._tf:Find("Icecream")
	self.mainToggleSelectedTF = {}
	self.mainToggleUnlockTF = {}

	for iter_5_1, iter_5_2 in ipairs(self.mainToggleTFList) do
		self.mainToggleSelectedTF[iter_5_1] = iter_5_2:GetChild(1)
		self.mainToggleUnlockTF[iter_5_1] = iter_5_2:GetChild(0)
	end

	return
end

function IcecreamPTPage:addListener()
	if IsUnityEditor then
		onButton(self, self.bg:Find("Logo"), function()
			for iter_7_0 = 1, 4 do
				PlayerPrefs.SetInt(IcecreamPTPage.Icecream_Save_Tag_Pre .. iter_7_0, 0)
			end

			return
		end, SFX_PANEL)
	end

	onButton(self, self.getBtn, function()
		local var_8_0, var_8_1, var_8_2 = self.ptData:GetLevelProgress()
		local var_8_3 = table.indexof(self.specialPhaseList, var_8_0, 1)

		if var_8_3 then
			self:openMainPanel(var_8_3)
		else
			local var_8_4 = {}
			local var_8_5 = self.ptData:GetAward()

			if var_8_5.type == DROP_TYPE_RESOURCE and var_8_5.id == PlayerConst.ResGold and getProxy(PlayerProxy):getData():GoldMax(var_8_5.count) then
				table.insert(var_8_4, function(arg_9_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("gold_max_tip_title") .. i18n("award_max_warning"),
						onYes = arg_9_0
					})

					return
				end)
			end

			seriesAsync(var_8_4, function()
				local var_10_0, var_10_1 = self.ptData:GetResProgress()

				self:emit(ActivityMediator.EVENT_PT_OPERATION, {
					cmd = 1,
					activity_id = self.ptData:GetId(),
					arg1 = var_10_1
				})

				return
			end)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.openBtn, function()
		self:openMainPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.icecream_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.shareBtn, function()
		self:share()

		return
	end, SFX_PANEL)

	return
end

function IcecreamPTPage:initMainPanel()
	onButton(self, self.backBG, function()
		self:closeSpecial()

		if self:isFinished() then
			setActive(self.openBtn, true)
		end

		return
	end, SFX_CANCEL)

	for iter_15_0, iter_15_1 in ipairs(self.mainToggleTFList) do
		onToggle(self, iter_15_1, function(arg_17_0)
			if arg_17_0 == true then
				self.curSelectOrder = iter_15_0

				setLocalPosition(self.secondPanel, {
					y = IcecreamPTPage.PosList[iter_15_0]
				})
				setLocalPosition(self.selectBtn, {
					y = IcecreamPTPage.PosList[iter_15_0]
				})

				local var_17_0

				if iter_15_0 == 1 then
					var_17_0 = self.iconTable["1"]
				elseif iter_15_0 == 2 then
					var_17_0 = self.iconTable[2 .. self.selectedList[1]]
				elseif iter_15_0 == 3 then
					var_17_0 = self.iconTable["3"]
				elseif iter_15_0 == 4 then
					var_17_0 = self.iconTable["4"]
				end

				local var_17_1 = {}

				for iter_17_0 = 1, 3 do
					var_17_1[iter_17_0] = self.secondPanel:GetChild(iter_17_0)
				end

				for iter_17_1 = 1, 3 do
					setImageSprite(var_17_1[iter_17_1]:Find("icon"), getImageSprite(var_17_0[iter_17_1]), true)
					onToggle(self, var_17_1[iter_17_1], function(arg_18_0)
						if arg_18_0 == true then
							local var_18_0 = Clone(self.selectedList)

							var_18_0[self.curSelectOrder] = iter_17_1

							self:updateIcecream(var_18_0)
							self:openSelectBtn()

							self.curSelectIndex = iter_17_1
						else
							setActive(self.selectBtn, false)

							self.curSelectIndex = 0
						end

						return
					end, SFX_PANEL)
				end

				for iter_17_2 = 1, 3 do
					triggerToggle(var_17_1[iter_17_2], false)
				end

				self:openSecondPanel()
				setActive(self.selectBtn, false)
			else
				self.curSelectOrder = 0

				setActive(self.secondPanel, false)
				setActive(self.selectBtn, false)
			end

			self:updateMainSelectPanel()

			return
		end, SFX_PANEL)
	end

	onButton(self, self.selectBtn, function()
		if not self:isFinished() then
			if self.curSelectIndex then
				local var_19_0, var_19_1 = self.ptData:GetResProgress()

				self:emit(ActivityMediator.EVENT_PT_OPERATION, {
					cmd = 1,
					activity_id = self.ptData:GetId(),
					arg1 = var_19_1,
					arg2 = self.curSelectIndex,
					callback = function()
						self.selectedList[self.curSelectOrder] = self.curSelectIndex

						self:closeSpecial()

						return
					end
				})
			end
		else
			self:changeIndexSelect()
			self:updateIcecream()
			self:updateMainSelectPanel()
		end

		return
	end, SFX_PANEL)

	return
end

function IcecreamPTPage:openMainPanel(arg_21_1)
	self.selectedList = self:getSelectedList()

	setActive(self.displayBtn, false)
	setActive(self.slider, false)
	setActive(self.awardTF, false)
	setActive(self.progress, false)

	for iter_21_0 = 1, 4 do
		triggerToggle(self.mainToggleTFList[iter_21_0], false)

		GetComponent(self.mainToggleTFList[iter_21_0], "Toggle").interactable = self:isFinished()
	end

	self:updateMainSelectPanel()
	setActive(self.specialTF, true)
	LeanTween.value(go(self.mainPanel), 0, 1, IcecreamPTPage.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_22_0)
		self.mainPanelCG.alpha = arg_22_0

		return
	end)):setOnComplete(System.Action(function()
		self.mainPanelCG.alpha = 1

		return
	end))
	LeanTween.value(go(self.mainPanel), -391, -271, IcecreamPTPage.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_24_0)
		setLocalPosition(self.mainPanel, {
			x = arg_24_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(self.mainPanel, {
			x = -271
		})

		if arg_21_1 and arg_21_1 > 0 then
			triggerToggle(self.mainToggleTFList[arg_21_1], true)
		end

		return
	end))

	return
end

function IcecreamPTPage:closeMainPanel()
	LeanTween.value(go(self.mainPanel), 1, 0, IcecreamPTPage.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_27_0)
		self.mainPanelCG.alpha = arg_27_0

		return
	end)):setOnComplete(System.Action(function()
		self.mainPanelCG.alpha = 0

		setActive(self.specialTF, false)

		return
	end))
	LeanTween.value(go(self.mainPanel), -271, -391, IcecreamPTPage.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_29_0)
		setLocalPosition(self.mainPanel, {
			x = arg_29_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(self.mainPanel, {
			x = -391
		})
		setActive(self.specialTF, false)
		self:updateIcecream()
		setActive(self.displayBtn, true)
		setActive(self.slider, true)
		setActive(self.awardTF, true)
		setActive(self.progress, true)

		return
	end))

	return
end

function IcecreamPTPage:openSecondPanel()
	setActive(self.secondPanel, true)
	LeanTween.value(go(self.secondPanel), 0, 1, IcecreamPTPage.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_32_0)
		self.secondPanelCG.alpha = arg_32_0

		return
	end)):setOnComplete(System.Action(function()
		self.secondPanelCG.alpha = 1

		return
	end))
	LeanTween.value(go(self.secondPanel), -646, -213, IcecreamPTPage.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_34_0)
		setLocalPosition(self.secondPanel, {
			x = arg_34_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(self.secondPanel, {
			x = -213
		})

		return
	end))

	return
end

function IcecreamPTPage:closeSecondPanel()
	LeanTween.value(go(self.secondPanel), 1, 0, IcecreamPTPage.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_37_0)
		self.secondPanelCG.alpha = arg_37_0

		return
	end)):setOnComplete(System.Action(function()
		self.secondPanelCG.alpha = 0

		setActive(self.secondPanel, false)

		return
	end))
	LeanTween.value(go(self.secondPanel), -213, -646, IcecreamPTPage.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_39_0)
		setLocalPosition(self.secondPanel, {
			x = arg_39_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(self.secondPanel, {
			x = -646
		})
		setActive(self.secondPanel, false)
		self:closeMainPanel()

		return
	end))

	return
end

function IcecreamPTPage:openSelectBtn()
	setLocalPosition(self.selectBtn, {
		x = 287
	})
	setActive(self.selectBtn, true)
	LeanTween.value(go(self.selectBtn), 0, 1, IcecreamPTPage.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_42_0)
		setImageAlpha(self.selectBtn, arg_42_0)

		return
	end)):setOnComplete(System.Action(function()
		setImageAlpha(self.selectBtn, 1)

		return
	end))

	return
end

function IcecreamPTPage:closeSelectBtn()
	LeanTween.value(go(self.selectBtn), 1, 0, IcecreamPTPage.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_45_0)
		setImageAlpha(self.selectBtn, arg_45_0)

		return
	end)):setOnComplete(System.Action(function()
		setImageAlpha(self.selectBtn, 0)
		setActive(self.selectBtn, false)

		return
	end))

	return
end

function IcecreamPTPage:closeSpecial()
	self:closeSelectBtn()
	self:closeSecondPanel()

	return
end

function IcecreamPTPage:updateIcecream(arg_48_1)
	local var_48_0 = arg_48_1 or self.selectedList

	setActive(self.icecreamTF, (arg_48_1 or self.selectedList)[1] > 0)

	local var_48_1 = self.icecreamTF:Find("1")
	local var_48_2 = self.icecreamTF:Find("2")
	local var_48_3 = self.icecreamTF:Find("3")
	local var_48_4 = self.icecreamTF:Find("4")
	local var_48_5 = var_48_0[1] and var_48_0[1] > 0

	if var_48_5 then
		for iter_48_0, iter_48_1 in pairs(var_48_0) do
			if iter_48_1 > 0 and iter_48_0 > 1 then
				var_48_5 = false
			end
		end
	end

	setActive(var_48_1, var_48_5)
	setActive(var_48_2, var_48_0[2] and var_48_0[2] > 0)
	setActive(var_48_3, var_48_0[3] and var_48_0[3] > 0)
	setActive(var_48_4, var_48_0[4] and var_48_0[4] > 0)

	if var_48_5 then
		setImageSprite(var_48_1:Find("Taste"), getImageSprite(self.icecreamResTF:Find("1_" .. var_48_0[1])), true)
	end

	if var_48_0[2] and var_48_0[2] > 0 then
		setImageSprite(var_48_2, getImageSprite(self.icecreamResTF:Find("2_" .. var_48_0[1] .. var_48_0[2])), true)
	end

	if var_48_0[3] and var_48_0[3] > 0 then
		setImageSprite(var_48_3, getImageSprite(self.icecreamResTF:Find("3_" .. var_48_0[3])), true)
	end

	if var_48_0[4] and var_48_0[4] > 0 then
		setImageSprite(var_48_4, getImageSprite(self.icecreamResTF:Find("4_" .. var_48_0[4])), true)
	end

	return
end

function IcecreamPTPage:updateMainSelectPanel()
	for iter_49_0 = 1, 4 do
		setActive(self.mainToggleUnlockTF[iter_49_0], self.selectedList[iter_49_0] and self.selectedList[iter_49_0] > 0)
	end

	if self.curSelectOrder > 0 then
		setActive(self.mainToggleUnlockTF[self.curSelectOrder], true)
	end

	if self.selectedList[1] and self.selectedList[1] > 0 then
		setImageSprite(self.mainToggleSelectedTF[1], getImageSprite(self.iconTable["1"][self.selectedList[1]]), true)
		setActive(self.mainToggleSelectedTF[1], true)
	else
		setActive(self.mainToggleSelectedTF[1], false)
	end

	if self.selectedList[2] and self.selectedList[2] > 0 then
		setImageSprite(self.mainToggleSelectedTF[2], getImageSprite(self.iconTable[2 .. self.selectedList[1]][self.selectedList[2]]), true)
		setActive(self.mainToggleSelectedTF[2], true)
	else
		setActive(self.mainToggleSelectedTF[2], false)
	end

	if self.selectedList[3] and self.selectedList[3] > 0 then
		setImageSprite(self.mainToggleSelectedTF[3], getImageSprite(self.iconTable["3"][self.selectedList[3]]), true)
		setActive(self.mainToggleSelectedTF[3], true)
	else
		setActive(self.mainToggleSelectedTF[3], false)
	end

	if self.selectedList[4] and self.selectedList[4] > 0 then
		setImageSprite(self.mainToggleSelectedTF[4], getImageSprite(self.iconTable["4"][self.selectedList[4]]), true)
		setActive(self.mainToggleSelectedTF[4], true)
	else
		setActive(self.mainToggleSelectedTF[4], false)
	end

	return
end

function IcecreamPTPage:isFinished()
	return #self.activity.data2_list == 4
end

function IcecreamPTPage:changeIndexSelect()
	self.selectedList[self.curSelectOrder] = self.curSelectIndex

	PlayerPrefs.SetInt(IcecreamPTPage.Icecream_Save_Tag_Pre .. self.curSelectOrder, self.curSelectIndex)

	return
end

function IcecreamPTPage:getSelectedList()
	self.selectedList = {
		0,
		0,
		0,
		0
	}

	for iter_52_0, iter_52_1 in ipairs(self.activity.data2_list) do
		self.selectedList[iter_52_0] = iter_52_1
	end

	if self:isFinished() then
		for iter_52_2 = 1, 4 do
			local var_52_0 = PlayerPrefs.GetInt(IcecreamPTPage.Icecream_Save_Tag_Pre .. iter_52_2, 0)

			if var_52_0 > 0 then
				self.selectedList[iter_52_2] = var_52_0
			end
		end
	end

	self:saveSelectedList()

	return self.selectedList
end

function IcecreamPTPage:saveSelectedList()
	for iter_53_0 = 1, 4 do
		PlayerPrefs.SetInt(IcecreamPTPage.Icecream_Save_Tag_Pre .. iter_53_0, self.selectedList[iter_53_0])
	end

	return
end

function IcecreamPTPage:share()
	PoolMgr.GetInstance():GetUI("IcecreamSharePage", false, function(arg_55_0)
		SetParent(arg_55_0, GameObject.Find("UICamera/Canvas/UIMain"), false)

		self.shareGo = arg_55_0

		local var_55_0 = arg_55_0:Find("IcecreamContainer")

		setText(arg_55_0:Find("PlayerName"), i18n("icecream_make_tip", getProxy(PlayerProxy):getData().name))

		local var_55_1 = getProxy(PlayerProxy)
		local var_55_2 = var_55_1:getRawData()
		local var_55_3 = getProxy(UserProxy):getRawData()
		local var_55_4 = getProxy(ServerProxy).getRawData(var_55_1)[(var_55_3 or nil) and (var_55_3.server or 0)]
		local var_55_5

		if var_55_2 then
			var_55_5 = var_55_2.name or ""

			local var_55_6

			if var_55_4 then
				var_55_6 = var_55_4.name or ""
			end
		end

		local var_55_7 = arg_55_0:Find("deck")

		setText(var_55_7:Find("name/value"), var_55_5)
		setText(var_55_7:Find("server/value"), var_55_6)
		setText(var_55_7:Find("lv/value"), var_55_2.level)

		local var_55_8 = cloneTplTo(self.icecreamTF, var_55_0)

		setLocalPosition(tf(var_55_8), {
			x = 0,
			y = 0
		})
		setLocalScale(tf(var_55_8), {
			x = 1.4,
			y = 1.4
		})
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeIcecream)

		if self.shareGo then
			PoolMgr.GetInstance():ReturnUI("IcecreamSharePage", self.shareGo)

			self.shareGo = nil
		end

		return
	end)

	return
end

function IcecreamPTPage:initSD()
	self.sdContainer = self.bg:Find("sdcontainer")
	self.spine = nil
	self.spineLRQ = GetSpineRequestPackage.New("salatuojia_8", function(arg_57_0)
		SetParent(arg_57_0, self.sdContainer)

		self.spine = arg_57_0
		self.spine.transform.localScale = Vector3.one

		local var_57_0 = self.spine:GetComponent("SpineAnimUI")

		if var_57_0 then
			var_57_0:SetAction("stand", 0)
		end

		self.spineLRQ = nil

		return
	end):Start()

	setActive(self.sdContainer, true)

	return
end

return IcecreamPTPage
