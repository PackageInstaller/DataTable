local CommanderCatPlayPage = class("CommanderCatPlayPage", import("view.base.BaseSubView"))

function CommanderCatPlayPage:getUIName()
	return "CommanderCatPlayui"
end

function CommanderCatPlayPage:OnLoaded()
	self.skillTF = self._tf:Find("skill/frame")
	self.skillNameTxt = self.skillTF:Find("name"):GetComponent(typeof(Text))
	self.skillIcon = self.skillTF:Find("icon/Image")
	self.skillLvTxt = self.skillTF:Find("level_container/level"):GetComponent(typeof(Text))
	self.skillAdditionTxt = self.skillTF:Find("level_container/addition"):GetComponent(typeof(Text))
	self.expTxt = self.skillTF:Find("exp/Text"):GetComponent(typeof(Text))
	self.descBtn = self._tf:Find("skill/frame/desc")
	self.descPage = self._tf:Find("skill_desc")
	self.descToggle = self.descPage:Find("tags")
	self.descToggleMark = self.descToggle:Find("sel")
	self.skillDescList = UIItemList.New(self.descPage:Find("content/list"), self.descPage:Find("content/list/tpl"))

	setActive(self.descPage, false)

	self.commanderLvTxt = self._tf:Find("select_panel/exp_bg/level_bg/Text"):GetComponent(typeof(Text))
	self.levelAdditionTxt = self._tf:Find("select_panel/exp_bg/level_bg/addition"):GetComponent(typeof(Text))
	self.preExpSlider = self._tf:Find("select_panel/exp_bg/slider"):GetComponent(typeof(Slider))
	self.expSlider = self._tf:Find("select_panel/exp_bg/slider/exp"):GetComponent(typeof(Slider))
	self.sliderExpTxt = self._tf:Find("select_panel/exp_bg/slider/Text"):GetComponent(typeof(Text))
	self.uilist = UIItemList.New(self._tf:Find("select_panel/frame/list"), self._tf:Find("select_panel/frame/list/commandeTF"))
	self.consumeTxt = self._tf:Find("select_panel/consume/Text"):GetComponent(typeof(Text))
	self.confirmBtn = self._tf:Find("select_panel/confirm_btn")
	self.animation = CommanderCatPlayAnimation.New(self.expSlider)

	setText(self._tf:Find("select_panel/title"), i18n("commander_confirm_tip"))
	setText(self._tf:Find("skill_desc/title"), i18n("commander_skill_effect"))

	return
end

function CommanderCatPlayPage:OnInit()
	self:RegisterEvent()
	onButton(self, self.descBtn, function()
		if self.isOpenDescPage then
			self:CloseDescPage()

			self.isOpenDescPage = false
		else
			self.isOpenDescPage = true

			self:UpdateDescPage()
			self:emit(CommanderCatScene.EVENT_CLOSE_DESC)
		end

		setActive(self.descBtn:Find("sel"), self.isOpenDescPage)

		return
	end, SFX_PANEL)
	setActive(self.descBtn:Find("sel"), false)

	self.commonFlag = true

	onButton(self, self.descToggle, function()
		self.commonFlag = not self.commonFlag

		setAnchoredPosition(self.descToggleMark, {
			x = self.commonFlag and 0 or self.descToggleMark.rect.width
		})
		self:UpdateDescPage()

		return
	end, SFX_PANEL)

	return
end

