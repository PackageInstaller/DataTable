using System.Collections.Generic;
using AIScript.Monster.Template;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai;

public class Parallel_1 : Parallel
{
	public static readonly FP[] waitTimes = new FP[4] { 0, 0, 0, 3 };

	public static readonly FP waitTime_Normal = 3.5;

	public static List<long> dicWai = new List<long>();

	public static List<long> dicNei = new List<long>();

	public static long pointAreaId;

	public static bool toPos;

	public static TSVector2 targetPos;

	public static bool toRot;

	public static bool safemove;

	public override void OnStart()
	{
		base.OnStart();
	}

	protected override void OnInitState()
	{
		base.OnInitState();
		EnterState(1);
	}

	public override void OnDisable()
	{
		safemove = false;
		toPos = false;
		toRot = false;
		pointAreaId = 0L;
		dicWai?.Clear();
		dicNei?.Clear();
		base.OnDisable();
	}
}
