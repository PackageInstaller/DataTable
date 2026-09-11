local PushBoxAffixItem = class("PushBoxAffixItem", ReduxView)

function PushBoxAffixItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function PushBoxAffixItem:InitUI()
	self.icon_ = self:FindCom(typeof(Image), "icon")
	self.text_ = self:FindCom(typeof(Text), "text")
end

function PushBoxAffixItem:Dispose()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil

	PushBoxAffixItem.super.Dispose(self)
end

function PushBoxAffixItem:SetData(arg_4_1)
	self.icon_.sprite = getAffixSprite(arg_4_1)
	self.text_.text = GetI18NText(getAffixName(arg_4_1))

	self:SetActive(true)
end

function PushBoxAffixItem:SetActive(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

return PushBoxAffixItem
