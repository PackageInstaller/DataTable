local DormSuitFurBgView = class("DormSuitFurBgView", ReduxView)

function DormSuitFurBgView:UIName()
	return "Widget/BackHouseUI/Dorm/DormSuitPreviewBgUI"
end

function DormSuitFurBgView:UIParent()
	return manager.ui.uiMain.transform
end

function DormSuitFurBgView:OnCtor()
	return
end

function DormSuitFurBgView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormSuitFurBgView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, FurnitureItem)
end

function DormSuitFurBgView:OnEnter()
	manager.windowBar:HideBar()

	self.suitID = self.params_.suitID
	self.shopID = self.params_.shopID

	self:RefreshView()
	self:RegisterEvents()
end

function DormSuitFurBgView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function DormSuitFurBgView:AddUIListener()
	self:AddBtnListenerScale(self.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
end

function DormSuitFurBgView:RefreshView()
	self:RefreshFurInfoList()
end

function DormSuitFurBgView:OnTop()
	self.scrollHelper_:Refresh()
end

function DormSuitFurBgView:RegisterEvents()
	self:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function(arg_13_0)
		if self.selIndex then
			local var_13_0 = self.scrollHelper_:GetItemByIndex(self.selIndex)

			if var_13_0 == nil then
				return
			end

			if self.suitID then
				var_13_0:RefreshUI(self.furInfoList[self.selIndex], nil, DormEnum.FurItemType.SuitFurShow, nil, self.selIndex)
			end
		end
	end)
end

function DormSuitFurBgView:RefreshFurInfoList()
	self.imageImg_.sprite = #BackHomeSuitCfg[self.suitID].scene_id == 1 and BackHomeSuitCfg[self.suitID].scene_id[1] == DormConst.BACKHOME_TYPE.PublicDorm and DormTools.GetShopStyleHallImage(self.shopID) or DormTools.GetShopStyleImage(self.shopID)
	self.furInfoList = {}

	if self.suitID then
		for iter_14_0, iter_14_1 in ipairs(BackHomeSuitCfg[self.suitID].suit_num) do
			table.insert(self.furInfoList, {
				furID = iter_14_1[1],
				suitID = self.suitID
			})
		end

		self.scrollHelper_:StartScroll(#self.furInfoList)

		self.suitName.text = ItemCfg[self.suitID].name or ""
	end
end

function DormSuitFurBgView:indexItem(arg_15_1, arg_15_2)
	if self.suitID then
		arg_15_2:RefreshUI(self.furInfoList[arg_15_1], nil, DormEnum.FurItemType.SuitFurShow, nil, arg_15_1)
	end

	arg_15_2:OnClickBtn(function(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		local var_16_0 = DormData:GetFurNumInfo(arg_16_0)

		self.selIndex = arg_16_1

		local var_16_1 = 0

		if arg_16_3 == "enough" then
			if var_16_0 then
				var_16_1 = var_16_0.num
			end

			ShowPopItem(POP_ITEM, {
				arg_16_0,
				var_16_1
			})
		elseif arg_16_3 == "canGift" then
			JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
				state = "gift",
				furID = arg_16_0,
				needNum = arg_16_4,
				defaultNum = arg_16_4
			})
		elseif arg_16_3 == "noEnough" then
			local var_16_2 = {}

			for iter_16_0, iter_16_1 in ipairs(ShopListCfg.all) do
				if ShopListCfg[iter_16_1].display_group == ShopListCfg[ShopConst.SHOP_ID.FURNITURE_SHOP].display_group then
					table.insert(var_16_2, iter_16_1)
				end
			end

			local var_16_3 = false

			for iter_16_2, iter_16_3 in ipairs((getGoodListByGiveID(arg_16_0))) do
				for iter_16_4, iter_16_5 in ipairs(var_16_2) do
					if ShopTools.IsGoodCanBuy(iter_16_5, iter_16_3) then
						var_16_3 = true

						break
					end
				end
			end

			if var_16_3 then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "buy",
					furID = arg_16_0,
					needNum = arg_16_4,
					defaultNum = arg_16_4
				})
			else
				ShowPopItem(POP_ITEM, {
					arg_16_0,
					var_16_1
				})
			end
		end
	end)
	arg_15_2:GrayCallBack(function(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
		self.selIndex = arg_17_1

		JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
			state = "gift",
			furID = arg_17_0,
			needNum = arg_17_4,
			defaultNum = arg_17_4
		})
	end)
end

function DormSuitFurBgView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()
	end

	DormSuitFurBgView.super.Dispose(self)
end

return DormSuitFurBgView
