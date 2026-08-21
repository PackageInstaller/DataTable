local var_0_0 = class("HeroTrammelsNetPartnerItem", ReduxView)

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

	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_btn, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.hero_id)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.hero_id = arg_6_1
	arg_6_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_6_1)

	arg_6_0.selectController:SetSelectedIndex(arg_6_1 == arg_6_2 and 1 or 0)

	local var_6_0 = ArchiveTools.GetRelationConfig(arg_6_3, arg_6_1)

	if var_6_0 ~= nil and var_6_0.story_id ~= 0 and not ArchiveData:GetRelationStoryRead(var_6_0.id) and IsConditionAchieved(var_6_0.story_condtion_id, {
		heroId = arg_6_0.hero_id
	}) then
		manager.redPoint:SetRedPointIndependent(arg_6_0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_6_0.transform_, false)
	end
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.callback_ = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
