local NewWarChessBuffItem = class("NewWarChessBuffItem", ReduxView)

function NewWarChessBuffItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewWarChessBuffItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessBuffItem:InitUI()
	self:BindCfgUI()
end

function NewWarChessBuffItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.index_, self.cfg_.name, NewChessTools.GetBuffDes(self.buffEntity_))
		else
			print("buffItem self.clickHandler_为空！！！！")
		end
	end)
end

function NewWarChessBuffItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.index_ = arg_6_1
	self.buffEntity_ = arg_6_3
	self.cfg_ = NewWarChessBuffPoolCfg[self.buffEntity_.buffPoolID]

	self:RefreshUI()

	if arg_6_1 == arg_6_2 then
		SetActive(self.arrowGo_, true)
	else
		SetActive(self.arrowGo_, false)
	end

	self.btn_.interactable = false
end

function NewWarChessBuffItem:RefreshUI()
	self.nameText_.text = self.cfg_.name
	self.icon_.sprite = getSprite("Atlas/NewWarChess", self.cfg_.icon)

	if self.buffEntity_.CurRemainRound and self.buffEntity_.CurRemainRound > 0 then
		SetActive(self.remainGo_, true)

		self.remainText_.text = self.buffEntity_.CurRemainRound
	else
		SetActive(self.remainGo_, false)
	end

	if self.buffEntity_.CurUpdateRound then
		SetActive(self.updateGo_, true)

		self.updateText_.text = self.buffEntity_.CurUpdateRound
		self.updateImage_.fillAmount = self.buffEntity_.CurUpdateRound / self.buffEntity_.UpdateRound
	else
		SetActive(self.updateGo_, false)
	end
end

function NewWarChessBuffItem:SetClickCallBack(arg_8_1)
	self.clickHandler_ = arg_8_1
	self.btn_.interactable = true
end

function NewWarChessBuffItem:Dispose()
	self.clickHandler_ = nil

	NewWarChessBuffItem.super.Dispose(self)
end

return NewWarChessBuffItem
