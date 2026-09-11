local SkuldTravelItemSelectItem = class("SkuldTravelItemSelectItem", ReduxView)
local var_0_1 = "TextureConfig/EmptyDream/travel/item/"

function SkuldTravelItemSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SkuldTravelItemSelectItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldTravelItemSelectItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if not self.lock_ then
			self.selecthandler_(self.itemid_)
		end
	end)
end

function SkuldTravelItemSelectItem:InitUI()
	self:BindCfgUI()

	self.islockcontroller_ = ControllerUtil.GetController(self.transform_, "islock")
	self.selectcontroller_ = ControllerUtil.GetController(self.transform_, "select")
end

function SkuldTravelItemSelectItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.itemid_ = arg_6_1
	self.mapid_ = arg_6_2
	self.poltid_ = SkuldTravelData:GetPlotIdByMapIdAndItemId(self.mapid_, self.itemid_)
	self.itemimage_.sprite = pureGetSpriteWithoutAtlas(var_0_1 .. TravelSkuldItemCfg[self.itemid_].icon)

	self:RefreshLockStatu()
	self:RefreshSelectStatu(arg_6_3)
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.TRAVEL_SKULD_TRAVELITEM .. self.poltid_)
end

function SkuldTravelItemSelectItem:SetSelecthandler(arg_7_1)
	self.selecthandler_ = arg_7_1
end

function SkuldTravelItemSelectItem:RefreshLockStatu()
	self.lock_ = false

	local var_8_0 = 1
	local var_8_1 = SkuldTravelData:GetAttrib()

	for iter_8_0, iter_8_1 in pairs(TravelSkuldItemCfg[self.itemid_].unlock) do
		if iter_8_1 > var_8_1[iter_8_0] then
			self.lock_ = true
		end

		if iter_8_1 > 0 then
			SetActive(self["attribtext_" .. var_8_0].gameObject, true)

			self["attribtext_" .. var_8_0].text = GetTips("TIP_NEED") .. SkuldTravelData:AttribIndexToString(iter_8_0) .. iter_8_1
			var_8_0 = var_8_0 + 1
		end
	end

	for iter_8_2 = var_8_0, 2 do
		SetActive(self["attribtext_" .. iter_8_2].gameObject, false)
	end

	self.islockcontroller_:SetSelectedState(self.lock_ and "true" or "false")
end

function SkuldTravelItemSelectItem:RefreshSelectStatu(arg_9_1)
	self.selectcontroller_:SetSelectedState(arg_9_1 == self.itemid_ and "true" or "false")
end

function SkuldTravelItemSelectItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.TRAVEL_SKULD_TRAVELITEM .. self.poltid_)

	self.selecthandler_ = nil

	SkuldTravelItemSelectItem.super.Dispose(self)
end

return SkuldTravelItemSelectItem
