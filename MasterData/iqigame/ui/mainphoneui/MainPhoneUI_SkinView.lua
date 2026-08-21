-- chunkname: @IQIGame\\UI\\MainPhoneUI\\MainPhoneUI_SkinView.lua

local CommonRoleDisplayView = require("IQIGame/UI/Common/CommonRoleDisplayView")
local CommonHeroBagView = require("IQIGame/UI/Common/BagView/CommonHeroBagView")
local CommonHeroBagItemView = require("IQIGame/UI/Common/BagView/CommonHeroBagItemView")
local HeroBagItem = Clone(CommonHeroBagItemView)

HeroBagItem.heroCid = 0

function HeroBagItem:__OnShow()
	local heroData = self.itemData

	self.heroCid = heroData.cid

	local iconPath = heroData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, iconPath, self.heroImg:GetComponent("Image"))
	self:ChangeSelectState(false)
end

function HeroBagItem:ChangeSelectState(isSelect)
	self.selectState.gameObject:SetActive(isSelect)
end

local HeroBagView = Clone(CommonHeroBagView)

function HeroBagView.New(view)
	local obj = Clone(HeroBagView)

	obj:__Init(view, HeroBagItem)

	return obj
end

function HeroBagView:__OnInit()
	self:__HeroBag_Init()
	self.gameObject.gameObject:SetActive(false)

	self.enableChangeSelectStateCall = false
end

function HeroBagView:__OnInitScreenControllerData()
	self.screenController.sortIndex = Constant.WarlockSortType.Quality

	self.screenController:SetSortOrderData(true)
	self.screenController:SetSortPopupData(CommonSortingPopupListApi:GetRoleSortingData(), 1)
	self.screenController:SetScreenPopupData(nil)
end

function HeroBagView:RefreshSelectHero(heroCid)
	ForPairs(self.itemCellList, function(k, _itemCell)
		local isSelect = _itemCell.heroCid == heroCid

		_itemCell:ChangeSelectState(isSelect)
	end)
end

local SkinItemCell = {}

function SkinItemCell.New(view)
	local obj = Clone(SkinItemCell)

	obj:__Init(view)

	return obj
end

function SkinItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function SkinItemCell:Show(skinCid)
	self.gameObject:SetActive(true)

	local heroSkinData = CfgHeroSkinTable[skinCid]
	local path = SkinModule.GetHeroSkinImgPathByType(heroSkinData, Constant.SkinImageType.HeroResourcesShowImg)

	AssetUtil.LoadImage(self, path, self.skinIcon:GetComponent("Image"))
end

function SkinItemCell:Hide()
	self.gameObject:SetActive(false)
end

function SkinItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local SkinSelectView = {
	skinItemList = {},
	skinCidList = {}
}

function SkinSelectView.New(view, skinChangeEvent, setSkinEvent, clearSkinEvent)
	local obj = Clone(SkinSelectView)

	obj:__Init(view, skinChangeEvent, setSkinEvent, clearSkinEvent)

	return obj
end

function SkinSelectView:__Init(view, skinChangeEvent, setSkinEvent, clearSkinEvent)
	self.gameObject = view
	self.skinChangeEvent = skinChangeEvent
	self.setSkinEvent = setSkinEvent
	self.clearSkinEvent = clearSkinEvent

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	UIEventUtil.AddClickEventListener_Button(self, "SetButton", self.__OnSetButtonClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "ClearButton", self.__OnClearButtonClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "LeftArrowBtn", self.__OnLeftArrowBtnClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "RightArrowBtn", self.__OnRightArrowBtnClickHandler)

	self.skinAreaList = self.SkinScrollAreaListRoot:GetComponent("ScrollAreaListPage")

	function self.skinAreaList.onRenderCell(cell)
		self:__OnRenderSkinListItem(cell)
	end

	function self.skinAreaList.onPageReachedMainPos(page)
		self:__OnPageReachedMainPos(page)
	end
end

function SkinSelectView:__OnRenderSkinListItem(page)
	local insID = page.gameObject:GetInstanceID()
	local skinItem = self.skinItemList[insID]

	if skinItem == nil then
		skinItem = SkinItemCell.New(page.gameObject)
		self.skinItemList[insID] = skinItem
	end

	local skinCid = self.skinCidList[page.index + 1]

	skinItem:Show(skinCid)
end

function SkinSelectView:__OnPageReachedMainPos(page)
	local selectIndex = page.index + 1
	local totalCount = #self.skinCidList

	if selectIndex == 1 then
		self.LeftArrowBtn.gameObject:SetActive(false)

		if selectIndex == totalCount then
			self.RightArrowBtn.gameObject:SetActive(false)
		else
			self.RightArrowBtn.gameObject:SetActive(true)
		end
	elseif selectIndex == totalCount then
		self.RightArrowBtn.gameObject:SetActive(false)

		if totalCount > 1 then
			self.LeftArrowBtn.gameObject:SetActive(true)
		else
			self.LeftArrowBtn.gameObject:SetActive(false)
		end
	else
		self.LeftArrowBtn.gameObject:SetActive(true)
		self.RightArrowBtn.gameObject:SetActive(true)
	end

	self.selectSkinCid = self.skinCidList[selectIndex]

	local inSkinList = self.selectSkinCid == self.__defaultSelectSkinCid

	self.SetButton.gameObject:SetActive(not inSkinList)
	self.ClearButton.gameObject:SetActive(inSkinList)

	if self.skinChangeEvent ~= nil then
		self.skinChangeEvent(self.selectSkinCid)
	end
