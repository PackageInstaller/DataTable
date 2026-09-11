using UnityEngine;
using UnityEngine.Playables;

public abstract class QTEUINode : PlayableAsset
{
	public string path;

	public string parent = "UICamera/Canvas/UIMain";

	public QTEUIAnchor uiAnchor;

	[Tooltip("单击QTE: UI整体的位置\n滑动QTE: UI整体的位置\n长按QTE: 进度条的位置\n连点QTE: 进度条的位置")]
	public Vector2 uiPos = Vector2.zero;

	public abstract QTEConditionType conditionType { get; }

	public static bool VerifyCompare(int left, int right, ECompareType compareType)
	{
		return compareType switch
		{
			ECompareType.Equal => left == right, 
			ECompareType.Greater => left > right, 
			ECompareType.GreaterAndEqual => left >= right, 
			ECompareType.Less => left < right, 
			ECompareType.LessAndEqual => left <= right, 
			_ => false, 
		};
	}

	public static bool VerifyCompare(float left, float right, ECompareType compareType)
	{
		return compareType switch
		{
			ECompareType.Equal => left == right, 
			ECompareType.Greater => left > right, 
			ECompareType.GreaterAndEqual => left >= right, 
			ECompareType.Less => left < right, 
			ECompareType.LessAndEqual => left <= right, 
			_ => false, 
		};
	}
}
