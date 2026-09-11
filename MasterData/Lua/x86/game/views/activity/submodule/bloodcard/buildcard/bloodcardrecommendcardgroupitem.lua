local BloodCardRecommendCardGroupItem = class("BloodCardRecommendCardGroupItem", ReduxView)

function BloodCardRecommendCardGroupItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()
	self:InitUI()
end

function BloodCardRecommendCardGroupItem:InitUI()
	self.selectController_ = self.controller_:GetController("select")
	self.collectController_ = self.controller_:GetController("collect")
end

function BloodCardRecommendCardGroupItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallBack_ then
			self.clickCallBack_(self.groupID_)
		end
	end)
end

function BloodCardRecommendCardGroupItem:SetData(arg_5_1)
	self.groupID_ = arg_5_1
	self.cfg_ = BloodCardGameRecommendCardSetCfg[self.groupID_]

	self:RefreshUI()
end

function BloodCardRecommendCardGroupItem:RefreshUI(arg_6_1)
	self.nameText_.text = self.cfg_.name
	self.ownCardNum_ = BloodCardData:GetGroupOwnCardNum(self.cfg_.card_list)
	self.progressText_.text = self.ownCardNum_ .. "/" .. #self.cfg_.card_list

	self.collectController_:SetSelectedState(tostring(self.ownCardNum_ == #self.cfg_.card_list))
end

function BloodCardRecommendCardGroupItem:SetClickCallBack(arg_7_1)
	self.clickCallBack_ = arg_7_1
end

function BloodCardRecommendCardGroupItem:RefreshSelect(arg_8_1)
	self.selectController_:SetSelectedState(tostring(self.groupID_ == arg_8_1))
end

function BloodCardRecommendCardGroupItem:Dispose()
	self.clickCallBack_ = nil

	BloodCardRecommendCardGroupItem.super.Dispose(self)
end

return BloodCardRecommendCardGroupItem
