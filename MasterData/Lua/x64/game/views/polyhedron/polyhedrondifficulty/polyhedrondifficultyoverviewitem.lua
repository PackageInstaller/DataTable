local PolyhedronDifficultyOverviewItem = class("PolyhedronDifficultyOverviewItem", ReduxView)

function PolyhedronDifficultyOverviewItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronDifficultyOverviewItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronDifficultyOverviewItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronDifficultyOverviewItem:AddUIListener()
	return
end

function PolyhedronDifficultyOverviewItem:SetData(arg_5_1, arg_5_2)
	if arg_5_1 == 1 then
		self.m_des.text = getAffixName(arg_5_2) .. NumberTools.IntToRomam(arg_5_2[2]) .. "\n" .. getAffixDesc(arg_5_2)
		self.m_icon.sprite = getAffixSprite(arg_5_2)
	elseif arg_5_1 == 2 then
		local var_5_0 = arg_5_2[2]

		if PublicAttrCfg[arg_5_2[1]].percent == 1 then
			var_5_0 = var_5_0 / 10 .. "%"
		end

		self.m_des.text = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[arg_5_2[1]][2]) .. "\n" .. GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[arg_5_2[1]][3]) .. var_5_0
		self.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.HERO_ATTRIBUTE_ICON_PATH .. arg_5_2[1])
	end
end

function PolyhedronDifficultyOverviewItem:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function PolyhedronDifficultyOverviewItem:Dispose()
	PolyhedronDifficultyOverviewItem.super.Dispose(self)
end

return PolyhedronDifficultyOverviewItem
