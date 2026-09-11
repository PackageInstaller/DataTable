local DormPartSuitInfoPopView = class("DormPartSuitInfoPopView", ReduxView)

function DormPartSuitInfoPopView:UIName()
	return "Widget/BackHouseUI/Dorm/DormFurnitureSuitInfoPopUI"
end

function DormPartSuitInfoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function DormPartSuitInfoPopView:OnCtor()
	return
end

function DormPartSuitInfoPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormPartSuitInfoPopView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, FurnitureItem)
end

function DormPartSuitInfoPopView:OnEnter()
	self.suitID = self.params_.suitID

	self:RefreshView()
end

function DormPartSuitInfoPopView:OnTop()
	if self.scrollHelper_ then
		self.scrollHelper_:Refresh()
	end
end

function DormPartSuitInfoPopView:OnExit()
	self:RemoveAllEventListener()
end

function DormPartSuitInfoPopView:AddUIListener()
	self:AddBtnListenerScale(self.getAllBtn_, nil, function()
		JumpTools.OpenPageByJump("dormSuitGetFurListView", {
			furEidList = self.canStorageList,
			callBack = handler(self, function()
				self:RefreshFurInfoList()
				self:RefreshCanRestorageState()
			end)
		})
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function DormPartSuitInfoPopView:RefreshView()
	self:RefreshSuitInfo()
	self:RefreshCanRestorageState()
	self:RefreshFurInfoList()
end

function DormPartSuitInfoPopView:RefreshCanRestorageState()
	local var_14_0, var_14_1 = self:CheckCanRecycleFur()

	self.canStorageFlag = var_14_0

	if not var_14_0 then
		self.canStorageList = nil
	else
		self.canStorageList = var_14_1
	end
end

function DormPartSuitInfoPopView:RefreshSuitInfo()
	if ItemCfg[self.suitID] then
		self.suitName.text = ItemTools.getItemName(self.suitID)
		self.furNum.text = DormSuitData:GetSuitNeedTotalFurNumList(self.suitID)

		local var_15_0 = 0

		for iter_15_0, iter_15_1 in ipairs(BackHomeSuitCfg[self.suitID].suit_num) do
			var_15_0 = var_15_0 + BackHomeFurniture[iter_15_1[1]].dorm_exp * iter_15_1[2]
		end

		self.comfortNum.text = var_15_0
		self.suitImg.sprite = DormSuitTools:GetSuitHighDefinitionIcon(self.suitID)
	end
end

function DormPartSuitInfoPopView:RefreshFurInfoList()
	self.furInfoList = {}

	for iter_16_0, iter_16_1 in ipairs((DormSuitData:GetNeedUseFurNumInfoBySuitID(self.suitID))) do
		table.insert(self.furInfoList, {
			furID = iter_16_1[1],
			suitID = self.suitID
		})
	end

	self.scrollHelper_:StartScroll(#self.furInfoList)
end

function DormPartSuitInfoPopView:indexItem(arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(self.furInfoList[arg_17_1], nil, DormEnum.FurItemType.SuitFurShow, nil, arg_17_1)
	arg_17_2:OnClickBtn(function(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
		local var_18_0 = DormData:GetFurNumInfo(arg_18_0)
		local var_18_1 = 0

		if arg_18_3 == "enough" then
			if var_18_0 then
				var_18_1 = var_18_0.num
			end

			ShowPopItem(POP_ITEM, {
				arg_18_0,
				var_18_1
			})
		elseif arg_18_3 == "canGift" then
			JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
				state = "gift",
				furID = arg_18_0,
				needNum = arg_18_4,
				defaultNum = arg_18_4
			})
		elseif arg_18_3 == "noEnough" then
			local var_18_2 = {}

			for iter_18_0, iter_18_1 in ipairs(ShopListCfg.all) do
				if ShopListCfg[iter_18_1].display_group == ShopListCfg[ShopConst.SHOP_ID.FURNITURE_SHOP].display_group then
					table.insert(var_18_2, iter_18_1)
				end
			end

			local var_18_3 = false

			for iter_18_2, iter_18_3 in ipairs((getGoodListByGiveID(arg_18_0))) do
				for iter_18_4, iter_18_5 in ipairs(var_18_2) do
					if ShopTools.IsGoodCanBuy(iter_18_5, iter_18_3) then
						var_18_3 = true

						break
					end
				end
			end

			if var_18_3 then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "buy",
					furID = arg_18_0,
					needNum = arg_18_4,
					defaultNum = arg_18_4
				})
			else
				ShowPopItem(POP_ITEM, {
					arg_18_0,
					var_18_1
				})
			end
		end
	end)
	arg_17_2:GrayCallBack(function(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
		local var_19_0 = DormData:GetFurNumInfo(arg_19_0)
		local var_19_1 = 0

		if arg_19_3 == "enough" then
			if var_19_0 then
				var_19_1 = var_19_0.num
			end

			ShowPopItem(POP_ITEM, {
				arg_19_0,
				var_19_1
			})
		elseif arg_19_3 == "canGift" then
			JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
				state = "gift",
				furID = arg_19_0,
				needNum = arg_19_4,
				defaultNum = arg_19_4
			})
		elseif arg_19_3 == "noEnough" then
			local var_19_2 = {}

			for iter_19_0, iter_19_1 in ipairs(ShopListCfg.all) do
				if ShopListCfg[iter_19_1].display_group == ShopListCfg[ShopConst.SHOP_ID.DORM_SHOP].display_group then
					table.insert(var_19_2, iter_19_1)
				end
			end

			local var_19_3 = false

			for iter_19_2, iter_19_3 in ipairs((getGoodListByGiveID(arg_19_0))) do
				for iter_19_4, iter_19_5 in ipairs(var_19_2) do
					if ShopTools.IsGoodCanBuy(iter_19_5, iter_19_3) then
						var_19_3 = true

						break
					end
				end
			end

			if var_19_3 then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "buy",
					furID = arg_19_0,
					needNum = arg_19_4,
					defaultNum = arg_19_4
				})
			else
				ShowPopItem(POP_ITEM, {
					arg_19_0,
					var_19_1
				})
			end
		end
	end)
