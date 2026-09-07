local PizzahutPTPage = class("PizzahutPTPage", import(".TemplatePage.PtTemplatePage"))

PizzahutPTPage.FADE_TIME = 0.5
PizzahutPTPage.SHOW_TIME = 1
PizzahutPTPage.FADE_OUT_TIME = 0.5
PizzahutPTPage.Menu_Ani_Open_Time = 0.5
PizzahutPTPage.Menu_Ani_Close_Time = 0.3
PizzahutPTPage.PosList = {
	-256,
	-150,
	-50,
	55,
	160,
	263
}
PizzahutPTPage.Pizza_Save_Tag_Pre = "Pizza_Tag_"

function PizzahutPTPage:OnDataSetting()
	PizzahutPTPage.super.OnDataSetting(self)

	self.specialPhaseList = self.activity:getConfig("config_data")
	self.selectedList = self:getSelectedList()
	self.curSelectOrder = 0
	self.curSelectIndex = 0

	return
end

function PizzahutPTPage:OnFirstFlush()
	PizzahutPTPage.super.OnFirstFlush(self)
	self:findUI()
	self:initMainPanel()
	self:addListener()
	self:initSD()

	return
end

function PizzahutPTPage:OnUpdateFlush()
	PizzahutPTPage.super.OnUpdateFlush(self)

	local var_3_0, var_3_1, var_3_2 = self.ptData:GetResProgress()

	setText(self.progress, (var_3_2 >= 1 and setColorStr(var_3_0, "#947D80FF") or var_3_0) .. "/" .. var_3_1)
	self:updatePizza()
	self:updateMainSelectPanel()
	setActive(self.openBtn, self:isFinished())
	setActive(self.shareBtn, self:isFinished())
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function PizzahutPTPage:OnDestroy()
	if self.spine then
		self.spine.transform.localScale = Vector3.one

		pg.PoolMgr.GetInstance():ReturnSpineChar("chuixue_6", self.spine)

		self.spine = nil
	end

	if self.shareGo then
		PoolMgr.GetInstance():ReturnUI("PizzahutSharePage", self.shareGo)

		self.shareGo = nil
	end

	return
end

function PizzahutPTPage:findUI()
	self.shareBtn = self.bg:Find("share_btn")
	self.empty = self.bg:Find("empty")
	self.pizzaTF = self.bg:Find("Pizza")
	self.openBtn = self.bg:Find("open_btn")
	self.helpBtn = self.bg:Find("help_btn")
	self.specialTF = self._tf:Find("Special")
	self.backBG = self.specialTF:Find("BG")
	self.closeBtn = self.specialTF:Find("CloseBtn")
	self.menuTF = self.specialTF:Find("Menu")
	self.mainPanel = self.menuTF:Find("MainPanel")
	self.mainToggleTFList = {}

	for iter_6_0 = 1, 6 do
		self.mainToggleTFList[iter_6_0] = self.mainPanel:GetChild(iter_6_0 - 1)
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
		["311"] = {
			(self.resTF:Find("3/1/1"))
		},
		["312"] = {
			(self.resTF:Find("3/1/2"))
		},
		["313"] = {
			(self.resTF:Find("3/1/3"))
		},
		["321"] = {
			(self.resTF:Find("3/2/1"))
		},
		["322"] = {
			(self.resTF:Find("3/2/2"))
		},
		["323"] = {
			(self.resTF:Find("3/2/3"))
		},
		["331"] = {
			(self.resTF:Find("3/3/1"))
		},
		["332"] = {
			(self.resTF:Find("3/3/2"))
		},
		["333"] = {
			(self.resTF:Find("3/3/3"))
		},
		["4"] = {
			self.resTF:Find("4/1"),
			self.resTF:Find("4/2"),
			(self.resTF:Find("4/3"))
		},
		["5"] = {
			self.resTF:Find("5/1"),
			self.resTF:Find("5/2"),
			(self.resTF:Find("5/3"))
		},
		["6"] = {
			self.resTF:Find("6/1"),
			self.resTF:Find("6/2"),
			(self.resTF:Find("6/3"))
		}
	}
	self.pizzaResTF = self._tf:Find("Pizza")
	self.mainToggleSelectedTF = {}

	for iter_6_1, iter_6_2 in ipairs(self.mainToggleTFList) do
		self.mainToggleSelectedTF[iter_6_1] = iter_6_2:GetChild(0)
	end

	self.selectedIconResTF = self._tf:Find("SelectedIcon")

	return
