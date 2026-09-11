local PolyhedronOverDifficultyItem = class("PolyhedronOverDifficultyItem", ReduxView)

function PolyhedronOverDifficultyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronOverDifficultyItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronOverDifficultyItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronOverDifficultyItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.name, self.desc, self.transform_.position, self.level)
		end
	end)
end

function PolyhedronOverDifficultyItem:SetData(arg_6_1, arg_6_2)
	if arg_6_1 == 1 then
		self.m_icon.sprite = getAffixSprite(arg_6_2)
		self.name = getAffixName(arg_6_2)
		self.desc = getAffixDesc(arg_6_2)
	elseif arg_6_1 == 2 then
		local var_6_0 = arg_6_2[1]
		local var_6_1 = arg_6_2[2]

		if PublicAttrCfg[arg_6_2[1]].percent == 1 then
			var_6_1 = var_6_1 / 10 .. "%"
		end

		if PolyhedronConst.SPECIAL_ATTR_DESC[var_6_0] ~= nil then
			self.name = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[var_6_0][2])
			self.desc = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[var_6_0][3]) .. var_6_1
		else
			self.name = PublicAttrCfg[arg_6_2[1]].name
			self.desc = PublicAttrCfg[arg_6_2[1]].name .. var_6_1
		end

		self.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.HERO_ATTRIBUTE_ICON_PATH .. var_6_0)
	end
end

function PolyhedronOverDifficultyItem:RegistCallBack(arg_7_1)
	self.clickFunc = arg_7_1
end

function PolyhedronOverDifficultyItem:Dispose()
	PolyhedronOverDifficultyItem.super.Dispose(self)
end

return PolyhedronOverDifficultyItem
