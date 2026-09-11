local KagutsuchiSpecialWinBarItem = class("KagutsuchiSpecialWinBarItem")
local WindowCurrencyItem = import("manager.windowBar.WindowCurrencyItem")
local WindowMaterialItem = import("manager.windowBar.WindowMaterialItem")
local WindowActivityMatrixCoinItem = import("manager.windowBar.WindowActivityMatrixCoinItem")

function KagutsuchiSpecialWinBarItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	KagutsuchiSpecialWinBarItem.gameObject_ = arg_1_2
	KagutsuchiSpecialWinBarItem.transform_ = arg_1_2.transform

	self:Init(arg_1_3)
	self:AddListeners(arg_1_1)
end

KagutsuchiSpecialWinBarItem.RegistEventListener = BaseView.RegistEventListener
KagutsuchiSpecialWinBarItem.RemoveAllEventListener = BaseView.RemoveAllEventListener

function KagutsuchiSpecialWinBarItem:TryInitDisplayTokenItem()
	self.materialItemCount = 0

	for iter_2_0 = 1, 4 do
		if isNil((nullable(self, "token" .. iter_2_0 .. "_"))) then
			break
		else
			self.materialItemCount = iter_2_0
		end
	end
end

function KagutsuchiSpecialWinBarItem:AddListeners(arg_3_1)
	if self.homeBtn_ then
		arg_3_1:AddBtnListener(self.homeBtn_, nil, function()
			OperationRecorder.Record(gameContext:GetLastOpenPage(), "homeBtn")

			if self.homeFunc_ then
				self.homeFunc_()
			else
				DestroyLua()
				LuaExchangeHelper.GoToMain()
				OpenPageUntilLoaded("/home")
			end
		end)
	end

	if self.backBtn_ then
		arg_3_1:AddBtnListener(self.backBtn_, nil, function()
			OperationRecorder.Record(gameContext:GetLastOpenPage(), "backBtn")

			if self.backFunc_ then
				self.backFunc_()
			else
				JumpTools.Back()
			end
		end)
	end

	if self.infoBtn_ then
		arg_3_1:AddBtnListener(self.infoBtn_, nil, function()
			OperationRecorder.Record(gameContext:GetLastOpenPage(), "infoBtn")

			if self.infoFunc_ then
				self.infoFunc_()
			elseif type(self.gameHelpKey) == "table" then
				if self.gameHelpKey.type == "jump" then
					JumpTools.OpenPageByJump(self.gameHelpKey.view, self.gameHelpKey.params)
				end
			else
				local var_6_0 = {
					icon = "icon_i",
					iconColor = Color(1, 1, 1),
					title = GetTips("STAGE_DESCRIPE")
				}

				var_6_0.content = GetTips(self.gameHelpKey)
				var_6_0.key = self.gameHelpKey

				JumpTools.OpenPageByJump("gameHelp", var_6_0)
			end
		end)
	end
end

function KagutsuchiSpecialWinBarItem:RegistHomeCallBack(arg_7_1)
	self.homeFunc_ = arg_7_1
end

function KagutsuchiSpecialWinBarItem:RegistBackCallBack(arg_8_1)
	self.backFunc_ = arg_8_1
end

function KagutsuchiSpecialWinBarItem:RegistInfoCallBack(arg_9_1)
	self.infoFunc_ = arg_9_1
end

function KagutsuchiSpecialWinBarItem:SetGameHelpKey(arg_10_1)
	self.gameHelpKey = arg_10_1
end

local function var_0_4(arg_11_0, arg_11_1)
	local var_11_0 = 0

	if arg_11_1 == nil then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if bar == BACK_BAR or bar == HOME_BAR or bar == INFO_BAR then
			-- block empty
		elseif nullable(ItemCfg, iter_11_1, "type") == ItemConst.ITEM_TYPE.CURRENCY and var_11_0 < arg_11_0.materialItemCount then
			var_11_0 = var_11_0 + 1

			local var_11_2 = WindowCurrencyItem.New(nullable(arg_11_0, "token" .. var_11_0 .. "_"), iter_11_1)

			arg_11_0.barGo["token" .. var_11_0 .. "_"]:SetActive(true)
			var_11_2:SetCanAdd(false)
			var_11_2:SetCanClick(true)

			arg_11_0.barGo["token" .. var_11_0 .. "_"] = var_11_2
		end
	end

	for iter_11_2 = var_11_0 + 1, arg_11_0.materialItemCount do
		SetActive(arg_11_0["token" .. iter_11_2 .. "_"], false)
	end
end

function KagutsuchiSpecialWinBarItem:Init(arg_12_1)
	BaseView.BindCfgUI(self)
	self:TryInitDisplayTokenItem()

	self.barGo = {}

	var_0_4(self, arg_12_1)
end

function KagutsuchiSpecialWinBarItem:Dispose()
	for iter_13_0, iter_13_1 in pairs(self.barGo) do
		iter_13_1:Dispose()
	end
end

return KagutsuchiSpecialWinBarItem
