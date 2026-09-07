local IslandSeasonPtPanel = class("IslandSeasonPtPanel", import("view.base.BaseSubView"))

IslandSeasonPtPanel.AWARD_SHOW_CNT = 6
IslandSeasonPtPanel.AWARD_OFFSET = 1e-05

function IslandSeasonPtPanel:getUIName()
	return "IslandSeasonPtPanel"
end

function IslandSeasonPtPanel:OnLoaded()
	local var_2_0 = self._tf:Find("pt")

	self.ptValueTF = var_2_0:Find("pt/value")

	setText(var_2_0:Find("Text"), i18n("island_season_pt_hold"))

	self.getAllBtn = self._tf:Find("get_all")

	setText(self.getAllBtn:Find("Text"), i18n("island_season_pt_collectall"))

	self.blurTF = self._tf:Find("content")
	self.scrollCom = self.blurTF:Find("view"):GetComponent("LScrollRect")
	self.importantAwardTF = self._tf:Find("important")

	return
end

function IslandSeasonPtPanel:OnInit()
	function self.scrollCom.onUpdateItem(arg_4_0, arg_4_1)
		self:UpdateAward(arg_4_0, tf(arg_4_1))

		return
	end

	onButton(self, self.getAllBtn, function()
		self:emit(IslandMediator.ON_GET_SEASON_PT_AWARD, 0)

		return
	end, SFX_PANEL)
	self:BuildPhaseAwardScrollPos()
	self.scrollCom.onValueChanged:AddListener(function(arg_6_0)
		self:UpdateNextAward(arg_6_0.x)

		return
	end)

	return
end

function IslandSeasonPtPanel:UpdateAward(arg_7_1, arg_7_2)
	local var_7_0 = self.awardInfos[arg_7_1 + 1]

	setText(arg_7_2:Find("target"), self.awardInfos[arg_7_1 + 1].target)
	updateCustomDrop(arg_7_2:Find("drop"), var_7_0.drop)

	local var_7_1 = self.pt >= var_7_0.target
	local var_7_2 = table.contains(self.gotList, var_7_0.target)

	setActive(arg_7_2:Find("got"), var_7_2)
	setActive(arg_7_2:Find("get"), not var_7_2 and var_7_1)
	setActive(arg_7_2:Find("lock"), not var_7_1)
	onButton(self, arg_7_2:Find("get"), function()
		self:emit(IslandMediator.ON_GET_SEASON_PT_AWARD, var_7_0.target)

		return
	end, SFX_PANEL)
	onButton(self, arg_7_2, function()
		self.contextData:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_7_0.drop
		})

		return
	end)

	return
end

function IslandSeasonPtPanel:Show()
	self.super.Show(self)
	self:Flush()
	self:OverlayPanel(self._tf, {
		pbList = {
			self.blurTF
		}
	})
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_15")

	return
end

function IslandSeasonPtPanel:Flush()
	if not self:isShowing() then
		return
	end

	self.pt = self.contextData.season:GetPt()
	self.gotList = self.contextData.season:GetGotPtAwardList()

	setText(self.ptValueTF, self.pt)
	setActive(self.getAllBtn, self.contextData.season:GanGetPtAward())
	self.scrollCom:SetTotalCount(#self.awardInfos)
	self:UpdateNextAward(self.scrollCom.value)

	return
end

function IslandSeasonPtPanel:BuildPhaseAwardScrollPos()
	self.awardInfos = IslandSeason.GetPtAwardInfos(self.contextData.season.id)
	self.impTotalPos = self.scrollCom:HeadIndexToValue(#self.awardInfos - IslandSeasonPtPanel.AWARD_SHOW_CNT) - self.scrollCom:HeadIndexToValue(0)
	self.importantInfos = {}

	for iter_12_0, iter_12_1 in pairs(self.awardInfos) do
		if iter_12_1.isImportant then
			table.insert(self.importantInfos, {
				idx = iter_12_0,
				pos = self.scrollCom:HeadIndexToValue(iter_12_0 - IslandSeasonPtPanel.AWARD_SHOW_CNT) / self.impTotalPos
			})
		end
	end

	return
end

function IslandSeasonPtPanel:UpdateNextAward(arg_13_1)
	arg_13_1 = math.min(arg_13_1, 1)

	for iter_13_0, iter_13_1 in pairs(self.importantInfos) do
		if arg_13_1 + IslandSeasonPtPanel.AWARD_OFFSET < iter_13_1.pos then
			setActive(self.importantAwardTF, true)
			self:UpdateAward(iter_13_1.idx - 1, self.importantAwardTF)

			break
		elseif iter_13_0 == #self.importantInfos then
			setActive(self.importantAwardTF, false)
		end
	end

	return
end

function IslandSeasonPtPanel:Hide()
	self.super.Hide(self)
	self:OnHide()

	return
end

function IslandSeasonPtPanel:OnHide()
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandSeasonPtPanel:OnDestroy()
	ClearLScrollrect(self.scrollCom)
	self:OnHide()

	return
end

return IslandSeasonPtPanel
