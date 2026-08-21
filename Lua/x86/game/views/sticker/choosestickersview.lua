local var_0_0 = class("ChooseStickersView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/paster/ChooseStickersUI_New"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.icon_ = {
		arg_4_0.img_1,
		arg_4_0.img_2,
		arg_4_0.img_3
	}
	arg_4_0.sizeTgl_ = {
		arg_4_0.toggle_1,
		arg_4_0.toggle_2,
		arg_4_0.toggle_3
	}
	arg_4_0.sizeCon_ = {
		ControllerUtil.GetController(arg_4_0.rect_s, "state"),
		ControllerUtil.GetController(arg_4_0.rect_m, "state"),
		(ControllerUtil.GetController(arg_4_0.rect_l, "state"))
	}
	arg_4_0.lockCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "lock")
	arg_4_0.scrollList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, StickerChooseItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.allStickerList_[arg_5_1].id
	local var_5_1 = arg_5_0:IsUsed(var_5_0)

	arg_5_2:RefreshItem(var_5_0)
	arg_5_2:SetUsed(var_5_1)
	arg_5_2:SetSelected(var_5_0 == arg_5_0.curID_)
	arg_5_2:RegisterClickListener(function()
		arg_5_0:SetCurID(arg_5_2.itemID_)
		arg_5_0:RefreshList()
	end)
end

function var_0_0.AddUIListeners(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.sizeTgl_) do
		arg_7_0:AddBtnListener(iter_7_1, nil, function()
			arg_7_0.curSize_ = iter_7_0

			arg_7_0:RefreshIcon()
			arg_7_0:RefreshBtn()
			arg_7_0:RefreshSize()

			if arg_7_0.curID_ == arg_7_0.oldStickerID_ then
				manager.notify:CallUpdateFunc(CHANGE_STICKER_SIZE, arg_7_0.curIndex_, arg_7_0.curID_, arg_7_0.curSize_)
				arg_7_0:Back()
			end
		end)
	end

	arg_7_0:AddBtnListener(arg_7_0.useBtn_, nil, function()
		if arg_7_0.curID_ == arg_7_0.oldStickerID_ and arg_7_0.curSize_ == arg_7_0.info_.size then
			arg_7_0.curID_ = 0
		end

		manager.notify:CallUpdateFunc(CHANGE_STICKER, arg_7_0.curIndex_, arg_7_0.curID_, arg_7_0.curSize_)
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.allStickerList_ = {}
	arg_11_0.info_ = arg_11_0.params_.info
	arg_11_0.curSize_ = arg_11_0.info_.size
	arg_11_0.curList_ = arg_11_0:GetCurList()
	arg_11_0.viewID_ = arg_11_0.params_.viewID
	arg_11_0.curIndex_ = arg_11_0.params_.site
	arg_11_0.oldStickerID_ = arg_11_0.info_.stickerID
	arg_11_0.curID_ = arg_11_0.oldStickerID_

	arg_11_0:GetAllSticker()

	if arg_11_0.curID_ == 0 then
		arg_11_0.curID_ = arg_11_0.allStickerList_[1].id
	end

	arg_11_0:RefreshUI()
	arg_11_0.scrollList_:StartScroll(#arg_11_0.allStickerList_)
end

function var_0_0.GetCurList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.params_.list) do
		table.insert(var_12_0, iter_12_1.stickerID)
	end

	return var_12_0
end

function var_0_0.GetAllSticker(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(PlayerData:GetStickerList()) do
		local var_13_0 = ItemCfg[iter_13_1]
		local var_13_1 = PlayerData:GetSticker(iter_13_1)

		if var_13_0.sub_type ~= 1302 or var_13_1.unlock ~= 0 then
			table.insert(arg_13_0.allStickerList_, var_13_1)
		end
	end

	table.sort(arg_13_0.allStickerList_, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_13_0:IsUsed(arg_14_0.id)
		local var_14_1 = arg_13_0:IsUsed(arg_14_1.id)

		if var_14_0 and var_14_1 then
			return table.indexof(arg_13_0.curList_, arg_14_0.id) < table.indexof(arg_13_0.curList_, arg_14_1.id)
		elseif var_14_0 or var_14_1 then
			return var_14_0
		end

		if arg_14_0.unlock ~= arg_14_1.unlock then
			return arg_14_0.unlock > arg_14_1.unlock
		end

		return arg_14_0.id < arg_14_1.id
	end)
end

function var_0_0.IsUsed(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.curList_) do
		if arg_15_1 == iter_15_1 then
			return true
		end
	end

	return false
end

function var_0_0.RefreshUI(arg_16_0)
	arg_16_0:SetCurID(arg_16_0.curID_)
	arg_16_0:RefreshSize()
end

function var_0_0.SetCurID(arg_17_0, arg_17_1)
	arg_17_0.curID_ = arg_17_1

	local var_17_0 = PlayerData:GetSticker(arg_17_0.curID_)
	local var_17_1 = ItemCfg[arg_17_0.curID_]

	arg_17_0:RefreshIcon()
	arg_17_0:RefreshBtn()
	arg_17_0.lockCon_:SetSelectedState(var_17_0.unlock == 0 and "lock" or "default")

	arg_17_0.nameTxt_.text = ItemTools.getItemName(var_17_1.id)
	arg_17_0.descTxt_.text = ItemTools.getItemDesc(var_17_1.id)
	arg_17_0.wayTxt_.text = GetI18NText(var_17_1.desc_source) or ""
end

function var_0_0.RefreshBtn(arg_18_0)
	if arg_18_0.curID_ == arg_18_0.oldStickerID_ then
		arg_18_0.btnTxt_.text = GetTips("CHIP_UNLOAD")
	elseif arg_18_0:IsUsed(arg_18_0.curID_) then
		arg_18_0.btnTxt_.text = GetTips("TIP_CHANGE")
	else
		arg_18_0.btnTxt_.text = GetTips("TIP_DISPLAY")
	end
end

function var_0_0.RefreshIcon(arg_19_0)
	arg_19_0.icon_[arg_19_0.curSize_].sprite = ItemTools.getItemSprite(arg_19_0.curID_, {
		size = arg_19_0.curSize_
	})
end

function var_0_0.RefreshList(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.scrollList_:GetItemList()) do
		iter_20_1:SetSelected(iter_20_1.itemID_ == arg_20_0.curID_)
		iter_20_1:SetUsed(arg_20_0:IsUsed(iter_20_1.itemID_))
	end
end

function var_0_0.RefreshSize(arg_21_0)
	local var_21_0 = StickViewTemplateCfg[arg_21_0.viewID_].range_list[arg_21_0.curIndex_][2]

	for iter_21_0 = 1, 3 do
		if not table.indexof(var_21_0, iter_21_0) then
			arg_21_0.sizeCon_[iter_21_0]:SetSelectedState(2)
		elseif iter_21_0 == arg_21_0.curSize_ then
			arg_21_0.sizeCon_[iter_21_0]:SetSelectedState(3)
		else
			arg_21_0.sizeCon_[iter_21_0]:SetSelectedState(1)
		end
	end
end

function var_0_0.OnExit(arg_22_0)
	return
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()
	arg_23_0.scrollList_:Dispose()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
