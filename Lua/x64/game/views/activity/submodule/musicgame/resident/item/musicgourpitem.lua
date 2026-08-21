local var_0_0 = class("MusicGourpItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.musicItemList = {}
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.toggleController_ = ControllerUtil.GetController(arg_3_0.titleNode_, "toggle")
	arg_3_0.openController_ = arg_3_0.controller_:GetController("open")
	arg_3_0.newController_ = arg_3_0.controller_:GetController("new")
	arg_3_0.isOpen = true
end

function var_0_0.SetCreateMusicItemFunc(arg_4_0, arg_4_1)
	arg_4_0.createMusicCallback = arg_4_1
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.openBtn_, nil, function()
		arg_5_0:ChangeOpenState()
	end)
end

function var_0_0.GetActivityID(arg_7_0)
	return arg_7_0.activityID
end

function var_0_0.GetMusicList(arg_8_0)
	return arg_8_0.musicList
end

function var_0_0.GetTargetMusicSelectItem(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.musicItemList) do
		if iter_9_1:GetMusicActivityID() == arg_9_1 then
			return iter_9_1
		end
	end
end

function var_0_0.SetData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.activityID = arg_10_1
	arg_10_0.musicList = arg_10_2

	arg_10_0:RefreshUI()
	arg_10_0:UpdateOpenStateUI()
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = ActivityCfg.get_id_list_by_sub_activity_list[arg_11_0.activityID][1]

	arg_11_0.nameText_.text = ActivityCfg[var_11_0].remark

	local var_11_1 = ActivityData:GetActivityIsOpen(var_11_0)

	arg_11_0.newController_:SetSelectedState(var_11_1 and "state1" or "state0")
end

function var_0_0.ChangeOpenState(arg_12_0)
	arg_12_0.isOpen = not arg_12_0.isOpen

	arg_12_0:UpdateOpenStateUI()
end

function var_0_0.UpdateOpenStateUI(arg_13_0)
	arg_13_0.toggleController_:SetSelectedState(arg_13_0.isOpen and "on" or "off")
	arg_13_0.openController_:SetSelectedState(arg_13_0.isOpen and "on" or "off")

	if arg_13_0.isOpen then
		arg_13_0:UpdateMusicList()
	end
end

function var_0_0.UpdateMusicList(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.musicList) do
		if not arg_14_0.musicItemList[iter_14_0] then
			arg_14_0.musicItemList[iter_14_0] = arg_14_0.createMusicCallback(arg_14_0.container_)
		end

		local var_14_0 = arg_14_0.musicItemList[iter_14_0]

		var_14_0:Show(true)
		var_14_0:SetData(arg_14_0.activityID, iter_14_1)
	end

	for iter_14_2 = #arg_14_0.musicList + 1, #arg_14_0.musicItemList do
		arg_14_0.musicItemList[iter_14_2]:Show(false)
	end
end

function var_0_0.Show(arg_15_0, arg_15_1)
	SetActive(arg_15_0.gameObject_, arg_15_1)
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.musicItemList) do
		iter_16_1:Dispose()

		iter_16_1 = nil
	end

	arg_16_0.musicItemList = {}

	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.BindRed(arg_17_0, arg_17_1)
	if arg_17_0.musicItemList then
		for iter_17_0, iter_17_1 in pairs(arg_17_0.musicItemList) do
			iter_17_1:BindRed(arg_17_1)
		end
	end
end

return var_0_0
