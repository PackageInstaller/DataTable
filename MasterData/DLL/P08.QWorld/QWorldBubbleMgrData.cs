using UnityEngine;

public class QWorldBubbleMgrData : QWorldEntityData<QWorldTalkBubbleMgr>
{
	public enum BubbleHostType
	{
		[InspectorName("用于一组NPC")]
		FromNpcList,
		[InspectorName("用于氛围人群")]
		FromPassivePeopleGroup
	}

	internal enum BubbleFunc
	{
		[InspectorName("顺序")]
		Sequential,
		[InspectorName("循环")]
		Cycle,
		[InspectorName("随机")]
		Random
	}

	public string bubblePrefab;

	[Range(0f, 12f)]
	public float displayBubbleRange;

	public float restartInterval;

	public BubbleHostType bubbleHostType;

	public int cfgID;

	[SerializeField]
	internal BubbleFunc getBubbleContentFunc;

	public int limit => 1;
}
