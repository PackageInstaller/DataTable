local var_0_0 = class("PolyhedronArtifactAtlasView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/PolyhedronAtlasUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tree_ = LuaTree.New(arg_4_0.uitreeGo_)

	arg_4_0.tree_:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnGroupSelect), handler(arg_4_0, arg_4_0.OnItemSelect))

	arg_4_0.itemList_ = {}

	arg_4_0:InitTree()
end

function var_0_0.InitTree(arg_5_0)
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
	arg_5_0.tree_:SetData(var_5_0)
end

function var_0_0.OnGroupSelect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return
end

function var_0_0.OnItemSelect(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4 == "exclusive" then
		arg_8_0.array = PolyhedronArtifactCfg.get_id_list_by_exclusive_hero_id[arg_8_2]
	elseif arg_8_4 == "common" then
		arg_8_0.array = PolyhedronArtifactCfg.get_id_list_by_sub_type[arg_8_2]
	else
		arg_8_0.array = {}
	end

	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.array) do
		if PolyhedronData:GetArtifaceAtlasState(iter_8_1) == 2 then
			var_8_0 = var_8_0 + 1
		end
	end

	local var_8_1 = #arg_8_0.array

	for iter_8_2 = 1, var_8_1 do
		if not arg_8_0.itemList_[iter_8_2] then
			arg_8_0.itemList_[iter_8_2] = PolyhedronArtifactAtlasIItem.New(arg_8_0.itemTemplate_, arg_8_0.contentTrans_)
		end

		arg_8_0.itemList_[iter_8_2]:SetData(arg_8_0.array[iter_8_2])
	end

	for iter_8_3 = var_8_1 + 1, #arg_8_0.itemList_ do
		arg_8_0.itemList_[iter_8_3]:SetActive(false)
	end

	arg_8_0.contentTrans_:SetAnchoredPositionY(0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.contentTrans_)

	arg_8_0.m_processLab.text = var_8_0 .. "/" .. var_8_1
end

function var_0_0.AddUIListener(arg_9_0)
	return
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.tree_:SelectGroup(1)
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.array[arg_13_1]

	arg_13_2:SetData(var_13_0)
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.tree_:Dispose()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.itemList_) do
		iter_14_1:Dispose()
	end

	arg_14_0.itemList_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
