using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10007KuangFengQingXiao;

public class Skill5_Teleport : SkillSimpleBase
{
	private readonly FP _rotateSpeed = 180;

	private readonly FP _duration = 0.8;

	private readonly FP _waitSeconds = 0;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private TSVector2 Shootdir;

	private readonly string Point1 = "MoveTo1";

	private readonly string Point2 = "MoveTo2";

	private readonly string Point3 = "MoveTo3";

	private readonly string Point4 = "MoveTo4";

	private readonly string Point5 = "MoveTo5";

	private readonly FP _minDistance = 5;

	private TSVector2 targetPoint;

	protected override IEnumerator DoMainLogic()
	{
		List<LogicEntity> b = GetTargetsByLogicTag(LogicTagType._Bool, "isEnvelope", null, value1: true);
		int friendcount = b.Count;
		yield return WaitTime(0.1);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCustomEvent("TP_Start");
		HideSelf();
		TSVector2 position = GetPosition();
		List<(string, TSVector2, FP)> list = new List<(string, TSVector2, FP)>
		{
			(Point1, GetPlaceHolderPosition(Point1), Distance(position, GetPlaceHolderPosition(Point1))),
			(Point2, GetPlaceHolderPosition(Point2), Distance(position, GetPlaceHolderPosition(Point2))),
			(Point3, GetPlaceHolderPosition(Point3), Distance(position, GetPlaceHolderPosition(Point3))),
			(Point4, GetPlaceHolderPosition(Point4), Distance(position, GetPlaceHolderPosition(Point4))),
			(Point5, GetPlaceHolderPosition(Point5), Distance(position, GetPlaceHolderPosition(Point5)))
		};
		List<(string, TSVector2, FP)> list2 = new List<(string, TSVector2, FP)>();
		foreach (var item in list)
		{
			if (item.Item3 >= _minDistance)
			{
				list2.Add(item);
			}
		}
		if (list2.Count > 0)
		{
			int index = TSRandom.Range(0, list2.Count);
			targetPoint = list2.get_Item(index).Item2;
		}
		else
		{
			(string, TSVector2, FP) tuple = list.get_Item(0);
			for (int i = 1; i < list.Count; i++)
			{
				if (list.get_Item(i).Item3 > tuple.Item3)
				{
					tuple = list.get_Item(i);
				}
			}
			targetPoint = tuple.Item2;
		}
		if (friendcount > 0)
		{
			LogicEntity targetNearOrFar = GetTargetNearOrFar(iNear: false, b);
			targetPoint = GetEntityPosition(targetNearOrFar);
		}
		yield return WaitTime(0.2);
		CancelAttack();
		Teleport(targetPoint);
		yield return WaitTime(0.1);
		ShowSelf();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
