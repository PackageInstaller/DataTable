local NewWarChessTipsBuffItem = class("NewWarChessTipsBuffItem")

function NewWarChessTipsBuffItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewWarChessTipsBuffItem:Init()
	self:InitUI()
end

function NewWarChessTipsBuffItem:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)
end

function NewWarChessTipsBuffItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.index_ = arg_4_1
	self.buffEntity_ = arg_4_3
	self.cfg_ = NewWarChessBuffPoolCfg[self.buffEntity_.buffPoolID]

	self:RefreshUI()

	if arg_4_1 == arg_4_2 then
		SetActive(self.arrowGo_, true)
	else
		SetActive(self.arrowGo_, false)
	end
end

function NewWarChessTipsBuffItem:RefreshUI()
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

function NewWarChessTipsBuffItem:Dispose()
	return
end

return NewWarChessTipsBuffItem
