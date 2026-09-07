local AttireAchievementPanel = class("AttireAchievementPanel", import("...base.BaseSubView"))

local function var_0_1(arg_1_0)
	local var_1_0 = {}

	function var_1_0:Update(arg_3_1, arg_3_2, arg_3_3)
		self.trophy = arg_3_1

		if self.trophy then
			local var_3_0 = self.trophy:isLoverLetter()

			setActive(self.icon, not var_3_0)
			setActive(self.now, var_3_0)

			if var_3_0 then
				setLoveLetterMedal(self.now:Find("medal"), self.trophy, {
					hideMark = true
				})
				setText(self.nameTxt, arg_3_1:getName())
			else
				LoadImageSpriteAsync("medal/" .. arg_3_1:getConfig("icon"), self.icon, true)
				setText(self.nameTxt, arg_3_1:getConfig("name"))
			end

			setActive(self.tags[1], arg_3_1:isNew())
			self:UpdateSelected(arg_3_2)
		end

		setActive(self.print5, not arg_3_3)
		setActive(self.print6, not arg_3_3)
		setActive(self.info, self.trophy)
		setActive(self.empty, not self.trophy)

		return
	end

	function var_1_0:UpdateSelected(arg_4_1)
		setActive(self.selected, arg_4_1)
		setActive(self.tags[2], arg_4_1)

		return
	end

	function var_1_0:Dispose()
		if self.now:Find("medal").childCount > 0 then
			returnLoveLetterMedal(self.now:Find("medal"):GetChild(0))
		end

		return
	end

	;(function(arg_2_0)
		arg_2_0._go = arg_1_0
		arg_2_0._tf = arg_2_0._go.transform
		arg_2_0.info = arg_2_0._tf:Find("info")
		arg_2_0.empty = arg_2_0._tf:Find("empty")
		arg_2_0.icon = arg_2_0._tf:Find("info/icon")
		arg_2_0.now = arg_2_0._tf:Find("info/now")
		arg_2_0.selected = arg_2_0._tf:Find("info/selected")
		arg_2_0.nameTxt = arg_2_0._tf:Find("info/label/Text")
		arg_2_0.tags = {
			arg_2_0._tf:Find("info/tags/new"),
			arg_2_0._tf:Find("info/tags/e")
		}
		arg_2_0.print5 = arg_2_0._tf:Find("prints/line5")
		arg_2_0.print6 = arg_2_0._tf:Find("prints/line6")

		return
	end)(var_1_0)

	return var_1_0
end

local function var_0_2(arg_6_0)
	local var_6_0 = {}

	function var_6_0:Update(arg_8_1)
		self.uiList:make(function(arg_9_0, arg_9_1, arg_9_2)
			if arg_9_0 == UIItemList.EventUpdate then
				local var_9_0 = arg_8_1[arg_9_1 + 1] > 0 and LoveLetterTrophy.New({
					id = arg_8_1[arg_9_1 + 1]
				}) or Trophy.New({
					id = arg_8_1[arg_9_1 + 1]
				})
				local var_9_1 = findTF(arg_9_2, "icon")
				local var_9_2 = arg_9_2:Find("now")
				local var_9_3 = var_9_0:isLoverLetter()

				setActive(var_9_1, not var_9_3)
				setActive(var_9_2, var_9_3)

				if var_9_3 then
					setLoveLetterMedal(var_9_2:Find("medal"), var_9_0, {
						hideMark = true
					})
				else
					LoadImageSpriteAsync("medal/s_" .. var_9_0:getConfig("icon"), var_9_1, true)
				end
			end

			return
		end)
		self.uiList:align(#arg_8_1)

		return
	end

	function var_6_0:Dispose()
		self.uiList:each(function(arg_11_0, arg_11_1)
			if arg_11_1:Find("now/medal").childCount > 0 then
				returnLoveLetterMedal(arg_11_1:Find("now/medal"):GetChild(0))
			end

			return
		end)

		return
	end

	;(function(arg_7_0)
		arg_7_0._tf = arg_6_0
		arg_7_0.uiList = UIItemList.New(arg_7_0._tf:Find("list"), arg_7_0._tf:Find("list/tpl"))

		return
	end)(var_6_0)

	return var_6_0
end

function AttireAchievementPanel:getUIName()
	return "AttireAchievementUI"
end

function AttireAchievementPanel:OnInit()
	self.listPanel = self._tf:Find("list_panel")
	self.scolrect = self.listPanel:Find("scrollrect/content"):GetComponent("LScrollRect")
	self.totalCount = self._tf:Find("total_count/Text"):GetComponent(typeof(Text))
	self.selectedTxt = self.listPanel:Find("selected_bg/Text"):GetComponent(typeof(Text))
	self.toggle = self.listPanel:Find("toggle")

	function self.scolrect.onInitItem(arg_14_0)
		self:OnInitItem(arg_14_0)

		return
	end

	function self.scolrect.onUpdateItem(arg_15_0, arg_15_1)
		self:OnUpdateItem(arg_15_0, arg_15_1)

		return
	end

	self.confirmBtn = self._tf:Find("list_panel/confirm")

	onButton(self, self.confirmBtn, function()
		if #self.contextData.selectedMedalList == #self.playerVO.displayTrophyList and underscore.all(underscore.keys(self.contextData.selectedMedalList), function(arg_17_0)
			return self.contextData.selectedMedalList[arg_17_0] == self.playerVO.displayTrophyList[arg_17_0]
		end) then
			return
		end

		self.event:emit(AttireMediator.ON_CHANGE_MEDAL_DISPLAY, self.contextData.selectedMedalList)

		return
	end, SFX_PANEL)

	self.descPanel = var_0_2(self._tf:Find("desc_panel"))
	self.selectMaxLevel = true

	onToggle(self, self.toggle, function(arg_18_0)
		self.selectMaxLevel = arg_18_0

		self:Filter()

		return
	end)

	self.cards = {}
	self.emptyPage = BaseEmptyListPage.New(self.listPanel, self.event)

	return
