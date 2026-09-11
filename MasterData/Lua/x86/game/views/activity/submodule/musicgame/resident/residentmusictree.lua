local ResidentMusicTree = class("ResidentMusicTree", ReduxView)

function ResidentMusicTree:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ResidentMusicTree:Init()
	self:InitUI()

	self.groupItemList = {}
end

function ResidentMusicTree:InitUI()
	self:BindCfgUI()
end

function ResidentMusicTree:GetPosY()
	return self.content_.anchoredPosition.y
end

function ResidentMusicTree:SetPos(arg_5_1)
	self.content_.anchoredPosition = Vector2.New(0, arg_5_1)
end

function ResidentMusicTree:SetData(arg_6_1)
	self:CreateTreeDataList(arg_6_1)
end

function ResidentMusicTree:CreateTreeDataList(arg_7_1)
	self.treeDataList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = MusicConst.MusicViewRoutesName[MusicData:GetMusicTypeByTheme(iter_7_1.theme)].activityID
		local var_7_1 = {}

		for iter_7_2, iter_7_3 in pairs(iter_7_1.musicActList) do
			table.insert(var_7_1, iter_7_3)
		end

		table.insert(self.treeDataList, {
			groupID = var_7_0,
			musicList = var_7_1
		})
	end

	self:RefreshTreeUI()
end

function ResidentMusicTree:RefreshTreeUI()
	for iter_8_0, iter_8_1 in ipairs(self.treeDataList) do
		self.groupItemList[iter_8_0] = self.groupItemList[iter_8_0] or self:CreateGroupItem()

		local var_8_0 = self.groupItemList[iter_8_0]

		self.groupItemList[iter_8_0]:Show(true)
		var_8_0:SetData(iter_8_1.groupID, iter_8_1.musicList)
	end

	for iter_8_2 = #self.treeDataList + 1, #self.groupItemList do
		self.groupItemList[iter_8_2]:Show(false)
	end
end

function ResidentMusicTree:CreateGroupItem()
	local var_9_0 = MusicGourpItem.New((Object.Instantiate(self.groupItem_, self.content_)))

	var_9_0:SetCreateMusicItemFunc(function(arg_10_0)
		return self:CreateMusicItem(arg_10_0)
	end)

	return var_9_0
end

function ResidentMusicTree:CreateMusicItem(arg_11_1)
	return MusicSelectItem.New((Object.Instantiate(self.selectItem_, arg_11_1)))
end

function ResidentMusicTree:GetTargetGroupItem(arg_12_1)
	for iter_12_0, iter_12_1 in pairs(self.groupItemList) do
		if iter_12_1:GetActivityID() == arg_12_1 then
			return iter_12_1
		end
	end

	return nil
end

function ResidentMusicTree:BindRed(arg_13_1)
	if self.groupItemList then
		for iter_13_0, iter_13_1 in pairs(self.groupItemList) do
			iter_13_1:BindRed(arg_13_1)
		end
	end
end

function ResidentMusicTree:FindScrollIndexMovePos(arg_14_1)
	for iter_14_0, iter_14_1 in pairs(self.groupItemList) do
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(iter_14_1.container_)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content_)

	local var_14_0 = false
	local var_14_1 = 0
	local var_14_2 = self:GetTargetItem(arg_14_1)

	if var_14_2 then
		var_14_0 = var_14_2.gameObject_.activeSelf
		var_14_1 = self.content_:InverseTransformPoint(var_14_2.transform_.position).y
	end

	return var_14_0, var_14_1
end

function ResidentMusicTree:ScrollToPos(arg_15_1)
	self.content_.anchoredPosition = Vector2.New(0, arg_15_1)
end

function ResidentMusicTree:GetTargetItem(arg_16_1)
	local var_16_0

	for iter_16_0, iter_16_1 in ipairs(self.groupItemList or {}) do
		local var_16_1 = iter_16_1:GetTargetMusicSelectItem(arg_16_1)

		if var_16_1 then
			var_16_0 = var_16_1

			break
		end
	end

	return var_16_0
end

function ResidentMusicTree:SelectTargetItem(arg_17_1)
	local var_17_0 = self:GetTargetItem(arg_17_1)

	if var_17_0 then
		var_17_0:OnClickBtn()
	end
end

function ResidentMusicTree:Dispose()
	for iter_18_0, iter_18_1 in pairs(self.groupItemList) do
		iter_18_1:Dispose()

		iter_18_1 = nil
	end

	self.groupItemList = {}

	ResidentMusicTree.super.Dispose(self)
end

return ResidentMusicTree