end

function PizzahutPTPage:addListener()
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
	onButton(self, self.openBtn, function()
		self:openMainPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.pizzahut_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.shareBtn, function()
		self:share()

		return
	end, SFX_PANEL)

	return
end

function PizzahutPTPage:initMainPanel()
	onButton(self, self.backBG, function()
		self:closeSpecial()

		if self:isFinished() then
			setActive(self.openBtn, true)
		end

		return
	end, SFX_CANCEL)

	for iter_14_0, iter_14_1 in ipairs(self.mainToggleTFList) do
		onToggle(self, iter_14_1, function(arg_16_0)
			self.curSelectOrder = iter_14_0

			if arg_16_0 == true then
				setLocalPosition(self.secondPanel, {
					x = PizzahutPTPage.PosList[iter_14_0]
				})
				setLocalPosition(self.selectBtn, {
					x = PizzahutPTPage.PosList[iter_14_0]
				})

				local var_16_0

				if iter_14_0 == 1 then
					var_16_0 = self.iconTable["1"]
				elseif iter_14_0 == 2 then
					var_16_0 = self.iconTable[2 .. self.selectedList[1]]
				elseif iter_14_0 == 3 then
					var_16_0 = self.iconTable[3 .. self.selectedList[1] .. self.selectedList[2]]
				elseif iter_14_0 >= 4 and iter_14_0 <= 6 then
					var_16_0 = self.iconTable[tostring(iter_14_0)]
				end

				local var_16_1 = {}

				for iter_16_0 = 1, 3 do
					var_16_1[iter_16_0] = self.secondPanel:GetChild(iter_16_0 - 1)
				end

				if #var_16_0 == 1 then
					setActive(var_16_1[2], false)
					setActive(var_16_1[3], false)
					setImageSprite(var_16_1[1]:Find("icon"), getImageSprite(var_16_0[1]), true)
					onToggle(self, var_16_1[1], function(arg_17_0)
						if arg_17_0 == true then
							self:openSelectBtn()

							self.curSelectIndex = 1
						end

						return
					end, SFX_PANEL)
					triggerToggle(var_16_1[1], true)
				else
					setActive(var_16_1[2], true)
					setActive(var_16_1[3], true)

					for iter_16_1 = 1, 3 do
						setImageSprite(var_16_1[iter_16_1]:Find("icon"), getImageSprite(var_16_0[iter_16_1]), true)
						onToggle(self, var_16_1[iter_16_1], function(arg_18_0)
							if arg_18_0 == true then
								self:openSelectBtn()

								self.curSelectIndex = iter_16_1
							else
								setActive(self.selectBtn, false)

								self.curSelectIndex = 0
							end

							return
						end, SFX_PANEL)
					end
				end

				for iter_16_2 = 1, 3 do
					triggerToggle(var_16_1[iter_16_2], false)
				end

				self:openSecondPanel()
				setActive(self.selectBtn, false)
			else
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
			self:updatePizza()
			self:updateMainSelectPanel()
		end

		return
	end, SFX_PANEL)

	return
end

function PizzahutPTPage:openMainPanel(arg_21_1)
	self.selectedList = self:getSelectedList()

	setActive(self.openBtn, false)

	for iter_21_0 = 1, 6 do
		triggerToggle(self.mainToggleTFList[iter_21_0], false)

		GetComponent(self.mainToggleTFList[iter_21_0], "Toggle").interactable = self:isFinished()
	end

	self:updateMainSelectPanel()
	setActive(self.specialTF, true)
	LeanTween.value(go(self.mainPanel), 0, 1, PizzahutPTPage.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_22_0)
		self.mainPanelCG.alpha = arg_22_0

		return
	end)):setOnComplete(System.Action(function()
		self.mainPanelCG.alpha = 1

		return
	end))
	LeanTween.value(go(self.mainPanel), -640, 0, PizzahutPTPage.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_24_0)
		setLocalPosition(self.mainPanel, {
			x = arg_24_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(self.mainPanel, {
			x = 0
		})

		if arg_21_1 and arg_21_1 > 0 then
			triggerToggle(self.mainToggleTFList[arg_21_1], true)
		end

		return
	end))

	return
