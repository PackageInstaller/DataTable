local var_0_0 = class("DormItemPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormFurnitureInfoPopUI_02"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.previewBtn_, nil, function()
		if BackHomeDataManager:IsInDormSystem() then
			local var_7_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")

			if not var_7_0 then
				manager.ui:SetMainCameraCom("CinemachineBrain", true)

				var_7_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")
			end

			local var_7_1 = var_7_0.m_DefaultBlend

			var_7_0.m_DefaultBlend = DanceGameController.cut

			JumpTools.OpenPageByJump("/furniturePreview", {
				furID = arg_5_0.itemID,
				cacheBlend = var_7_1
			})
		else
			JumpTools.OpenPageByJump("/furniturePreviewWithEntity", {
				furID = arg_5_0.itemID
			})
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.itemID = arg_8_0.params_.id

	arg_8_0:RefreshView()
end

function var_0_0.RefreshView(arg_9_0)
	SetActive(arg_9_0.previewBtn_.gameObject, not IsQworldRunning())
	arg_9_0:RefreshCommonItem()
	arg_9_0:RefreshItemInfo()
	arg_9_0:RefreshLableContent()
end

function var_0_0.RefreshCommonItem(arg_10_0)
	if not arg_10_0.commonItemView_ then
		arg_10_0.commonItemView_ = CommonItemView.New(arg_10_0.commonItem_)
	end

	arg_10_0.commonItemView_:SetData({
		id = arg_10_0.itemID
	})
end

function var_0_0.RefreshItemInfo(arg_11_0)
	local var_11_0 = DormData:GetFurNumInfo(arg_11_0.itemID)

	arg_11_0.holdNum.text = tostring(var_11_0.num)
end

function var_0_0.RefreshLableContent(arg_12_0)
	if ItemCfg[arg_12_0.itemID] then
		arg_12_0.ItemDesc.text = ItemTools.getItemDesc(arg_12_0.itemID)
	else
		arg_12_0.ItemDesc.text = ""
	end

	arg_12_0.titletextText_.text = ItemTools.getItemName(arg_12_0.itemID)
	arg_12_0.typeDesc.text = DormTools:GetFurGiftTypeDesc(arg_12_0.itemID)

	local var_12_0 = ""
	local var_12_1 = BackHomeFurniture[arg_12_0.itemID].scene_id

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		var_12_0 = var_12_0 .. DormTools:GetRoomTypeName(iter_12_1) .. " "
	end

	arg_12_0.sceneDesc.text = var_12_0
	arg_12_0.giftMax.text = DormTools:GetFurGiftMaxDesc(arg_12_0.itemID)
	arg_12_0.comfortNum.text = DormTools:GetFurComfortDesc(arg_12_0.itemID)
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.commonItemView_ then
		arg_13_0.commonItemView_:Dispose()
	end

	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.Cacheable(arg_14_0)
	return false
end

return var_0_0
