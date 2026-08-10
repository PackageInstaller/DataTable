local var_0_0 = class("CustomStickerFilterPanel", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.contentItemMap_ = {}
	arg_3_0.bottomItemMap_ = {}
	arg_3_0.filterCallBack_ = nil
	arg_3_0.allFilterList_ = {}
	arg_3_0.tmpSelectMap_ = {}
	arg_3_0.curSelectMap_ = {}
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.okBtn_, nil, function()
		local var_5_0 = true

		arg_4_0.curSelectMap_ = {}

		for iter_5_0, iter_5_1 in pairs(arg_4_0.tmpSelectMap_) do
			arg_4_0.curSelectMap_[iter_5_0] = iter_5_1
			var_5_0 = false
		end

		if arg_4_0.filterCallBack_ then
			arg_4_0.filterCallBack_(arg_4_0.curSelectMap_, var_5_0)
		end

		arg_4_0:ClosePanel()
	end)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, function()
		for iter_6_0, iter_6_1 in pairs(arg_4_0.tmpSelectMap_) do
			if arg_4_0.contentItemMap_[iter_6_0] then
				arg_4_0.contentItemMap_[iter_6_0]:Select(false)
			end

			if arg_4_0.bottomItemMap_[iter_6_0] then
				SetActive(arg_4_0.bottomItemMap_[iter_6_0], false)
			end
		end

		arg_4_0.tmpSelectMap_ = {}

		arg_4_0:ClosePanel()
	end)
	arg_4_0:AddBtnListener(arg_4_0.clearAllBtn_, nil, function()
		for iter_7_0, iter_7_1 in pairs(arg_4_0.tmpSelectMap_) do
			if arg_4_0.contentItemMap_[iter_7_0] then
				arg_4_0.contentItemMap_[iter_7_0]:Select(false)
			end

			if arg_4_0.bottomItemMap_[iter_7_0] then
				SetActive(arg_4_0.bottomItemMap_[iter_7_0], false)
			end
		end

		arg_4_0.tmpSelectMap_ = {}

		arg_4_0:UpdateBottomRootGoActive()
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.filterCallBack_ = arg_8_2
	arg_8_0.allFilterList_ = arg_8_1
	arg_8_0.tmpSelectMap_ = {}
	arg_8_0.curSelectMap_ = {}

	arg_8_0:UpdateBottomRootGoActive()

	for iter_8_0 = 1, #arg_8_0.allFilterList_ do
		local var_8_0 = arg_8_0.allFilterList_[iter_8_0]

		if not arg_8_0.bottomItemMap_[var_8_0] then
			local var_8_1 = Object.Instantiate(arg_8_0.bottomTmpGo_, arg_8_0.bottomTrs_)

			arg_8_0.bottomItemMap_[var_8_0] = var_8_1
		end

		arg_8_0.bottomItemMap_[var_8_0].transform:Find("name"):GetComponent("Text").text = GetI18NText(StickerSuitCfg[var_8_0].name)

		SetActive(arg_8_0.bottomItemMap_[var_8_0], false)

		if not arg_8_0.contentItemMap_[var_8_0] then
			local var_8_2 = Object.Instantiate(arg_8_0.contentTmpGo_, arg_8_0.contentTrs_)

			SetActive(var_8_2, true)

			arg_8_0.contentItemMap_[var_8_0] = CustomStickerFilterSuitItem.New(var_8_2)
		end

		arg_8_0.contentItemMap_[var_8_0]:SetData(var_8_0, function()
			if arg_8_0.tmpSelectMap_[var_8_0] then
				arg_8_0.tmpSelectMap_[var_8_0] = nil

				arg_8_0.contentItemMap_[var_8_0]:Select(false)
				SetActive(arg_8_0.bottomItemMap_[var_8_0], false)
			else
				arg_8_0.tmpSelectMap_[var_8_0] = true

				arg_8_0.contentItemMap_[var_8_0]:Select(true)
				SetActive(arg_8_0.bottomItemMap_[var_8_0], true)
			end

			arg_8_0:UpdateBottomRootGoActive()
		end)
		arg_8_0.contentItemMap_[var_8_0]:Select(false)
	end
end

function var_0_0.OpenPanel(arg_10_0)
	arg_10_0.tmpSelectMap_ = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.curSelectMap_) do
		arg_10_0.tmpSelectMap_[iter_10_0] = iter_10_1

		if arg_10_0.contentItemMap_[iter_10_0] then
			arg_10_0.contentItemMap_[iter_10_0]:Select(true)
		end

		if arg_10_0.bottomItemMap_[iter_10_0] then
			SetActive(arg_10_0.bottomItemMap_[iter_10_0], true)
		end
	end

	arg_10_0:UpdateBottomRootGoActive()
	SetActive(arg_10_0.gameObject_, true)
	manager.windowBar:HideBar()
end

function var_0_0.ClosePanel(arg_11_0)
	SetActive(arg_11_0.gameObject_, false)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.UpdateBottomRootGoActive(arg_12_0)
	local var_12_0 = false

	for iter_12_0, iter_12_1 in pairs(arg_12_0.tmpSelectMap_) do
		var_12_0 = true
	end

	SetActive(arg_12_0.bottomRootGo_, var_12_0)
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)

	for iter_13_0, iter_13_1 in pairs(arg_13_0.contentItemMap_) do
		iter_13_1:Dispose()
	end

	for iter_13_2, iter_13_3 in pairs(arg_13_0.bottomItemMap_) do
		Object.Destroy(iter_13_3)
	end
end

return var_0_0
