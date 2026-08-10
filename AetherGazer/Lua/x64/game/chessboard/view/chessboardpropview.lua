local var_0_0 = class("ChessBoardPropView", ReduxView)
local var_0_1 = {
	change_check_prop = "change_check_prop",
	name = "btnState",
	change_have_prop = "change_have_prop",
	change_select_prop = "change_select_prop",
	empty = "empty",
	use_view = "use_view",
	change_no_prop = "change_no_prop"
}
local var_0_2 = {
	change_check_prop = 5,
	change_select_prop = 3,
	change_have_prop = 4,
	empty = 6,
	use = 1,
	change_no_prop = 2
}
local var_0_3 = {
	[var_0_2.use] = "use_view",
	[var_0_2.change_no_prop] = "change_no_prop",
	[var_0_2.change_select_prop] = "change_select_prop",
	[var_0_2.change_have_prop] = "change_have_prop",
	[var_0_2.change_check_prop] = "change_check_prop",
	[var_0_2.empty] = "empty"
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_PropertyPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.controller_ = arg_4_0.controllerexcollection_:GetController(var_0_1.name)
	arg_4_0.propList = ChessBoardPropList.New(arg_4_0.propListGo_)
	arg_4_0.propItemClickHandle_ = handler(arg_4_0, arg_4_0.OnPropItemClick)

	arg_4_0.propList:SetClickHandle(arg_4_0.propItemClickHandle_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.fullscreenBtn_, nil, function()
		arg_5_0:OnClickCancelBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:OnClickCancelBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.sureBtn_, nil, function()
		arg_5_0:OnClickSureBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btniconlockBtn_, nil, function()
		arg_5_0:OnClickLeftBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btniconaddBtn_, nil, function()
		arg_5_0:OnClickRightBtn()
	end)
end

function var_0_0.OnClickLeftBtn(arg_11_0)
	arg_11_0:ChangeControllerState(var_0_2.change_check_prop)
end

function var_0_0.OnClickRightBtn(arg_12_0)
	arg_12_0:ChangeControllerState(var_0_2.change_select_prop)

	local var_12_0 = arg_12_0.propList:GetSelectIndex()

	arg_12_0.propList:ClickTargetProp(var_12_0 or 1)
end

function var_0_0.OnClickCancelBtn(arg_13_0)
	if arg_13_0.currentState == var_0_2.use then
		gameContext:Go("/chessBoardHomeView")
	elseif arg_13_0.currentState == var_0_2.change_no_prop or arg_13_0.currentState == var_0_2.change_have_prop then
		if arg_13_0.giveUpPropCallback then
			ChessBoardTools.ChessBoardMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("CHESSBOARD_GIVEUP_CHANCE"), ChessBoardPropCfg[arg_13_0.selectPropID].name),
				OkCallback = function()
					arg_13_0.giveUpPropCallback()
				end
			})
		else
			gameContext:Go("/chessBoardHomeView")
		end
	elseif arg_13_0.currentState == var_0_2.change_select_prop or arg_13_0.currentState == var_0_2.change_check_prop then
		arg_13_0.selectChangePropID = arg_13_0.selectPropID

		arg_13_0:ChangeControllerState(arg_13_0.lastState)
	end
end

function var_0_0.OnClickSureBtn(arg_15_0)
	if arg_15_0.currentState == var_0_2.use then
		arg_15_0:OnPropUse()
	elseif arg_15_0.currentState == var_0_2.change_no_prop then
		ShowTips("CHESSBOARD_CHOOSE_PROP_TO_SWAP")
	elseif arg_15_0.currentState == var_0_2.change_select_prop then
		arg_15_0.changePropID = arg_15_0.selectChangePropID

		arg_15_0:ChangeControllerState(var_0_2.change_have_prop)

		arg_15_0.selectChangePropID = nil
	elseif arg_15_0.currentState == var_0_2.change_have_prop and arg_15_0.changePropCallback then
		arg_15_0.changePropCallback(arg_15_0.changePropID)
	end
end

