local polyhedronDifficultyGroupItem = class("polyhedronDifficultyGroupItem", ReduxView)

function polyhedronDifficultyGroupItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.id = arg_1_2

	self:Init()
end

function polyhedronDifficultyGroupItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function polyhedronDifficultyGroupItem:InitUI()
	self:BindCfgUI()

	self.itemList = {}

	for iter_3_0, iter_3_1 in ipairs(PolyhedronDifficultyCfg[self.id].params) do
		local var_3_0 = Object.Instantiate(self.m_item, self.m_content)

		SetActive(var_3_0, true)
		table.insert(self.itemList, PolyhedronDifficultyItem.New(var_3_0, iter_3_1))
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content)

	self.transform_.sizeDelta = Vector2.New(self.transform_.rect.width, self.m_content.rect.height + 50)
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.m_lvLab.text = self.id
end

function polyhedronDifficultyGroupItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.id)
		end
	end)
end

function polyhedronDifficultyGroupItem:SetData(arg_6_1, arg_6_2)
	if arg_6_1 < PolyhedronDifficultyCfg[self.id].unlock_difficulty then
		self.stateController:SetSelectedIndex(1)
	elseif arg_6_2 >= self.id then
		self.stateController:SetSelectedIndex(2)
	else
		self.stateController:SetSelectedIndex(0)
	end
end

function polyhedronDifficultyGroupItem:RegistCallBack(arg_7_1)
	self.clickFunc = arg_7_1
end

function polyhedronDifficultyGroupItem:Dispose()
	for iter_8_0, iter_8_1 in ipairs(self.itemList) do
		iter_8_1:Dispose()
	end

	self.itemList = {}

	polyhedronDifficultyGroupItem.super.Dispose(self)
end

return polyhedronDifficultyGroupItem
