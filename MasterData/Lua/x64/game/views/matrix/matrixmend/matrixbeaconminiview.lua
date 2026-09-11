local MatrixSelectBeaconItem = import("game.views.matrix.matrixPrepare.MatrixSelectBeaconItem")
local MatrixTreasureMiniView = class("MatrixTreasureMiniView", ReduxView)

function MatrixTreasureMiniView:UIBackCount()
	return 3
end

function MatrixTreasureMiniView:UIName()
	return "UI/Matrix/Prepare/MatrixBeaconMiniUI"
end

function MatrixTreasureMiniView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixTreasureMiniView:Init()
	self:InitUI()
end

function MatrixTreasureMiniView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexBeaconItem), self.m_list, MatrixSelectBeaconItem)
	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
end

function MatrixTreasureMiniView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function MatrixTreasureMiniView:OnEnter()
	self.beaconData = MatrixData:GetUseBeaconList()

	local var_8_0 = #self.beaconData

	self.list_:StartScroll(#self.beaconData)
	self.stateController_:SetSelectedIndex(var_8_0 == 0 and 1 or 0)
end

function MatrixTreasureMiniView:IndexBeaconItem(arg_9_1, arg_9_2)
	arg_9_2:Refresh(self.beaconData[arg_9_1])
end

function MatrixTreasureMiniView:Dispose()
	self.list_:Dispose()
	MatrixTreasureMiniView.super.Dispose(self)
end

return MatrixTreasureMiniView
