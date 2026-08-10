local var_0_0 = class("OathHeroArchieveSubView", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.parent = nullable(arg_1_2, "parentView")

	arg_1_0:BindCfgUI()

	arg_1_0.items = {}
	arg_1_0.unlockController = arg_1_0.controllers_:GetController("unlock")
	arg_1_0.playStateController = arg_1_0.controllers_:GetController("isPlaying")

	function arg_1_0.onClickTabItemHandler(arg_2_0)
		local var_2_0 = arg_2_0.itemIndex
		local var_2_1 = arg_2_0.voiceID

		arg_1_0:SwitchTab(var_2_0, true)
	end

	arg_1_0:AddBtnListener(arg_1_0.playBtn_, nil, function()
		local var_3_0 = arg_1_0.curSelect
		local var_3_1 = arg_1_0.items[var_3_0]
		local var_3_2 = var_3_1.voiceID

		if var_3_1.lockState or var_3_2 == nil or arg_1_0:GetCurPlayingVoice() == var_3_2 then
			arg_1_0:StopVoice()
		else
			arg_1_0:PlayVoice(var_3_2)
		end
	end)
end

function var_0_0.OnEnter(arg_4_0)
	SetActive(arg_4_0.gameObject_, true)
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.curSelect = nil

	arg_5_0:StopVoice()
	SetActive(arg_5_0.gameObject_, false)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:RemoveAllListeners()

	if arg_6_0.items then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.items) do
			Object.Destroy(iter_6_1.gameObject_)
			iter_6_1:Dispose()
		end
	end

	arg_6_0.items = nil
end

local var_0_1 = class("OathArchieveTabItem", BaseView)

var_0_0.Item = var_0_1

function var_0_1.Ctor(arg_7_0, arg_7_1)
	arg_7_0.gameObject_ = arg_7_1
	arg_7_0.transform_ = arg_7_1.transform

	arg_7_0:Init()
end

function var_0_1.Init(arg_8_0)
	arg_8_0:BindCfgUI()

	arg_8_0.lockController = arg_8_0.linktabitemControllerEx_:GetController("lock")
	arg_8_0.selectController = arg_8_0.linktabitemControllerEx_:GetController("select")
	arg_8_0.bgController = arg_8_0.linktabitemControllerEx_:GetController("bg")

	arg_8_0:AddBtnListener(arg_8_0.selectBtn_, nil, function()
		if arg_8_0.onClick then
			arg_8_0:onClick()
		end
	end)
	arg_8_0:SetLockState(false)
	arg_8_0:SetSelectState(false)
end

function var_0_1.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_1.super.Dispose(arg_10_0)
end

function var_0_1.SetData(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.itemIndex = arg_11_2
	arg_11_0.onClick = arg_11_3
	arg_11_0.titleText_.text = GetTips(string.format("WEDDING_CONTENT_RECORD%d_TITLE", arg_11_2))
	arg_11_0.voiceID = nullable(WeddingCfg, arg_11_1, "wedding_record_voice" .. arg_11_2)
end

function var_0_1.SetLockState(arg_12_0, arg_12_1)
	arg_12_0.lockState = arg_12_1

	arg_12_0.lockController:SetSelectedState(arg_12_1 and "lock" or "unlock")
end

function var_0_1.SetSelectState(arg_13_0, arg_13_1)
	arg_13_0.selectController:SetSelectedState(arg_13_1 and "select" or "cancel")
end

function var_0_1.SetBgState(arg_14_0, arg_14_1)
	arg_14_0.bgController:SetSelectedState(arg_14_1)
end

function var_0_1.SetIsShow(arg_15_0, arg_15_1)
	SetActive(arg_15_0.gameObject_, arg_15_1)
end

function var_0_0.GetHeroID(arg_16_0)
	return arg_16_0.curHeroID
end

local function var_0_2(arg_17_0, arg_17_1)
	for iter_17_0 = arg_17_0.list_.childCount + 1, arg_17_1 do
		local var_17_0 = Object.Instantiate(arg_17_0.itemPrefab_, arg_17_0.list_)
	end

	local var_17_1 = arg_17_0.list_.childCount

	for iter_17_1 = 1, var_17_1 do
		local var_17_2 = arg_17_0.list_:GetChild(iter_17_1 - 1).gameObject

		arg_17_0.items[iter_17_1] = arg_17_0.items[iter_17_1] or var_0_0.Item.New(var_17_2)

		arg_17_0.items[iter_17_1]:SetIsShow(iter_17_1 <= arg_17_1)
	end
end

function var_0_0.RefreshUI(arg_18_0, arg_18_1)
	arg_18_0.curHeroID = arg_18_1

	var_0_2(arg_18_0, HeroConst.HERO_OATH_STORY_MAX_COUNT)

	for iter_18_0 = 1, HeroConst.HERO_OATH_STORY_MAX_COUNT do
		local var_18_0 = arg_18_0.items[iter_18_0]

		var_18_0:SetData(arg_18_1, iter_18_0, arg_18_0.onClickTabItemHandler)
		var_18_0:SetBgState("oath")

		local var_18_1 = nullable(WeddingCfg, arg_18_1, string.format("record%d_condition", iter_18_0)) or 0

		var_18_0:SetLockState(not IsConditionAchieved(var_18_1))
	end

	arg_18_0:SwitchTab(arg_18_0.curSelect or 1)
	arg_18_0:UpdateVoicePlayStatus()
end

function var_0_0.RefreshTabStyle(arg_19_0)
	if arg_19_0.items == nil then
		return
	end

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.items) do
		iter_19_1:SetSelectState(iter_19_1.itemIndex == arg_19_0.curSelect)
	end
end

function var_0_0.SwitchTab(arg_20_0, arg_20_1)
	arg_20_0:StopVoice()

	arg_20_0.curSelect = arg_20_1

	local var_20_0 = arg_20_0.items[arg_20_1]

	arg_20_0.title_.text = var_20_0.titleText_.text
	arg_20_0.voiceTitle_.text = GetTipsF("WEDDING_RECORD_TIPS1", arg_20_1)

	if var_20_0.lockState then
		arg_20_0.unlockController:SetSelectedState("false")

		local var_20_1 = nullable(WeddingCfg, arg_20_0:GetHeroID(), string.format("record%d_condition", arg_20_1)) or 0

		arg_20_0.lockTipsText_.text = nullable(ConditionCfg, var_20_1, "desc") or ""
	else
		arg_20_0.unlockController:SetSelectedState("true")

		arg_20_0.detailText_.text = nullable(WeddingCfg, arg_20_0:GetHeroID(), "wedding_record" .. arg_20_1)
	end

	arg_20_0:RefreshTabStyle()
end

function var_0_0.GetCurPlayingVoice(arg_21_0)
	if arg_21_0.parent then
		return arg_21_0.parent:IsPlaying()
	end

	return nil
end

function var_0_0.PlayVoice(arg_22_0, arg_22_1)
	if arg_22_0.parent then
		arg_22_0.parent:PlayVoice(arg_22_1, function()
			arg_22_0:UpdateVoicePlayStatus()
		end)
	end

	arg_22_0:UpdateVoicePlayStatus()
end

function var_0_0.StopVoice(arg_24_0)
	if arg_24_0.parent then
		arg_24_0.parent:StopVoice()
	end

	arg_24_0:UpdateVoicePlayStatus()
end

function var_0_0.UpdateVoicePlayStatus(arg_25_0)
	if arg_25_0:GetCurPlayingVoice() then
		arg_25_0.playStateController:SetSelectedState("true")
	else
		arg_25_0.playStateController:SetSelectedState("false")
	end
end

return var_0_0
