local FishingGameCollectionView = class("FishingGameCollectionView", ReduxView)

function FishingGameCollectionView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingIllustratedPopUI"
end

function FishingGameCollectionView:UIParent()
	return manager.ui.uiMain.transform
end

function FishingGameCollectionView:OnCtor(...)
	return
end

local var_0_1 = -1

local function var_0_2(arg_4_0)
	local var_4_0

	if arg_4_0 == var_0_1 then
		var_4_0 = "icon_group_all_c"
	else
		for iter_4_0, iter_4_1 in ipairs(GameDisplayCfg.hero_race_type_tag.value) do
			if iter_4_1[1] == arg_4_0 then
				var_4_0 = iter_4_1[2]

				break
			end
		end
	end

	return getSprite("Atlas/CampItemAtlas", var_4_0)
end

function FishingGameCollectionView:Init()
	self:BindCfgUI()

	self.winBar = KagutsuchiSpecialWinBarItem.New(self, self.winBar_)
	self.showDetailController = ControllerUtil.GetController(self.transform_, "showDetail")

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(HanafudaCardCfg.get_id_list_by_race) do
		table.insert(var_5_0, iter_5_0)
	end

	table.insert(var_5_0, var_0_1)
	table.sort(var_5_0)

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		local var_5_1 = Object.Instantiate(self.filterItemPrefab_, self.filterTabRoot_)

		var_5_1.name = iter_5_3

		local var_5_2 = {}

		self:BindCfgUI(var_5_1, var_5_2)

		var_5_2.img_.sprite = var_0_2(iter_5_3)

		self:AddToggleListener(var_5_2.btn_, function(arg_6_0)
			if arg_6_0 then
				self.filter = iter_5_3

				self:UpdateList()
			end
		end)

		if iter_5_3 == var_0_1 then
			self.toggleFilterAcceptAllRace = var_5_2.btn_
			var_5_1.name = "all"
		end

		var_5_1:SetActive(true)
	end

	self.collectionItemList = LuaList.New(handler(self, self.RenderCollectionItem), self.collectionItemList_, HanafudaCardView)
	self.detailPanel = FishCollectionDetailItem.New(self.detailPanel_)

	self.detailPanel:SetClickOnMask(function()
		self.showDetailController:SetSelectedState("false")
	end)
end

function FishingGameCollectionView:OnEnter()
	self.toggleFilterAcceptAllRace.isOn = true

	if self.toggleFilterAcceptAllRace.isOn then
		self:UpdateList()
	end

	manager.windowBar:HideBar()
end

function FishingGameCollectionView:OnExit()
	self.showDetailController:SetSelectedState("false")
end

function FishingGameCollectionView:OnTop()
	return
end

function FishingGameCollectionView:OnBehind()
	return
end

function FishingGameCollectionView:Dispose()
	self.detailPanel:Dispose()
	FishingGameCollectionView.super.Dispose(self)

	if self.collectionItemList then
		self.collectionItemList:Dispose()

		self.collectionItemList = nil
	end

	self.winBar:Dispose()
end

function FishingGameCollectionView:UpdateList()
	local var_13_0 = {}

	if self.filter == var_0_1 then
		for iter_13_0, iter_13_1 in ipairs(HanafudaCardCfg.all) do
			table.insert(var_13_0, iter_13_1)
		end
	else
		for iter_13_2, iter_13_3 in ipairs(HanafudaCardCfg.get_id_list_by_race[self.filter]) do
			table.insert(var_13_0, iter_13_3)
		end
	end

	CommonTools.UniversalSortEx(var_13_0, {
		map = function(arg_14_0)
			return KagutsuchiFishingEventData:GetRarity(arg_14_0).order
		end
	}, {
		ascend = true
	})

	self.fishCollectionIdList = var_13_0

	self.collectionItemList:StartScroll(#var_13_0, 0, false, true)
end

local function var_0_3(arg_15_0)
	manager.notify:CallUpdateFunc("OnFishCollectionItemClick", arg_15_0.data_.id, arg_15_0.index_)
end

function FishingGameCollectionView:RenderCollectionItem(arg_16_1, arg_16_2)
	arg_16_2:SetData(arg_16_1, {
		id = HanafudaCardCfg[self.fishCollectionIdList[arg_16_1]].id,
		race = HanafudaCardCfg[self.fishCollectionIdList[arg_16_1]].race,
		desc = HanafudaCardCfg[self.fishCollectionIdList[arg_16_1]].desc,
		placeType = HanafudaData.CARD_PLACE_TYPE.COLLECTION,
		rarity = KagutsuchiFishingEventData:GetRarity(HanafudaCardCfg[self.fishCollectionIdList[arg_16_1]].id).order
	})
	arg_16_2:SetPlayerClickCallBack(var_0_3)
	arg_16_2:RefreshUI()
end

function FishingGameCollectionView:OnFishCollectionItemClick(arg_17_1, arg_17_2)
	self.select = arg_17_2

	self.collectionItemList:Refresh()
	self.detailPanel:SetData(arg_17_1)
	self.showDetailController:SetSelectedState("true")
end

return FishingGameCollectionView
