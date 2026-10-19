namespace Fundamental;

public class LogManager
{
	public const string DamageLog = "DamageLog";

	public static bool DamageEnabled;

	public const string BehaviorTreeLog = "BehaviorTreeLog";

	public static bool BehaviorTreeEnabled;

	public const string AbilityLog = "AbilityLog";

	public static bool AbilityEnabled;

	public const string ServerInfoLog = "ServerInfoLog";

	public static bool ServerInfoEnabled;

	public const string BluePrintLog = "BluePrintLog";

	public static bool BluePrintEnabled;

	public const string MotionLog = "MotionLog";

	public static bool MotionEnabled;

	public const string Motion_WaitLeftLog = "Motion_WaitLeftLog";

	public static bool Motion_WaitLeftEnabled;

	public const string WorldLog = "WorldLog";

	public static bool WorldEnabled;

	public const string World_WorldAssetLog = "World_WorldAssetLog";

	public static bool World_WorldAssetEnabled;

	public const string ObjectPoolLog = "ObjectPoolLog";

	public static bool ObjectPoolEnabled;

	public const string StateObjectLog = "StateObjectLog";

	public static bool StateObjectEnabled;

	public const string StateObject_MonsterPointLog = "StateObject_MonsterPointLog";

	public static bool StateObject_MonsterPointEnabled;

	public const string EventTrackLog = "EventTrackLog";

	public static bool EventTrackEnabled;

	public const string EventTrackDataLog = "EventTrackDataLog";

	public static bool EventTrackDataEnabled;

	public const string SceneManagerLog = "SceneManagerLog";

	public static bool SceneManagerEnabled;

	public const string CodeAnalysisLog = "CodeAnalysisLog";

	public static bool CodeAnalysisEnabled;

	public const string ProtoRecorderLog = "ProtoRecorderLog";

	public static bool ProtoRecorderEnabled;

	public const string DialogLog = "DialogLog";

	public static bool DialogEnabled;

	public const string EnergyLog = "EnergyLog";

	public static bool EnergyEnabled;

	public const string BuffLog = "BuffLog";

	public static bool BuffEnabled;

	public static void SetLogEnabled(string logType, bool enabled)
	{
		switch (logType)
		{
		case "DamageLog":
			DamageEnabled = enabled;
			break;
		case "BehaviorTreeLog":
			BehaviorTreeEnabled = enabled;
			break;
		case "AbilityLog":
			AbilityEnabled = enabled;
			break;
		case "ServerInfoLog":
			ServerInfoEnabled = enabled;
			break;
		case "BluePrintLog":
			BluePrintEnabled = enabled;
			break;
		case "MotionLog":
			MotionEnabled = enabled;
			break;
		case "Motion_WaitLeftLog":
			Motion_WaitLeftEnabled = enabled;
			break;
		case "WorldLog":
			WorldEnabled = enabled;
			break;
		case "World_WorldAssetLog":
			World_WorldAssetEnabled = enabled;
			break;
		case "ObjectPoolLog":
			ObjectPoolEnabled = enabled;
			break;
		case "StateObjectLog":
			StateObjectEnabled = enabled;
			break;
		case "StateObject_MonsterPointLog":
			StateObject_MonsterPointEnabled = enabled;
			break;
		case "EventTrackLog":
			EventTrackEnabled = enabled;
			break;
		case "EventTrackDataLog":
			EventTrackDataEnabled = enabled;
			break;
		case "SceneManagerLog":
			SceneManagerEnabled = enabled;
			break;
		case "CodeAnalysisLog":
			CodeAnalysisEnabled = enabled;
			break;
		case "ProtoRecorderLog":
			ProtoRecorderEnabled = enabled;
			break;
		case "DialogLog":
			DialogEnabled = enabled;
			break;
		case "EnergyLog":
			EnergyEnabled = enabled;
			break;
		case "BuffLog":
			BuffEnabled = enabled;
			break;
		}
	}

	public static bool IsLogEnabled(string logType)
	{
		return logType switch
		{
			"DamageLog" => DamageEnabled, 
			"BehaviorTreeLog" => BehaviorTreeEnabled, 
			"AbilityLog" => AbilityEnabled, 
			"ServerInfoLog" => ServerInfoEnabled, 
			"BluePrintLog" => BluePrintEnabled, 
			"MotionLog" => MotionEnabled, 
			"Motion_WaitLeftLog" => Motion_WaitLeftEnabled, 
			"WorldLog" => WorldEnabled, 
			"World_WorldAssetLog" => World_WorldAssetEnabled, 
			"ObjectPoolLog" => ObjectPoolEnabled, 
			"StateObjectLog" => StateObjectEnabled, 
			"StateObject_MonsterPointLog" => StateObject_MonsterPointEnabled, 
			"EventTrackLog" => EventTrackEnabled, 
			"EventTrackDataLog" => EventTrackDataEnabled, 
			"SceneManagerLog" => SceneManagerEnabled, 
			"CodeAnalysisLog" => CodeAnalysisEnabled, 
			"ProtoRecorderLog" => ProtoRecorderEnabled, 
			"DialogLog" => DialogEnabled, 
			"EnergyLog" => EnergyEnabled, 
			"BuffLog" => BuffEnabled, 
			_ => true, 
		};
	}
}
