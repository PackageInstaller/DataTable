local ActivitySkinDrawGiftItem = class("ActivitySkinDrawGiftItem", ReduxView)

function ActivitySkinDrawGiftItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinDrawGiftItem:Init()
	self:InitUI()

	self.rewardItemList = {}

	for iter_2_0 = 1, 2 do
		self.rewardItemList[iter_2_0] = ActivitySkinDrawItem.New(self["rewardGo_" .. iter_2_0])
	end

	self.stateController_ = self.controller_:GetController("state")
	self.getController_ = self.controller_:GetController("get")
	self.posController_ = self.controller_:GetController("pos")
end

function ActivitySkinDrawGiftItem:InitUI()
	self:BindCfgUI()
end

function ActivitySkinDrawGiftItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	for iter_4_0, iter_4_1 in ipairs(ItemCfg[arg_4_1].param) do
		if ItemCfg[iter_4_1[1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			self.rewardItemList[iter_4_0]:RefreshData({
				itemId = iter_4_1[1],
				count = iter_4_1[2] * arg_4_2
			}, arg_4_4)
		else
			self.rewardItemList[iter_4_0]:RefreshData({
				itemId = iter_4_1[1],
				count = iter_4_1[2] * arg_4_2
			})
		end
	end

	if arg_4_3 then
		self.stateController_:SetSelectedState("showText")

		self.bottomText_.text = arg_4_3
	else
		self.stateController_:SetSelectedState("normal")
	end
end

function ActivitySkinDrawGiftItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function ActivitySkinDrawGiftItem:SetInPopView(arg_6_1)
	if arg_6_1 then
		self.posController_:SetSelectedState("pop")
	else
		self.posController_:SetSelectedState("normal")
	end
end

function ActivitySkinDrawGiftItem:Dispose()
	for iter_7_0, iter_7_1 in pairs(self.rewardItemList) do
		iter_7_1:Dispose()

		iter_7_1 = nil
	end

	self.rewardItemList = nil

	self.super.Dispose(self)
end

return ActivitySkinDrawGiftItem
