using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17001ChangFuWeiBing;

public class TurnWhenSneak : SkillSimpleBase
{
	private readonly string SearchShapeFX = "FX/Warning/fx_warning_fan_45c_10r";

	private readonly string CallEmojiFX1 = "Actor/Monster/17001ChangFuWeiBing/FX/fx_m17001_loop_QiEBaoXiang_Call";

	private readonly string FindingEmojiFX1 = "Actor/Monster/17001ChangFuWeiBing/FX/fx_m17001_loop_QiEBaoXiang_Idle";

	private readonly string CallEmojiFX2 = "Actor/Monster/18001LiMingShuangDao/FX/fx_m18001_loop_QiEBaoXiang_Call";

	private readonly string FindingEmojiFX2 = "Actor/Monster/18001LiMingShuangDao/FX/fx_m18001_loop_QiEBaoXiang_Idle";

	private readonly FP SearchTime = 4;

	private FP TurnAngle;

	private string CallEmojiFX;

	private string FindingEmojiFX;

	private bool FindSuccess;

	private bool Searching;

	private long SearchShapeFXID;

	private long CallEmojiFXID;

	private long FindingEmojiFXID;

	private List<LogicEntity> Enemylist;

	private List<LogicEntity> FriendList;

	private List<LogicEntity> EntityFoundList;

	private CoroutineNode TurnMoveCorNode;

	protected override void OnSkillEnable()
	{
		TurnAngle = 0;
		FindSuccess = false;
		Searching = true;
		Enemylist = new List<LogicEntity>();
		EntityFoundList = new List<LogicEntity>();
		FriendList = new List<LogicEntity>();
		if (GetMonsterTagValue(_actor, 2) == "Normal")
		{
			CallEmojiFX = CallEmojiFX1;
			FindingEmojiFX = FindingEmojiFX1;
		}
		else if (GetMonsterTagValue(_actor, 2) == "Elite")
		{
			CallEmojiFX = CallEmojiFX2;
			FindingEmojiFX = FindingEmojiFX2;
		}
	}

	protected override void OnSkillDisable()
	{
		StopEffect(SearchShapeFXID);
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable(autoDisableWhenSkillDisable: false);
		if (GetMonsterTagValue(_actor, 1) == "Left")
		{
			TurnAngle = 90;
		}
		else if (GetMonsterTagValue(_actor, 1) == "Right")
		{
			TurnAngle = -90;
		}
		StartCor(ref TurnMoveCorNode, TurnLoop(TurnAngle));
		yield return StartCor(FindEnemy());
		AddBuffToTarget(_actor, 999002120);
		CallEmojiFXID = PlayEffect(CallEmojiFX, 1f, 2, GetPosition(), GetRotation(), 0.3f);
		StopCor(TurnMoveCorNode);
		yield return WaitTime(1);
		InterruptBattleOut();
	}

	private IEnumerator TurnLoop(FP angle)
	{
		while (true)
		{
			TurnWhenSneak turnWhenSneak = this;
			TurnWhenSneak turnWhenSneak2 = this;
			string searchShapeFX = SearchShapeFX;
			float duration = (float)SearchTime;
			TSVector2 position = GetPosition();
			FP rotation = GetRotation();
			turnWhenSneak.SearchShapeFXID = turnWhenSneak2.PlayEarlyWarningEffect(searchShapeFX, duration, default, position, rotation, 0.7f);
			FindingEmojiFXID = PlayEffect(FindingEmojiFX, 1f, 2, GetPosition(), GetRotation(), 0.3f);
			yield return WaitTime(SearchTime);
			StopEffect(SearchShapeFXID);
			StopEffect(FindingEmojiFXID);
			BeginLookAtByDir(RotateTo(GetForward(), angle), 1, 90);
			Searching = false;
			angle = -angle;
			yield return WaitTime(1);
			Searching = true;
		}
	}

	private IEnumerator FindEnemy()
	{
		while (!FindSuccess && !GetLogicTagToggleValue(_actor, "FriendSearchSuccess"))
		{
			if (Searching)
			{
				TurnWhenSneak turnWhenSneak = this;
				TSVector2 position = GetPosition();
				FP radius = 6.3;
				FP innerRadius = 0;
				FP angle = 45;
				FP rotation = GetRotation();
				DeterministicShape shapeData = turnWhenSneak.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
				EntityFoundList.AddRange(GetTargetsByFaction(isFriend: false));
				Enemylist.AddRange(GetTargetsFromShape(shapeData, EntityFoundList));
				if (Enemylist.Count > 0)
				{
					EntityFoundList.Clear();
					EntityFoundList.AddRange(GetTargetsByFaction(isFriend: true));
					FindSuccess = true;
					TurnWhenSneak turnWhenSneak2 = this;
					TSVector2 position2 = GetPosition();
					rotation = 10;
					angle = 0;
					innerRadius = GetRotation();
					DeterministicShape shapeData2 = turnWhenSneak2.GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, rotation, angle, default, innerRadius);
					FriendList.AddRange(GetTargetsFromShape(shapeData2, EntityFoundList));
					foreach (LogicEntity friend in FriendList)
					{
						SetLogicTagToggleValue(friend, "FriendSearchSuccess", value: true);
					}
				}
				EntityFoundList.Clear();
			}
			yield return WaitTime(0.2);
		}
		StopEffect(FindingEmojiFXID);
		StopEffect(SearchShapeFXID);
	}
}
