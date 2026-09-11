local SevenDaySkinItem = class("SevenDaySkinItem", ReduxView)

function SevenDaySkinItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InjectUI()
	self:AddListeners()
end

function SevenDaySkinItem:InjectUI()
	self:BindCfgUI()

	self.ctrl = ControllerUtil.GetController(self.transform_, "receive")
end

function SevenDaySkinItem:RefreshView(arg_3_1, arg_3_2)
	self.item = arg_3_1

	local var_3_0 = arg_3_1[1]
	local var_3_1 = arg_3_1[2]

	self.group:SetActive(arg_3_1[2] > 1)
	self.ctrl:SetSelectedIndex(arg_3_2)

	self.txt.text = var_3_1
	self.icon.sprite = ItemTools.getItemSprite(var_3_0)
end

function SevenDaySkinItem:AddListeners()
	self:AddBtnListener(self.btn, nil, handler(self, self.OnItemClick))
end

function SevenDaySkinItem:OnItemClick()
	ShowPopItem(POP_ITEM, self.item)
end

function SevenDaySkinItem:Dispose()
	SevenDaySkinItem.super.Dispose(self)
end

return SevenDaySkinItem
