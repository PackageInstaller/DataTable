local MomoTalkBubleItem = class("MomoTalkBubleItem", ReduxView)

function MomoTalkBubleItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function MomoTalkBubleItem:AddListeners()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.onClick_ then
			self.onClick_(self.id_)
		end
	end)
end

function MomoTalkBubleItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.id_ = arg_4_1.id
	self.onClick_ = arg_4_3

	local var_4_0 = arg_4_1.state == 1

	if self.previewImg_ then
		self.previewImg_.sprite = getSpriteViaConfig("ChatBubble", arg_4_1.id)
	end

	if self.lockGo_ then
		SetActive(self.lockGo_, not var_4_0)
	end

	if self.selectGo_ then
		SetActive(self.selectGo_, arg_4_2)
	end

	if self.itemBtn_ then
		self.itemBtn_.interactable = var_4_0
	end
end

function MomoTalkBubleItem:SetSelected(arg_5_1)
	if self.selectGo_ then
		SetActive(self.selectGo_, arg_5_1)
	end
end

function MomoTalkBubleItem:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function MomoTalkBubleItem:Dispose()
	self:RemoveAllListeners()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil

	MomoTalkBubleItem.super.Dispose(self)
end

return MomoTalkBubleItem
