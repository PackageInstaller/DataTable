local ChessBoardPropView = class("ChessBoardPropView", ReduxView)
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

function ChessBoardPropView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_PropertyPopUI"
end

function ChessBoardPropView:UIParent()
	return manager.ui.uiPop.transform
end

function ChessBoardPropView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardPropView:InitUI()
	self:BindCfgUI()

	self.controller_ = self.controllerexcollection_:GetController(var_0_1.name)
	self.propList = ChessBoardPropList.New(self.propListGo_)
	self.propItemClickHandle_ = handler(self, self.OnPropItemClick)

	self.propList:SetClickHandle(self.propItemClickHandle_)
end

function ChessBoardPropView:AddUIListener()
	self:AddBtnListener(self.fullscreenBtn_, nil, function()
		self:OnClickCancelBtn()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:OnClickCancelBtn()
	end)
	self:AddBtnListener(self.sureBtn_, nil, function()
		self:OnClickSureBtn()
	end)
	self:AddBtnListener(self.btniconlockBtn_, nil, function()
		self:OnClickLeftBtn()
	end)
	self:AddBtnListener(self.btniconaddBtn_, nil, function()
		self:OnClickRightBtn()
	end)
end

function ChessBoardPropView:OnClickLeftBtn()
	self:ChangeControllerState(var_0_2.change_check_prop)
end

function ChessBoardPropView:OnClickRightBtn()
	self:ChangeControllerState(var_0_2.change_select_prop)
	self.propList:ClickTargetProp(self.propList:GetSelectIndex() or 1)
end

function ChessBoardPropView:OnClickCancelBtn()
	if self.currentState == var_0_2.use then
		gameContext:Go("/chessBoardHomeView")
	elseif self.currentState == var_0_2.change_no_prop or self.currentState == var_0_2.change_have_prop then
		if self.giveUpPropCallback then
			ChessBoardTools.ChessBoardMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("CHESSBOARD_GIVEUP_CHANCE"), ChessBoardPropCfg[self.selectPropID].name),
				OkCallback = function()
					self.giveUpPropCallback()
				end
			})
		else
			gameContext:Go("/chessBoardHomeView")
		end
	elseif self.currentState == var_0_2.change_select_prop or self.currentState == var_0_2.change_check_prop then
		self.selectChangePropID = self.selectPropID

		self:ChangeControllerState(self.lastState)
	end
end

function ChessBoardPropView:OnClickSureBtn()
	if self.currentState == var_0_2.use then
		self:OnPropUse()
	elseif self.currentState == var_0_2.change_no_prop then
		ShowTips("CHESSBOARD_CHOOSE_PROP_TO_SWAP")
	elseif self.currentState == var_0_2.change_select_prop then
		self.changePropID = self.selectChangePropID

		self:ChangeControllerState(var_0_2.change_have_prop)

		self.selectChangePropID = nil
	elseif self.currentState == var_0_2.change_have_prop and self.changePropCallback then
		self.changePropCallback(self.changePropID)
	end
end

function ChessBoardPropView:OnPropUse()
	if self.selectPropID then
		if ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.GUN or ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.SWAP then
			if manager.ChessBoardManager.NPCManager_:GetNPCNum() > 0 then
				manager.ChessBoardManager:UseSelectNpcProp(self.selectPropID)
				gameContext:Go("/chessBoardHomeView")
				manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.USE_PROP)
			else
				ShowTips("CHESSBOARD_HAVE_NO_NPC")
			end
		elseif ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.SET_DICE_POINT then
			gameContext:Go("/chessBoardPropDiceView", {
				propID = self.selectPropID
			})
		elseif ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.NEW_MAP_THING then
			manager.ChessBoardManager:UseSelectNoThingGridProp(self.selectPropID)
			gameContext:Go("/chessBoardHomeView")
			manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.USE_PROP)
		elseif ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.DEFUSE_CARD then
			if manager.ChessBoardManager:CheckCanUseDefuseCard() then
				manager.ChessBoardManager:UseSelectThingProp(self.selectPropID)
				gameContext:Go("/chessBoardHomeView")
				manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.USE_PROP)
			else
				ShowTips("CHESSBOARD_PROP_CANT_USE")
			end
		elseif ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.SELECT_ADD_BUFF then
			manager.ChessBoardManager:UseSelectPlayerProp(self.selectPropID)
			gameContext:Go("/chessBoardHomeView")
			manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.USE_PROP)
		else
			ChessBoardAction.UseProp(self.selectPropID, {}, function()
				gameContext:Go("/chessBoardHomeView")
				manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
				manager.ChessBoardManager:PropEffect(self.selectPropID, {})
			end)
		end
	else
		ShowTips("CHESSBOARD_NO_CHOOSE_PROP")
	end
end

function ChessBoardPropView:OnPropItemClick(arg_18_1)
	if self.currentState == var_0_2.use then
		self.selectPropID = arg_18_1
	end

	if self.currentState == var_0_2.change_select_prop then
		self.selectChangePropID = arg_18_1
	end

	self:RefreshItemInfo()
	self:RefreshChangeInfo()
end

function ChessBoardPropView:OnEnter()
	self.selectPropID = self.params_.propID
	self.changePropID = nil
	self.selectChangePropID = nil
	self.viewType = self.params_.viewType
	self.changePropCallback = self.params_.changePropCallback or nil
	self.giveUpPropCallback = self.params_.giveUpPropCallback or nil

	self.propList:OnEnter()
	self:ChangeViewShow()
end

function ChessBoardPropView:ChangeViewShow()
	if self.viewType == ChessBoardConst.VIEW_TYPE.USE_PROP then
		self:ChangeControllerState(var_0_2.use)
		self.propList:ClickTargetProp(self.params_.index)
	elseif self.viewType == ChessBoardConst.VIEW_TYPE.CHANGE_PROP then
		self:ChangeControllerState(var_0_2.change_no_prop)
	end
end

function ChessBoardPropView:ChangeControllerState(arg_21_1)
	self.lastState = self.currentState
	self.currentState = arg_21_1

	if var_0_3[self.currentState] then
		self.controller_:SetSelectedState(var_0_3[self.currentState])
		self:RefreshItemInfo()
		self:RefreshChangeInfo()
	end
end

function ChessBoardPropView:RefreshItemInfo()
	local var_22_1 = ChessBoardPropCfg[self.selectChangePropID or self.selectPropID]

	if ChessBoardPropCfg[self.selectChangePropID or self.selectPropID] then
		self.iconImg_.sprite = ChessBoardTools.GetPropImage(var_22_1.icon)
		self.nameText_.text = var_22_1.name
		self.descText_.text = var_22_1.use_description
		self.tipsText_.text = var_22_1.prop_description
	end
end

function ChessBoardPropView:RefreshChangeInfo()
	if ChessBoardPropCfg[self.selectPropID] then
		self.iconleftImg_.sprite = ChessBoardTools.GetPropImage(ChessBoardPropCfg[self.selectPropID].icon)
	end

	if ChessBoardPropCfg[self.changePropID] then
		self.iconrightImg_.sprite = ChessBoardTools.GetPropImage(ChessBoardPropCfg[self.changePropID].icon)
	end
end

function ChessBoardPropView:Dispose()
	self.propList:Dispose()

	self.propList = nil

	self.super.Dispose(self)
end

return ChessBoardPropView
