local WinConditionDisplayPanel = class("WinConditionDisplayPanel", BaseSubView)

function WinConditionDisplayPanel:getUIName()
	return "WinConditionDisplayPanel"
end

function WinConditionDisplayPanel:OnInit()
	self.listTF = self._tf:Find("window/bg/awards/awardList")
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.winCondtitle = self._tf:Find("window/bg/winCond/title/text")

	setText(self.winCondtitle, i18n("text_win_condition"))

	self.winCondDesc = self._tf:Find("window/bg/winCond/desc")
	self.loseCondtitle = self._tf:Find("window/bg/loseCond/title/text")

	setText(self.loseCondtitle, i18n("text_lose_condition"))

	self.loseCondDesc = self._tf:Find("window/bg/loseCond/desc")
	self.rewardList = self._tf:Find("window/bg/awards")
	self.rewardtip = self.rewardList:Find("text")

	setText(self.rewardtip, i18n("desc_defense_reward"))

	self.rewardWord = self.rewardList:Find("desc")

	setText(self.rewardWord, i18n("word_reward"))

	self.rewardCond = self.rewardList:Find("cond")

	setText(self.rewardCond, i18n("text_rest_HP"))
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

local var_0_1 = {
	"s",
	"a",
	"b"
}

function WinConditionDisplayPanel:UpdateList(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0

	if #arg_5_3 == 3 then
		self.listTF:GetChild(1).gameObject:SetActive(true)
		self.listTF:GetChild(2).gameObject:SetActive(true)
		self.listTF:GetChild(3).gameObject:SetActive(true)

		var_5_0 = {
			3,
			2,
			1
		}
	elseif #arg_5_3 == 2 then
		self.listTF:GetChild(1).gameObject:SetActive(true)
		self.listTF:GetChild(2).gameObject:SetActive(false)
		self.listTF:GetChild(3).gameObject:SetActive(true)

		var_5_0 = {
			3,
			1
		}
	elseif #arg_5_3 == 1 then
		self.listTF:GetChild(1).gameObject:SetActive(false)
		self.listTF:GetChild(2).gameObject:SetActive(true)
		self.listTF:GetChild(3).gameObject:SetActive(false)

		var_5_0 = {
			2
		}
	end

	local var_5_1 = false

	for iter_5_0 = 1, #arg_5_3 do
		local var_5_2 = self.listTF:GetChild(var_5_0[iter_5_0])
		local var_5_3 = tostring(arg_5_2[iter_5_0] - 1)

		if arg_5_2[iter_5_0] - 1 ~= arg_5_2[iter_5_0 + 1] then
			var_5_3 = tostring(arg_5_2[iter_5_0 + 1]) .. "-" .. var_5_3
		end

		setText(var_5_2:Find("text"), var_5_3)

		local var_5_4 = arg_5_3[iter_5_0]

		updateDrop(var_5_2:Find("award"), arg_5_3[iter_5_0], {
			hideName = true
		})
		onButton(self, var_5_2:Find("award"), function()
			self:emit(BaseUI.ON_DROP, var_5_4)

			return
		end, SFX_PANEL)

		var_5_1 = var_5_1 or arg_5_4 >= arg_5_2[iter_5_0 + 1]

		setActive(var_5_2:Find("mask"), not (not var_5_1 and arg_5_4 >= arg_5_2[iter_5_0 + 1]))
	end

	return
end

function WinConditionDisplayPanel:Enter(arg_7_1)
	setText(self.winCondDesc, i18n(arg_7_1:getConfig("win_condition_display")))
	setText(self.loseCondDesc, i18n(arg_7_1:getConfig("lose_condition_display")))

	local var_7_0 = arg_7_1:getPlayType() == ChapterConst.TypeDefence

	setActive(self.rewardList, var_7_0)

	if var_7_0 then
		self:UpdateRewardList(arg_7_1)
	end

	self:Show()
	Canvas.ForceUpdateCanvases()

	return
end

function WinConditionDisplayPanel:UpdateRewardList(arg_8_1)
	if not pg.chapter_defense[arg_8_1.id] then
		return
	end

	local var_8_0 = Clone(pg.chapter_defense[arg_8_1.id].score)

	table.insert(var_8_0, 1, pg.chapter_defense[arg_8_1.id].port_hp + 1)

	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(var_0_1) do
		if #pg.chapter_defense[arg_8_1.id]["evaluation_display_" .. iter_8_1] > 0 then
			table.insert(var_8_1, {
				type = pg.chapter_defense[arg_8_1.id]["evaluation_display_" .. iter_8_1][1],
				id = pg.chapter_defense[arg_8_1.id]["evaluation_display_" .. iter_8_1][2],
				count = pg.chapter_defense[arg_8_1.id]["evaluation_display_" .. iter_8_1][3]
			})
		end
	end

	self:UpdateList(pg.chapter_defense[arg_8_1.id], var_8_0, var_8_1, arg_8_1.BaseHP)

	return
end

return WinConditionDisplayPanel
