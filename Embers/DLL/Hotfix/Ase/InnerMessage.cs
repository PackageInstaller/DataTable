namespace Ase;

public static class InnerMessage
{
	public const ushort M2A_Reload = 1001;

	public const ushort A2M_Reload = 1002;

	public const ushort G2G_LockRequest = 1003;

	public const ushort G2G_LockResponse = 1004;

	public const ushort G2G_LockReleaseRequest = 1005;

	public const ushort G2G_LockReleaseResponse = 1006;

	public const ushort ObjectAddRequest = 1007;

	public const ushort ObjectAddResponse = 1008;

	public const ushort ObjectRemoveRequest = 1009;

	public const ushort ObjectRemoveResponse = 1010;

	public const ushort ObjectLockRequest = 1011;

	public const ushort ObjectLockResponse = 1012;

	public const ushort ObjectUnLockRequest = 1013;

	public const ushort ObjectUnLockResponse = 1014;

	public const ushort ObjectGetRequest = 1015;

	public const ushort ObjectGetResponse = 1016;

	public const ushort R2G_GetLoginKey = 1017;

	public const ushort G2R_GetLoginKey = 1018;

	public const ushort G2M_CreateUnit = 1019;

	public const ushort M2G_CreateUnit = 1020;

	public const ushort G2M_SessionDisconnect = 1021;

	public const ushort BattleFieldSessionDisconnect = 1022;

	public const ushort G2H_CreateUnit = 1023;

	public const ushort H2G_CreateUnit = 1024;

	public const ushort H2G_GetRoomLoginKeyRequest = 1025;

	public const ushort G2H_GetRoomLoginKeyResponse = 1026;

	public const ushort RG2R_CreateUnitRequest = 1027;

	public const ushort R2RG_CreateUnitResponse = 1028;

	public const ushort H2R_LoginRoomRequest = 1029;

	public const ushort R2H_LoginRoomResponse = 1030;

	public const ushort G2B_CreateUnitRequest = 1031;

	public const ushort B2G_CreateUnitResponse = 1032;

	public const ushort BFRoleInfo = 1033;

	public const ushort G2H_CreateUserRequest = 1034;

	public const ushort H2G_CreateUserResponse = 1035;

	public const ushort KickUserRequest = 1036;

	public const ushort KickUserResponse = 1037;

	public const ushort KickRoomUserRequest = 1038;

	public const ushort KickRoomUserResponse = 1039;

	public const ushort KickBattleFieldUserRequest = 1040;

	public const ushort KickBattleFieldUserResponse = 1041;

	public const ushort ReceiveChatClientMessageRequest = 1042;

	public const ushort ReceiveChatClientMessageResponse = 1043;

	public const ushort SendChatServerMessageRequest = 1044;

	public const ushort SendChatServerMessageResponse = 1045;

	public const ushort TeamChatMessageRequest = 1046;

	public const ushort TeamChatMessageResponse = 1047;

	public const ushort InnerTeamChatMessageRequest = 1048;

	public const ushort InnerTeamChatMessageResponse = 1049;

	public const ushort SendGoldenFingerMessage = 1050;

	public const ushort GMSetDataRequest = 1051;

	public const ushort GMSetDataResponse = 1052;

	public const ushort ServerUserNotifyMessage = 1053;

	public const ushort UserMatchRoomDisconnectRequest = 1054;

	public const ushort UserSettingRoomDisconnectRequest = 1055;

	public const ushort UserLeaveStopMatchRequest = 1056;

	public const ushort UpdateTeamRoomStateRequest = 1057;

	public const ushort PbInnerRankTeamInfo = 1058;

	public const ushort H2A_AddSingleRankRequest = 1059;

	public const ushort H2A_AddMultiRankRequest = 1060;

	public const ushort A2H_RankListSettleNotify = 1061;

	public const ushort InnerUpdateSuitboxCopyRankInfoRequest = 1062;

	public const ushort InnerUpdateRaceCopyRankInfoRequest = 1063;

	public const ushort InnerUpdateHeroRankInfoRequest = 1064;

	public const ushort InnerCheckUserBattleFieldInfoRequest = 1065;

	public const ushort InnerCheckUserBattleFieldInfoResponse = 1066;

	public const ushort InnerReloginChangeSessionInfoRequest = 1067;

	public const ushort InnerReloginChangeSessionInfoResponse = 1068;

	public const ushort InnerMultiFightLeaveCopyRequest = 1069;

	public const ushort InnerCheckReloginKeyRequest = 1070;

	public const ushort InnerDisconnectBackToMatchRoomRequest = 1071;

	public const ushort InnerMultiFightLoadRate = 1072;

	public const ushort InnerCheckBattleSettleRequest = 1073;

	public const ushort InnerCheckBattleSettleResponse = 1074;

	public const ushort InnerBattleDissolveMessage = 1075;

	public const ushort InnerGetBattleFieldUserFightInfoRequest = 1076;

	public const ushort InnerGetBattleFieldUserFightInfoResponse = 1077;

