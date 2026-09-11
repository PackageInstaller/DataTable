local NewBieHeroPoolItem = class("NewBieHeroPoolItem", ReduxView)

function NewBieHeroPoolItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewBieHeroPoolItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewBieHeroPoolItem:InitUI()
	self:BindCfgUI()
end

function NewBieHeroPoolItem:AddUIListener()
	self:AddBtnListener(self.detailBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			isDraw = true,
			hid = self.id_
		})
	end)
end

function NewBieHeroPoolItem:AddEventListeners()
	return
end

function NewBieHeroPoolItem:SetData(arg_7_1, arg_7_2)
	self.index_ = arg_7_1
	self.id_ = arg_7_2
	self.cfg_ = HeroCfg[self.id_]

	self:UpdateView()
end

function NewBieHeroPoolItem:UpdateView()
	if HeroCfg[self.id_] == nil then
		return
	end

	self.nameText_.text = GetI18NText(HeroCfg[self.id_].name)

	if self.suffixText_ then
		self.suffixText_.text = GetI18NText(HeroCfg[self.id_].suffix)
	else
		self.nameText_.text = HeroTools.GetHeroFullName(self.id_)
	end

	self.campIcon_.sprite = HeroTools.GetHeroRaceIcon(self.id_)
end

function NewBieHeroPoolItem:OnEnter()
	self:AddEventListeners()
end

function NewBieHeroPoolItem:OnExit()
	self:RemoveAllEventListener()
end

function NewBieHeroPoolItem:Dispose()
	self.data_ = nil

	NewBieHeroPoolItem.super.Dispose(self)
end

return NewBieHeroPoolItem