function var_0_0.OnPropUse(arg_16_0)
	if arg_16_0.selectPropID then
		local var_16_0 = ChessBoardPropCfg[arg_16_0.selectPropID]

		if var_16_0.type == ChessBoardConst.PROPTYPE.GUN or var_16_0.type == ChessBoardConst.PROPTYPE.SWAP then
			if manager.ChessBoardManager.NPCManager_:GetNPCNum() > 0 then
				manager.ChessBoardManager:UseSelectNpcProp(arg_16_0.selectPropID)
				gameContext:Go("/chessBoardHomeView")
				manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.USE_PROP)
			else
				ShowTips("CHESSBOARD_HAVE_NO_NPC")
			end
		elseif var_16_0.type == ChessBoardConst.PROPTYPE.SET_DICE_POINT then
			gameContext:Go("/chessBoardPropDiceView", {
				propID = arg_16_0.selectPropID
			})
		elseif var_16_0.type == ChessBoardConst.PROPTYPE.NEW_MAP_THING then
			manager.ChessBoardManager:UseSelectNoThingGridProp(arg_16_0.selectPropID)
			gameContext:Go("/chessBoardHomeView")
			manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.USE_PROP)
		elseif var_16_0.type == ChessBoardConst.PROPTYPE.DEFUSE_CARD then
			if manager.ChessBoardManager:CheckCanUseDefuseCard() then
				manager.ChessBoardManager:UseSelectThingProp(arg_16_0.selectPropID)
				gameContext:Go("/chessBoardHomeView")
				manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.USE_PROP)
			else
				ShowTips("CHESSBOARD_PROP_CANT_USE")
			end
		elseif var_16_0.type == ChessBoardConst.PROPTYPE.SELECT_ADD_BUFF then
			manager.ChessBoardManager:UseSelectPlayerProp(arg_16_0.selectPropID)
			gameContext:Go("/chessBoardHomeView")
			manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.USE_PROP)
		else
			ChessBoardAction.UseProp(arg_16_0.selectPropID, {}, function()
				gameContext:Go("/chessBoardHomeView")
				manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
				manager.ChessBoardManager:PropEffect(arg_16_0.selectPropID, {})
			end)
		end
	else
		ShowTips("CHESSBOARD_NO_CHOOSE_PROP")
	end
end

function var_0_0.OnPropItemClick(arg_18_0, arg_18_1)
	if arg_18_0.currentState == var_0_2.use then
		arg_18_0.selectPropID = arg_18_1
	end

	if arg_18_0.currentState == var_0_2.change_select_prop then
		arg_18_0.selectChangePropID = arg_18_1
	end

	arg_18_0:RefreshItemInfo()
	arg_18_0:RefreshChangeInfo()
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0.selectPropID = arg_19_0.params_.propID
	arg_19_0.changePropID = nil
	arg_19_0.selectChangePropID = nil
	arg_19_0.viewType = arg_19_0.params_.viewType
	arg_19_0.changePropCallback = arg_19_0.params_.changePropCallback or nil
	arg_19_0.giveUpPropCallback = arg_19_0.params_.giveUpPropCallback or nil

	arg_19_0.propList:OnEnter()
	arg_19_0:ChangeViewShow()
end

function var_0_0.ChangeViewShow(arg_20_0)
	if arg_20_0.viewType == ChessBoardConst.VIEW_TYPE.USE_PROP then
		arg_20_0:ChangeControllerState(var_0_2.use)

		local var_20_0 = arg_20_0.params_.index

		arg_20_0.propList:ClickTargetProp(var_20_0)
	elseif arg_20_0.viewType == ChessBoardConst.VIEW_TYPE.CHANGE_PROP then
		arg_20_0:ChangeControllerState(var_0_2.change_no_prop)
	end
end

function var_0_0.ChangeControllerState(arg_21_0, arg_21_1)
	arg_21_0.lastState = arg_21_0.currentState
	arg_21_0.currentState = arg_21_1

	local var_21_0 = var_0_3[arg_21_0.currentState]

	if var_21_0 then
		arg_21_0.controller_:SetSelectedState(var_21_0)
		arg_21_0:RefreshItemInfo()
		arg_21_0:RefreshChangeInfo()
	end
end

function var_0_0.RefreshItemInfo(arg_22_0)
	local var_22_0 = arg_22_0.selectChangePropID or arg_22_0.selectPropID
	local var_22_1 = ChessBoardPropCfg[var_22_0]

	if var_22_1 then
		arg_22_0.iconImg_.sprite = ChessBoardTools.GetPropImage(var_22_1.icon)
		arg_22_0.nameText_.text = var_22_1.name
		arg_22_0.descText_.text = var_22_1.use_description
		arg_22_0.tipsText_.text = var_22_1.prop_description
	end
end

function var_0_0.RefreshChangeInfo(arg_23_0)
	local var_23_0 = ChessBoardPropCfg[arg_23_0.selectPropID]

	if var_23_0 then
		arg_23_0.iconleftImg_.sprite = ChessBoardTools.GetPropImage(var_23_0.icon)
	end

	local var_23_1 = ChessBoardPropCfg[arg_23_0.changePropID]

	if var_23_1 then
		arg_23_0.iconrightImg_.sprite = ChessBoardTools.GetPropImage(var_23_1.icon)
	end
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0.propList:Dispose()

	arg_24_0.propList = nil

	arg_24_0.super.Dispose(arg_24_0)
end

return var_0_0