function CommanderCatPlayPage:RegisterEvent()
	self:bind(CommanderCatScene.EVENT_OPEN_DESC, function(arg_7_0)
		if self.isOpenDescPage then
			triggerButton(self.descBtn)
		end

		return
	end)
	self:bind(CommanderCatScene.MSG_UPGRADE, function(arg_8_0, arg_8_1, arg_8_2)
		self.preExpSlider.value = 0

		pg.UIMgr.GetInstance():LoadingOn(false)
		self.animation:Action(arg_8_1, arg_8_2, function()
			pg.UIMgr.GetInstance():LoadingOff()
			self:Flush(arg_8_2)
			self:emit(CommanderCatScene.EVENT_UPGRADE)

			return
		end)

		return
	end)
	self:bind(CommanderCatScene.EVENT_FOLD, function(arg_10_0, arg_10_1)
		if arg_10_1 then
			LeanTween.moveX(rtf(self._tf), 1000, 0.5)
		else
			LeanTween.moveX(rtf(self._tf), -410, 0.5)
		end

		return
	end)
	self:bind(CommanderCatScene.EVENT_SWITCH_PAGE, function(arg_11_0, arg_11_1)
		if arg_11_1 == CommanderCatScene.PAGE_DOCK then
			self:ClearSortData()
		end

		return
	end)
	self:bind(CommanderCatScene.EVENT_SELECTED, function(arg_12_0, arg_12_1)
		self:Flush(arg_12_1)

		return
	end)

	return
end

function CommanderCatPlayPage:Flush(arg_13_1)
	self.commander = arg_13_1
	self.contextData.materialIds = {}

	self:UpdateMaterials()

	return
end

function CommanderCatPlayPage:Show(arg_14_1)
	CommanderCatPlayPage.super.Show(self)

	self.commander = arg_14_1

	self:UpdateMaterials()

	if self.isOpenDescPage then
		self:UpdateDescPage()
	end

	return
end

function CommanderCatPlayPage:UpdateMaterials()
	self.uilist:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			self:UpdateCard(arg_16_1, arg_16_2)
		end

		return
	end)
	self.uilist:align(CommanderConst.PLAY_MAX_COUNT)
	self:UpdateMainView()

	return
end

