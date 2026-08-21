-- chunkname: @IQIGame\\UI\\LotteryRewardListUI.lua

local LotteryRewardListUI = {
	Tabs = {},
	ItemList = {}
}

LotteryRewardListUI = Base:Extend("LotteryRewardListUI", "IQIGame.Onigao.UI.LotteryRewardListUI", LotteryRewardListUI)

local LotteryRewardCell = require("IQIGame.UI.Lottery.LotteryRewardCell")
local tabLen = 4
local tabTypeEnum = {
	UpItem = 1,
	Skill = 2,
	Hero = 3,
	Description = 4
}

function LotteryRewardListUI:OnInit()
	function self.DelegateOnClickTab(isOn)
		self:OnClickTab(isOn)
	end

	UGUIUtil.SetText(self.PoolOtherTitle, LotteryRewardListUIApi:GetPoolOtherTitle())

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.hasLoadPrefabs = {}

	self:InitTabs()
end

function LotteryRewardListUI:GetPreloadAssetPaths()
	return nil
end

function LotteryRewardListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LotteryRewardListUI:IsManualShowOnOpen(userData)
	return false
end

function LotteryRewardListUI:GetBGM(userData)
	return nil
end

function LotteryRewardListUI:OnOpen(userData)
	self.PoolType = userData
	self.ShowItemData = LotteryModule.ScreenTypeDatas(self.PoolType)
	self.PoolTyps = LotteryModule.PrizePoolHasType(self.PoolType)
	self.ShowStarData = CfgCardJackpotTable[self.PoolType].ShowStar
	self.poolCfg = CfgCardJackpotTable[self.PoolType]

	self:SetTabsInfo()

	if #self.Tabs > 0 then
		for i = 1, #self.Tabs do
			if self.Tabs[i].activeSelf then
				self:ShowTab(i)

				self.Tabs[i]:GetComponent("Toggle").isOn = true

				break
			end
		end
	end

	UGUIUtil.SetText(self.PoolTitle, CfgCardJackpotTable[self.PoolType].Name)
end

function LotteryRewardListUI:OnClose(userData)
	self:CloseCurrentShowPrefab()
	self:CloseCurrentShowContent()
end

function LotteryRewardListUI:OnAddListeners()
	for i = 1, #self.Tabs do
		self.Tabs[i]:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickTab)
	end
end

function LotteryRewardListUI:OnRemoveListeners()
	for i = 1, #self.Tabs do
		self.Tabs[i]:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnClickTab)
	end
end

function LotteryRewardListUI:OnPause()
	return
end

function LotteryRewardListUI:OnResume()
	return
end

function LotteryRewardListUI:OnCover()
	return
end

function LotteryRewardListUI:OnReveal()
	return
end

function LotteryRewardListUI:OnRefocus(userData)
	return
end

function LotteryRewardListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LotteryRewardListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LotteryRewardListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LotteryRewardListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LotteryRewardListUI:OnDestroy()
	self.commonReturnBtn:Dispose()
end

function LotteryRewardListUI:InitTabs()
	for i = 1, tabLen do
		local tabBtn = self.Tabs[i]

		if tabBtn == nil then
			tabBtn = UnityEngine.Object.Instantiate(self.TogglePrefab)
			self.Tabs[i] = tabBtn
		end

		tabBtn.transform:SetParent(self.ItemTabs.transform, false)

		self.Tabs[i] = tabBtn
		self.Tabs[i]:GetComponent("Toggle").group = self.ItemTabs:GetComponent("ToggleGroup")

		self.Tabs[i]:SetActive(false)
	end
end

