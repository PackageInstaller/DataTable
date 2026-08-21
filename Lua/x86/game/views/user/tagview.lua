local var_0_0 = class("TagView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, TagViewPanel)
	arg_3_0.tagSpace_ = arg_3_0.tagPanelTemplate_:GetComponent("HorizontalLayoutGroup").spacing
	arg_3_0.width_ = arg_3_0.panel_.rect.width
	arg_3_0.tagTemplateItem_ = TagItem.New(arg_3_0.tagTemplate_)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RegisterClickFunction(function(arg_5_0)
		PlayerData:ClearTargetTagRed(arg_5_0)

		if arg_4_0.usingList_[arg_5_0] then
			arg_4_0.usingList_[arg_5_0] = nil
			arg_4_0.useTotal_ = arg_4_0.useTotal_ - 1

			arg_4_2:RefreshSelect(arg_4_0.usingList_)
		elseif arg_4_0.useTotal_ >= GameSetting.profile_label_max_num.value[1] then
			ShowTips("PROFILE_LABEL_MAX_NUM")

			return
		else
			arg_4_0.usingList_[arg_5_0] = true
			arg_4_0.useTotal_ = arg_4_0.useTotal_ + 1

			arg_4_2:RefreshSelect(arg_4_0.usingList_)
		end

		arg_4_0:RefreshText()

		if arg_4_0.callback_ then
			local var_5_0 = {}

			for iter_5_0, iter_5_1 in pairs(arg_4_0.usingList_) do
				table.insert(var_5_0, iter_5_0)
			end

			table.sort(var_5_0, function(arg_6_0, arg_6_1)
				local var_6_0 = ProfileLabelCfg[arg_6_0]
				local var_6_1 = ProfileLabelCfg[arg_6_1]

				if var_6_0.type ~= var_6_1.type then
					return var_6_0.type > var_6_1.type
				end

				local var_6_2 = PlayerData:GetTagInfo(arg_6_0)
				local var_6_3 = PlayerData:GetTagInfo(arg_6_1)

				if var_6_2.obtain_time ~= var_6_3.obtain_time then
					return var_6_2.obtain_time < var_6_3.obtain_time
				end

				return arg_6_0 < arg_6_1
			end)
			arg_4_0.callback_(var_5_0)
		end
	end)
	arg_4_2:RefreshData(arg_4_0.panelList_[arg_4_1])
	arg_4_2:RefreshSelect(arg_4_0.usingList_)
end

function var_0_0.AddUIListeners(arg_7_0)
	return
end

function var_0_0.OnEnter(arg_8_0)
	return
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshData()
	arg_9_0:RefreshList()
	arg_9_0:RefreshText()
end

function var_0_0.RefreshData(arg_10_0)
	arg_10_0.usingList_ = {}
	arg_10_0.list_ = PlayerData:GetUnlockTagListInfo()

	local var_10_0 = PlayerData:GetUsingTagListInfo()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		arg_10_0.usingList_[iter_10_1] = true
	end

	arg_10_0.useTotal_ = #var_10_0
end

function var_0_0.RefreshList(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = 1

	arg_11_0.panelList_ = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.list_) do
		arg_11_0.panelList_[var_11_1] = arg_11_0.panelList_[var_11_1] or {}

		arg_11_0.tagTemplateItem_:SetData(iter_11_1)

		local var_11_2 = arg_11_0.tagTemplateItem_.transform_.rect.width

		if var_11_0 == 0 then
			var_11_0 = var_11_2
		else
			var_11_0 = var_11_0 + var_11_2 + arg_11_0.tagSpace_
		end

		local var_11_3 = iter_11_1.id

		if var_11_0 < arg_11_0.width_ then
			table.insert(arg_11_0.panelList_[var_11_1], iter_11_1)
		else
			var_11_1 = var_11_1 + 1
			arg_11_0.panelList_[var_11_1] = arg_11_0.panelList_[var_11_1] or {}

			table.insert(arg_11_0.panelList_[var_11_1], iter_11_1)

			var_11_0 = var_11_2
		end
	end

	arg_11_0.scrollHelper_:StartScroll(#arg_11_0.panelList_)
end

function var_0_0.RefreshText(arg_12_0)
	arg_12_0.num_.text = string.format(GetTips("PROFILE_LABEL_SELECTIONAL_RESTRICTION"), arg_12_0.useTotal_, GameSetting.profile_label_max_num.value[1])
end

function var_0_0.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

function var_0_0.RegisterClickFunction(arg_14_0, arg_14_1)
	arg_14_0.callback_ = arg_14_1
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0.tagTemplateItem_:OnExit()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.scrollHelper_:GetItemList()) do
		iter_15_1:OnExit()
	end
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:RemoveAllEventListener()
	arg_16_0.tagTemplateItem_:Dispose()

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.scrollHelper_:GetItemList()) do
		iter_16_1:Dispose()
	end

	arg_16_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
