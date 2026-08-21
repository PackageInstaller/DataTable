-- chunkname: @IQIGame\\UI\\Skin\\SkinUIStaticImageSkinPanel.lua

local SkinUIStaticImageSkinPanel = {}
local SkinItemCell = require("IQIGame.UI.Skin.SkinItemCell")
local SkinUIFunctionButtonsPanel = require("IQIGame.UI.Skin.SkinUIFunctionButtonsPanel")
local enhanceScrollRect_BaseX, enhanceScrollRect_BaseY

function SkinUIStaticImageSkinPanel.New(view)
	local obj = Clone(SkinUIStaticImageSkinPanel)

	obj:Init(view)

	return obj
end

function SkinUIStaticImageSkinPanel:Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitProperties()
	self:AddListeners()
end

function SkinUIStaticImageSkinPanel:InitProperties()
	self.skinItemList = {}
	self.skinGroupsForScrollView = {}
	self.skinImageForCenter = self.skinImageForCenterObj:GetComponent("Image")
	self.headIconImage = self.headIconImageObj:GetComponent("Image")
	self.LeftButton = self.LeftButtonObj:GetComponent("Button")
	self.RightButton = self.RightButtonObj:GetComponent("Button")
	self.forceImg = self.forceImgObj:GetComponent("Image")
	self.enhanceScrollView = self.EnhanceScrollViewObj:GetComponent("EnhanceScrollView")

	self:InitEnhanceScrollviewProperties()

	self.skinUIFunctionButtonsPanel = SkinUIFunctionButtonsPanel.New(self.FunctionPanelObj)

	function self.DelegateOnSelectSkinItemCell(cellIndex)
		self:OnSelectSkinItemCell(cellIndex)
	end

	function self.DelegateOnLeftArrowsBtnClick()
		self:OnArrowsButtonClick(true)
	end

	function self.DelegateOnRightArrowsBtnClick()
		self:OnArrowsButtonClick(false)
	end

	function self.DelegateOnSkinChange()
		self:OnSkinChange()
	end
end

function SkinUIStaticImageSkinPanel:DisposeProperties()
	for key, _ in pairs(self.skinItemList) do
		self.skinItemList[key]:Dispose()

		self.skinItemList[key] = nil
	end

	self.skinItemList = nil
	self.skinImageForCenter = nil
	self.headIconImage = nil
	self.LeftButton = nil
	self.RightButton = nil
	self.forceImg = nil
	self.enhanceScrollView = nil

	self.skinUIFunctionButtonsPanel:Dispose()

	self.DelegateOnSelectSkinItemCell = nil
	self.DelegateOnLeftArrowsBtnClick = nil
	self.DelegateOnRightArrowsBtnClick = nil
	self.DelegateOnSkinChange = nil
end

function SkinUIStaticImageSkinPanel:AddListeners()
	self.LeftButton.onClick:AddListener(self.DelegateOnLeftArrowsBtnClick)
	self.RightButton.onClick:AddListener(self.DelegateOnRightArrowsBtnClick)
	EventDispatcher.AddEventListener(EventID.ChangeSkinResult, self.DelegateOnSkinChange)
end

function SkinUIStaticImageSkinPanel:RemoveListeners()
	self.LeftButton.onClick:RemoveListener(self.DelegateOnLeftArrowsBtnClick)
	self.RightButton.onClick:RemoveListener(self.DelegateOnRightArrowsBtnClick)
	EventDispatcher.RemoveEventListener(EventID.ChangeSkinResult, self.DelegateOnSkinChange)
end

function SkinUIStaticImageSkinPanel:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	self:DisposeProperties()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function SkinUIStaticImageSkinPanel:SetVisible(isVisible)
	LuaUtility.SetGameObjectShow(self.gameObject, isVisible)
end

function SkinUIStaticImageSkinPanel:Refresh(heroCid)
	if self.heroCid ~= heroCid then
		self.lastSelectCellIndex = nil
		self.lastShowSkinCid = nil
	end

	self.heroCid = heroCid

	self:InitSkinInfo()
	self:RefreshEnhanceScrollView()
end

function SkinUIStaticImageSkinPanel:OnClose()
	return
end

