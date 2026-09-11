local PolyhedronArtifactAtlasIItem = class("PolyhedronArtifactAtlasIItem", ReduxView)

function PolyhedronArtifactAtlasIItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PolyhedronArtifactAtlasIItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronArtifactAtlasIItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function PolyhedronArtifactAtlasIItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.state == 2 then
			JumpTools.OpenPageByJump("polyhedronArtifactTips", {
				artifact_id = self.artifact_id
			})
		end
	end)
end

function PolyhedronArtifactAtlasIItem:SetData(arg_6_1)
	self.artifact_id = arg_6_1

	local var_6_0 = PolyhedronArtifactCfg[arg_6_1]

	self.m_name.text = GetI18NText(PolyhedronArtifactCfg[arg_6_1].name)
	self.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. var_6_0.icon)
	self.state = PolyhedronData:GetArtifaceAtlasState(arg_6_1)

	if self.state == 0 then
		self.m_des.text = GetTips("POLYHEDRON_HANDBOOK_NOT_COLLECT")

		self.stateController:SetSelectedIndex(1)
	else
		if self.state == 1 then
			self.stateController:SetSelectedIndex(2)
		else
			self.stateController:SetSelectedIndex(0)
		end

		self.m_des.text = var_6_0.note or ""
	end

	self:SetActive(true)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_descTrans_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_descPanelTrans_)
	self.transform_:SetSizeDeltaY(self.m_descPanelTrans_:GetSizeDeltaY(0))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function PolyhedronArtifactAtlasIItem:Dispose()
	PolyhedronArtifactAtlasIItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function PolyhedronArtifactAtlasIItem:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

return PolyhedronArtifactAtlasIItem
