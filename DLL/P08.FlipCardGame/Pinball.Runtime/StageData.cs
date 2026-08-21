using System.Collections.Generic;
using UnityEngine;

namespace Pinball.Runtime;

public class StageData : ScriptableObject
{
	private const float OVERFLOWDAMAGETRANSFAC = 0.5f;

	private const float DEBATESTAGEDAMAGETRIGGER = 0.5f;

	private const int SUPPLEMENTTRIGGERNUMBER = 2;

	private const int SUPPLEMENTMAXNUMBER = 5;

	private const int BASEOVERTIMES = 3;

	private const int BASESPARETIMES = 5;

	private const int BASEREMAINHP = 1;

	private const int BASEEXPLOSIONLENGTH = 3;

	private const int BASEEXITPORTALCD = 3;

	private const int BASEHIGHVALUEWORDVALUE = 3;

	public List<PolygonBlockData> polygonBlocks = new List<PolygonBlockData>();

	public List<RandomPolygon> excludePolygonBlocks = new List<RandomPolygon>
	{
		new RandomPolygon(PolygonType.skillBlock)
	};

	public int stageId;

	public int resBlockNum;

	public bool isDebateStage;

	public bool isBossStage;

	public bool hasDebateStage;

	public StageData debateStageData;

	public float debateStageDamageTrigger = 0.5f;

	public float overflowDamageTransFac = 0.5f;

	public int baseOverTimes = 3;

	public int baseSpareTimes = 5;

	public int baseHighValueWordValue = 3;

	public int baseremainHp = 1;

	public int baseExplosionLength = 3;

	public int baseExitPortalCD = 3;

	public int debateRoundLimit;

	public int debateFinishCount;

	public int supplementTriggerNumber = 2;

	public int supplementMaxNumber = 5;

	public string debateDescription = "默认辩论描述文本";

	public string debateSuccessDesc = "默认辩论描述文本";

	public int[] bubbleIDList;
}
