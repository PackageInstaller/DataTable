local var_0_0 = class("OathHeroVoiceArchieveSubView", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.parent = nullable(arg_1_2, "parentView")
	arg_1_0.items = {}

	arg_1_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_2_0)
	SetActive(arg_2_0.gameObject_, true)
	arg_2_0:UpdateVoicePlayStatus()
end

function var_0_0.OnExit(arg_3_0)
	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.Dispose(arg_4_0)
	if arg_4_0.items then
		for iter_4_0, iter_4_1 in pairs(arg_4_0.items) do
			Object.Destroy(iter_4_1.gameObject_)
			iter_4_1:Dispose()
		end
	end

	arg_4_0.items = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.GetHeroID(arg_5_0)
	return arg_5_0.curHeroID
end

var_0_0.Item = HeroFileVoiceItem

local function var_0_1(arg_6_0, arg_6_1)
	for iter_6_0 = arg_6_0.list_.childCount + 1, arg_6_1 do
		local var_6_0 = Object.Instantiate(arg_6_0.itemPrefab_, arg_6_0.list_)
	end

	local var_6_1 = arg_6_0.list_.childCount

	for iter_6_1 = 1, var_6_1 do
		local var_6_2 = arg_6_0.list_:GetChild(iter_6_1 - 1).gameObject

		arg_6_0.items[iter_6_1] = arg_6_0.items[iter_6_1] or var_0_0.Item.New(var_6_2)

		arg_6_0.items[iter_6_1]:SetIsShow(iter_6_1 <= arg_6_1)
	end
end

function var_0_0.PlayVoice(arg_7_0, arg_7_1)
	if arg_7_0.parent then
		arg_7_0.parent:PlayVoice(arg_7_1, function()
			arg_7_0:UpdateVoicePlayStatus()
		end)
	end

	arg_7_0:UpdateVoicePlayStatus()
end

function var_0_0.StopVoice(arg_9_0)
	if arg_9_0.parent then
		arg_9_0.parent:StopVoice(voiceID, callback)
	end
end

function var_0_0.GetCurPlayingVoice(arg_10_0)
	if arg_10_0.parent then
		return arg_10_0.parent:IsPlaying()
	end

	return nil
end

function var_0_0.RefreshUI(arg_11_0, arg_11_1)
	arg_11_0.curHeroID = arg_11_1

	local var_11_0 = arg_11_0:GetVoiceTag()
	local var_11_1 = arg_11_0:GetAllCategory(arg_11_1)

	var_0_1(arg_11_0, #var_11_1)

	local function var_11_2(arg_12_0)
		PlayerAction.CheckHeroVoice(arg_11_0:GetHeroID(), function()
			if arg_11_0:GetCurPlayingVoice() == arg_12_0 then
				arg_11_0:StopVoice()
			else
				arg_11_0:PlayVoice(arg_12_0)
			end
		end)
	end

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		local var_11_3 = arg_11_0.items[iter_11_0]

		var_11_3:SetData(arg_11_1, iter_11_1, var_11_2)
		var_11_3:SetBgState("oath")
	end

	arg_11_0:UpdateVoicePlayStatus()
end

function var_0_0.GetVoiceTag(arg_14_0)
	return {
		8
	}
end

local function var_0_2(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = HeroVoiceCfg.get_id_list_by_tag_id[arg_15_2] or {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_1 = HeroVoiceDescCfg.get_id_list_by_subtitle_id_form_id[iter_15_1]

		if var_15_1 then
			for iter_15_2, iter_15_3 in pairs(var_15_1) do
				if (HeroTools.GetHeroIDFromFormID(iter_15_2) or SkinCfg[iter_15_2].hero) == arg_15_1 then
					table.insert(arg_15_0, {
						id = iter_15_1,
						unlock = HeroTools.IsUnlockVoice(arg_15_1, iter_15_1)
					})
				end
			end
		end
	end
end

function var_0_0.GetAllCategory(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:GetVoiceTag()
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		var_0_2(var_16_1, arg_16_1, iter_16_1)
	end

	CommonTools.UniversalSortEx(var_16_1, {
		map = function(arg_17_0)
			return arg_17_0.unlock and 1 or 0
		end
	}, {
		ascend = true,
		map = function(arg_18_0)
			return arg_18_0.id
		end
	})

	return var_16_1
end

function var_0_0.UpdateItemPlayState(arg_19_0, arg_19_1)
	if arg_19_0:GetCurPlayingVoice() == arg_19_1.id_ then
		arg_19_1:StartPlay()
	else
		arg_19_1:StopPlay()
	end
end

function var_0_0.UpdateVoicePlayStatus(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.items) do
		arg_20_0:UpdateItemPlayState(iter_20_1)
	end
end

return var_0_0
