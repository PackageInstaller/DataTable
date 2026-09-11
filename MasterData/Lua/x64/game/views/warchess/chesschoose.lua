local WarChessChoose = class("WarChessChoose", ReduxView)

function WarChessChoose:UIName()
	return "Widget/System/WarChess_Battle/WarChessChoosePopUI"
end

function WarChessChoose:UIParent()
	return manager.ui.uiMain.transform
end

function WarChessChoose:Init()
	self.selectItem_ = 1
	self.itemList_ = {}

	self:InitUI()
	self:AddUIListener()
end

function WarChessChoose:InitUI()
	self:BindCfgUI()
end

function WarChessChoose:AddUIListener()
	self:AddBtnListener(self.btn_tickBtn_, nil, function()
		local var_6_0 = manager.ChessManager:GetExecutingChess()

		WarChessAction.GetTreasure({
			x = var_6_0.x,
			z = var_6_0.z
		}, self.state[self.selectItem_])
		OperationRecorder.Record("chess", "check_select_artifact")
	end)
end

function WarChessChoose:OnGetTreasure(arg_7_1, arg_7_2)
	if isSuccess(arg_7_1.result) then
		WarChessData:ModifyArtifactData(arg_7_2.param, 1)
		self:Back()
		manager.ChessManager:DoNextEvent()
	else
		manager.ChessManager:EventsEnd()
		ShowTips(arg_7_1.result)
	end
end

function WarChessChoose:OnEnter()
	self.state = self.params_.state

	SetActive(self.btn_tickBtn_.gameObject, false)
	self:RefreshUI()
end

function WarChessChoose:RefreshUI()
	self.selectItem_ = 1

	for iter_9_0 = 1, 3 do
		self.itemList_[iter_9_0] = self.itemList_[iter_9_0] or ChessChooseItem.New(self.battleflagitemGo_)

		self.itemList_[iter_9_0]:RefreshUI(iter_9_0, self.state[iter_9_0])
		self.itemList_[iter_9_0]:RegisterListener(function(arg_10_0, arg_10_1)
			SetActive(self.btn_tickBtn_.gameObject, true)

			if arg_10_0 then
				self.selectItem_ = arg_10_1

				for iter_10_0 = 1, 3 do
					self.itemList_[iter_10_0]:SetSelectState(self.selectItem_ == iter_10_0)
				end
			end
		end)
		self.itemList_[iter_9_0].controller_:SetSelectedState(0)
	end
end

function WarChessChoose:OnExit()
	for iter_11_0, iter_11_1 in pairs(self.itemList_) do
		iter_11_1:ResetToggle()
	end
end

function WarChessChoose:Dispose()
	for iter_12_0 = 1, 3 do
		self.itemList_[iter_12_0]:Dispose()
	end

	WarChessChoose.super.Dispose(self)
end

return WarChessChoose