function SkinUIStaticImageSkinPanel:InitSkinInfo()
	self.skinGroupsFromConfig = SkinModule.GetAllSkinGroupFromConfigTableByHeroCid(self.heroCid)
	self.skinGroupsFromPlayer = SkinModule.GetAllSkinGroupFromPlayerByHeroCid(self.heroCid)
	self.skinGroupsForScrollView = {}

	for skinGroupID, _ in pairs(self.skinGroupsFromConfig) do
		local staticImageSkinPOD

		if self.skinGroupsFromPlayer[skinGroupID] ~= nil then
			staticImageSkinPOD = self.skinGroupsFromPlayer[skinGroupID][Constant.SkinType.StaticImage]
		else
			staticImageSkinPOD = self.skinGroupsFromConfig[skinGroupID][Constant.SkinType.StaticImage]

			local isSkinHideInSkinUI = staticImageSkinPOD ~= nil and SkinModule.GetSkinConfigBySkinCid(staticImageSkinPOD.skinCid).IsHideInSkinUI or false

			if isSkinHideInSkinUI then
				staticImageSkinPOD = nil
			end
		end

		if staticImageSkinPOD ~= nil then
			table.insert(self.skinGroupsForScrollView, staticImageSkinPOD)
		end
	end
end

function SkinUIStaticImageSkinPanel:RefreshEnhanceScrollView()
	local skinGroupTotalCount = getTableLength(self.skinGroupsForScrollView)

	self:SetSkinEnhanceScrollviewRect(self.enhanceScrollView, skinGroupTotalCount)

	for _, skinItemCell in pairs(self.skinItemList) do
		skinItemCell:SetVisible(false)
	end

	local list = {}
	local skinItemCell

	for i = 1, #self.skinGroupsForScrollView do
		skinItemCell = self:CreatSkinItem(i)

		skinItemCell:Refresh(i, self.skinGroupsForScrollView[i])

		list[i] = skinItemCell.View
	end

	self.enhanceScrollView:InitList(list)

	self.lastShowSkinCid, self.lastSelectCellIndex = self:GetScrollViewLastInfo()
	self.enhanceScrollView.startCenterIndex = self.lastSelectCellIndex

	self.enhanceScrollView:Initialize()
end

function SkinUIStaticImageSkinPanel:CreatSkinItem(index)
	local item = self.skinItemList[index]

	if item == nil then
		local go = UnityEngine.Object.Instantiate(self.enhanceScrollViewCellPrefabObj)

		go.transform:SetParent(self.enhanceScrollView.transform, false)

		local uGUIEnhanceItem = LuaUtility.GameObjectGetOrAddComponent(go, typeof(UGUIEnhanceItem))

		uGUIEnhanceItem:Init(self.enhanceScrollView)
		LuaUtility.SetGameObjectName(go, "ItemCell" .. index)

		item = SkinItemCell.New(go, self.DelegateOnSelectSkinItemCell)
		self.skinItemList[index] = item
	end

	item:SetVisible(true)

	return item
end

function SkinUIStaticImageSkinPanel:OnSelectSkinItemCell(cellIndex)
	self.lastSelectCellIndex = cellIndex
	self.lastShowSkinCid = self:GetSkinCidByCellIndex(cellIndex)

	self:RefreshSkinPreview(self.lastShowSkinCid)
	self:RefreshSkinFunctionPanel(self.heroCid, self.lastShowSkinCid)
end

function SkinUIStaticImageSkinPanel:OnArrowsButtonClick(isLeft)
	if isLeft then
		self.enhanceScrollView:OnBtnRightClick()
	else
		self.enhanceScrollView:OnBtnLeftClick()
	end
end

function SkinUIStaticImageSkinPanel:OnSkinChange()
	if self.lastShowSkinCid ~= nil and self.lastShowSkinCid > 0 then
		self:RefreshSkinFunctionPanel(self.heroCid, self.lastShowSkinCid)
	end
end