function LotteryRewardListUI:SetTabsInfo()
	for i = 1, #self.Tabs do
		local str = ""

		if i == tabTypeEnum.Skill then
			str = LotteryRewardListUIApi:GetTabSkill()
		elseif i == tabTypeEnum.Hero then
			str = LotteryRewardListUIApi:GetTabHero()
		elseif i == tabTypeEnum.UpItem then
			str = LotteryRewardListUIApi:GetTabUpItem()
		elseif i == tabTypeEnum.Description then
			str = LotteryRewardListUIApi:GetTabDescription()
		end

		self.Tabs[i]:GetComponent("ToggleHelperComponent").text = str
	end

	for i = 1, #self.Tabs do
		LuaUtility.SetGameObjectShow(self.Tabs[i], i == tabTypeEnum.Description)
	end

	local cfgCardJackpot = CfgUtil.GetCardJackpotWithID(self.PoolType)

	if LuaUtility.StrIsNullOrEmpty(cfgCardJackpot.ShowSkillWeight) then
		LuaUtility.SetGameObjectShow(self.Tabs[tabTypeEnum.Skill], false)
	end

	if LuaUtility.StrIsNullOrEmpty(cfgCardJackpot.ShowHeroWeight) then
		LuaUtility.SetGameObjectShow(self.Tabs[tabTypeEnum.Hero], false)
	end

	if LuaUtility.StrIsNullOrEmpty(cfgCardJackpot.ShowUpWeight) then
		LuaUtility.SetGameObjectShow(self.Tabs[tabTypeEnum.UpItem], false)
	end
end

function LotteryRewardListUI:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.UIController:GetCurrentTarget()

		for i = 1, #self.Tabs do
			if self.Tabs[i].gameObject == currentTarget then
				self:ShowTab(i)

				return
			end
		end
	end
end

function LotteryRewardListUI:ShowTab(index)
	self:CloseCurrentShowContent()
	self:CloseCurrentShowPrefab()

	local cfgCardJackpot = CfgUtil.GetCardJackpotWithID(self.PoolType)

	self.currentTabNum = index

	if index == tabTypeEnum.Hero then
		LuaUtility.SetGameObjectShow(self.HeroScrollview, true)
		self:SetCurrentShowContent(self.HeroScrollview)

		if self.hasLoadPrefabs[self.PoolType] and self.hasLoadPrefabs[self.PoolType][index] then
			LuaUtility.SetGameObjectShow(self.hasLoadPrefabs[self.PoolType][index], true)

			self.currentShowPrefab = self.hasLoadPrefabs[self.PoolType][index]
		else
			local path = cfgCardJackpot.ShowHeroWeight

			self:LoadContentPrefab(path, self.HeroScrollview)
		end
	elseif index == tabTypeEnum.Skill then
		LuaUtility.SetGameObjectShow(self.SkillScrollview, true)
		self:SetCurrentShowContent(self.SkillScrollview)

		if self.hasLoadPrefabs[self.PoolType] and self.hasLoadPrefabs[self.PoolType][index] then
			LuaUtility.SetGameObjectShow(self.hasLoadPrefabs[self.PoolType][index], true)

			self.currentShowPrefab = self.hasLoadPrefabs[self.PoolType][index]
		else
			local path = cfgCardJackpot.ShowSkillWeight

			self:LoadContentPrefab(path, self.SkillScrollview)
		end
	elseif index == tabTypeEnum.Description then
		LuaUtility.SetGameObjectShow(self.descriptionScroll, true)
		self:SetCurrentShowContent(self.descriptionScroll)
		LuaUtility.SetText(self.textDescription, CfgUtil.GetCfgHelpTipsDataWithID(self.poolCfg.DescID))
	elseif index == tabTypeEnum.UpItem then
		LuaUtility.SetGameObjectShow(self.upItemScroll, true)
		self:SetCurrentShowContent(self.upItemScroll)

		if self.hasLoadPrefabs[self.PoolType] and self.hasLoadPrefabs[self.PoolType][index] then
			LuaUtility.SetGameObjectShow(self.hasLoadPrefabs[self.PoolType][index], true)

			self.currentShowPrefab = self.hasLoadPrefabs[self.PoolType][index]
		else
			local path = cfgCardJackpot.ShowUpWeight

			self:LoadContentPrefab(path, self.upItemScroll)
		end
	end