end

function PizzahutPTPage:closeMainPanel()
	LeanTween.value(go(self.mainPanel), 1, 0, PizzahutPTPage.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_27_0)
		self.mainPanelCG.alpha = arg_27_0

		return
	end)):setOnComplete(System.Action(function()
		self.mainPanelCG.alpha = 0

		setActive(self.specialTF, false)

		return
	end))
	LeanTween.value(go(self.mainPanel), 0, -640, PizzahutPTPage.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_29_0)
		setLocalPosition(self.mainPanel, {
			x = arg_29_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(self.mainPanel, {
			x = -640
		})
		setActive(self.specialTF, false)

		return
	end))

	return
end

function PizzahutPTPage:openSecondPanel()
	setActive(self.secondPanel, true)
	LeanTween.value(go(self.secondPanel), 0, 1, PizzahutPTPage.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_32_0)
		self.secondPanelCG.alpha = arg_32_0

		return
	end)):setOnComplete(System.Action(function()
		self.secondPanelCG.alpha = 1

		return
	end))
	LeanTween.value(go(self.secondPanel), -530, -60, PizzahutPTPage.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_34_0)
		setLocalPosition(self.secondPanel, {
			y = arg_34_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(self.secondPanel, {
			y = -60
		})

		return
	end))

	return
end

function PizzahutPTPage:closeSecondPanel()
	LeanTween.value(go(self.secondPanel), 1, 0, PizzahutPTPage.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_37_0)
		self.secondPanelCG.alpha = arg_37_0

		return
	end)):setOnComplete(System.Action(function()
		self.secondPanelCG.alpha = 0

		setActive(self.secondPanel, false)

		return
	end))
	LeanTween.value(go(self.secondPanel), -60, -530, PizzahutPTPage.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_39_0)
		setLocalPosition(self.secondPanel, {
			y = arg_39_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(self.secondPanel, {
			y = -530
		})
		setActive(self.secondPanel, false)
		self:closeMainPanel()

		return
	end))

	return
end

function PizzahutPTPage:openSelectBtn()
	setActive(self.selectBtn, true)
	LeanTween.value(go(self.selectBtn), 0, 1, PizzahutPTPage.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_42_0)
		setImageAlpha(self.selectBtn, arg_42_0)

		return
	end)):setOnComplete(System.Action(function()
		setImageAlpha(self.selectBtn, 1)

		return
	end))
	LeanTween.value(go(self.selectBtn), -145, -210, PizzahutPTPage.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_44_0)
		setLocalPosition(self.selectBtn, {
			y = arg_44_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(self.selectBtn, {
			y = -210
		})

		return
	end))

	return
end

function PizzahutPTPage:closeSelectBtn()
	LeanTween.value(go(self.selectBtn), 1, 0, PizzahutPTPage.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_47_0)
		setImageAlpha(self.selectBtn, arg_47_0)

		return
	end)):setOnComplete(System.Action(function()
		setImageAlpha(self.selectBtn, 0)
		setActive(self.selectBtn, false)

		return
	end))
	LeanTween.value(go(self.selectBtn), -210, -145, PizzahutPTPage.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_49_0)
		setLocalPosition(self.selectBtn, {
			y = arg_49_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(self.selectBtn, {
			y = -145
		})
		setActive(self.selectBtn, false)

		return
	end))

	return
end

function PizzahutPTPage:closeSpecial()
	self:closeSelectBtn()
	self:closeSecondPanel()

	return
end

