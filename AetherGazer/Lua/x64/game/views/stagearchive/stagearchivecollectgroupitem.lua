local var_0_0 = class("StageArchiveCollectGroupItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.archiveItemList_ = {}
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.groupID_ = arg_5_1
	arg_5_0.archiveIDList_ = arg_5_2

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0:RefreshArchiveItem()
	arg_6_0:RefreshTitle()
end

function var_0_0.RefreshArchiveItem(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.archiveIDList_) do
		if not arg_7_0.archiveItemList_[iter_7_0] then
			local var_7_0 = Object.Instantiate(arg_7_0.archiveItemGo_, arg_7_0.archivePanelTrans_)

			arg_7_0.archiveItemList_[iter_7_0] = StageArchiveCollectItem.New(var_7_0)
		end

		arg_7_0.archiveItemList_[iter_7_0]:SetActive(true)
		arg_7_0.archiveItemList_[iter_7_0]:SetData(iter_7_1)
	end

	for iter_7_2 = #arg_7_0.archiveIDList_ + 1, #arg_7_0.archiveItemList_ do
		arg_7_0.archiveItemList_[iter_7_2]:SetActive(false)
	end
end

function var_0_0.RefreshTitle(arg_8_0)
	arg_8_0.titleText_.text = StageArchivesCollectTagCfg[arg_8_0.groupID_].tag_name
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.archiveItemList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.archiveItemList_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
