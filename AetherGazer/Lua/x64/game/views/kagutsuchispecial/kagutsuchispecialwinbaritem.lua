local var_0_0 = class("KagutsuchiSpecialWinBarItem")
local var_0_1 = import("manager.windowBar.WindowCurrencyItem")
local var_0_2 = import("manager.windowBar.WindowMaterialItem")
local var_0_3 = import("manager.windowBar.WindowActivityMatrixCoinItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.gameObject_ = arg_1_2
	var_0_0.transform_ = arg_1_2.transform

	arg_1_0:Init(arg_1_3)
	arg_1_0:AddListeners(arg_1_1)
end

var_0_0.RegistEventListener = BaseView.RegistEventListener
var_0_0.RemoveAllEventListener = BaseView.RemoveAllEventListener

function var_0_0.TryInitDisplayTokenItem(arg_2_0)
	arg_2_0.materialItemCount = 0

	for iter_2_0 = 1, 4 do
		local var_2_0 = nullable(arg_2_0, "token" .. iter_2_0 .. "_")

		if isNil(var_2_0) then
			break
		else
			arg_2_0.materialItemCount = iter_2_0
		end
	end
end

function var_0_0.AddListeners(arg_3_0, arg_3_1)
	if arg_3_0.homeBtn_ then
		arg_3_1:AddBtnListener(arg_3_0.homeBtn_, nil, function()
			OperationRecorder.Record(gameContext:GetLastOpenPage(), "homeBtn")

			if arg_3_0.homeFunc_ then
				arg_3_0.homeFunc_()
			else
				DestroyLua()
				LuaExchangeHelper.GoToMain()
				OpenPageUntilLoaded("/home")
			end
		end)
	end

	if arg_3_0.backBtn_ then
		arg_3_1:AddBtnListener(arg_3_0.backBtn_, nil, function()
			OperationRecorder.Record(gameContext:GetLastOpenPage(), "backBtn")

			if arg_3_0.backFunc_ then
				arg_3_0.backFunc_()
			else
				JumpTools.Back()
			end
		end)
	end

	if arg_3_0.infoBtn_ then
		arg_3_1:AddBtnListener(arg_3_0.infoBtn_, nil, function()
			OperationRecorder.Record(gameContext:GetLastOpenPage(), "infoBtn")

			if arg_3_0.infoFunc_ then
				arg_3_0.infoFunc_()
			elseif type(arg_3_0.gameHelpKey) == "table" then
				if arg_3_0.gameHelpKey.type == "jump" then
					local var_6_0 = arg_3_0.gameHelpKey.view
					local var_6_1 = arg_3_0.gameHelpKey.params

					JumpTools.OpenPageByJump(var_6_0, var_6_1)
				end
			else
				local var_6_2 = GetTips(arg_3_0.gameHelpKey)

				JumpTools.OpenPageByJump("gameHelp", {
					icon = "icon_i",
					iconColor = Color(1, 1, 1),
					title = GetTips("STAGE_DESCRIPE"),
					content = var_6_2,
					key = arg_3_0.gameHelpKey
				})
			end
		end)
	end
end

function var_0_0.RegistHomeCallBack(arg_7_0, arg_7_1)
	arg_7_0.homeFunc_ = arg_7_1
end

function var_0_0.RegistBackCallBack(arg_8_0, arg_8_1)
	arg_8_0.backFunc_ = arg_8_1
end

function var_0_0.RegistInfoCallBack(arg_9_0, arg_9_1)
	arg_9_0.infoFunc_ = arg_9_1
end

function var_0_0.SetGameHelpKey(arg_10_0, arg_10_1)
	arg_10_0.gameHelpKey = arg_10_1
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

			local var_11_1 = "token" .. var_11_0 .. "_"
			local var_11_2 = arg_11_0.barGo[var_11_1]
			local var_11_3 = nullable(arg_11_0, var_11_1)
			local var_11_4 = var_0_1.New(var_11_3, iter_11_1)

			var_11_4:SetActive(true)
			var_11_4:SetCanAdd(false)
			var_11_4:SetCanClick(true)

			arg_11_0.barGo[var_11_1] = var_11_4
		end
	end

	for iter_11_2 = var_11_0 + 1, arg_11_0.materialItemCount do
		SetActive(arg_11_0["token" .. iter_11_2 .. "_"], false)
	end
end

function var_0_0.Init(arg_12_0, arg_12_1)
	BaseView.BindCfgUI(arg_12_0)
	arg_12_0:TryInitDisplayTokenItem()

	arg_12_0.barGo = {}

	var_0_4(arg_12_0, arg_12_1)
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.barGo) do
		iter_13_1:Dispose()
	end
end

return var_0_0
