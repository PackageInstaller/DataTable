local ChessMenu = class("ChessMenu", ReduxView)

function ChessMenu:UIName()
	return "Widget/System/WarChess_Battle/WarChessMenu"
end

function ChessMenu:UIParent()
	return manager.ui.uiPop.transform
end

function ChessMenu:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessMenu:InitUI()
	self:BindCfgUI()
	self:BindCfgUI(self.summercontextTrs_)

	self.themeCon_ = ControllerUtil.GetController(self.transform_, "name")
end

function ChessMenu:AddUIListener()
	self:AddBtnListener(self.cancelbtnBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("CONFIRM_TO_QUIT_CHESS"),
			OkCallback = function()
				OnExitChessScene(true)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		OnExitChessScene(false)
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()

		if self.callback_ then
			self.callback_()
		end
	end)
end

function ChessMenu:OnEnter()
	self.callback_ = self.params_.callback

	if table.indexof(WarchessLevelCfg[manager.ChessManager.ChapterID].extra_gameplay, 3) then
		self.themeCon_:SetSelectedState("summer")
		self:RefreshSummerUI()
	else
		self.themeCon_:SetSelectedState("normal")
		self:RefreshUI()
	end
end

function ChessMenu:RefreshUI()
	local var_12_0 = manager.ChessManager.ChapterID
	local var_12_1 = WarChessData:GetBoxNum(manager.ChessManager.ChapterID, ChessConst.BOX.SMALL)
	local var_12_2 = WarChessData:GetBoxNum(manager.ChessManager.ChapterID, ChessConst.BOX.BIG)
	local var_12_3 = var_12_1 * WarchessLevelCfg[manager.ChessManager.ChapterID].sbox_progress
	local var_12_4 = var_12_2 * WarchessLevelCfg[manager.ChessManager.ChapterID].lbox_progress

	self.progressText_.text = (var_12_1 * WarchessLevelCfg[manager.ChessManager.ChapterID].sbox_progress + var_12_2 * WarchessLevelCfg[manager.ChessManager.ChapterID].lbox_progress > 100 and 100 or var_12_3 + var_12_4) .. "%"
	self.box1Text_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", var_12_1, WarchessLevelCfg[var_12_0].sbox_num)
	self.box2Text_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", var_12_2, WarchessLevelCfg[var_12_0].lbox_num)
	self.progressimgImg_.fillAmount = (var_12_3 + var_12_4) / 100
	self.progressmarkerTrs_.localPosition = Vector2(math.sin(WarchessLevelCfg[var_12_0].success_progress / 100 * 2 * math.pi), (math.cos(WarchessLevelCfg[var_12_0].success_progress / 100 * 2 * math.pi))) * (self.progressimgImg_.transform.rect.width / 2)
	self.chapternameText_.text = ChapterClientCfg[var_12_0] and GetI18NText(ChapterClientCfg[var_12_0].name) or GetI18NText(WarchessLevelCfg[var_12_0].name_level)
end

function ChessMenu:RefreshSummerUI()
	local var_13_0 = manager.ChessManager.ChapterID
	local var_13_1 = WarChessData:GetBoxNum(manager.ChessManager.ChapterID, ChessConst.BOX.SMALL)
	local var_13_2 = WarChessData:GetBoxNum(manager.ChessManager.ChapterID, ChessConst.BOX.BIG)
	local var_13_3 = WarChessData:GetItemData()[ChessConst.BOX.CLUE] or 0
	local var_13_4 = var_13_1 * WarchessLevelCfg[manager.ChessManager.ChapterID].sbox_progress
	local var_13_5 = var_13_2 * WarchessLevelCfg[manager.ChessManager.ChapterID].lbox_progress
	local var_13_6 = var_13_3 * (100 / WarchessLevelCfg[manager.ChessManager.ChapterID].clue_sum)

	self.progressleftText_.text = var_13_1 * WarchessLevelCfg[manager.ChessManager.ChapterID].sbox_progress + var_13_2 * WarchessLevelCfg[manager.ChessManager.ChapterID].lbox_progress > 100 and 100 or var_13_4 + var_13_5
	self.boxupText_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", var_13_1, WarchessLevelCfg[var_13_0].sbox_num)
	self.boxdownText_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", var_13_2, WarchessLevelCfg[var_13_0].lbox_num)
	self.progressrightText_.text = string.format("%d", var_13_6)
	self.clueText_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", var_13_3, WarchessLevelCfg[var_13_0].clue_sum)
	self.progressleftImg_.fillAmount = (var_13_4 + var_13_5) / 100
	self.progressrightImg_.fillAmount = var_13_6 / 100

	if ChapterClientCfg[var_13_0] then
		self.chaptername2Text_.text = ChapterClientCfg[var_13_0].name or WarchessLevelCfg[var_13_0].name_level
	end
end

function ChessMenu:OnExit()
	return
end

function ChessMenu:Dispose()
	ChessMenu.super.Dispose(self)
end

return ChessMenu
