local PolyhedronSetArtifactGroup = class("PolyhedronSetArtifactGroup", ReduxView)

function PolyhedronSetArtifactGroup:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronSetArtifactGroup:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronSetArtifactGroup:InitUI()
	self:BindCfgUI()

	self.itemList = {}
end

function PolyhedronSetArtifactGroup:AddUIListener()
	return
end

function PolyhedronSetArtifactGroup:RegistCallBack(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self.itemList) do
		iter_5_1:RegistCallBack(arg_5_1)
	end
end

function PolyhedronSetArtifactGroup:SetData(arg_6_1, arg_6_2)
	self.m_title.text = PolyhedronTools.GetPolyhedronArtifactSubTypeDes(arg_6_1)
	self.group = arg_6_2

	for iter_6_0, iter_6_1 in ipairs(self.group) do
		self.itemList[iter_6_0] = self.itemList[iter_6_0] or PolyhedronSetArtifactItem.New(self.m_item, self.m_content)

		self.itemList[iter_6_0]:SetActive(true)
		self.itemList[iter_6_0]:SetData(iter_6_1)
	end

	for iter_6_2 = #self.group + 1, #self.itemList do
		self.itemList[iter_6_2]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content)
end

function PolyhedronSetArtifactGroup:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function PolyhedronSetArtifactGroup:Dispose()
	for iter_8_0, iter_8_1 in ipairs(self.itemList) do
		iter_8_1:Dispose()
	end

	self.itemList = nil

	PolyhedronSetArtifactGroup.super.Dispose(self)
end

function PolyhedronSetArtifactGroup:RefreshContentHeight()
	local var_9_0 = self.m_content:GetComponent("VerticalLayoutGroup").spacing
	local var_9_1 = 0

	for iter_9_0 = 1, self.m_content.childCount do
		var_9_1 = var_9_1 + self.m_content:GetChild(iter_9_0 - 1):GetSizeDeltaY(nil) + var_9_0
	end

	self.m_content:SetSizeDeltaY(var_9_1 - var_9_0)
end

function PolyhedronSetArtifactGroup:RefreshHeight()
	local var_10_0 = self.transform_:GetComponent("VerticalLayoutGroup").spacing
	local var_10_1 = 0

	for iter_10_0 = 1, self.transform_.childCount do
		var_10_1 = var_10_1 + self.transform_:GetChild(iter_10_0 - 1):GetSizeDeltaY(nil) + var_10_0
	end

	self.transform_:SetSizeDeltaY(var_10_1 - var_10_0)
end

return PolyhedronSetArtifactGroup