end

function SkinSelectView:Show(heroCid, showSkinCid)
	self.__defaultSelectSkinCid = showSkinCid

	self.gameObject:SetActive(true)

	self.skinCidList = {}

	local skinList = SkinModule.GetHeroSkinList(heroCid)
	local curShowIndex = 1

	ForArray(skinList, function(_index, _skinCid)
		if not SkinModule.SkinIsUnlock(_skinCid) then
			return
		end

		table.insert(self.skinCidList, _skinCid)

		if _skinCid ~= showSkinCid then
			return
		end

		curShowIndex = #self.skinCidList
	end)

	self.skinAreaList.startIndex = curShowIndex - 1

	self.skinAreaList:Refresh(#self.skinCidList)

	local heroData = CfgHeroTable[heroCid]

	self.RoleName:GetComponent("Text").text = heroData.Name
	self.ProgressText:GetComponent("Text").text = SkinUIApi:GetSkinCountStr(#self.skinCidList, #skinList)

	return self.skinCidList[curShowIndex]
end

function SkinSelectView:Hide()
	self.gameObject:SetActive(false)
end

function SkinSelectView:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function SkinSelectView:__OnSetButtonClickHandler()
	if self.setSkinEvent ~= nil then
		self.setSkinEvent(self.selectSkinCid)
	end
end

function SkinSelectView:__OnClearButtonClickHandler()
	if self.clearSkinEvent == nil then
		return
	end

	self.clearSkinEvent(self.selectSkinCid)
end

function SkinSelectView:__OnLeftArrowBtnClickHandler()
	self.skinAreaList:TurnToBackward()
end

function SkinSelectView:__OnRightArrowBtnClickHandler()
	self.skinAreaList:TurnToForward()
end

local SkinView = {}

function SkinView.New(view)
	local obj = Clone(SkinView)

	obj:__Init(view)

	return obj
end

function SkinView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.heroBag = HeroBagView.New(self.BagContentRoot)

	function self.__delegateOnRoleBagItemClick(_heroData)
		self:__OnHeroSelect(_heroData.cid, self.defaultSelectSkinCid)
	end

	self.heroBag.ItemSelectEvent = self.__delegateOnRoleBagItemClick
	self.skinSelectView = SkinSelectView.New(self.SkinContentRoot, function(_skinCid)
		self:__OnSkinDisplayViewChange(_skinCid)
	end, function(_skinCid)
		self:__OnSkinDisplaySelected(_skinCid)
	end, function(_skinCid)
		self:__OnClearSkinDisplay(_skinCid)
	end)
	self.roleDisplayView = CommonRoleDisplayView.New(self.RoleDisplayRoot, Constant.DynamicSkinShowPosition.MobilePhone_Skin)

	UIEventUtil.AddClickEventListener_Button(self, "ReturnBtn", self.__OnCloseBtnClickHandler)
end

function SkinView:Show(skinCid)
	self.gameObject:SetActive(true)
	self.heroBag:OnShow()

	local heroCid = 0

	if skinCid == 0 or skinCid == nil then
		self.defaultSelectSkinCid = 0
		heroCid = self.heroBag.heroDataList[1].cid
	else
		self.defaultSelectSkinCid = skinCid

		local skinCfg = CfgHeroSkinTable[skinCid]

		heroCid = skinCfg.HeroId
	end

	self:__OnHeroSelect(heroCid, self.defaultSelectSkinCid)
end

function SkinView:Hide()
	self.gameObject:SetActive(false)
end

function SkinView:Dispose()
	UIEventUtil.ClearEventListener(self)
	self.heroBag:Dispose()
	self.skinSelectView:Dispose()
	self.roleDisplayView:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function SkinView:__OnCloseBtnClickHandler()
	EventDispatcher.Dispatch(EventID.SetMainPhoneUIRoleDisplaySelectViewActive, false)
end

function SkinView:__OnHeroSelect(heroCid, skinCid)
	self.heroBag:RefreshSelectHero(heroCid)

	local showSkinCid = self.skinSelectView:Show(heroCid, skinCid)

	self:__OnSkinDisplayViewChange(showSkinCid)
end

function SkinView:__OnSkinDisplayViewChange(skinCid)
	self.roleDisplayView:Show(skinCid)
end

function SkinView:__OnSkinDisplaySelected(skinCid)
	EventDispatcher.Dispatch(EventID.MainPhoneUIRoleDisplaySkinSelected, skinCid, self.defaultSelectSkinCid)
end

function SkinView:__OnClearSkinDisplay(skinCid)
	EventDispatcher.Dispatch(EventID.MainPhoneUIRoleDisplaySkinRemove, skinCid, self.defaultSelectSkinCid)
end

return SkinView
