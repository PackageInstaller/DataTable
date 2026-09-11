local NewWarChessSkillItem = class("NewWarChessSkillItem", ReduxView)

function NewWarChessSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewWarChessSkillItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessSkillItem:InitUI()
	self:BindCfgUI()
end

function NewWarChessSkillItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. self.data_.skillID, 0)
			self.clickHandler_(self.data_.skillID)
		end
	end)
end

function NewWarChessSkillItem:SetData(arg_6_1)
	self.data_ = arg_6_1
	self.cfg_ = NewWarChessDiceSkillCfg[self.data_.skillID]
	self.leftUseLimit_ = self.data_.useLimit
	self.totalUseLimit_ = self.cfg_.use_limit
	self.name_ = self.cfg_.name

	self:RefreshUI()

	self.btn_.interactable = false
end

function NewWarChessSkillItem:RefreshUI()
	self.title_.text = self.name_
	self.iconImage_.sprite = getSprite("Atlas/NewWarChess", self.cfg_.icon)
	self.useText_.text = self.leftUseLimit_ .. "/" .. self.totalUseLimit_
end

function NewWarChessSkillItem:SetClickCallBack(arg_8_1)
	self.clickHandler_ = arg_8_1
	self.btn_.interactable = true
end

function NewWarChessSkillItem:BindSkillRedPoint()
	self.enableRed_ = true

	if self.data_ then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. self.data_.skillID)
	end
end

function NewWarChessSkillItem:Dispose()
	self.clickHandler_ = nil

	if self.enableRed_ and self.data_ then
		manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. self.data_.skillID)
	end

	NewWarChessSkillItem.super.Dispose(self)
end

return NewWarChessSkillItem
