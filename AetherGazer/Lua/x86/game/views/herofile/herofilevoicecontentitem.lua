local var_0_0 = class("HeroFileVoiceContentItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeID_ = -1
	arg_3_0.itemList_ = {}
	arg_3_0.curHeroID_ = -1
	arg_3_0.showController_ = arg_3_0.mainControllerEx_:GetController("show")
	arg_3_0.bgController = arg_3_0.mainControllerEx_:GetController("bg")
	arg_3_0.expand = false
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_0.curHeroID_ = arg_4_1
	arg_4_0.typeID_ = arg_4_2
	arg_4_0.formID_ = arg_4_3 or nil
	arg_4_0.onClick_ = arg_4_4
	arg_4_0.showClick_ = arg_4_5

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0.typeText_.text = HeroVoiceTagCfg[arg_5_0.typeID_].tag_name

	arg_5_0:InitItemList()
	arg_5_0:RefreshActive()
end

function var_0_0.RefreshActive(arg_6_0)
	SetActive(arg_6_0.gameObject_, not arg_6_0:IsEmpty())
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.showBtn_, nil, function()
		arg_7_0:ChangeShow(not arg_7_0.expand)
		arg_7_0.showClick_()
	end)
end

function var_0_0.ChangeShow(arg_9_0, arg_9_1)
	if arg_9_0.expand == arg_9_1 then
		return
	end

	arg_9_0.expand = arg_9_1

	arg_9_0.showController_:SetSelectedIndex(arg_9_0.expand and 1 or 0)
end

local var_0_1 = 8

function var_0_0.InitItemList(arg_10_0)
	arg_10_0:UpdateVoiceData()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.voiceList_) do
		local var_10_0 = iter_10_1.id
		local var_10_1 = arg_10_0.itemList_[iter_10_0]

		if not var_10_1 then
			local var_10_2 = Object.Instantiate(arg_10_0.itemGo_, arg_10_0.content_)

			var_10_1 = HeroFileVoiceItem.New(var_10_2)
			arg_10_0.itemList_[iter_10_0] = var_10_1
		end

		var_10_1:SetIsShow(true)

		local var_10_3 = HeroVoiceCfg[var_10_0].use_skin_id

		if var_10_3 == 0 then
			var_10_3 = arg_10_0.curHeroID_
		end

		var_10_1:SetData(var_10_3, iter_10_1, arg_10_0.onClick_)
	end

	for iter_10_2 = #arg_10_0.voiceList_ + 1, #arg_10_0.itemList_ do
		arg_10_0.itemList_[iter_10_2]:SetIsShow(false)
	end
end

function var_0_0.SetIsShow(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

local function var_0_2(arg_12_0)
	return nullable(SkinCfg, arg_12_0, "hero")
end

local var_0_3 = 8

local function var_0_4(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 == var_0_3 and not OathTools.IsOath(arg_13_1) then
		return
	end

	for iter_13_0, iter_13_1 in ipairs(HeroVoiceCfg.get_id_list_by_tag_id[arg_13_2]) do
		local var_13_0 = nullable(HeroVoiceDescCfg.get_id_list_by_subtitle_id_form_id, iter_13_1)

		if var_13_0 then
			for iter_13_2, iter_13_3 in pairs(var_13_0) do
				if var_0_2(iter_13_2) == arg_13_1 then
					table.insert(arg_13_0, iter_13_1)

					break
				end
			end
		end
	end
end

function var_0_0.UpdateVoiceData(arg_14_0)
	arg_14_0.voiceList_ = {}

	local var_14_0 = {}

	if arg_14_0.formID_ then
		local var_14_1 = var_0_2(arg_14_0.formID_)

		var_0_4(var_14_0, var_14_1, arg_14_0.typeID_)
	else
		var_0_4(var_14_0, arg_14_0.curHeroID_, arg_14_0.typeID_)
	end

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_2 = HeroVoiceCfg[iter_14_1]
		local var_14_3 = HeroTools.IsUnlockVoice(arg_14_0.curHeroID_, iter_14_1)
		local var_14_4 = var_14_2.use_skin_id

		if var_14_4 == 0 then
			var_14_4 = arg_14_0.curHeroID_
		end

		local var_14_5 = (var_14_2.hide or 0) ~= 0
		local var_14_6 = HeroVoiceDescCfg.Get(var_14_4, iter_14_1)

		if var_14_6 ~= nil and var_14_6 ~= "" and not var_14_5 then
			table.insert(arg_14_0.voiceList_, {
				id = iter_14_1,
				unlock = var_14_3
			})
		end
	end

	table.sort(arg_14_0.voiceList_, function(arg_15_0, arg_15_1)
		if (arg_15_0.unlock or arg_15_1.unlock) and arg_15_0.unlock ~= arg_15_1.unlock then
			return arg_15_0.unlock
		end

		return arg_15_0.id < arg_15_1.id
	end)
end

function var_0_0.IsEmpty(arg_16_0)
	if arg_16_0.voiceList_ and #arg_16_0.voiceList_ == 0 then
		return true
	else
		return false
	end
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.itemList_) do
		iter_17_1:Dispose()
	end

	arg_17_0.itemList_ = {}

	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.StartPlay(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.voiceList_) do
		local var_18_0 = arg_18_0.itemList_[iter_18_0]

		if var_18_0 then
			if arg_18_1 == iter_18_1.id then
				var_18_0:StartPlay()
			else
				var_18_0:StopPlay()
			end
		end
	end
end

function var_0_0.StopPlay(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.itemList_) do
		iter_19_1:StopPlay()
	end
end

function var_0_0.GetItemByID(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.itemList_) do
		if iter_20_1:GetID() == arg_20_1 then
			return iter_20_1
		end
	end

	return nil
end

function var_0_0.SetBgState(arg_21_0, arg_21_1)
	arg_21_0.bgController:SetSelectedState(arg_21_1)
end

return var_0_0
