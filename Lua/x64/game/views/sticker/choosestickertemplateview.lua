local var_0_0 = class("ChooseStickerTemplateView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/paster/StickerChooseTemplateUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateCon_ = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.scrollList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, StickerTemplateItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.list_[arg_5_1]

	arg_5_2:RefreshUI(var_5_0, arg_5_0.bgID_)

	if var_5_0 == arg_5_0.chooseID_ then
		arg_5_2:SetState("use")
	else
		arg_5_2:SetState("change")
	end

	arg_5_2:SetSelected(var_5_0 == arg_5_0.curID_)
	arg_5_2:RegistClickFunc(function()
		arg_5_0:SetTemplateID(var_5_0)
	end)
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.changeBtn_, nil, function()
		arg_7_0.params_.temp.info[arg_7_0.index_].viewID = arg_7_0.curID_

		arg_7_0:Back(1, {
			resetSize = true,
			type = 2,
			tempInfo = arg_7_0.params_.temp,
			index = arg_7_0.index_
		})
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.index_ = arg_9_0.params_.index
	arg_9_0.chooseID_ = arg_9_0.params_.chooseID
	arg_9_0.bgID_ = arg_9_0.params_.temp.stickerBg
	arg_9_0.list_ = StickViewTemplateCfg.all

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.bg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Sticker/stickerBtn/Sticker_big_" .. arg_10_0.bgID_)

	arg_10_0:Sortlist()
	arg_10_0:SetTemplateID(arg_10_0.chooseID_)
	arg_10_0.scrollList_:StartScroll(#arg_10_0.list_, table.indexof(arg_10_0.list_, arg_10_0.chooseID_))
end

function var_0_0.Sortlist(arg_11_0)
	table.sort(arg_11_0.list_, function(arg_12_0, arg_12_1)
		if arg_12_0 == arg_11_0.chooseID_ or arg_12_1 == arg_11_0.chooseID_ then
			return arg_12_0 == arg_11_0.chooseID_
		end

		return arg_12_0 < arg_12_1
	end)
end

function var_0_0.SetTemplateID(arg_13_0, arg_13_1)
	arg_13_0.curID_ = arg_13_1

	arg_13_0:RefreshInfo()
	arg_13_0.scrollList_:Refresh()
end

function var_0_0.RefreshInfo(arg_14_0)
	arg_14_0.show_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Sticker/stickerBtn/Sticker_template_" .. arg_14_0.curID_)

	if arg_14_0.curID_ == arg_14_0.chooseID_ then
		arg_14_0.stateCon_:SetSelectedState("use")
	else
		arg_14_0.stateCon_:SetSelectedState("change")
	end
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_15_0:Back(1, {
			type = 2,
			tempInfo = arg_15_0.params_.temp
		})
	end)
end

function var_0_0.OnExit(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:RemoveAllListeners()

	if arg_18_0.scrollList_ then
		arg_18_0.scrollList_:Dispose()

		arg_18_0.scrollList_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
