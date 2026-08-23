local var_0_0 = ...

local function var_0_1(arg_1_0)
	if import then
		return import("." .. arg_1_0, var_0_0)
	else
		return require(arg_1_0)
	end
end

local protobuf = require("protobuf.protobuf")
local var_0_3 = var_0_1("pb_out_base")
local var_0_4 = var_0_1("pb_bs")
local descriptor_helper = require("protobuf.descriptor_helper")
local var_0_10 = {
	C2S_MINE_DELETEENEMYUSER_ME = protobuf.Descriptor(),
	C2S_MINE_DELETEENEMYUSER_USERID_F = protobuf.FieldDescriptor(),
	S2C_MINE_DELETEENEMYUSER_ME = protobuf.Descriptor(),
	S2C_MINE_DELETEENEMYUSER_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_DELETEENEMYUSER_USERID_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETMASSINFO_ME = protobuf.Descriptor(),
	S2C_MINE_GETMASSINFO_ME = protobuf.Descriptor(),
	S2C_MINE_GETMASSINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETMASSINFO_CITYID_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETMASSINFO_STAMP_F = protobuf.FieldDescriptor(),
	C2S_MINE_MASS_ME = protobuf.Descriptor(),
	C2S_MINE_MASS_TYPE_F = protobuf.FieldDescriptor(),
	C2S_MINE_MASS_CITYID_F = protobuf.FieldDescriptor(),
	S2C_MINE_MASS_ME = protobuf.Descriptor(),
	S2C_MINE_MASS_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_MASS_TYPE_F = protobuf.FieldDescriptor(),
	S2C_MINE_MASS_CITYID_F = protobuf.FieldDescriptor(),
	S2C_MINE_MASS_STAMP_F = protobuf.FieldDescriptor(),
	S2C_MINE_MASSNOTIFY_ME = protobuf.Descriptor(),
	S2C_MINE_MASSNOTIFY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_MINE_MASSNOTIFY_CITYID_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETENEMYUSER_ME = protobuf.Descriptor(),
	S2C_MINE_GETENEMYUSER_ME = protobuf.Descriptor(),
	S2C_MINE_GETENEMYUSER_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETENEMYUSER_MINEENEMYUSER_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETENEMYGUILD_ME = protobuf.Descriptor(),
	S2C_MINE_GETENEMYGUILD_ME = protobuf.Descriptor(),
	S2C_MINE_GETENEMYGUILD_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETENEMYGUILD_MINEENEMYGUILD_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETMISSION_ME = protobuf.Descriptor(),
	S2C_MINE_GETMISSION_ME = protobuf.Descriptor(),
	S2C_MINE_GETMISSION_MINEACTIONS_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETMISSION_MINEACHIEVES_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETMISSIONREWARD_ME = protobuf.Descriptor(),
	C2S_MINE_GETMISSIONREWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETMISSIONREWARD_ME = protobuf.Descriptor(),
	S2C_MINE_GETMISSIONREWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETMISSIONREWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETMISSIONREWARD_AWARD_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETACHIEVEREWARD_ME = protobuf.Descriptor(),
	C2S_MINE_GETACHIEVEREWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETACHIEVEREWARD_ME = protobuf.Descriptor(),
	S2C_MINE_GETACHIEVEREWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETACHIEVEREWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETACHIEVEREWARD_AWARD_F = protobuf.FieldDescriptor(),
	S2C_MINE_PLAYERPOWERNOTIFY_ME = protobuf.Descriptor(),
	S2C_MINE_PLAYERPOWERNOTIFY_POWER_F = protobuf.FieldDescriptor(),
	S2C_MINE_PLAYERDIENOTIFY_ME = protobuf.Descriptor(),
	S2C_MINE_PLAYERDIENOTIFY_NOWCITYID_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETRECORD_ME = protobuf.Descriptor(),
	S2C_MINE_GETRECORD_ME = protobuf.Descriptor(),
	S2C_MINE_GETRECORD_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETRECORD_RECORDS_F = protobuf.FieldDescriptor(),
	S2C_MINE_EVENTNOTIFY_ME = protobuf.Descriptor(),
	S2C_MINE_EVENTNOTIFY_EVENT_F = protobuf.FieldDescriptor(),
	C2S_MINE_LEAVE_ME = protobuf.Descriptor(),
	S2C_MINE_LEAVE_ME = protobuf.Descriptor(),
	S2C_MINE_LEAVE_RET_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETLEAGUESTATUS_ME = protobuf.Descriptor(),
	S2C_MINE_GETLEAGUESTATUS_ME = protobuf.Descriptor(),
	S2C_MINE_GETLEAGUESTATUS_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETLEAGUESTATUS_SERVERINFO_F = protobuf.FieldDescriptor(),
	C2S_MINE_BUYPOWER_ME = protobuf.Descriptor(),
	C2S_MINE_BUYPOWER_NUM_F = protobuf.FieldDescriptor(),
	S2C_MINE_BUYPOWER_ME = protobuf.Descriptor(),
	S2C_MINE_BUYPOWER_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_BUYPOWER_POWER_F = protobuf.FieldDescriptor(),
	S2C_MINE_BUYPOWER_NUM_F = protobuf.FieldDescriptor(),
	S2C_MINE_CAPTURENOTIFY_ME = protobuf.Descriptor(),
	S2C_MINE_CAPTURENOTIFY_CITYSTATUSINFO_F = protobuf.FieldDescriptor(),
	C2S_MINE_ATTACKUSERBEGIN_ME = protobuf.Descriptor(),
	C2S_MINE_ATTACKUSERBEGIN_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_MINE_ATTACKUSERBEGIN_SKIP_BATTLE_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERBEGIN_ME = protobuf.Descriptor(),
	S2C_MINE_ATTACKUSERBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERBEGIN_SKIP_BATTLE_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERBEGIN_ENEMY_ENTER_CD_END_TIME_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERFINISH_ME = protobuf.Descriptor(),
	S2C_MINE_ATTACKUSERFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERFINISH_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERFINISH_SKIP_BATTLE_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERFINISH_CITYSTATUSINFO_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERFINISH_MYBATTLERESULT_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERFINISH_ENEMYBATTLERESULT_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERFINISH_WIN_TIME_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERFINISH_WIN_RATE_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERFINISH_ENEMY_F = protobuf.FieldDescriptor(),
	S2C_MINE_ATTACKUSERFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_MINE_MOVECITY_ME = protobuf.Descriptor(),
	C2S_MINE_MOVECITY_CITYID_F = protobuf.FieldDescriptor(),
	S2C_MINE_MOVECITY_ME = protobuf.Descriptor(),
	S2C_MINE_MOVECITY_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_MOVECITY_CITYSTATUSINFO_F = protobuf.FieldDescriptor(),
	S2C_MINE_MOVECITY_NOWGOLD_F = protobuf.FieldDescriptor(),
	S2C_MINE_MOVECITY_NOWGOLDSPEED_F = protobuf.FieldDescriptor(),
	S2C_MINE_MOVECITY_CITYID_F = protobuf.FieldDescriptor(),
	S2C_MINE_MOVECITY_ENTER_CD_END_TIME_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETCITYINFO_ME = protobuf.Descriptor(),
	C2S_MINE_GETCITYINFO_CITYID_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETCITYINFO_PAGE_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETCITYINFO_FILTERTYPE_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETCITYINFO_ME = protobuf.Descriptor(),
	S2C_MINE_GETCITYINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETCITYINFO_EVENTID_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETCITYINFO_CITYSTATUSINFO_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETCITYINFO_USERS_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETCITYINFO_CITYID_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETCITYINFO_PAGE_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETCITYINFO_TOTALPAGE_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETCITYINFO_FILTERTYPE_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETGOLD_ME = protobuf.Descriptor(),
	S2C_MINE_GETGOLD_ME = protobuf.Descriptor(),
	S2C_MINE_GETGOLD_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETGOLD_AWARD_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETGOLD_GOLDACC_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETINFO_ME = protobuf.Descriptor(),
	S2C_MINE_GETINFO_ME = protobuf.Descriptor(),
	S2C_MINE_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETINFO_STATUS_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETINFO_GOLDACC_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETINFO_NOWGOLD_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETINFO_NOWCITYID_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETINFO_NOWGOLDSPEED_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETINFO_MINECITYINFO_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETINFO_POWER_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETINFO_MINEENEMYUSER_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETINFO_MINEENEMYGUILD_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETINFO_SHIELD_END_TIME_F = protobuf.FieldDescriptor(),
	C2S_MINE_GETSHIELD_ME = protobuf.Descriptor(),
	C2S_MINE_GETSHIELD_IS_BUY_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETSHIELD_ME = protobuf.Descriptor(),
	S2C_MINE_GETSHIELD_RET_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETSHIELD_IS_BUY_F = protobuf.FieldDescriptor(),
	S2C_MINE_GETSHIELD_SHIELD_END_TIME_F = protobuf.FieldDescriptor(),
	S2C_MINE_USERSHIELDNOTIFY_ME = protobuf.Descriptor(),
	S2C_MINE_USERSHIELDNOTIFY_USER_F = protobuf.FieldDescriptor(),
	S2C_MINE_USERSHIELDNOTIFY_SHIELD_END_TIME_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_DELETEENEMYUSER_USERID_F, {
	"userId",
	".cs.C2S_Mine_DeleteEnemyUser.userId",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_DELETEENEMYUSER_ME, {
	"C2S_Mine_DeleteEnemyUser",
	".cs.C2S_Mine_DeleteEnemyUser",
	{},
	{},
	{
		var_0_10.C2S_MINE_DELETEENEMYUSER_USERID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_DELETEENEMYUSER_RET_F, {
	"ret",
	".cs.S2C_Mine_DeleteEnemyUser.ret",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_DELETEENEMYUSER_USERID_F, {
	"userId",
	".cs.S2C_Mine_DeleteEnemyUser.userId",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_DELETEENEMYUSER_ME, {
	"S2C_Mine_DeleteEnemyUser",
	".cs.S2C_Mine_DeleteEnemyUser",
	{},
	{},
	{
		var_0_10.S2C_MINE_DELETEENEMYUSER_RET_F,
		var_0_10.S2C_MINE_DELETEENEMYUSER_USERID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_GETMASSINFO_ME, {
	"C2S_Mine_GetMassInfo",
	".cs.C2S_Mine_GetMassInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETMASSINFO_RET_F, {
	"ret",
	".cs.S2C_Mine_GetMassInfo.ret",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETMASSINFO_CITYID_F, {
	"cityId",
	".cs.S2C_Mine_GetMassInfo.cityId",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETMASSINFO_STAMP_F, {
	"stamp",
	".cs.S2C_Mine_GetMassInfo.stamp",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_GETMASSINFO_ME, {
	"S2C_Mine_GetMassInfo",
	".cs.S2C_Mine_GetMassInfo",
	{},
	{},
	{
		var_0_10.S2C_MINE_GETMASSINFO_RET_F,
		var_0_10.S2C_MINE_GETMASSINFO_CITYID_F,
		var_0_10.S2C_MINE_GETMASSINFO_STAMP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_MASS_TYPE_F, {
	"type",
	".cs.C2S_Mine_Mass.type",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_MASS_CITYID_F, {
	"cityId",
	".cs.C2S_Mine_Mass.cityId",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_MASS_ME, {
	"C2S_Mine_Mass",
	".cs.C2S_Mine_Mass",
	{},
	{},
	{
		var_0_10.C2S_MINE_MASS_TYPE_F,
		var_0_10.C2S_MINE_MASS_CITYID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_MASS_RET_F, {
	"ret",
	".cs.S2C_Mine_Mass.ret",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_MASS_TYPE_F, {
	"type",
	".cs.S2C_Mine_Mass.type",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_MASS_CITYID_F, {
	"cityId",
	".cs.S2C_Mine_Mass.cityId",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_MASS_STAMP_F, {
	"stamp",
	".cs.S2C_Mine_Mass.stamp",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_MASS_ME, {
	"S2C_Mine_Mass",
	".cs.S2C_Mine_Mass",
	{},
	{},
	{
		var_0_10.S2C_MINE_MASS_RET_F,
		var_0_10.S2C_MINE_MASS_TYPE_F,
		var_0_10.S2C_MINE_MASS_CITYID_F,
		var_0_10.S2C_MINE_MASS_STAMP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_MASSNOTIFY_TYPE_F, {
	"type",
	".cs.S2C_Mine_MassNotify.type",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_MASSNOTIFY_CITYID_F, {
	"cityId",
	".cs.S2C_Mine_MassNotify.cityId",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_MASSNOTIFY_ME, {
	"S2C_Mine_MassNotify",
	".cs.S2C_Mine_MassNotify",
	{},
	{},
	{
		var_0_10.S2C_MINE_MASSNOTIFY_TYPE_F,
		var_0_10.S2C_MINE_MASSNOTIFY_CITYID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_GETENEMYUSER_ME, {
	"C2S_Mine_GetEnemyUser",
	".cs.C2S_Mine_GetEnemyUser",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETENEMYUSER_RET_F, {
	"ret",
	".cs.S2C_Mine_GetEnemyUser.ret",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETENEMYUSER_MINEENEMYUSER_F, {
	"mineEnemyUser",
	".cs.S2C_Mine_GetEnemyUser.mineEnemyUser",
	2,
	1,
	3,
	false,
	{},
	var_0_3.MINEENEMYUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_GETENEMYUSER_ME, {
	"S2C_Mine_GetEnemyUser",
	".cs.S2C_Mine_GetEnemyUser",
	{},
	{},
	{
		var_0_10.S2C_MINE_GETENEMYUSER_RET_F,
		var_0_10.S2C_MINE_GETENEMYUSER_MINEENEMYUSER_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_GETENEMYGUILD_ME, {
	"C2S_Mine_GetEnemyGuild",
	".cs.C2S_Mine_GetEnemyGuild",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETENEMYGUILD_RET_F, {
	"ret",
	".cs.S2C_Mine_GetEnemyGuild.ret",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETENEMYGUILD_MINEENEMYGUILD_F, {
	"mineEnemyGuild",
	".cs.S2C_Mine_GetEnemyGuild.mineEnemyGuild",
	2,
	1,
	3,
	false,
	{},
	var_0_3.MINEENEMYGUILD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_GETENEMYGUILD_ME, {
	"S2C_Mine_GetEnemyGuild",
	".cs.S2C_Mine_GetEnemyGuild",
	{},
	{},
	{
		var_0_10.S2C_MINE_GETENEMYGUILD_RET_F,
		var_0_10.S2C_MINE_GETENEMYGUILD_MINEENEMYGUILD_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_GETMISSION_ME, {
	"C2S_Mine_GetMission",
	".cs.C2S_Mine_GetMission",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETMISSION_MINEACTIONS_F, {
	"mineActions",
	".cs.S2C_Mine_GetMission.mineActions",
	1,
	0,
	3,
	false,
	{},
	var_0_3.MINEACTION_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETMISSION_MINEACHIEVES_F, {
	"mineAchieves",
	".cs.S2C_Mine_GetMission.mineAchieves",
	2,
	1,
	3,
	false,
	{},
	var_0_3.MINEACHIEVE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_GETMISSION_ME, {
	"S2C_Mine_GetMission",
	".cs.S2C_Mine_GetMission",
	{},
	{},
	{
		var_0_10.S2C_MINE_GETMISSION_MINEACTIONS_F,
		var_0_10.S2C_MINE_GETMISSION_MINEACHIEVES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_GETMISSIONREWARD_ID_F, {
	"id",
	".cs.C2S_Mine_GetMissionReward.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_GETMISSIONREWARD_ME, {
	"C2S_Mine_GetMissionReward",
	".cs.C2S_Mine_GetMissionReward",
	{},
	{},
	{
		var_0_10.C2S_MINE_GETMISSIONREWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETMISSIONREWARD_RET_F, {
	"ret",
	".cs.S2C_Mine_GetMissionReward.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETMISSIONREWARD_ID_F, {
	"id",
	".cs.S2C_Mine_GetMissionReward.id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETMISSIONREWARD_AWARD_F, {
	"award",
	".cs.S2C_Mine_GetMissionReward.award",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_GETMISSIONREWARD_ME, {
	"S2C_Mine_GetMissionReward",
	".cs.S2C_Mine_GetMissionReward",
	{},
	{},
	{
		var_0_10.S2C_MINE_GETMISSIONREWARD_RET_F,
		var_0_10.S2C_MINE_GETMISSIONREWARD_ID_F,
		var_0_10.S2C_MINE_GETMISSIONREWARD_AWARD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_GETACHIEVEREWARD_ID_F, {
	"id",
	".cs.C2S_Mine_GetAchieveReward.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_GETACHIEVEREWARD_ME, {
	"C2S_Mine_GetAchieveReward",
	".cs.C2S_Mine_GetAchieveReward",
	{},
	{},
	{
		var_0_10.C2S_MINE_GETACHIEVEREWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETACHIEVEREWARD_RET_F, {
	"ret",
	".cs.S2C_Mine_GetAchieveReward.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETACHIEVEREWARD_ID_F, {
	"id",
	".cs.S2C_Mine_GetAchieveReward.id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETACHIEVEREWARD_AWARD_F, {
	"award",
	".cs.S2C_Mine_GetAchieveReward.award",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_GETACHIEVEREWARD_ME, {
	"S2C_Mine_GetAchieveReward",
	".cs.S2C_Mine_GetAchieveReward",
	{},
	{},
	{
		var_0_10.S2C_MINE_GETACHIEVEREWARD_RET_F,
		var_0_10.S2C_MINE_GETACHIEVEREWARD_ID_F,
		var_0_10.S2C_MINE_GETACHIEVEREWARD_AWARD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_PLAYERPOWERNOTIFY_POWER_F, {
	"power",
	".cs.S2C_Mine_PlayerPowerNotify.power",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_PLAYERPOWERNOTIFY_ME, {
	"S2C_Mine_PlayerPowerNotify",
	".cs.S2C_Mine_PlayerPowerNotify",
	{},
	{},
	{
		var_0_10.S2C_MINE_PLAYERPOWERNOTIFY_POWER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_PLAYERDIENOTIFY_NOWCITYID_F, {
	"nowCityId",
	".cs.S2C_Mine_PlayerDieNotify.nowCityId",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_PLAYERDIENOTIFY_ME, {
	"S2C_Mine_PlayerDieNotify",
	".cs.S2C_Mine_PlayerDieNotify",
	{},
	{},
	{
		var_0_10.S2C_MINE_PLAYERDIENOTIFY_NOWCITYID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_GETRECORD_ME, {
	"C2S_Mine_GetRecord",
	".cs.C2S_Mine_GetRecord",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETRECORD_RET_F, {
	"ret",
	".cs.S2C_Mine_GetRecord.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETRECORD_RECORDS_F, {
	"records",
	".cs.S2C_Mine_GetRecord.records",
	2,
	1,
	3,
	false,
	{},
	var_0_3.MINERECORD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_GETRECORD_ME, {
	"S2C_Mine_GetRecord",
	".cs.S2C_Mine_GetRecord",
	{},
	{},
	{
		var_0_10.S2C_MINE_GETRECORD_RET_F,
		var_0_10.S2C_MINE_GETRECORD_RECORDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_EVENTNOTIFY_EVENT_F, {
	"event",
	".cs.S2C_Mine_EventNotify.event",
	1,
	0,
	3,
	false,
	{},
	var_0_3.MINEEVENTINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_EVENTNOTIFY_ME, {
	"S2C_Mine_EventNotify",
	".cs.S2C_Mine_EventNotify",
	{},
	{},
	{
		var_0_10.S2C_MINE_EVENTNOTIFY_EVENT_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_LEAVE_ME, {
	"C2S_Mine_Leave",
	".cs.C2S_Mine_Leave",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_LEAVE_RET_F, {
	"ret",
	".cs.S2C_Mine_Leave.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_LEAVE_ME, {
	"S2C_Mine_Leave",
	".cs.S2C_Mine_Leave",
	{},
	{},
	{
		var_0_10.S2C_MINE_LEAVE_RET_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_GETLEAGUESTATUS_ME, {
	"C2S_Mine_GetLeagueStatus",
	".cs.C2S_Mine_GetLeagueStatus",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETLEAGUESTATUS_RET_F, {
	"ret",
	".cs.S2C_Mine_GetLeagueStatus.ret",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETLEAGUESTATUS_SERVERINFO_F, {
	"serverInfo",
	".cs.S2C_Mine_GetLeagueStatus.serverInfo",
	2,
	1,
	3,
	false,
	{},
	var_0_3.SERVERINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_GETLEAGUESTATUS_ME, {
	"S2C_Mine_GetLeagueStatus",
	".cs.S2C_Mine_GetLeagueStatus",
	{},
	{},
	{
		var_0_10.S2C_MINE_GETLEAGUESTATUS_RET_F,
		var_0_10.S2C_MINE_GETLEAGUESTATUS_SERVERINFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_BUYPOWER_NUM_F, {
	"num",
	".cs.C2S_Mine_BuyPower.num",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_BUYPOWER_ME, {
	"C2S_Mine_BuyPower",
	".cs.C2S_Mine_BuyPower",
	{},
	{},
	{
		var_0_10.C2S_MINE_BUYPOWER_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_BUYPOWER_RET_F, {
	"ret",
	".cs.S2C_Mine_BuyPower.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_BUYPOWER_POWER_F, {
	"power",
	".cs.S2C_Mine_BuyPower.power",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_BUYPOWER_NUM_F, {
	"num",
	".cs.S2C_Mine_BuyPower.num",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_BUYPOWER_ME, {
	"S2C_Mine_BuyPower",
	".cs.S2C_Mine_BuyPower",
	{},
	{},
	{
		var_0_10.S2C_MINE_BUYPOWER_RET_F,
		var_0_10.S2C_MINE_BUYPOWER_POWER_F,
		var_0_10.S2C_MINE_BUYPOWER_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_CAPTURENOTIFY_CITYSTATUSINFO_F, {
	"cityStatusInfo",
	".cs.S2C_Mine_CaptureNotify.cityStatusInfo",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.MINECITYSTATUSINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_CAPTURENOTIFY_ME, {
	"S2C_Mine_CaptureNotify",
	".cs.S2C_Mine_CaptureNotify",
	{},
	{},
	{
		var_0_10.S2C_MINE_CAPTURENOTIFY_CITYSTATUSINFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_ATTACKUSERBEGIN_USER_ID_F, {
	"user_id",
	".cs.C2S_Mine_AttackUserBegin.user_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_ATTACKUSERBEGIN_SKIP_BATTLE_F, {
	"skip_battle",
	".cs.C2S_Mine_AttackUserBegin.skip_battle",
	2,
	1,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_ATTACKUSERBEGIN_ME, {
	"C2S_Mine_AttackUserBegin",
	".cs.C2S_Mine_AttackUserBegin",
	{},
	{},
	{
		var_0_10.C2S_MINE_ATTACKUSERBEGIN_USER_ID_F,
		var_0_10.C2S_MINE_ATTACKUSERBEGIN_SKIP_BATTLE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERBEGIN_RET_F, {
	"ret",
	".cs.S2C_Mine_AttackUserBegin.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Mine_AttackUserBegin.battle_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERBEGIN_SKIP_BATTLE_F, {
	"skip_battle",
	".cs.S2C_Mine_AttackUserBegin.skip_battle",
	3,
	2,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERBEGIN_ENEMY_ENTER_CD_END_TIME_F, {
	"enemy_enter_cd_end_time",
	".cs.S2C_Mine_AttackUserBegin.enemy_enter_cd_end_time",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_ATTACKUSERBEGIN_ME, {
	"S2C_Mine_AttackUserBegin",
	".cs.S2C_Mine_AttackUserBegin",
	{},
	{},
	{
		var_0_10.S2C_MINE_ATTACKUSERBEGIN_RET_F,
		var_0_10.S2C_MINE_ATTACKUSERBEGIN_BATTLE_ID_F,
		var_0_10.S2C_MINE_ATTACKUSERBEGIN_SKIP_BATTLE_F,
		var_0_10.S2C_MINE_ATTACKUSERBEGIN_ENEMY_ENTER_CD_END_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERFINISH_RET_F, {
	"ret",
	".cs.S2C_Mine_AttackUserFinish.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERFINISH_USER_ID_F, {
	"user_id",
	".cs.S2C_Mine_AttackUserFinish.user_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERFINISH_SKIP_BATTLE_F, {
	"skip_battle",
	".cs.S2C_Mine_AttackUserFinish.skip_battle",
	3,
	2,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_Mine_AttackUserFinish.is_win",
	4,
	3,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERFINISH_CITYSTATUSINFO_F, {
	"cityStatusInfo",
	".cs.S2C_Mine_AttackUserFinish.cityStatusInfo",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.MINECITYSTATUSINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERFINISH_MYBATTLERESULT_F, {
	"myBattleResult",
	".cs.S2C_Mine_AttackUserFinish.myBattleResult",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.MINEBATTLERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERFINISH_ENEMYBATTLERESULT_F, {
	"enemyBattleResult",
	".cs.S2C_Mine_AttackUserFinish.enemyBattleResult",
	7,
	6,
	1,
	false,
	nil,
	var_0_3.MINEBATTLERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERFINISH_WIN_TIME_F, {
	"win_time",
	".cs.S2C_Mine_AttackUserFinish.win_time",
	8,
	7,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERFINISH_WIN_RATE_F, {
	"win_rate",
	".cs.S2C_Mine_AttackUserFinish.win_rate",
	9,
	8,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERFINISH_ENEMY_F, {
	"enemy",
	".cs.S2C_Mine_AttackUserFinish.enemy",
	10,
	9,
	1,
	false,
	nil,
	var_0_3.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_ATTACKUSERFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_Mine_AttackUserFinish.awards",
	11,
	10,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_ATTACKUSERFINISH_ME, {
	"S2C_Mine_AttackUserFinish",
	".cs.S2C_Mine_AttackUserFinish",
	{},
	{},
	{
		var_0_10.S2C_MINE_ATTACKUSERFINISH_RET_F,
		var_0_10.S2C_MINE_ATTACKUSERFINISH_USER_ID_F,
		var_0_10.S2C_MINE_ATTACKUSERFINISH_SKIP_BATTLE_F,
		var_0_10.S2C_MINE_ATTACKUSERFINISH_IS_WIN_F,
		var_0_10.S2C_MINE_ATTACKUSERFINISH_CITYSTATUSINFO_F,
		var_0_10.S2C_MINE_ATTACKUSERFINISH_MYBATTLERESULT_F,
		var_0_10.S2C_MINE_ATTACKUSERFINISH_ENEMYBATTLERESULT_F,
		var_0_10.S2C_MINE_ATTACKUSERFINISH_WIN_TIME_F,
		var_0_10.S2C_MINE_ATTACKUSERFINISH_WIN_RATE_F,
		var_0_10.S2C_MINE_ATTACKUSERFINISH_ENEMY_F,
		var_0_10.S2C_MINE_ATTACKUSERFINISH_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_MOVECITY_CITYID_F, {
	"cityId",
	".cs.C2S_Mine_MoveCity.cityId",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_MOVECITY_ME, {
	"C2S_Mine_MoveCity",
	".cs.C2S_Mine_MoveCity",
	{},
	{},
	{
		var_0_10.C2S_MINE_MOVECITY_CITYID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_MOVECITY_RET_F, {
	"ret",
	".cs.S2C_Mine_MoveCity.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_MOVECITY_CITYSTATUSINFO_F, {
	"cityStatusInfo",
	".cs.S2C_Mine_MoveCity.cityStatusInfo",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.MINECITYSTATUSINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_MOVECITY_NOWGOLD_F, {
	"nowGold",
	".cs.S2C_Mine_MoveCity.nowGold",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_MOVECITY_NOWGOLDSPEED_F, {
	"nowGoldSpeed",
	".cs.S2C_Mine_MoveCity.nowGoldSpeed",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_MOVECITY_CITYID_F, {
	"cityId",
	".cs.S2C_Mine_MoveCity.cityId",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_MOVECITY_ENTER_CD_END_TIME_F, {
	"enter_cd_end_time",
	".cs.S2C_Mine_MoveCity.enter_cd_end_time",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_MOVECITY_ME, {
	"S2C_Mine_MoveCity",
	".cs.S2C_Mine_MoveCity",
	{},
	{},
	{
		var_0_10.S2C_MINE_MOVECITY_RET_F,
		var_0_10.S2C_MINE_MOVECITY_CITYSTATUSINFO_F,
		var_0_10.S2C_MINE_MOVECITY_NOWGOLD_F,
		var_0_10.S2C_MINE_MOVECITY_NOWGOLDSPEED_F,
		var_0_10.S2C_MINE_MOVECITY_CITYID_F,
		var_0_10.S2C_MINE_MOVECITY_ENTER_CD_END_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_GETCITYINFO_CITYID_F, {
	"cityId",
	".cs.C2S_Mine_GetCityInfo.cityId",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_GETCITYINFO_PAGE_F, {
	"page",
	".cs.C2S_Mine_GetCityInfo.page",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_GETCITYINFO_FILTERTYPE_F, {
	"filterType",
	".cs.C2S_Mine_GetCityInfo.filterType",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_GETCITYINFO_ME, {
	"C2S_Mine_GetCityInfo",
	".cs.C2S_Mine_GetCityInfo",
	{},
	{},
	{
		var_0_10.C2S_MINE_GETCITYINFO_CITYID_F,
		var_0_10.C2S_MINE_GETCITYINFO_PAGE_F,
		var_0_10.C2S_MINE_GETCITYINFO_FILTERTYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETCITYINFO_RET_F, {
	"ret",
	".cs.S2C_Mine_GetCityInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETCITYINFO_EVENTID_F, {
	"eventId",
	".cs.S2C_Mine_GetCityInfo.eventId",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETCITYINFO_CITYSTATUSINFO_F, {
	"cityStatusInfo",
	".cs.S2C_Mine_GetCityInfo.cityStatusInfo",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.MINECITYSTATUSINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETCITYINFO_USERS_F, {
	"users",
	".cs.S2C_Mine_GetCityInfo.users",
	4,
	3,
	3,
	false,
	{},
	var_0_3.MINECITYUSERINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETCITYINFO_CITYID_F, {
	"cityId",
	".cs.S2C_Mine_GetCityInfo.cityId",
	5,
	4,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETCITYINFO_PAGE_F, {
	"page",
	".cs.S2C_Mine_GetCityInfo.page",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETCITYINFO_TOTALPAGE_F, {
	"totalPage",
	".cs.S2C_Mine_GetCityInfo.totalPage",
	7,
	6,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETCITYINFO_FILTERTYPE_F, {
	"filterType",
	".cs.S2C_Mine_GetCityInfo.filterType",
	8,
	7,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_GETCITYINFO_ME, {
	"S2C_Mine_GetCityInfo",
	".cs.S2C_Mine_GetCityInfo",
	{},
	{},
	{
		var_0_10.S2C_MINE_GETCITYINFO_RET_F,
		var_0_10.S2C_MINE_GETCITYINFO_EVENTID_F,
		var_0_10.S2C_MINE_GETCITYINFO_CITYSTATUSINFO_F,
		var_0_10.S2C_MINE_GETCITYINFO_USERS_F,
		var_0_10.S2C_MINE_GETCITYINFO_CITYID_F,
		var_0_10.S2C_MINE_GETCITYINFO_PAGE_F,
		var_0_10.S2C_MINE_GETCITYINFO_TOTALPAGE_F,
		var_0_10.S2C_MINE_GETCITYINFO_FILTERTYPE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_GETGOLD_ME, {
	"C2S_Mine_GetGold",
	".cs.C2S_Mine_GetGold",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETGOLD_RET_F, {
	"ret",
	".cs.S2C_Mine_GetGold.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETGOLD_AWARD_F, {
	"award",
	".cs.S2C_Mine_GetGold.award",
	2,
	1,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETGOLD_GOLDACC_F, {
	"goldAcc",
	".cs.S2C_Mine_GetGold.goldAcc",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_GETGOLD_ME, {
	"S2C_Mine_GetGold",
	".cs.S2C_Mine_GetGold",
	{},
	{},
	{
		var_0_10.S2C_MINE_GETGOLD_RET_F,
		var_0_10.S2C_MINE_GETGOLD_AWARD_F,
		var_0_10.S2C_MINE_GETGOLD_GOLDACC_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_GETINFO_ME, {
	"C2S_Mine_GetInfo",
	".cs.C2S_Mine_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Mine_GetInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETINFO_STATUS_F, {
	"status",
	".cs.S2C_Mine_GetInfo.status",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETINFO_GOLDACC_F, {
	"goldAcc",
	".cs.S2C_Mine_GetInfo.goldAcc",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETINFO_NOWGOLD_F, {
	"nowGold",
	".cs.S2C_Mine_GetInfo.nowGold",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETINFO_NOWCITYID_F, {
	"nowCityId",
	".cs.S2C_Mine_GetInfo.nowCityId",
	5,
	4,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETINFO_NOWGOLDSPEED_F, {
	"nowGoldSpeed",
	".cs.S2C_Mine_GetInfo.nowGoldSpeed",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETINFO_MINECITYINFO_F, {
	"mineCityInfo",
	".cs.S2C_Mine_GetInfo.mineCityInfo",
	7,
	6,
	3,
	false,
	{},
	var_0_3.MINECITYINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETINFO_POWER_F, {
	"power",
	".cs.S2C_Mine_GetInfo.power",
	8,
	7,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETINFO_MINEENEMYUSER_F, {
	"mineEnemyUser",
	".cs.S2C_Mine_GetInfo.mineEnemyUser",
	9,
	8,
	3,
	false,
	{},
	var_0_3.MINEENEMYUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETINFO_MINEENEMYGUILD_F, {
	"mineEnemyGuild",
	".cs.S2C_Mine_GetInfo.mineEnemyGuild",
	10,
	9,
	3,
	false,
	{},
	var_0_3.MINEENEMYGUILD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETINFO_SHIELD_END_TIME_F, {
	"shield_end_time",
	".cs.S2C_Mine_GetInfo.shield_end_time",
	11,
	10,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_GETINFO_ME, {
	"S2C_Mine_GetInfo",
	".cs.S2C_Mine_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_MINE_GETINFO_RET_F,
		var_0_10.S2C_MINE_GETINFO_STATUS_F,
		var_0_10.S2C_MINE_GETINFO_GOLDACC_F,
		var_0_10.S2C_MINE_GETINFO_NOWGOLD_F,
		var_0_10.S2C_MINE_GETINFO_NOWCITYID_F,
		var_0_10.S2C_MINE_GETINFO_NOWGOLDSPEED_F,
		var_0_10.S2C_MINE_GETINFO_MINECITYINFO_F,
		var_0_10.S2C_MINE_GETINFO_POWER_F,
		var_0_10.S2C_MINE_GETINFO_MINEENEMYUSER_F,
		var_0_10.S2C_MINE_GETINFO_MINEENEMYGUILD_F,
		var_0_10.S2C_MINE_GETINFO_SHIELD_END_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MINE_GETSHIELD_IS_BUY_F, {
	"is_buy",
	".cs.C2S_Mine_GetShield.is_buy",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MINE_GETSHIELD_ME, {
	"C2S_Mine_GetShield",
	".cs.C2S_Mine_GetShield",
	{},
	{},
	{
		var_0_10.C2S_MINE_GETSHIELD_IS_BUY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETSHIELD_RET_F, {
	"ret",
	".cs.S2C_Mine_GetShield.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETSHIELD_IS_BUY_F, {
	"is_buy",
	".cs.S2C_Mine_GetShield.is_buy",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_GETSHIELD_SHIELD_END_TIME_F, {
	"shield_end_time",
	".cs.S2C_Mine_GetShield.shield_end_time",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_GETSHIELD_ME, {
	"S2C_Mine_GetShield",
	".cs.S2C_Mine_GetShield",
	{},
	{},
	{
		var_0_10.S2C_MINE_GETSHIELD_RET_F,
		var_0_10.S2C_MINE_GETSHIELD_IS_BUY_F,
		var_0_10.S2C_MINE_GETSHIELD_SHIELD_END_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_USERSHIELDNOTIFY_USER_F, {
	"user",
	".cs.S2C_Mine_UserShieldNotify.user",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MINE_USERSHIELDNOTIFY_SHIELD_END_TIME_F, {
	"shield_end_time",
	".cs.S2C_Mine_UserShieldNotify.shield_end_time",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MINE_USERSHIELDNOTIFY_ME, {
	"S2C_Mine_UserShieldNotify",
	".cs.S2C_Mine_UserShieldNotify",
	{},
	{},
	{
		var_0_10.S2C_MINE_USERSHIELDNOTIFY_USER_F,
		var_0_10.S2C_MINE_USERSHIELDNOTIFY_SHIELD_END_TIME_F
	},
	false,
	{}
})

return var_0_10
