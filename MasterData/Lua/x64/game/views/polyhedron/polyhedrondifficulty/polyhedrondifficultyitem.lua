local polyhedronDifficultyItem = class("polyhedronDifficultyItem", ReduxView)

function polyhedronDifficultyItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()

	if arg_1_2[1] == 1 then
		local var_1_0 = {
			arg_1_2[2],
			arg_1_2[3],
			arg_1_2[4]
		}

		self.m_name.text = getAffixName(var_1_0) .. NumberTools.IntToRomam(arg_1_2[3])
		self.m_des.text = getAffixDesc(var_1_0)
		self.m_icon.sprite = getAffixSprite(var_1_0)
	elseif arg_1_2[1] == 2 then
		local var_1_1 = arg_1_2[2]
		local var_1_2 = arg_1_2[3]

		if PublicAttrCfg[arg_1_2[2]].percent == 1 then
			var_1_2 = var_1_2 / 10 .. "%"
		end

		if PolyhedronConst.SPECIAL_ATTR_DESC[var_1_1] ~= nil then
			self.m_name.text = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[var_1_1][2])
			self.m_des.text = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[var_1_1][3]) .. var_1_2
		else
			self.m_name.text = GetI18NText(PublicAttrCfg[arg_1_2[2]].name)
			self.m_des.text = GetI18NText(PublicAttrCfg[arg_1_2[2]].name) .. var_1_2
		end

		self.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.HERO_ATTRIBUTE_ICON_PATH .. var_1_1)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_desTrans)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function polyhedronDifficultyItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function polyhedronDifficultyItem:InitUI()
	self:BindCfgUI()
end

function polyhedronDifficultyItem:AddUIListener()
	return
end

function polyhedronDifficultyItem:SetData(arg_5_1)
	return
end

function polyhedronDifficultyItem:Dispose()
	polyhedronDifficultyItem.super.Dispose(self)
end

return polyhedronDifficultyItem
