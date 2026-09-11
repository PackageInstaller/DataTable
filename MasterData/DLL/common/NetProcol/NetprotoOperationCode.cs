using Google.Protobuf.Reflection;

namespace NetProcol;

public enum NetprotoOperationCode
{
	[OriginalName("None")]
	None = 0,
	[OriginalName("ping")]
	Ping = 100,
	[OriginalName("pong")]
	Pong = 101,
	[OriginalName("B2G_ConnectRequest")]
	B2GConnectRequest = 102,
	[OriginalName("G2B_ConnectResponse")]
	G2BConnectResponse = 103,
	[OriginalName("G2B_start_battle")]
	G2BStartBattle = 104,
	[OriginalName("B2G_ack_start_battle")]
	B2GAckStartBattle = 105,
	[OriginalName("B2G_BattleResult")]
	B2GBattleResult = 106,
	[OriginalName("G2B_Ack_BattleResult")]
	G2BAckBattleResult = 107,
	[OriginalName("G2B_end_battle")]
	G2BEndBattle = 108,
	[OriginalName("CMD_move_dir")]
	CmdMoveDir = 109,
	[OriginalName("CMD_stop_move_dir")]
	CmdStopMoveDir = 110,
	[OriginalName("CMD_melee_attack")]
	CmdMeleeAttack = 111,
	[OriginalName("CMD_change_role")]
	CmdChangeRole = 112,
	[OriginalName("CMD_game_stop")]
	CmdGameStop = 113,
	[OriginalName("CMD_modify_trigger_state")]
	CmdModifyTriggerState = 114,
	[OriginalName("CMD_AI_Command")]
	CmdAiCommand = 115,
	[OriginalName("CMD_EnterSourceCode")]
	CmdEnterSourceCode = 116,
	[OriginalName("CMD_AbilityDirection")]
	CmdAbilityDirection = 117,
	[OriginalName("CMD_Choose_Target")]
	CmdChooseTarget = 118,
	[OriginalName("CMD_Throw_Item")]
	CmdThrowItem = 119,
	[OriginalName("CMD_Sub_Joystick")]
	CmdSubJoystick = 120,
	[OriginalName("CMD_Story")]
	CmdStory = 121,
	[OriginalName("CMD_Resurrect")]
	CmdResurrect = 122,
	[OriginalName("C2B_Unit_Frame")]
	C2BUnitFrame = 123,
	[OriginalName("B2C_Server_Frame")]
	B2CServerFrame = 124,
	[OriginalName("B2C_start_match")]
	B2CStartMatch = 125,
	[OriginalName("C2B_join_room")]
	C2BJoinRoom = 126,
	[OriginalName("B2C_ack_join_room")]
	B2CAckJoinRoom = 127,
	[OriginalName("C2B_fetch_team_info")]
	C2BFetchTeamInfo = 128,
	[OriginalName("B2C_ack_fetch_team_info")]
	B2CAckFetchTeamInfo = 129,
	[OriginalName("C2B_PlayerReady")]
	C2BPlayerReady = 130,
	[OriginalName("B2C_ack_PlayerReady")]
	B2CAckPlayerReady = 131,
	[OriginalName("C2B_BattleResult")]
	C2BBattleResult = 132,
	[OriginalName("B2C_ErrorCode")]
	B2CErrorCode = 133,
	[OriginalName("B2C_Ack_BattleResult")]
	B2CAckBattleResult = 134,
	[OriginalName("B2C_Ack_BattleGSResult")]
	B2CAckBattleGsresult = 135,
	[OriginalName("B2C_BattleFrames")]
	B2CBattleFrames = 136,
	[OriginalName("C2B_BattleResultOnline")]
	C2BBattleResultOnline = 137,
	[OriginalName("B2G_BattleResultOnline")]
	B2GBattleResultOnline = 138,
	[OriginalName("CMD_EnemyAlert")]
	CmdEnemyAlert = 139,
	[OriginalName("CMD_trigger_parameters")]
	CmdTriggerParameters = 140,
	[OriginalName("CMD_move_to_pos")]
	CmdMoveToPos = 141,
	[OriginalName("CMD_ButtonShoot")]
	CmdButtonShoot = 142,
	[OriginalName("CMD_signal_exchange")]
	CmdSignalExchange = 143,
	[OriginalName("CMD_OnlineReady")]
	CmdOnlineReady = 144,
	[OriginalName("B2C_Player_Offline")]
	B2CPlayerOffline = 145,
	[OriginalName("CMD_Player_Offline")]
	CmdPlayerOffline = 146,
	[OriginalName("CMD_QTE")]
	CmdQte = 147,
	[OriginalName("CMD_LockListEmeny")]
	CmdLockListEmeny = 148
}
