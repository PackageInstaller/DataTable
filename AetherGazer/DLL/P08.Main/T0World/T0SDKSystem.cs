namespace T0World;

public class T0SDKSystem
{
	public static void SendSDKData(T0WorldInteractionBehavior behaviour, T0SDKData data)
	{
		int characterID = 0;
		if (behaviour.mAgent is T0CharacterAgent t0CharacterAgent)
		{
			characterID = t0CharacterAgent.CharacterBoard.characterID;
		}
		data.characterID = characterID;
		LuaHelper.CallFunction("RecordT0SDK", data);
	}

	public static void SendSDKData(T0WorldConst.SDKInterationTypeEnum sdkType)
	{
		T0SDKData t0SDKData = new T0SDKData();
		t0SDKData.sdkType = (int)sdkType;
		LuaHelper.CallFunction("RecordT0SDK", t0SDKData);
	}

	public static void SendSDKData(T0SDKData data)
	{
		LuaHelper.CallFunction("RecordT0SDK", data);
	}
}