function CommanderCatPlayPage:UpdateMainView()
	local var_17_0 = self.contextData.materialIds or {}
	local var_17_1, var_17_2 = CommanderCatUtil.GetSkillExpAndCommanderExp(self.commander, var_17_0)

	self:UpdateSkillTF(var_17_2)
	self:UpdateCommanderTF(var_17_1)
	self:UpdateConsume(var_17_0, var_17_2)
	setActive(go(self.skillAdditionTxt), #var_17_0 > 0)
	setActive(go(self.levelAdditionTxt), #var_17_0 > 0)

	return
end

function CommanderCatPlayPage:UpdateDescPage()
	local function var_18_0(arg_19_0, arg_19_1)
		if not arg_19_0 and arg_19_1.desc_world and arg_19_1.desc_world ~= "" then
			return arg_19_1.desc_world
		else
			return arg_19_1.desc
		end

		return
	end

	setActive(self.descPage, true)

	local var_18_1 = self.commander:getSkills()[1]
	local var_18_2 = var_18_1:GetSkillGroup()
	local var_18_3 = var_18_1:getConfig("lv")

	self.skillDescList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0 = var_18_2[arg_20_1 + 1]
			local var_20_1 = var_18_3 >= var_18_2[arg_20_1 + 1].lv and "#66472a" or "#a3a2a2"

			setText(arg_20_2, "<color=" .. (var_18_3 >= var_18_2[arg_20_1 + 1].lv and "#66472a" or "#a3a2a2") .. ">" .. var_18_0(self.commonFlag, var_18_2[arg_20_1 + 1]) .. "</color>" .. (var_18_3 < var_18_2[arg_20_1 + 1].lv and "(Lv." .. var_20_0.lv .. i18n("word_take_effect") .. ")" or ""))
			setText(arg_20_2:Find("level"), "<color=" .. var_20_1 .. ">" .. "Lv." .. var_20_0.lv .. "</color>")
		end

		return
	end)
	self.skillDescList:align(#var_18_2)

	return
end

function CommanderCatPlayPage:CloseDescPage()
	setActive(self.descPage, false)

	return
end

function CommanderCatPlayPage:SimulateAddSkillExp(arg_22_1)
	local var_22_0 = self.commander:getSkills()[1]
	local var_22_1 = Clone(var_22_0)

	var_22_1:addExp(arg_22_1)

	return var_22_1, var_22_0
end

function CommanderCatPlayPage:UpdateSkillTF(arg_23_1)
	local var_23_0, var_23_1 = self:SimulateAddSkillExp(arg_23_1)
	local var_23_2 = var_23_1:getConfig("lv")

	GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. var_23_1:getConfig("icon"), "", self.skillIcon)

	self.skillNameTxt.text = var_23_1:getConfig("name")
	self.skillLvTxt.text = "Lv." .. var_23_1:getLevel()
	self.skillAdditionTxt.text = "+" .. var_23_0:getLevel() - var_23_1:getLevel()
	self.expTxt.text = var_23_1:isMaxLevel() and "0/0" or var_23_1.exp .. (arg_23_1 == 0 and "" or "<color=#A9F548FF>(+" .. arg_23_1 .. ")</color>") .. "/" .. var_23_1:getNextLevelExp()

	return
end

function CommanderCatPlayPage:SimulateAddCommanderExp(arg_24_1)
	local var_24_0 = Clone(self.commander)

	var_24_0:addExp(arg_24_1)

	return var_24_0, self.commander
end

function CommanderCatPlayPage:UpdateCommanderTF(arg_25_1)
	local var_25_0, var_25_1 = self:SimulateAddCommanderExp(arg_25_1)

	self:emit(CommanderCatScene.EVENT_PREVIEW_REVERSE, var_25_1, var_25_0)

	self.commanderLvTxt.text = "LV." .. var_25_1.level

	if var_25_1:isMaxLevel() then
		self.expSlider.value = 1
		self.sliderExpTxt.text = "EXP: +0/MAX"
		self.preExpSlider.value = 1
		self.levelAdditionTxt.text = "+0"
	else
		self.expSlider.value = arg_25_1 > 0 and 0 or var_25_1.exp / var_25_1:getNextLevelExp()
		self.sliderExpTxt.text = "EXP: " .. ((arg_25_1 > 0 or nil) and ("<color=#A9F548FF>" .. var_25_1.exp + arg_25_1 .. "</color>" or var_25_1.exp)) .. "/" .. var_25_1:getNextLevelExp()
		self.preExpSlider.value = var_25_0:isMaxLevel() and 1 or var_25_0.exp / var_25_0:getNextLevelExp()
		self.levelAdditionTxt.text = "+" .. var_25_0.level - var_25_1.level
	end

	return
end

function CommanderCatPlayPage:UpdateConsume(arg_26_1, arg_26_2)
	local var_26_0 = getProxy(PlayerProxy):getRawData()

	self.total = CommanderCatUtil.CalcCommanderConsume(arg_26_1)

	if var_26_0.gold < self.total then
		self.consumeTxt.text = "<color=" .. COLOR_RED .. ">" .. self.total .. "</color>" or self.total
	end

	local function var_26_1()
		if var_26_0.gold < self.total then
			GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
				{
					59001,
					self.total - var_26_0.gold,
					self.total
				}
			})

			return
		end

		self:emit(CommanderCatMediator.UPGRADE, self.commander.id, arg_26_1, self.commander:getSkills()[1].id)

		return
	end

	onButton(self, self.confirmBtn, function()
		if not arg_26_1 or #arg_26_1 <= 0 then
			return
		end

		self:CheckTip(arg_26_1, arg_26_2, var_26_1)

		return
	end, SFX_PANEL)

	return
end

