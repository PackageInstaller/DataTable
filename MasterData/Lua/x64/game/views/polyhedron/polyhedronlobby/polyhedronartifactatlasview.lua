local PolyhedronArtifactAtlasView = class("PolyhedronArtifactAtlasView", ReduxView)

function PolyhedronArtifactAtlasView:UIName()
	return "Widget/System/Polyhedron/PolyhedronAtlasUI"
end

function PolyhedronArtifactAtlasView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronArtifactAtlasView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronArtifactAtlasView:InitUI()
	self:BindCfgUI()

	self.tree_ = LuaTree.New(self.uitreeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect), handler(self, self.OnItemSelect))

	self.itemList_ = {}

	self:InitTree()
end

function PolyhedronArtifactAtlasView:InitTree()
	local var_5_0 = UITreeData.New()
	local var_5_1 = UITreeGroupData.New()

	var_5_1.id = 1
	var_5_1.text = GetTips("POLYHEDRON_ARTIFACT_TITLE_1")

	for iter_5_0, iter_5_1 in pairs(PolyhedronArtifactCfg.get_id_list_by_exclusive_hero_id) do
		if iter_5_0 ~= 0 and table.indexof(PolyhedronData:GetHeroIDList(), iter_5_0) then
			local var_5_2 = UITreeItemData.New()

			var_5_2.id = iter_5_0
			var_5_2.text = GetI18NText(HeroCfg[iter_5_0].name)
			var_5_2.extraData = "exclusive"

			var_5_1.itemDatas:Add(var_5_2)
		end
	end

	local var_5_3 = UITreeGroupData.New()

	var_5_3.id = 2
	var_5_3.text = GetTips("POLYHEDRON_ARTIFACT_TITLE_2")

	local var_5_4 = {}

	for iter_5_2, iter_5_3 in pairs(PolyhedronArtifactCfg.get_id_list_by_sub_type) do
		var_5_4[#var_5_4 + 1] = iter_5_2
	end

	table.sort(var_5_4, function(arg_6_0, arg_6_1)
		return arg_6_0 < arg_6_1
	end)

	for iter_5_4, iter_5_5 in pairs(var_5_4) do
		if iter_5_5 ~= 3007 then
			local var_5_5 = UITreeItemData.New()

			var_5_5.id = iter_5_5
			var_5_5.text = PolyhedronTools.GetPolyhedronArtifactSubTypeDes(iter_5_5)
			var_5_5.extraData = "common"

			var_5_3.itemDatas:Add(var_5_5)
		end
	end

	var_5_0.groupDatas:Add(var_5_1)
	var_5_0.groupDatas:Add(var_5_3)
	self.tree_:SetData(var_5_0)
end

function PolyhedronArtifactAtlasView:OnGroupSelect(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return
end

function PolyhedronArtifactAtlasView:OnItemSelect(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self.array = arg_8_4 == "exclusive" and PolyhedronArtifactCfg.get_id_list_by_exclusive_hero_id[arg_8_2] or arg_8_4 == "common" and PolyhedronArtifactCfg.get_id_list_by_sub_type[arg_8_2] or {}

	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(self.array) do
		if PolyhedronData:GetArtifaceAtlasState(iter_8_1) == 2 then
			var_8_0 = var_8_0 + 1
		end
	end

	for iter_8_2 = 1, #self.array do
		self.itemList_[iter_8_2] = self.itemList_[iter_8_2] or PolyhedronArtifactAtlasIItem.New(self.itemTemplate_, self.contentTrans_)

		self.itemList_[iter_8_2]:SetData(self.array[iter_8_2])
	end

	for iter_8_3 = #self.array + 1, #self.itemList_ do
		self.itemList_[iter_8_3]:SetActive(false)
	end

	self.contentTrans_:SetAnchoredPositionY(0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

	self.m_processLab.text = var_8_0 .. "/" .. #self.array
end

function PolyhedronArtifactAtlasView:AddUIListener()
	return
end

function PolyhedronArtifactAtlasView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function PolyhedronArtifactAtlasView:OnEnter()
	self.tree_:SelectGroup(1)
end

function PolyhedronArtifactAtlasView:OnExit()
	manager.windowBar:HideBar()
end

function PolyhedronArtifactAtlasView:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(self.array[arg_13_1])
end

function PolyhedronArtifactAtlasView:Dispose()
	self.tree_:Dispose()

	for iter_14_0, iter_14_1 in ipairs(self.itemList_) do
		iter_14_1:Dispose()
	end

	self.itemList_ = nil

	PolyhedronArtifactAtlasView.super.Dispose(self)
end

return PolyhedronArtifactAtlasView
