local MythicAffixItem = class("MythicAffixItem", ReduxView)

function MythicAffixItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function MythicAffixItem:InitUI()
	self:BindCfgUI()

	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
end

function MythicAffixItem:SetData(arg_3_1)
	if arg_3_1.lock then
		self.lockController:SetSelectedIndex(1)
	else
		self.lockController:SetSelectedIndex(0)

		self.nameText_.text = getAffixName(arg_3_1)
		self.icon_.sprite = getAffixSprite(arg_3_1)
		self.level_.text = arg_3_1[2]
	end

	self:Show(true)
end

function MythicAffixItem:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function MythicAffixItem:Dispose()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil

	MythicAffixItem.super.Dispose(self)
end

return MythicAffixItem
