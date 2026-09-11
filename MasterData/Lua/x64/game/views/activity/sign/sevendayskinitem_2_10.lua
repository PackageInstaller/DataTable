local SevenDaySkinItem_2_10 = class("SevenDaySkinItem_2_10", ReduxView)

function SevenDaySkinItem_2_10:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InjectUI()
	self:AddListeners()
end

function SevenDaySkinItem_2_10:InjectUI()
	self:BindCfgUI()

	self.ctrl = ControllerUtil.GetController(self.transform_, "receive")
	self.nameController = ControllerUtil.GetController(self.transform_, "name")
	self.qualityController = ControllerUtil.GetController(self.transform_, "quality")
end

function SevenDaySkinItem_2_10:RefreshView(arg_3_1, arg_3_2)
	self.item = arg_3_1

	local var_3_0 = arg_3_1[1]
	local var_3_1 = arg_3_1[2]

	self.group:SetActive(arg_3_1[2] >= 1)
	self.ctrl:SetSelectedIndex(arg_3_2)
	self.nameController:SetSelectedIndex(ItemCfg[var_3_0].display_rare - 1)
	self.qualityController:SetSelectedIndex(ItemCfg[var_3_0].display_rare - 1)

	self.txt.text = var_3_1
	self.icon.sprite = var_3_0 == 106001 and pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/106001") or ItemTools.getItemSprite(var_3_0)
end

function SevenDaySkinItem_2_10:AddListeners()
	self:AddBtnListener(self.btn, nil, handler(self, self.OnItemClick))
end

function SevenDaySkinItem_2_10:OnItemClick()
	ShowPopItem(POP_ITEM, self.item)
end

function SevenDaySkinItem_2_10:Dispose()
	SevenDaySkinItem_2_10.super.Dispose(self)
end

return SevenDaySkinItem_2_10
