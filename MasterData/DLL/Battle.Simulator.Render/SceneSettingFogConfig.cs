using UnityEngine;

public class SceneSettingFogConfig : MonoBehaviour
{
	public float EnterTime = 0.3f;

	public float ExitTime = 0.3f;

	public Color ColorOfMonster = Color.yellow;

	public Color ColorOfPlayer1 = Color.magenta;

	public Color ColorOfPlayer2 = Color.magenta;

	public Color ColorOfPlayer3 = Color.magenta;

	public Color ColorOfUltimateAvoid = Color.magenta;

	public Color ColorOfSourceSpace = Color.green;

	[ColorUsage(false, true)]
	public Color TintColorOfUltimateAvoid = Color.magenta;

	[ColorUsage(false, true)]
	public Color TintColorOfSourceSpace = Color.green;

	public Color GetColorOfMemberPosition(EnMemberPositionOfFog enMemberPositionOfFog, Color color)
	{
		switch (enMemberPositionOfFog)
		{
		case EnMemberPositionOfFog.Monster:
		case EnMemberPositionOfFog.Player:
		case EnMemberPositionOfFog.First:
		case EnMemberPositionOfFog.Second:
		case EnMemberPositionOfFog.Third:
			return color;
		case EnMemberPositionOfFog.UltimateAvoid:
			return ColorOfUltimateAvoid;
		case EnMemberPositionOfFog.SourceSpace:
			return ColorOfSourceSpace;
		default:
			return Color.green;
		}
	}

	public Color GetTinitColorOfMemberPosition(EnMemberPositionOfFog enMemberPositionOfFog, Color color)
	{
		switch (enMemberPositionOfFog)
		{
		case EnMemberPositionOfFog.Monster:
		case EnMemberPositionOfFog.Player:
		case EnMemberPositionOfFog.First:
		case EnMemberPositionOfFog.Second:
		case EnMemberPositionOfFog.Third:
			return color;
		case EnMemberPositionOfFog.UltimateAvoid:
			return TintColorOfUltimateAvoid;
		case EnMemberPositionOfFog.SourceSpace:
			return TintColorOfSourceSpace;
		default:
			return Color.green;
		}
	}
}
