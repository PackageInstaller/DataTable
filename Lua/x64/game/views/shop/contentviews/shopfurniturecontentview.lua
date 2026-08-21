local var_0_0 = import("game.views.shop.contentViews.ShopContentViewWithPoster")
local var_0_1 = class("ShopFurnitureContentView", var_0_0)

function var_0_1.GetAssetPath()
	return "Widget/System/Shop/contentViews/furnitureView"
end

function var_0_1.InitUI(arg_2_0)
	var_0_1.super.InitUI(arg_2_0)

	arg_2_0.scrollRect = arg_2_0.listGo_:GetComponent("ScrollRectEx")
	arg_2_0.listController = ControllerUtil.GetController(arg_2_0.listGo_.transform, "empty")

	arg_2_0:AddUIListener()
end

function var_0_1.GetPoster(arg_3_0)
	return DormTools.GetShopStyleImage(arg_3_0.shopId_)
end

function var_0_1.OnEnter(arg_4_0)
	arg_4_0:RegistEventListener(COMMON_FILTER_OK, handler(arg_4_0, arg_4_0.UpdateDormList))
end

function var_0_1.OnExit(arg_5_0)
	var_0_1.super.OnExit(arg_5_0)
	arg_5_0:RemoveAllEventListener()
	DormRedPointTools:CloseAllSuitGoodRedPoint(arg_5_0.shopId_)
end

function var_0_1.Dispose(arg_6_0)
	var_0_1.super.Dispose(arg_6_0)
end

function var_0_1.UpdateDormList(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(Filter_Group_Define.DORM_FURNITURE_TYPE.tags) do
		if CommonFilterData:HasIndexFlag(Filter_Root_Define.DORM_SHOP_Filter_List.filter_id, Filter_Group_Define.DORM_FURNITURE_TYPE.groupID, iter_7_1) then
			var_7_0 = iter_7_1

			break
		end
	end

	if var_7_0 == Filter_Tags_Define.FURNITURETYPEALL then
		arg_7_0.selectedPos = nil
	else
		arg_7_0.selectedPos = var_7_0 + DormConst.DORM_FURTYPE_OFFSET
	end

	arg_7_0.textText_.text = CommonFilterCfg[var_7_0].name
end

function var_0_1.ResetFilter(arg_8_0)
	arg_8_0.selectedPos = nil
end

function var_0_1.AddUIListener(arg_9_0)
	arg_9_0.scrollRect.onValueChanged:AddListener(function(arg_10_0)
		if arg_9_0.lastpos then
			local var_10_0 = arg_9_0.contentTrs_.localPosition.y - arg_9_0.lastpos

			arg_9_0.goTrs_.localPosition = Vector3(arg_9_0.goTrs_.localPosition.x, arg_9_0.goTrs_.localPosition.y + var_10_0, 0)
		end

		arg_9_0.lastpos = arg_9_0.contentTrs_.localPosition.y
	end)
	arg_9_0:AddBtnListener(arg_9_0.btnBtn_, nil, function()
		JumpTools.OpenPageByJump("dormFurnitureImageView", {
			shopID = arg_9_0.shopId_
		})
	end)
	arg_9_0:AddBtnListener(arg_9_0.filterBtn_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.DORM_SHOP_Filter_List
		})
	end)
end

function var_0_1.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	var_0_1.super.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:BindSuitRedPoint(arg_13_0.shopDataList_[arg_13_1], arg_13_2)
end

function var_0_1.BindSuitRedPoint(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = getShopCfg(arg_14_1.id).give_id
	local var_14_1 = DormRedPointTools.FurnitureItemRedPoint(arg_14_0.shopId_, arg_14_1.id)

	if manager.redPoint:getTipBoolean(var_14_1) then
		manager.redPoint:SetRedPointIndependent(arg_14_2.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_14_2.transform_, false)
	end
end

function var_0_1.OnItemClick(arg_15_0, arg_15_1)
	local var_15_0 = getShopCfg(arg_15_1.id, arg_15_0.shopId_)
	local var_15_1 = var_15_0.give_id

	if DormSuitData:CheckUnlockSuit(var_15_1) then
		if arg_15_1.buyTime >= var_15_0.limit_num then
			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("DORM_BUY_SAME_FURNITURE_SUIT"),
			OkCallback = function()
				arg_15_0:OnShopClick(arg_15_1)
			end,
			CancelCallback = function()
				return
			end
		})
	else
		arg_15_0:OnShopClick(arg_15_1)

		if DormSuitData:CheckIsConfigSuit(var_15_1) then
			DormRedPointTools:CloseSingleSuitGoodRedPoint(arg_15_0.shopId_, arg_15_1.id)
		end
	end
end

return var_0_1
