local QWorldRewardSideItem = class("QWorldRewardSideItem", ReduxView)

function QWorldRewardSideItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function QWorldRewardSideItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldRewardSideItem:InitUI()
	self:BindCfgUI()

	self.rareController_ = self.transform_:GetComponent("ControllerExCollection"):GetController("highlight")
end

function QWorldRewardSideItem:AddUIListener()
	return
end

function QWorldRewardSideItem:SetData(arg_5_1)
	self.reward_ = arg_5_1

	self:RefreshUI()
end

function QWorldRewardSideItem:RefreshUI()
	local var_6_0 = self.reward_

	if self.reward_ then
		self.text_.text = ItemTools.getItemName(self.reward_.id)
		self.numText_.text = formatNumber(self.reward_.num)

		ItemTools.GetItemSpriteAsync(self.reward_.id, function(arg_7_0, arg_7_1)
			if isNil(self.gameObject_) then
				return
			end

			if var_6_0 and arg_7_0 == var_6_0.id then
				self.icon_.sprite = arg_7_1
			end
		end, nil, ItemCfg[self.reward_.id].type == ItemConst.ITEM_TYPE.EQUIP)

		if ItemCfg[self.reward_.id].display_rare == 5 then
			self.animName_ = "UI_propsPanel_Item_gloden"

			self.rareController_:SetSelectedState("true")
		else
			self.animName_ = "UI_propsPanel_Item"

			self.rareController_:SetSelectedState("false")
		end

		self:RefreshAnim()
	end
end

function QWorldRewardSideItem:RefreshAnim()
	if self.animName_ and self.gameObject_.activeInHierarchy then
		self.ani_:Play(self.animName_)
		self.ani_:Update(0)

		self.animName_ = nil
	end
end

function QWorldRewardSideItem:Dispose()
	QWorldRewardSideItem.super.Dispose(self)
end

return QWorldRewardSideItem
