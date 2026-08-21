local var_0_0 = class("DormRoomUnLockItem", ReduxView)

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
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.unLockBtn_, nil, function()
		if arg_4_0.unLockFunc then
			arg_4_0.unLockFunc(arg_4_0.archiveID)
		end
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.archiveID = arg_6_1
	arg_6_0.archiveName.text = string.format(GetTips("DORM_HERO_ROOM_NAME"), GetI18NText(HeroRecordCfg[arg_6_0.archiveID].name))
	arg_6_0.condition.text = string.format(GetTips("DORM_ROOM_UNLOCK_TIPS"), GetI18NText(HeroRecordCfg[arg_6_0.archiveID].name))
	arg_6_0.heroImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_6_0.archiveID)
end

function var_0_0.PlaceHeroCallBack(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.unLockFunc = arg_7_1
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