end

function DormPartSuitInfoPopView:CheckCanRecycleFur()
	local var_20_0 = DormSuitData:GetSuitFurInfo(self.suitID)
	local var_20_1 = {}
	local var_20_2 = DormData:GetCurrectSceneID()

	if var_20_0 then
		local var_20_3 = DormData:GetCurrectSceneID()

		for iter_20_0, iter_20_1 in ipairs(var_20_0.suit_num) do
			local var_20_4 = DormSuitData:GetFurNeedNumBySuitID(self.suitID, iter_20_1[1])
			local var_20_5 = math.min(DormFurEditStateData:GetCanUseFurNumInRoom(var_20_2, iter_20_1[1]), var_20_4)
			local var_20_6 = math.min(DormRoomTools:GetHasPlaceFurInfoByRoom(var_20_3, iter_20_1[1]) + DormFurEditStateData:GetCacheFurNum(iter_20_1[1]), var_20_4)

			if var_20_5 < var_20_4 and var_20_6 > 0 then
				table.insert(var_20_1, {
					furID = iter_20_1[1],
					num = math.min(var_20_4 - var_20_5, var_20_6)
				})
			end
		end
	end

	local var_20_7 = {}
	local var_20_8 = false

	for iter_20_2, iter_20_3 in ipairs(var_20_1) do
		local var_20_9 = DormLuaBridge.GetCanRestoreFur(iter_20_3.furID, iter_20_3.num)

		if var_20_9.Length > 0 then
			var_20_7[iter_20_3.furID] = {}
			var_20_7[iter_20_3.furID] = var_20_9
			var_20_8 = true
		end
	end

	return var_20_8, var_20_7
end

function DormPartSuitInfoPopView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()
	end

	DormPartSuitInfoPopView.super.Dispose(self)
end

return DormPartSuitInfoPopView
