local var_0_0 = import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")
local var_0_1 = class("SailShopEventView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesTransactionEventPopUI"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.itemList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiList_, SailShopItem)
end

function var_0_1.Dispose(arg_3_0)
	arg_3_0.itemList_:Dispose()

	arg_3_0.itemList_ = nil

	var_0_1.super.Dispose(arg_3_0)
end

function var_0_1.RefreshUI(arg_4_0)
	arg_4_0.shopDataList_ = SailGameData:GetCurGameData(arg_4_0.activityID_).eventList[arg_4_0.curStageIndex_].shopInfo

	arg_4_0.itemList_:StartScroll(#arg_4_0.shopDataList_)
	arg_4_0:RefreshTitle()
end

function var_0_1.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.activityID_, arg_5_0.shopDataList_[arg_5_1], arg_5_1)
end

function var_0_1.OnEventOperateSuccess(arg_6_0, arg_6_1)
	if arg_6_1 ~= SailGameConst.EVENT_COMMON_OPERATE.OVER then
		arg_6_0.shopDataList_ = SailGameData:GetCurGameData(arg_6_0.activityID_).eventList[arg_6_0.curStageIndex_].shopInfo

		arg_6_0.itemList_:StartScroll(#arg_6_0.shopDataList_)
	else
		SailGameAction.SetEventEndMark(arg_6_0.activityID_, SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS)
		SailGameTools.GoToGameView(arg_6_0.activityID_)
	end
end

return var_0_1
