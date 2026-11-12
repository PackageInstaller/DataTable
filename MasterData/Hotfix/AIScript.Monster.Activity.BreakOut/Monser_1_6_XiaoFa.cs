using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Activity.BreakOut;

public class Monser_1_6_XiaoFa : SkillSimpleBase
{
	private int startKeyIndex1 = 1;

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private TSVector2 targetPosition1;

	private TSVector2 targetPosition2;

	private string tag1 = "Monster1";

	private string tag2 = "Monster2";

	private string tag3 = "Monster3";

	private string Tag4 = "Monster4";

	private string Point1 = "MoveTo1";

	private string Point2 = "MoveTo2";

	private string Point3 = "MoveTo3";

	private string Point4 = "MoveTo4";

	private string Point5 = "MoveTo5";

	private string Point6 = "MoveTo6";

	private string Point7 = "MoveTo7";

	private string Point8 = "MoveTo8";

	private List<string> Points;

	private int time = 10000;

	protected void OSkillEnable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1f);
		string monsterTagValue = GetMonsterTagValue(_actor, 1);
		if (monsterTagValue == Tag4)
		{
			Points = new List<string> { Point8, Point1, Point2, Point3, Point4, Point5, Point6, Point7 };
		}
		else if (monsterTagValue == tag1)
		{
			Points = new List<string> { Point2, Point3, Point4, Point5, Point6, Point7, Point8, Point1 };
		}
		else if (monsterTagValue == tag2)
		{
			Points = new List<string> { Point4, Point5, Point6, Point7, Point8, Point1, Point2, Point3 };
		}
		else if (monsterTagValue == tag3)
		{
			Points = new List<string> { Point6, Point7, Point8, Point1, Point2, Point3, Point4, Point5 };
		}
		int i = 0;
		while (time > 0)
		{
			for (; i < Points.Count; i++)
			{
				MoveToPosition(GetPlaceHolderPosition(Points.get_Item(i)), 0.1, AdventureActor.MovementMode.Run, 3);
				yield return WaitMoveStatus();
			}
			yield return WaitTime(0.5);
			i = 0;
			time--;
		}
		yield return WaitTime(99999);
	}
}
