local DormItemPopView = class("DormItemPopView", ReduxView)

function DormItemPopView:UIName()
	return "Widget/BackHouseUI/Dorm/DormFurnitureInfoPopUI_02"
end

function DormItemPopView:UIParent()
	return manager.ui.uiPop.transform
end

function DormItemPopView:Init()
	self:InitUI()
	self:AddListeners()
end

function DormItemPopView:InitUI()
	self:BindCfgUI()
end

function DormItemPopView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.previewBtn_, nil, function()
		if BackHomeDataManager:IsInDormSystem() then
			local var_7_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")

			if not var_7_0 then
				manager.ui:SetMainCameraCom("CinemachineBrain", true)

				var_7_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")
			end

			local var_7_1 = var_7_0.m_DefaultBlend

			var_7_0.m_DefaultBlend = DanceGameController.cut

			JumpTools.OpenPageByJump("/furniturePreview", {
				furID = self.itemID,
				cacheBlend = var_7_1
			})
		else
			JumpTools.OpenPageByJump("/furniturePreviewWithEntity", {
				furID = self.itemID
			})
		end
	end)
end

function DormItemPopView:OnEnter()
	self.itemID = self.params_.id

	self:RefreshView()
end

function DormItemPopView:RefreshView()
	SetActive(self.previewBtn_.gameObject, not IsQworldRunning())
	self:RefreshCommonItem()
	self:RefreshItemInfo()
	self:RefreshLableContent()
end

function DormItemPopView:RefreshCommonItem()
	self.commonItemView_ = self.commonItemView_ or CommonItemView.New(self.commonItem_)

	self.commonItemView_:SetData({
		id = self.itemID
	})
end

function DormItemPopView:RefreshItemInfo()
	self.holdNum.text = tostring(DormData:GetFurNumInfo(self.itemID).num)
end

function DormItemPopView:RefreshLableContent()
	self.ItemDesc.text = ItemCfg[self.itemID] and ItemTools.getItemDesc(self.itemID) or ""
	self.titletextText_.text = ItemTools.getItemName(self.itemID)
	self.typeDesc.text = DormTools:GetFurGiftTypeDesc(self.itemID)

	local var_12_0 = ""

	for iter_12_0, iter_12_1 in ipairs(BackHomeFurniture[self.itemID].scene_id) do
		var_12_0 = var_12_0 .. DormTools:GetRoomTypeName(iter_12_1) .. " "
	end

	self.sceneDesc.text = var_12_0
	self.giftMax.text = DormTools:GetFurGiftMaxDesc(self.itemID)
	self.comfortNum.text = DormTools:GetFurComfortDesc(self.itemID)
end

function DormItemPopView:Dispose()
	if self.commonItemView_ then
		self.commonItemView_:Dispose()
	end

	DormItemPopView.super.Dispose(self)
end

function DormItemPopView:Cacheable()
	return false
end

return DormItemPopView