function CommanderCatPlayPage:CheckTip(arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = {}

	if CommanderCatUtil.AnySSRCommander(arg_29_1) then
		table.insert(var_29_0, function(arg_30_0)
			self.contextData.msgBox:ExecuteAction("Show", {
				content = i18n("commander_material_is_rarity"),
				onYes = arg_30_0
			})

			return
		end)
	end

	local var_29_1, var_29_2 = self:SimulateAddSkillExp(arg_29_2)

	if var_29_1:isMaxLevel() and var_29_1.exp > 0 and not var_29_2:isMaxLevel() then
		table.insert(var_29_0, function(arg_31_0)
			self.contextData.msgBox:ExecuteAction("Show", {
				content = i18n("commander_exp_overflow_tip"),
				onYes = arg_31_0
			})

			return
		end)
	end

	if self.commander:isMaxLevel() then
		table.insert(var_29_0, function(arg_32_0)
			self.contextData.msgBox:ExecuteAction("Show", {
				content = i18n("commander_material_is_maxLevel"),
				onYes = arg_32_0
			})

			return
		end)
	end

	seriesAsync(var_29_0, arg_29_3)

	return
end

function CommanderCatPlayPage:UpdateCard(arg_33_1, arg_33_2)
	local var_33_0 = self.contextData.materialIds or {}
	local var_33_1 = var_33_0[arg_33_1 + 1]
	local var_33_2 = arg_33_2:Find("add")
	local var_33_3 = arg_33_2:Find("icon")

	if var_33_0[arg_33_1 + 1] then
		onButton(self, var_33_3, function()
			table.remove(var_33_0, (table.indexof(var_33_0, var_33_1)))
			self:UpdateMaterials()

			return
		end, SFX_PANEL)

		local var_33_4 = getProxy(CommanderProxy):getCommanderById(var_33_1)

		GetImageSpriteFromAtlasAsync("commandericon/" .. var_33_4:getPainting(), "", var_33_3)
		setActive(var_33_3:Find("up"), self.commander:isSameGroup(var_33_4.groupId))
		setActive(var_33_3:Find("formation"), var_33_4.inFleet)
		setText(var_33_3:Find("level_bg/Text"), var_33_4.level)
	else
		onButton(self, var_33_2, function()
			if table.getCount(getProxy(CommanderProxy):getRawData()) == 1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("commander_material_noenough"))

				return
			end

			if not self.commander:getSkills()[1]:isMaxLevel() or not self.commander:isMaxLevel() then
				self:emit(CommanderCatMediator.ON_SELECT, self:GenSelectData())
			end

			return
		end, SFX_PANEL)
	end

	setActive(var_33_2, not var_33_1)
	setActive(var_33_3, var_33_1)

	return
end

function CommanderCatPlayPage:GenSelectData()
	local var_36_0 = {
		activeCommander = self.commander
	}

	var_36_0.selectedIds = self.contextData.materialIds or {}

	function var_36_0.onSelected(arg_37_0, arg_37_1)
		self.contextData.materialIds = arg_37_0

		self:UpdateMaterials()
		arg_37_1()

		return
	end

	function var_36_0.OnSort(arg_38_0)
		self:SaveSortData(arg_38_0)

		return
	end

	var_36_0.sortData = self:GetSortData()

	return var_36_0
end

function CommanderCatPlayPage:Hide()
	CommanderCatPlayPage.super.Hide(self)

	return
end

function CommanderCatPlayPage:OnDestroy()
	if self.animation then
		self.animation:Dispose()

		self.animation = nil
	end

	self:ClearSortData()

	return
end

function CommanderCatPlayPage:GetSortData()
	CommanderCatPlayPage.SortData = CommanderCatPlayPage.SortData or Clone(self.contextData.sortData) or {
		asc = true,
		sortData = "Rarity",
		nationData = {},
		rarityData = {}
	}

	return CommanderCatPlayPage.SortData
end

function CommanderCatPlayPage:SaveSortData(arg_42_1)
	CommanderCatPlayPage.SortData = arg_42_1

	return
end

function CommanderCatPlayPage:ClearSortData()
	CommanderCatPlayPage.SortData = nil

	return
end

return CommanderCatPlayPage
