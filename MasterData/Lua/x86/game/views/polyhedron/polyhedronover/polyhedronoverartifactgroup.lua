local PolyhedronOverArtifactGroup = class("PolyhedronOverArtifactGroup", ReduxView)

function PolyhedronOverArtifactGroup:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronOverArtifactGroup:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronOverArtifactGroup:InitUI()
	self:BindCfgUI()

	self.itemList = {}
end

function PolyhedronOverArtifactGroup:AddUIListener()
	return
end

function PolyhedronOverArtifactGroup:SetData(arg_5_1, arg_5_2)
	self.m_title.text = PolyhedronTools.GetPolyhedronArtifactSubTypeDes(arg_5_1)
	self.group = arg_5_2

	for iter_5_0, iter_5_1 in ipairs(self.group) do
		if not self.itemList[iter_5_0] then
			table.insert(self.itemList, PolyhedronOverArtifactItem.New((Object.Instantiate(self.m_item, self.m_content))))
		end

		self.itemList[iter_5_0]:SetActive(true)
		self.itemList[iter_5_0]:SetData(iter_5_1)
	end

	for iter_5_2 = #self.group + 1, #self.itemList do
		self.itemList[iter_5_2]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function PolyhedronOverArtifactGroup:RegistCallBack(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self.itemList) do
		iter_6_1:RegistCallBack(arg_6_1)
	end
end

function PolyhedronOverArtifactGroup:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function PolyhedronOverArtifactGroup:Dispose()
	for iter_8_0, iter_8_1 in ipairs(self.itemList) do
		iter_8_1:Dispose()
	end

	self.itemList = nil

	PolyhedronOverArtifactGroup.super.Dispose(self)
end

function PolyhedronOverArtifactGroup:IndexItem(arg_9_1, arg_9_2)
	return
end

return PolyhedronOverArtifactGroup