end

function AttireAchievementPanel:UpdateselectedTxt()
	self.selectedTxt.text = #(self.contextData.selectedMedalList or {}) .. "/5"

	return
end

function AttireAchievementPanel:OnInitItem(arg_20_1)
	local var_20_0 = var_0_1(arg_20_1)

	self.cards[arg_20_1] = var_20_0

	onButton(self, var_20_0._go, function()
		if not var_20_0.trophy then
			return
		end

		local var_21_0 = self.contextData.selectedMedalList or {}
		local var_21_1 = var_20_0.trophy.id

		if table.contains(var_21_0, var_20_0.trophy.id) then
			table.removebyvalue(var_21_0, var_21_1)
			var_20_0:UpdateSelected(false)
		elseif #var_21_0 >= 5 then
			return
		else
			table.insert(var_21_0, var_21_1)
			var_20_0:UpdateSelected(true)
		end

		self.contextData.selectedMedalList = var_21_0

		self.descPanel:Update(self.contextData.selectedMedalList)
		self:UpdateselectedTxt()

		return
	end, SFX_PANEL)

	return
end

function AttireAchievementPanel:OnUpdateItem(arg_22_1, arg_22_2)
	local var_22_0 = self.cards[arg_22_2]

	if not self.cards[arg_22_2] then
		self:OnInitItem(arg_22_2)

		var_22_0 = self.cards[arg_22_2]
	end

	local var_22_1 = self.displayVOs[arg_22_1 + 1]
	local var_22_2 = arg_22_1 < self.scolrect.content:GetComponent(typeof(GridLayoutGroup)).constraintCount

	if self.displayVOs[arg_22_1 + 1] then
		var_22_0:Update(var_22_1, table.contains(self.contextData.selectedMedalList, var_22_1.id), var_22_2)
	else
		var_22_0:Update(var_22_1, false, var_22_2)
	end

	return
end

function AttireAchievementPanel:Update(arg_23_1, arg_23_2)
	self.playerVO = arg_23_2
	self.trophys = arg_23_1.trophys

	for iter_23_0, iter_23_1 in ipairs(arg_23_1.loveTrophys) do
		self.trophys[iter_23_1.id] = iter_23_1
	end

	self.contextData.selectedMedalList = Clone(self.playerVO.displayTrophyList) or {}

	self.descPanel:Update(self.contextData.selectedMedalList)
	self:UpdateselectedTxt()
	self:Filter()

	self.totalCount.text = self:getTotalCnt()

	local var_23_0 = self:getTotalCnt()

	if var_23_0 <= 0 then
		self.emptyPage:ExecuteAction("ShowOrHide", true)
		self.emptyPage:ExecuteAction("SetEmptyText", i18n("decoration_medal_placeholder"))
		self.emptyPage:ExecuteAction("SetPosY", {
			x = 0,
			y = 22
		})
		setActive(self.listPanel:Find("scrollrect"), false)
	elseif var_23_0 > 0 and self.emptyPage:GetLoaded() then
		self.emptyPage:ExecuteAction("ShowOrHide", false)
		setActive(self.listPanel:Find("scrollrect"), true)
	end

	return
end

function AttireAchievementPanel:getTotalCnt()
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in pairs(self.trophys) do
		if iter_24_1:isClaimed() and not iter_24_1:isHide() then
			var_24_0 = var_24_0 + 1
		end
	end

	return var_24_0
end

function AttireAchievementPanel:Filter()
	self.displayVOs = {}

	local function var_25_0(arg_26_0)
		local var_26_0 = self.trophys[arg_26_0:getConfig("next")]

		return var_26_0 and var_26_0:isClaimed() and not var_26_0:isHide()
	end

	for iter_25_0, iter_25_1 in pairs(self.trophys) do
		if iter_25_1:isClaimed() and not iter_25_1:isHide() and (not self.selectMaxLevel or not var_25_0(iter_25_1)) then
			table.insert(self.displayVOs, iter_25_1)
		end
	end

	table.sort(self.displayVOs, CompareFuncs({
		function(arg_27_0)
			return arg_27_0.id
		end
	}))

	local var_25_1 = self.scolrect.content:GetComponent(typeof(GridLayoutGroup)).constraintCount
	local var_25_2 = var_25_1 - #self.displayVOs % var_25_1

	if var_25_2 == var_25_1 then
		var_25_2 = 0
	end

	local var_25_3 = var_25_1 * self:GetColumn()

	if var_25_3 > #self.displayVOs then
		var_25_2 = var_25_3 - #self.displayVOs
	end

	for iter_25_2 = 1, var_25_2 do
		table.insert(self.displayVOs, false)
	end

	self.scolrect:SetTotalCount(#self.displayVOs, -1)

	return
end

function AttireAchievementPanel:GetColumn()
	return 2
end

function AttireAchievementPanel:OnDestroy()
	self.descPanel:Dispose()

	if self.emptyPage then
		self.emptyPage:Destroy()

		self.emptyPage = nil
	end

	if self.cards then
		for iter_29_0, iter_29_1 in pairs(self.cards) do
			iter_29_1:Dispose()
		end

		self.cards = nil
	end

	return
end

return AttireAchievementPanel