	public const ushort InnerBattleFieldSettleRequest = 1078;

	public const ushort InnerBattleFieldUserQuitRequest = 1079;

	public const ushort InnerBattleDataStatisticsRequest = 1080;

	public const ushort InnerMatchSuccessEnterRoomNotify = 1081;

	public const ushort InnerGetTeamRoomInfoRequest = 1082;

	public const ushort InnerGetTeamRoomInfoResponse = 1083;

	public const ushort InnerGetUnionInfoRequest = 1084;

	public const ushort InnerGetUnionInfoResponse = 1085;

	public const ushort InnerCreateUnionRequest = 1086;

	public const ushort InnerCreateUnionResponse = 1087;

	public const ushort InnerGetUnionListRequest = 1088;

	public const ushort InnerGetUnionListResponse = 1089;

	public const ushort InnerUpgradeUnionLevelRequest = 1090;

	public const ushort InnerUpgradeUnionLevelResponse = 1091;

	public const ushort InnerExitUnionRequest = 1092;

	public const ushort InnerExitUnionResponse = 1093;

	public const ushort InnerUpdateUnionUpdateInfoRequest = 1094;

	public const ushort InnerUpdateUnionUpdateInfoResponse = 1095;

	public const ushort InnerKickUnionMemberRequest = 1096;

	public const ushort InnerKickUnionMemberResponse = 1097;

	public const ushort InnerUnionAddMemberRequest = 1098;

	public const ushort InnerUnionAddMemberResponse = 1099;

	public const ushort InnerModifyUnionInfoRequest = 1100;

	public const ushort InnerModifyUnionInfoResponse = 1101;

	public const ushort InnerModifyUnionPositionRequest = 1102;

	public const ushort InnerModifyUnionPositionResponse = 1103;

	public const ushort InnerSearchUnionRequest = 1104;

	public const ushort InnerSearchUnionResponse = 1105;

	public const ushort InnerTransUnionLeaderRequest = 1106;

	public const ushort InnerTransUnionLeaderResponse = 1107;

	public const ushort InnerGetUnionRankListRequest = 1108;

	public const ushort InnerGetUnionRankListResponse = 1109;

	public const ushort InnerUnionCommandMessage = 1110;

	public const ushort InnerQuickJoinRequest = 1111;

	public const ushort InnerQuickJoinResponse = 1112;

	public const ushort InnerUserUnionChangeNotify = 1113;

	public const ushort InnerBattleSendEmoteClientMessageRequest = 1114;

	public const ushort InnerSendUnionApplyToUnionLeadersRequest = 1115;

	public const ushort InnerFriendAddServerNotify = 1116;

	public const ushort InnerFriendAtchievementCheckRequest = 1117;

	public const ushort InnerFriendAtchievementCheckResponse = 1118;

	public const ushort InnerUnionChatRequest = 1119;

	public const ushort InnerUpdateRankUserInfoRequest = 1120;

	public const ushort InnerGetRankListRequest = 1121;

	public const ushort InnerGetRankListResponse = 1122;

	public const ushort InnerBattleChangeBattlePropRequest = 1123;

	public const ushort InnerBattleChangeBattlePropResponse = 1124;

	public const ushort InnerServerAliveCheckRequest = 1125;

	public const ushort InnerServerAliveCheckResponse = 1126;

	public const ushort InnerGoldFingerRequest = 1127;

	public const ushort InnerRegisterServerRequest = 1128;

	public const ushort InnerLoginOutGateRequest = 1129;

	public const ushort InnerLoginOutGateResponse = 1130;

	public const ushort InnerChatCheckRequest = 1131;

	public const ushort InnerChatCheckResponse = 1132;

	public const ushort InnerMultiFightInviteFriendNotify = 1133;

	public const ushort InnerGetSelfHeroRankInfoRequest = 1134;

	public const ushort InnerGetSelfHeroRankInfoResponse = 1135;

	public const ushort InnerSettingRoomToBattleSettleRequest = 1136;

	public const ushort InnerChatMessageNotify = 1137;

	public const ushort GmRefreshRank = 1138;

	public const ushort InnerGetTeamRoomInfo = 1139;

	public const ushort InnerUpdateRedeemCodeInfo = 1140;

	public const ushort InnerUseRedeemCodeRequest = 1141;

	public const ushort InnerUseRedeemCodeResponse = 1142;

	public const ushort InnerSendMailToClusterUserRequest = 1143;

	public const ushort InnerSendMailToClusterUserResponse = 1144;

	public const ushort GmInnerModifyUnionInfoRequest = 1145;

	public const ushort GmInnerModifyUnionInfoResponse = 1146;

	public const ushort InnerRegisterUserPayRequest = 1147;

	public const ushort InnerRegisterUserPayResponse = 1148;

	public const ushort InnerNotifyPayResultRequest = 1149;

	public const ushort InnerLeaveTeamRoomWithEnterNewRoomRequest = 1150;

	public const ushort InnerLeaveTeamRoomWithEnterNewRoomResponse = 1151;
}
