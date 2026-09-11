local SurpassUpAttrNode = class("SurpassUpAttrNode", ReduxView)

function SurpassUpAttrNode:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function SurpassUpAttrNode:InitUI()
	self:BindCfgUI()

	self.attrList = {}

	for iter_2_0 = 1, 3 do
		self.attrList[iter_2_0] = SurpassUpAttrItem.New(self["attr" .. iter_2_0 .. "Go_"])
	end
end

function SurpassUpAttrNode:RefreshUi(arg_3_1, arg_3_2)
	self.texttittleText_.text = GetTips("BASE_PROPERTY_UP")

	for iter_3_0 = 1, 3 do
		self.attrList[iter_3_0]:SetActive(false)
	end

	for iter_3_1, iter_3_2 in pairs(arg_3_1.params) do
		self.attrList[iter_3_1]:RefreshUi(iter_3_2[1], iter_3_2[2], arg_3_2[iter_3_2[1]])
	end
end

function SurpassUpAttrNode:Dispose()
	for iter_4_0, iter_4_1 in pairs(self.attrList) do
		iter_4_1:Dispose()

		iter_4_1 = nil
	end

	SurpassUpAttrNode.super.Dispose(self)
end

return SurpassUpAttrNode
