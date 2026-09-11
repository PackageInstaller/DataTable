local PolyhedronArtifactTipsItem = class("PolyhedronArtifactTipsItem", ReduxView)

function PolyhedronArtifactTipsItem:OnCtor(arg_1_1, arg_1_2)
	local var_1_0 = Object.Instantiate(arg_1_1, arg_1_2)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function PolyhedronArtifactTipsItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronArtifactTipsItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronArtifactTipsItem:AddUIListener()
	return
end

function PolyhedronArtifactTipsItem:SetData(arg_5_1, arg_5_2)
	self.m_level.text = string.format("LV.<size=48>%d</size>", arg_5_2)
	self.m_des.text = getAffixDesc({
		arg_5_1,
		arg_5_2
	})

	self:SetActive(true)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function PolyhedronArtifactTipsItem:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function PolyhedronArtifactTipsItem:Dispose()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	PolyhedronArtifactTipsItem.super.Dispose(self)
end

return PolyhedronArtifactTipsItem
