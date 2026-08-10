local var_0_0 = class("HeroArchiveStoryItem", ReduxView)

local function var_0_1(arg_1_0)
	local var_1_0 = math.round(HeroConst.HERO_LOVE_LV_MAX / 5)

	return (math.ceil(arg_1_0 / var_1_0))
end

function var_0_0.OnCtor(arg_2_0, arg_2_1)
	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_1.transform

	arg_2_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.controller_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "conName")
	arg_4_0.colorController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "colorChange")
end

function var_0_0.RefreshLoveCircle(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or ArchiveData:GetArchive(arg_5_0.archiveID_).lv

	local var_5_0 = var_0_1(arg_5_1)

	arg_5_0.colorController_:SetSelectedIndex(var_5_0 - 1)

	arg_5_0.lovelevelText_.text = arg_5_1
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.archiveID_ = arg_6_2
	arg_6_0.ID_ = arg_6_1
	arg_6_0.storyLinId_ = HeroRecordCfg[arg_6_2].plot_id[arg_6_1]

	local var_6_0 = GameSetting.hero_plot_unlock_condition.value[arg_6_1]
	local var_6_1 = ConditionCfg[var_6_0]
	local var_6_2, var_6_3, var_6_4 = IsConditionAchieved(var_6_0, {
		heroId = arg_6_0.archiveID_
	})

	arg_6_0:RefreshLoveCircle(ConditionCfg[var_6_0].params[1])

	if var_6_2 then
		arg_6_0.controller_:SetSelectedState("unLock")
	else
		arg_6_0.controller_:SetSelectedState("lock")
	end

	arg_6_0.titleText_.text = GetI18NText(HeroRecordCfg[arg_6_2].plot_title[arg_6_1])

	local var_6_5 = ArchiveData:IsStoryRead(arg_6_0.archiveID_, arg_6_0.storyLinId_)

	manager.redPoint:SetRedPointIndependent(arg_6_0.playbtnBtn_.transform, not var_6_5 and var_6_2)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.playbtnBtn_, nil, function()
		manager.redPoint:SetRedPointIndependent(arg_7_0.playbtnBtn_.transform, false)
		manager.story:StartStoryById(arg_7_0.storyLinId_, function(arg_9_0)
			HeroAction.ReadStory(arg_7_0.archiveID_, arg_7_0.storyLinId_)
		end)
	end)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
