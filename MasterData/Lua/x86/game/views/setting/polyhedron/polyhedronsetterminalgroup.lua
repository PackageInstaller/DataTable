local PolyhedronSetTerminalGroup = class("PolyhedronSetTerminalGroup", ReduxView)

function PolyhedronSetTerminalGroup:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronSetTerminalGroup:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronSetTerminalGroup:InitUI()
	self:BindCfgUI()

	self.itemList = {}
end

function PolyhedronSetTerminalGroup:AddUIListener()
	return
end

function PolyhedronSetTerminalGroup:SetData(arg_5_1, arg_5_2)
	self.m_title.text = PolyhedronTools.GetPolyhedronTerminalClassifyDes(arg_5_1)
	self.group = arg_5_2

	for iter_5_0, iter_5_1 in ipairs(self.group) do
		if not self.itemList[iter_5_0] then
			table.insert(self.itemList, PolyhedronSetTerminalItem.New((Object.Instantiate(self.m_item, self.m_content))))
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

function PolyhedronSetTerminalGroup:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function PolyhedronSetTerminalGroup:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.itemList) do
		iter_7_1:Dispose()
	end

	self.itemList = nil

	PolyhedronSetTerminalGroup.super.Dispose(self)
end

function PolyhedronSetTerminalGroup:RegistCallBack(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self.itemList) do
		iter_8_1:RegistCallBack(arg_8_1)
	end
end

return PolyhedronSetTerminalGroup