end

function LotteryRewardListUI:LoadContentPrefab(path, parent)
	AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil, {
		parent = parent
	})
end

function LotteryRewardListUI:OnLoadSucceed(assetName, asset, duration, userData)
	local objAsset = GameObject.Instantiate(asset, userData.parent.transform)

	if not self.hasLoadPrefabs[self.PoolType] then
		self.hasLoadPrefabs[self.PoolType] = {}
	end

	self.hasLoadPrefabs[self.PoolType][self.currentTabNum] = objAsset.gameObject
	self.currentShowPrefab = self.hasLoadPrefabs[self.PoolType][self.currentTabNum]
end

function LotteryRewardListUI:CloseCurrentShowContent()
	if self.currentShowContent then
		LuaUtility.SetGameObjectShow(self.currentShowContent, false)
	end
end

function LotteryRewardListUI:CloseCurrentShowPrefab()
	if self.currentShowPrefab then
		LuaUtility.SetGameObjectShow(self.currentShowPrefab, false)
	end
end

function LotteryRewardListUI:SetCurrentShowContent(gameObject)
	self.currentShowContent = gameObject
end

function LotteryRewardListUI:RefreshList(toTypeIndex)
	self.CurTabIndex = toTypeIndex

	local lengths = {}
	local toIndex = 0
	local data = CfgCardJackpotTable[self.PoolType].ShowStar

	for i = #data, 1, -1 do
		if self.Rewards[data[i]] ~= nil then
			table.insert(lengths, #self.Rewards[data[i]])

			if i < toTypeIndex then
				toIndex = toIndex + #self.Rewards[data[i]]
			end
		end
	end

	if table.len(data) > 0 then
		if self.PoolTyps[toTypeIndex] == Constant.ItemType.Skill then
			self.SkillScrollList:RefreshOnLua(lengths)
		elseif self.PoolTyps[toTypeIndex] == Constant.ItemType.Hero then
			self.HeroScrollList:RefreshOnLua(lengths)
		end
	end
end

function LotteryRewardListUI:UpdateTitles(renderPage, groupIndex)
	local type = self.PoolTyps[self.CurTabIndex]
	local star = self:GetStar(type, groupIndex)

	renderPage.prefabPage.transform:Find("Star"):GetComponent("SimpleStarComponent"):UpdateView(star, 0)

	renderPage.prefabPage.transform:Find("Info/Probability"):GetComponent("Text").text = CfgCardJackpotTable[self.PoolType].CardWeight[#self.ShowStarData - groupIndex] / 10 .. "%"
	renderPage.prefabPage.transform:Find("Info/Text"):GetComponent("Text").text = LotteryRewardListUIApi:GetRewardListTitle(star, type)
end

function LotteryRewardListUI:UpdateRewards(renderCell, groupIndex, cellIndex)
	local type = self.PoolTyps[self.CurTabIndex]
	local star = self:GetStar(type, groupIndex)
	local rewardDatas = self.ShowItemData[type][star]
	local gameObjectInstanceId = renderCell.gameObject:GetInstanceID()
	local rewardCell = self.ItemList[gameObjectInstanceId]

	if rewardCell == nil then
		rewardCell = LotteryRewardCell.__New(renderCell.gameObject)
		self.ItemList[gameObjectInstanceId] = rewardCell
	end

	local rewardType = self.PoolTyps[self.CurTabIndex]

	rewardCell:SetData(rewardType, rewardDatas[#rewardDatas - cellIndex])
end

function LotteryRewardListUI:GetStar(type, groupIndex)
	local starTypes = self.ShowItemData[type]
	local starTable = {}

	for k, v in pairs(starTypes) do
		table.insert(starTable, k)
	end

	table.sort(starTable, function(a, b)
		return b < a
	end)

	return starTable[groupIndex + 1]
end

return LotteryRewardListUI