function PizzahutPTPage:updatePizza()
	setActive(self.empty, self.selectedList[1] == 0)
	setActive(self.pizzaTF, self.selectedList[1] > 0)

	local var_52_0 = self.pizzaTF:Find("PizzaPan")
	local var_52_1 = self.pizzaTF:Find("PizzaSauce")
	local var_52_2 = self.pizzaTF:Find("PizzaCheese")
	local var_52_3 = self.pizzaTF:Find("EX1")
	local var_52_4 = self.pizzaTF:Find("EX2")
	local var_52_5 = self.pizzaTF:Find("EX3")

	setActive(var_52_0, self.selectedList[1] and self.selectedList[1] > 0)
	setActive(var_52_1, self.selectedList[2] and self.selectedList[2] > 0)
	setActive(var_52_2, self.selectedList[3] and self.selectedList[3] > 0)
	setActive(var_52_3, self.selectedList[4] and self.selectedList[4] > 0)
	setActive(var_52_4, self.selectedList[5] and self.selectedList[5] > 0)
	setActive(var_52_5, self.selectedList[6] and self.selectedList[6] > 0)

	if self.selectedList[1] and self.selectedList[1] > 0 then
		setImageSprite(var_52_0, getImageSprite(self._tf:Find(tostring(self.selectedList[1]), self.pizzaResTF)), true)
	end

	if self.selectedList[2] and self.selectedList[2] > 0 then
		setImageSprite(var_52_1, getImageSprite(self.pizzaResTF:Find(self.selectedList[1] .. self.selectedList[2])), true)
	end

	if self.selectedList[3] and self.selectedList[3] > 0 then
		setImageSprite(var_52_2, getImageSprite(self.pizzaResTF:Find(self.selectedList[1] .. self.selectedList[2] .. self.selectedList[3])), true)
	end

	if self.selectedList[4] and self.selectedList[4] > 0 then
		setImageSprite(var_52_3, getImageSprite(self.pizzaResTF:Find(4 .. self.selectedList[4])), true)
	end

	if self.selectedList[5] and self.selectedList[5] > 0 then
		setImageSprite(var_52_4, getImageSprite(self.pizzaResTF:Find(5 .. self.selectedList[5])), true)
	end

	if self.selectedList[6] and self.selectedList[6] > 0 then
		setImageSprite(var_52_5, getImageSprite(self.pizzaResTF:Find(6 .. self.selectedList[6])), true)
	end

	return
end

function PizzahutPTPage:updateMainSelectPanel()
	if self.selectedList[1] and self.selectedList[1] > 0 then
		setImageSprite(self.mainToggleSelectedTF[1], getImageSprite(self._tf:Find(tostring(self.selectedList[1]), self.selectedIconResTF)), true)
		setActive(self.mainToggleSelectedTF[1], true)
	end

	if self.selectedList[2] and self.selectedList[2] > 0 then
		setImageSprite(self.mainToggleSelectedTF[2], getImageSprite(self.selectedIconResTF:Find(self.selectedList[1] .. self.selectedList[2])), true)
		setActive(self.mainToggleSelectedTF[2], true)
	end

	if self.selectedList[3] and self.selectedList[3] > 0 then
		setImageSprite(self.mainToggleSelectedTF[3], getImageSprite(self.selectedIconResTF:Find(self.selectedList[1] .. self.selectedList[2] .. self.selectedList[3])), true)
		setActive(self.mainToggleSelectedTF[3], true)
	end

	if self.selectedList[4] and self.selectedList[4] > 0 then
		setImageSprite(self.mainToggleSelectedTF[4], getImageSprite(self.selectedIconResTF:Find(4 .. self.selectedList[4])), true)
		setActive(self.mainToggleSelectedTF[4], true)
	end

	if self.selectedList[5] and self.selectedList[5] > 0 then
		setImageSprite(self.mainToggleSelectedTF[5], getImageSprite(self.selectedIconResTF:Find(5 .. self.selectedList[5])), true)
		setActive(self.mainToggleSelectedTF[5], true)
	end

	if self.selectedList[6] and self.selectedList[6] > 0 then
		setImageSprite(self.mainToggleSelectedTF[6], getImageSprite(self.selectedIconResTF:Find(6 .. self.selectedList[6])), true)
		setActive(self.mainToggleSelectedTF[6], true)
	end

	return
end

function PizzahutPTPage:isFinished()
	return #self.activity.data2_list == 6
end

function PizzahutPTPage:changeIndexSelect()
	self.selectedList[self.curSelectOrder] = self.curSelectIndex

	PlayerPrefs.SetInt(PizzahutPTPage.Pizza_Save_Tag_Pre .. self.curSelectOrder, self.curSelectIndex)

	return
end

function PizzahutPTPage:getSelectedList()
	self.selectedList = {
		0,
		0,
		0,
		0,
		0,
		0
	}

	for iter_56_0, iter_56_1 in ipairs(self.activity.data2_list) do
		self.selectedList[iter_56_0] = iter_56_1
	end

	if self:isFinished() then
		for iter_56_2 = 1, 6 do
			local var_56_0 = PlayerPrefs.GetInt(PizzahutPTPage.Pizza_Save_Tag_Pre .. iter_56_2, 0)

			if var_56_0 > 0 then
				self.selectedList[iter_56_2] = var_56_0
			end
		end
	end

	self:saveSelectedList()

	return self.selectedList
