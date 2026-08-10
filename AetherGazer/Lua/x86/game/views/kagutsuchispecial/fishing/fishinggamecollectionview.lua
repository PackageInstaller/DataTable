local var_0_0 = class("FishingGameCollectionView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingIllustratedPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0, ...)
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

function var_0_0.Init(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.winBar = KagutsuchiSpecialWinBarItem.New(arg_5_0, arg_5_0.winBar_)
	arg_5_0.showDetailController = ControllerUtil.GetController(arg_5_0.transform_, "showDetail")

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(HanafudaCardCfg.get_id_list_by_race) do
		table.insert(var_5_0, iter_5_0)
	end

	table.insert(var_5_0, var_0_1)
	table.sort(var_5_0)

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		local var_5_1 = Object.Instantiate(arg_5_0.filterItemPrefab_, arg_5_0.filterTabRoot_)

		var_5_1.name = iter_5_3

		local var_5_2 = {}

		arg_5_0:BindCfgUI(var_5_1, var_5_2)

		local var_5_3 = var_5_2.btn_

		var_5_2.img_.sprite = var_0_2(iter_5_3)

		arg_5_0:AddToggleListener(var_5_3, function(arg_6_0)
			if arg_6_0 then
				arg_5_0.filter = iter_5_3

				arg_5_0:UpdateList()
			end
		end)

		if iter_5_3 == var_0_1 then
			arg_5_0.toggleFilterAcceptAllRace = var_5_3
			var_5_1.name = "all"
		end

		var_5_1:SetActive(true)
	end

	arg_5_0.collectionItemList = LuaList.New(handler(arg_5_0, arg_5_0.RenderCollectionItem), arg_5_0.collectionItemList_, HanafudaCardView)
	arg_5_0.detailPanel = FishCollectionDetailItem.New(arg_5_0.detailPanel_)

	arg_5_0.detailPanel:SetClickOnMask(function()
		arg_5_0.showDetailController:SetSelectedState("false")
	end)
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = arg_8_0.toggleFilterAcceptAllRace.isOn

	arg_8_0.toggleFilterAcceptAllRace.isOn = true

	if var_8_0 then
		arg_8_0:UpdateList()
	end

	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0.showDetailController:SetSelectedState("false")
end

function var_0_0.OnTop(arg_10_0)
	return
end

function var_0_0.OnBehind(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.detailPanel:Dispose()
	var_0_0.super.Dispose(arg_12_0)

	if arg_12_0.collectionItemList then
		arg_12_0.collectionItemList:Dispose()

		arg_12_0.collectionItemList = nil
	end

	arg_12_0.winBar:Dispose()
end

function var_0_0.UpdateList(arg_13_0)
	local var_13_0 = {}

	if arg_13_0.filter == var_0_1 then
		for iter_13_0, iter_13_1 in ipairs(HanafudaCardCfg.all) do
			table.insert(var_13_0, iter_13_1)
		end
	else
		for iter_13_2, iter_13_3 in ipairs(HanafudaCardCfg.get_id_list_by_race[arg_13_0.filter]) do
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

	arg_13_0.fishCollectionIdList = var_13_0

	arg_13_0.collectionItemList:StartScroll(#var_13_0, 0, false, true)
end

local function var_0_3(arg_15_0)
	manager.notify:CallUpdateFunc("OnFishCollectionItemClick", arg_15_0.data_.id, arg_15_0.index_)
end

function var_0_0.RenderCollectionItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.fishCollectionIdList[arg_16_1]
	local var_16_1 = HanafudaCardCfg[var_16_0]
	local var_16_2 = {
		id = var_16_1.id,
		race = var_16_1.race,
		desc = var_16_1.desc,
		placeType = HanafudaData.CARD_PLACE_TYPE.COLLECTION,
		rarity = KagutsuchiFishingEventData:GetRarity(var_16_1.id).order
	}

	arg_16_2:SetData(arg_16_1, var_16_2)
	arg_16_2:SetPlayerClickCallBack(var_0_3)
	arg_16_2:RefreshUI()
end

function var_0_0.OnFishCollectionItemClick(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.select = arg_17_2

	arg_17_0.collectionItemList:Refresh()
	arg_17_0.detailPanel:SetData(arg_17_1)
	arg_17_0.showDetailController:SetSelectedState("true")
end

return var_0_0
