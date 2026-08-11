namespace Ase;

public static class OuterMessage
{
	public const ushort PbAttributeBase = 5001;

	public const ushort PbEntryBase = 5002;

	public const ushort PbEquipBase = 5003;

	public const ushort PbMapData = 5004;

	public const ushort C2G_EnterMap = 5005;

	public const ushort G2C_EnterMap = 5006;

	public const ushort UnitInfo = 5007;

	public const ushort M2C_CreateUnits = 5008;

	public const ushort Frame_ClickMap = 5009;

	public const ushort M2C_PathfindingResult = 5010;

	public const ushort C2R_Ping = 5011;

	public const ushort R2C_Ping = 5012;

	public const ushort G2C_Test = 5013;

	public const ushort C2M_Reload = 5014;

	public const ushort M2C_Reload = 5015;

	public const ushort C2S_HeartBeat = 5016;

	public const ushort S2C_HeartBeat = 5017;

	public const ushort S2C_ServerCloseNotify = 5018;

	public const ushort ActorResponse = 5019;
}
