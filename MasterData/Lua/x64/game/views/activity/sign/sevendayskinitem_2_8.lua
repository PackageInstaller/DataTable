local SevenDaySkinItem_2_8 = class("SevenDaySkinItem_2_8", ReduxView)

function SevenDaySkinItem_2_8:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InjectUI()
	self:AddListeners()
end

function SevenDaySkinItem_2_8:InjectUI()
	self:BindCfgUI()

	self.ctrl = ControllerUtil.GetController(self.transform_, "receive")
end

function SevenDaySkinItem_2_8:RefreshView(arg_3_1, arg_3_2)
	self.item = arg_3_1

	local var_3_0 = arg_3_1[1]
	local var_3_1 = arg_3_1[2]

	self.group:SetActive(arg_3_1[2] > 1)
	self.ctrl:SetSelectedIndex(arg_3_2)

	self.txt.text = var_3_1
	self.icon.sprite = var_3_0 == 106001 and pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/106001") or ItemTools.getItemSprite(var_3_0)
end

function SevenDaySkinItem_2_8:AddListeners()
	self:AddBtnListener(self.btn, nil, handler(self, self.OnItemClick))
end

function SevenDaySkinItem_2_8:OnItemClick()
	ShowPopItem(POP_ITEM, self.item)
end

function SevenDaySkinItem_2_8:Dispose()
	SevenDaySkinItem_2_8.super.Dispose(self)
end

return SevenDaySkinItem_2_8