end

function PizzahutPTPage:saveSelectedList()
	for iter_57_0 = 1, 6 do
		PlayerPrefs.SetInt(PizzahutPTPage.Pizza_Save_Tag_Pre .. iter_57_0, self.selectedList[iter_57_0])
	end

	return
end

function PizzahutPTPage:share()
	PoolMgr.GetInstance():GetUI("PizzahutSharePage", false, function(arg_59_0)
		SetParent(arg_59_0, GameObject.Find("UICamera/Canvas/UIMain"), false)

		self.shareGo = arg_59_0

		local var_59_0 = arg_59_0:Find("PizzaContainer")

		setText(arg_59_0:Find("PlayerName"), getProxy(PlayerProxy):getData().name)

		local var_59_1 = getProxy(PlayerProxy)
		local var_59_2 = var_59_1:getRawData()
		local var_59_3 = getProxy(UserProxy):getRawData()
		local var_59_4 = getProxy(ServerProxy).getRawData(var_59_1)[(var_59_3 or nil) and (var_59_3.server or 0)]
		local var_59_5

		if var_59_2 then
			var_59_5 = var_59_2.name or ""

			local var_59_6

			if var_59_4 then
				var_59_6 = var_59_4.name or ""
			end
		end

		local var_59_7 = arg_59_0:Find("deck")

		setText(var_59_7:Find("name/value"), var_59_5)
		setText(var_59_7:Find("server/value"), var_59_6)
		setText(var_59_7:Find("lv/value"), var_59_2.level)

		local var_59_8 = cloneTplTo(self.pizzaTF, var_59_0)

		setLocalPosition(tf(var_59_8), {
			x = 0,
			y = 0
		})
		setLocalScale(tf(var_59_8), {
			x = 1.4,
			y = 1.4
		})
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypePizzahut)

		if self.shareGo then
			PoolMgr.GetInstance():ReturnUI("PizzahutSharePage", self.shareGo)

			self.shareGo = nil
		end

		return
	end)

	return
end

function PizzahutPTPage:initSD()
	self.sdContainer = self.bg:Find("sdcontainer")
	self.spine = nil
	self.spineLRQ = GetSpineRequestPackage.New("chuixue_6", function(arg_61_0)
		SetParent(arg_61_0, self.sdContainer)

		self.spine = arg_61_0
		self.spine.transform.localScale = Vector3.one

		local var_61_0 = self.spine:GetComponent("SpineAnimUI")

		if var_61_0 then
			var_61_0:SetAction("stand", 0)
		end

		self.spineLRQ = nil

		return
	end):Start()

	setActive(self.sdContainer, true)

	return
end

function PizzahutPTPage:showBubble(arg_62_1)
	local var_62_0

	if not arg_62_1 then
		if isActive(self.battleBtn) then
			var_62_0 = i18n("sofmapsd_1")
		elseif isActive(self.getBtn) then
			var_62_0 = i18n("sofmapsd_2")
		elseif isActive(self.gotBtn) then
			var_62_0 = i18n("sofmapsd_4")
		end
	else
		var_62_0 = arg_62_1
	end

	setText(self.bubbleText, var_62_0)

	local function var_62_1(arg_63_0)
		self.bubbleCG.alpha = arg_63_0

		setLocalScale(self.bubble, Vector3.one * arg_63_0)

		return
	end

	local function var_62_2()
		LeanTween.value(go(self.bubble), 1, 0, PizzahutPTPage.FADE_OUT_TIME):setOnUpdate(System.Action_float(var_62_1)):setOnComplete(System.Action(function()
			setActive(self.bubble, false)

			return
		end))

		return
	end

	LeanTween.cancel(go(self.bubble))
	setActive(self.bubble, true)
	LeanTween.value(go(self.bubble), 0, 1, PizzahutPTPage.FADE_TIME):setOnUpdate(System.Action_float(var_62_1)):setOnComplete(System.Action(function()
		LeanTween.delayedCall(go(self.bubble), PizzahutPTPage.SHOW_TIME, System.Action(var_62_2))

		return
	end))

	return
end

return PizzahutPTPage
