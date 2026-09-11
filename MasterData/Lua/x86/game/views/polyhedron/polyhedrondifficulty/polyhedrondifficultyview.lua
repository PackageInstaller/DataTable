local PolyhedronDifficultyView = class("PolyhedronDifficultyView", ReduxView)

function PolyhedronDifficultyView:UIName()
	return "Widget/System/Polyhedron/PolyhedronDifficultyUI"
end

function PolyhedronDifficultyView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronDifficultyView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronDifficultyView:InitUI()
	self:BindCfgUI()

	self.difficultyGroupList = {}
	self.lockGoDict = {}

	local var_4_0 = table.keys(PolyhedronDifficultyCfg.get_id_list_by_unlock_difficulty)

	table.sort(var_4_0, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	local var_4_1 = handler(self, self.DifficultyClick)

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1 ~= 0 then
			local var_4_2 = Object.Instantiate(self.m_lockTip, self.m_content)

			SetActive(var_4_2, true)

			self:FindCom("Text", "text", var_4_2.transform).text = string.format(GetTips("POLYHEDRON_DIFFICULTY_UNLOCK"), iter_4_1)

			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(var_4_2.transform)

			self.lockGoDict[iter_4_1] = var_4_2
		end

		for iter_4_2, iter_4_3 in ipairs(PolyhedronDifficultyCfg.get_id_list_by_unlock_difficulty[iter_4_1]) do
			local var_4_3 = Object.Instantiate(self.m_groupItem, self.m_content)

			SetActive(var_4_3, true)

			local var_4_4 = PolyhedronDifficultyGroupItem.New(var_4_3, iter_4_3)

			var_4_4:RegistCallBack(var_4_1)
			table.insert(self.difficultyGroupList, var_4_4)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content)

	self.overviewList = {}
end

function PolyhedronDifficultyView:AddUIListener()
	self:AddBtnListener(self.m_difficultybtn, nil, function()
		local var_7_0 = PolyhedronData:GetCacheSelectHero() ~= 0 and {
			self.leader
		} or {}

		gameContext:Go("/heroTeamInfoPolyhedron", {
			selectHeroPos = 1,
			heroTeam = var_7_0,
			heroDataType = HeroConst.HERO_DATA_TYPE.POLYHEDRON
		})
	end)
end

function PolyhedronDifficultyView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function PolyhedronDifficultyView:OnEnter()
	manager.ui:SetMainCamera("hero")

	self.maxDifficulty = PolyhedronData:GetClearMaxDifficulty()
	self.selectDifficulty = PolyhedronData:GetCacheSelectDifficulty()

	self:RefreshUI()
end

function PolyhedronDifficultyView:OnExit()
	manager.windowBar:HideBar()
	PolyhedronData:SetCacheSelectDifficulty(self.selectDifficulty)
end

function PolyhedronDifficultyView:RefreshUI()
	for iter_11_0, iter_11_1 in ipairs(self.difficultyGroupList) do
		iter_11_1:SetData(self.maxDifficulty, self.selectDifficulty)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(iter_11_1.gameObject_.transform)
	end

	for iter_11_2, iter_11_3 in pairs(self.lockGoDict) do
		if iter_11_2 > self.maxDifficulty then
			SetActive(iter_11_3, true)
		else
			SetActive(iter_11_3, false)
		end
	end

	self.m_curDifficultyLab.text = self.selectDifficulty

	if self.selectDifficulty == 0 then
		SetActive(self.m_difficultybtnGo, false)

		for iter_11_4, iter_11_5 in ipairs(self.overviewList) do
			iter_11_5:SetActive(false)
		end

		self.m_scoreLab.text = "0%"
	else
		SetActive(self.m_difficultybtnGo, true)

		self.m_scoreLab.text = PolyhedronDifficultyCfg[self.selectDifficulty].score / 10 .. "%"

		local var_11_0 = {}

		PolyhedronTools.CalPolyhedronDifficultyAttr(var_11_0, self.selectDifficulty)

		local var_11_1 = 1

		for iter_11_6, iter_11_7 in pairs(var_11_0) do
			if not self.overviewList[var_11_1] then
				local var_11_2 = Object.Instantiate(self.m_overviewItem, self.m_overviewContent)

				SetActive(var_11_2, true)

				self.overviewList[var_11_1] = PolyhedronDifficultyOverviewItem.New(var_11_2)
			end

			self.overviewList[var_11_1]:SetActive(true)
			self.overviewList[var_11_1]:SetData(2, {
				iter_11_6,
				iter_11_7
			})
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.overviewList[var_11_1].gameObject_.transform)

			var_11_1 = var_11_1 + 1
		end

		for iter_11_8, iter_11_9 in pairs((PolyhedronTools.GetPolyhedronDifficultyAffixDir(self.selectDifficulty))) do
			if not self.overviewList[var_11_1] then
				local var_11_3 = Object.Instantiate(self.m_overviewItem, self.m_overviewContent)

				SetActive(var_11_3, true)

				self.overviewList[var_11_1] = PolyhedronDifficultyOverviewItem.New(var_11_3)
			end

			self.overviewList[var_11_1]:SetActive(true)
			self.overviewList[var_11_1]:SetData(1, iter_11_9)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.overviewList[var_11_1].gameObject_.transform)

			var_11_1 = var_11_1 + 1
		end

		for iter_11_10 = var_11_1, #self.overviewList do
			self.overviewList[iter_11_10]:SetActive(false)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_overviewContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content)
end

function PolyhedronDifficultyView:DifficultyClick(arg_12_1)
	if PolyhedronDifficultyCfg[arg_12_1].unlock_difficulty > self.maxDifficulty then
		return
	end

	self.selectDifficulty = arg_12_1

	self:RefreshUI()
end

function PolyhedronDifficultyView:Dispose()
	for iter_13_0, iter_13_1 in ipairs(self.difficultyGroupList) do
		iter_13_1:Dispose()
	end

	self.difficultyGroupList = {}
	self.lockGoDict = {}

	for iter_13_2, iter_13_3 in ipairs(self.overviewList) do
		iter_13_3:Dispose()
	end

	self.overviewList = {}

	PolyhedronDifficultyView.super.Dispose(self)
end

return PolyhedronDifficultyView