function SkinUIStaticImageSkinPanel:RefreshSkinPreview(skinCid)
	if skinCid == nil or skinCid < 0 then
		return
	end

	local centerSkinImagePath = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinCid, Constant.SkinImageType.HeroResourcesVerticalDraw)

	AssetUtil.LoadImage(self, centerSkinImagePath, self.skinImageForCenter, function()
		self.skinImageForCenter:SetNativeSize()
		LuaUtility.SetImageRectTransformPivot(self.skinImageForCenter:GetComponent(typeof(UnityEngine.RectTransform)), self.skinImageForCenter)
	end)
	UGUIUtil.SetText(self.skinOwnerHeroNameTextObj, CfgHeroTable[self.heroCid].Name)

	local skinConfig = SkinModule.GetSkinConfigBySkinCid(skinCid)

	if skinConfig ~= nil then
		UGUIUtil.SetText(self.skinDescTextObj, skinConfig.SkinDesc)
	end

	local totalSkinCount = getTableLength(self.skinGroupsForScrollView)
	local ownedSkinCount = getTableLength(self.skinGroupsFromPlayer)

	UGUIUtil.SetText(self.skinProgressTextObj, tostring(ownedSkinCount) .. "/" .. tostring(totalSkinCount))

	local headIconImagePath = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinCid, Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, headIconImagePath, self.headIconImage)

	local heroConfig = CfgHeroTable[self.heroCid]

	if heroConfig ~= nil and heroConfig.Forces > 0 then
		LuaUtility.SetGameObjectShow(self.forceImgObj, true)

		local heroForceImgPath = WarlockApi:GetForceImgPath(heroConfig.Forces)

		AssetUtil.LoadImage(self, heroForceImgPath, self.forceImg)
	else
		LuaUtility.SetGameObjectShow(self.forceImgObj, false)
	end
end

function SkinUIStaticImageSkinPanel:RefreshSkinFunctionPanel(heroCid, skinCid)
	local skinState = SkinModule.GetSkinStateByHeroCidAndSkinCid(heroCid, skinCid)

	self.skinUIFunctionButtonsPanel:Refresh(heroCid, skinCid, skinState)
end

function SkinUIStaticImageSkinPanel:GetScrollViewLastInfo()
	if self.lastShowSkinCid ~= nil then
		local lastSelectCellIndex = self:GetCellIndexBySkinCid(self.lastShowSkinCid)

		if lastSelectCellIndex >= 0 then
			return self.lastShowSkinCid, lastSelectCellIndex
		end
	end

	local showingSkinPOD

	if self:IsPlayerOwnTargetHero(self.heroCid) then
		showingSkinPOD = SkinModule.GetHeroCurrentSkinGroupFromPlayerByHeroCid(self.heroCid)[Constant.SkinType.StaticImage]
	else
		showingSkinPOD = SkinModule.GetHeroDefaultSkinGroupFromConfigTableByHeroCid(self.heroCid)[Constant.SkinType.StaticImage]
	end

	if showingSkinPOD ~= nil then
		local lastSelectCellIndex = math.max(0, self:GetCellIndexBySkinCid(showingSkinPOD.skinCid))

		return showingSkinPOD.skinCid, lastSelectCellIndex
	else
		logError("皮肤系统 - showingSkinPOD=nil, heroCid={1}", self.heroCid)
	end

	return nil, 0
end

function SkinUIStaticImageSkinPanel:InitEnhanceScrollviewProperties()
	local rect = self.enhanceScrollView:GetComponent("RectTransform")
	local anchoredPosition = rect.anchoredPosition

	enhanceScrollRect_BaseX = anchoredPosition.x
	enhanceScrollRect_BaseY = anchoredPosition.y
end

function SkinUIStaticImageSkinPanel:SetSkinEnhanceScrollviewRect(enhanceScrollView, cellCount)
	local rect = enhanceScrollView:GetComponent("RectTransform")
	local constant_OffsetValue = 50
	local x = enhanceScrollRect_BaseX - cellCount * constant_OffsetValue

	LuaUtility.SetAnchoredPositionWithRectTransform(rect, x, enhanceScrollRect_BaseY)
end

function SkinUIStaticImageSkinPanel:JumpToCurPage(index)
	self.enhanceScrollView:JumpPage(index)
end

function SkinUIStaticImageSkinPanel:IsPlayerOwnTargetHero(heroCid)
	return WarlockModule.WarlockDataDic[heroCid] ~= nil
end

function SkinUIStaticImageSkinPanel:GetCellIndexBySkinCid(skinCid)
	for index = 1, #self.skinGroupsForScrollView do
		if self.skinGroupsForScrollView[index].skinCid == skinCid then
			return index - 1
		end
	end

	return -1
end

function SkinUIStaticImageSkinPanel:GetSkinCidByCellIndex(cellIndex)
	if self.skinGroupsForScrollView ~= nil and self.skinGroupsForScrollView[cellIndex] ~= nil then
		return self.skinGroupsForScrollView[cellIndex].skinCid
	end

	return nil
end

return SkinUIStaticImageSkinPanel
