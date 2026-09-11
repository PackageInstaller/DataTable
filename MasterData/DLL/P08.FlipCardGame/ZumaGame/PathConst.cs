using System.Runtime.InteropServices;

namespace ZumaGame;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct PathConst
{
	public static string ediotrScenePath = "Packages/com.ys4fun.p08.filp_card_game/Runtime/ZumaGame/Res/ZumaMapEditor.unity";

	public static string mapDataPath = "Assets/ComBattle/ABResources/Map/ZumaMap";

	public static string mapImgPath = "TextureConfig/VersionUI/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/";
}
