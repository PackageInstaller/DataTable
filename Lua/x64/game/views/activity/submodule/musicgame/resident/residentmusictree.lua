local var_0_0 = class("ResidentMusicTree", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.groupItemList = {}
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.GetPosY(arg_4_0)
	return arg_4_0.content_.anchoredPosition.y
end

function var_0_0.SetPos(arg_5_0, arg_5_1)
	arg_5_0.content_.anchoredPosition = Vector2.New(0, arg_5_1)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0:CreateTreeDataList(arg_6_1)
end

function var_0_0.CreateTreeDataList(arg_7_0, arg_7_1)
	arg_7_0.treeDataList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = MusicData:GetMusicTypeByTheme(iter_7_1.theme)
		local var_7_1 = MusicConst.MusicViewRoutesName[var_7_0].activityID
		local var_7_2 = {}

		for iter_7_2, iter_7_3 in pairs(iter_7_1.musicActList) do
			local var_7_3 = ActivityMusicCfg.get_id_list_by_activity_id[iter_7_3]

			table.insert(var_7_2, iter_7_3)
		end

		table.insert(arg_7_0.treeDataList, {
			groupID = var_7_1,
			musicList = var_7_2
		})
	end

	arg_7_0:RefreshTreeUI()
end

function var_0_0.RefreshTreeUI(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.treeDataList) do
		if not arg_8_0.groupItemList[iter_8_0] then
			arg_8_0.groupItemList[iter_8_0] = arg_8_0:CreateGroupItem()
		end

		local var_8_0 = arg_8_0.groupItemList[iter_8_0]

		var_8_0:Show(true)
		var_8_0:SetData(iter_8_1.groupID, iter_8_1.musicList)
	end

	for iter_8_2 = #arg_8_0.treeDataList + 1, #arg_8_0.groupItemList do
		arg_8_0.groupItemList[iter_8_2]:Show(false)
	end
end

function var_0_0.CreateGroupItem(arg_9_0)
	local var_9_0 = Object.Instantiate(arg_9_0.groupItem_, arg_9_0.content_)
	local var_9_1 = MusicGourpItem.New(var_9_0)

	var_9_1:SetCreateMusicItemFunc(function(arg_10_0)
		return arg_9_0:CreateMusicItem(arg_10_0)
	end)

	return var_9_1
end

function var_0_0.CreateMusicItem(arg_11_0, arg_11_1)
	local var_11_0 = Object.Instantiate(arg_11_0.selectItem_, arg_11_1)

	return MusicSelectItem.New(var_11_0)
end

function var_0_0.GetTargetGroupItem(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.groupItemList) do
		if iter_12_1:GetActivityID() == arg_12_1 then
			return iter_12_1
		end
	end

	return nil
end

function var_0_0.BindRed(arg_13_0, arg_13_1)
	if arg_13_0.groupItemList then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.groupItemList) do
			iter_13_1:BindRed(arg_13_1)
		end
	end
end

function var_0_0.FindScrollIndexMovePos(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.groupItemList) do
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(iter_14_1.container_)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.content_)

	local var_14_0 = false
	local var_14_1 = 0
	local var_14_2 = arg_14_0:GetTargetItem(arg_14_1)

	if var_14_2 then
		var_14_0 = var_14_2.gameObject_.activeSelf
		var_14_1 = arg_14_0.content_:InverseTransformPoint(var_14_2.transform_.position).y
	end

	return var_14_0, var_14_1
end

function var_0_0.ScrollToPos(arg_15_0, arg_15_1)
	arg_15_0.content_.anchoredPosition = Vector2.New(0, arg_15_1)
end

function var_0_0.GetTargetItem(arg_16_0, arg_16_1)
	local var_16_0

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.groupItemList or {}) do
		local var_16_1 = iter_16_1:GetTargetMusicSelectItem(arg_16_1)

		if var_16_1 then
			var_16_0 = var_16_1

			break
		end
	end

	return var_16_0
end

function var_0_0.SelectTargetItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:GetTargetItem(arg_17_1)

	if var_17_0 then
		var_17_0:OnClickBtn()
	end
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.groupItemList) do
		iter_18_1:Dispose()

		iter_18_1 = nil
	end

	arg_18_0.groupItemList = {}

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
