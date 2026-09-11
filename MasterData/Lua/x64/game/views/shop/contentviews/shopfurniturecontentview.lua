local ShopFurnitureContentView = class("ShopFurnitureContentView", (import("game.views.shop.contentViews.ShopContentViewWithPoster")))

function ShopFurnitureContentView.GetAssetPath()
	return "Widget/System/Shop/contentViews/furnitureView"
end

function ShopFurnitureContentView:InitUI()
	ShopFurnitureContentView.super.InitUI(self)

	self.scrollRect = self.listGo_:GetComponent("ScrollRectEx")
	self.listController = ControllerUtil.GetController(self.listGo_.transform, "empty")

	self:AddUIListener()
end

function ShopFurnitureContentView:GetPoster()
	return DormTools.GetShopStyleImage(self.shopId_)
end

function ShopFurnitureContentView:OnEnter()
	self:RegistEventListener(COMMON_FILTER_OK, handler(self, self.UpdateDormList))
end

function ShopFurnitureContentView:OnExit()
	ShopFurnitureContentView.super.OnExit(self)
	self:RemoveAllEventListener()
	DormRedPointTools:CloseAllSuitGoodRedPoint(self.shopId_)
end

function ShopFurnitureContentView:Dispose()
	ShopFurnitureContentView.super.Dispose(self)
end

function ShopFurnitureContentView:UpdateDormList()
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(Filter_Group_Define.DORM_FURNITURE_TYPE.tags) do
		if CommonFilterData:HasIndexFlag(Filter_Root_Define.DORM_SHOP_Filter_List.filter_id, Filter_Group_Define.DORM_FURNITURE_TYPE.groupID, iter_7_1) then
			var_7_0 = iter_7_1

			break
		end
	end

	if var_7_0 == Filter_Tags_Define.FURNITURETYPEALL then
		self.selectedPos = nil
	else
		self.selectedPos = var_7_0 + DormConst.DORM_FURTYPE_OFFSET
	end

	self.textText_.text = CommonFilterCfg[var_7_0].name
end

function ShopFurnitureContentView:ResetFilter()
	self.selectedPos = nil
end

function ShopFurnitureContentView:AddUIListener()
	self.scrollRect.onValueChanged:AddListener(function(arg_10_0)
		if self.lastpos then
			self.goTrs_.localPosition = Vector3(self.goTrs_.localPosition.x, self.goTrs_.localPosition.y + (self.contentTrs_.localPosition.y - self.lastpos), 0)
		end

		self.lastpos = self.contentTrs_.localPosition.y
	end)
	self:AddBtnListener(self.btnBtn_, nil, function()
		JumpTools.OpenPageByJump("dormFurnitureImageView", {
			shopID = self.shopId_
		})
	end)
	self:AddBtnListener(self.filterBtn_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.DORM_SHOP_Filter_List
		})
	end)
end

function ShopFurnitureContentView:IndexItem(arg_13_1, arg_13_2)
	ShopFurnitureContentView.super.IndexItem(self, arg_13_1, arg_13_2)
	self:BindSuitRedPoint(self.shopDataList_[arg_13_1], arg_13_2)
end

function ShopFurnitureContentView:BindSuitRedPoint(arg_14_1, arg_14_2)
	local var_14_0 = getShopCfg(arg_14_1.id).give_id

	if manager.redPoint:getTipBoolean((DormRedPointTools.FurnitureItemRedPoint(self.shopId_, arg_14_1.id))) then
		manager.redPoint:SetRedPointIndependent(arg_14_2.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_14_2.transform_, false)
	end
end

function ShopFurnitureContentView:OnItemClick(arg_15_1)
	local var_15_0 = getShopCfg(arg_15_1.id, self.shopId_)

	if DormSuitData:CheckUnlockSuit(var_15_0.give_id) then
		if arg_15_1.buyTime >= var_15_0.limit_num then
			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("DORM_BUY_SAME_FURNITURE_SUIT"),
			OkCallback = function()
				self:OnShopClick(arg_15_1)
			end,
			CancelCallback = function()
				return
			end
		})
	else
		self:OnShopClick(arg_15_1)

		if DormSuitData:CheckIsConfigSuit(var_15_0.give_id) then
			DormRedPointTools:CloseSingleSuitGoodRedPoint(self.shopId_, arg_15_1.id)
		end
	end
end

return ShopFurnitureContentView
