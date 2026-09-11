local PolyhedronSetArtifactItem = class("PolyhedronSetArtifactItem", ReduxView)

function PolyhedronSetArtifactItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PolyhedronSetArtifactItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronSetArtifactItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronSetArtifactItem:AddUIListener()
	return
end

function PolyhedronSetArtifactItem:SetData(arg_5_1)
	self.id = arg_5_1.id
	self.level = arg_5_1.level
	self.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. PolyhedronArtifactCfg[arg_5_1.id].icon)
	self.m_name.text = getAffixName({
		PolyhedronArtifactCfg[arg_5_1.id].affix_id,
		arg_5_1.level,
		PolyhedronArtifactCfg[arg_5_1.id].affix_target
	})
	self.m_des.text = getAffixDesc({
		PolyhedronArtifactCfg[arg_5_1.id].affix_id,
		arg_5_1.level,
		PolyhedronArtifactCfg[arg_5_1.id].affix_target
	})
	self.m_levelLab.text = "LV." .. arg_5_1.level

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function PolyhedronSetArtifactItem:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function PolyhedronSetArtifactItem:RegistCallBack(arg_7_1)
	self.clickFunc = arg_7_1
end

function PolyhedronSetArtifactItem:Dispose()
	PolyhedronSetArtifactItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return PolyhedronSetArtifactItem
