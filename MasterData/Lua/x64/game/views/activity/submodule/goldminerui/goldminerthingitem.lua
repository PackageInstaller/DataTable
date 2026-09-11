local GoldMinerThingItem = class("GoldMinerThingItem", ReduxView)

function GoldMinerThingItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GoldMinerThingItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function GoldMinerThingItem:InitUI()
	self:BindCfgUI()

	self.oriX_ = self.transform_.localPosition.x
	self.direct_ = 1
end

function GoldMinerThingItem:AddUIListener()
	return
end

function GoldMinerThingItem:AddEventListeners()
	return
end

function GoldMinerThingItem:SetData(arg_6_1, arg_6_2)
	self.id_ = arg_6_2
	self.data_ = arg_6_1
	self.cfg_ = GameFishCfg[arg_6_1.fishId]
	self.hitArea_.sizeDelta = Vector2(self.data_.hitWidth, self.data_.hitHeight)
end

function GoldMinerThingItem:GetData()
	return self.data_
end

function GoldMinerThingItem:GetID()
	return self.id_
end

function GoldMinerThingItem:GetLocalPosition()
	return self.transform_.localPosition
end

function GoldMinerThingItem:UpdateView()
	return
end

function GoldMinerThingItem:Update(arg_11_1)
	if self.data_ and self.data_.moveable == 1 then
		local var_11_0 = self.transform_.localPosition

		var_11_0.x = self.transform_.localPosition.x + arg_11_1 * self.direct_ * self.cfg_.speed / 10 * 60

		if var_11_0.x < self.oriX_ - self.data_.radius then
			var_11_0.x = self.oriX_ - self.data_.radius
			self.direct_ = 1

			if self.imageTransform_.localScale == nil then
				CustomLog.Log(string.format("scale is nil"))
			end

			self.imageTransform_.localScale.x = 1
			self.imageTransform_.localScale = self.imageTransform_.localScale
		elseif var_11_0.x > self.oriX_ + self.data_.radius then
			var_11_0.x = self.oriX_ + self.data_.radius
			self.direct_ = -1
			self.imageTransform_.localScale.x = -1
			self.imageTransform_.localScale = self.imageTransform_.localScale
		end

		self.transform_.localPosition = var_11_0
	end
end

function GoldMinerThingItem:SetActive(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)
end

function GoldMinerThingItem:Dispose()
	Object.Destroy(self.gameObject_)
	GoldMinerThingItem.super.Dispose(self)
end

return GoldMinerThingItem
