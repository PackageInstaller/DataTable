local PolyhedronArtifactTipsView = class("PolyhedronArtifactTipsView", ReduxView)

function PolyhedronArtifactTipsView:UIName()
	return "Widget/System/Polyhedron/PolyhedronTreasureUI"
end

function PolyhedronArtifactTipsView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronArtifactTipsView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronArtifactTipsView:InitUI()
	self:BindCfgUI()

	self.list = {}
end

function PolyhedronArtifactTipsView:AddUIListener()
	self:AddBtnListener(self.m_mask, nil, function()
		self:Back()
	end)
end

function PolyhedronArtifactTipsView:OnTop()
	manager.windowBar:SwitchBar({})
end

function PolyhedronArtifactTipsView:OnEnter()
	self.id = self.params_.artifact_id
	self.m_name.text = GetI18NText(PolyhedronArtifactCfg[self.id].name)
	self.m_story.text = GetI18NText(PolyhedronArtifactCfg[self.id].story) or ""
	self.affix_id = PolyhedronArtifactCfg[self.id].affix_id
	self.max_level = math.min(PolyhedronArtifactCfg[self.id].max_level, AffixTypeCfg[self.affix_id].max_level)

	for iter_8_0 = 1, self.max_level do
		self.list[iter_8_0] = self.list[iter_8_0] or PolyhedronArtifactTipsItem.New(self.m_explainGo, self.m_content)

		self.list[iter_8_0]:SetData(self.affix_id, iter_8_0)
	end

	for iter_8_1 = self.max_level + 1, #self.list do
		self.list[iter_8_1]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_contentw)
end

function PolyhedronArtifactTipsView:OnExit()
	manager.windowBar:HideBar()
end

function PolyhedronArtifactTipsView:Dispose()
	for iter_10_0, iter_10_1 in ipairs(self.list) do
		iter_10_1:Dispose()
	end

	self.list = nil

	PolyhedronArtifactTipsView.super.Dispose(self)
end

return PolyhedronArtifactTipsView
