using System.Collections.Generic;
using AIScript.Monster._72001ShuangZiQi;
using TrueSync;

namespace AIScript.LevelAndGroupController.Group;

public class ShuangZiQiGroupController_Lv3 : ShuangZiQiGroupController
{
	private int _BossID_Red = 7010101;

	private int _BossID_Green = 7010107;

	private int _AI_Difficulty = 3;

	private int _Phase = 1;

	private FP _interval = 1;

	private int _energyDelta_1 = 1;

	private int _energyDelta_2 = 1;

	private int _dmgEnergyDelta = 5;

	private int _initSeqIndex;

	protected override int BossID_Red => _BossID_Red;

	protected override int BossID_Green => _BossID_Green;

	protected override int AI_Difficulty => _AI_Difficulty;

	protected override int Phase
	{
		get
		{
			return _Phase;
		}
		set
		{
			_Phase = value;
		}
	}

	protected override FP interval => _interval;

	protected override int energyDelta_1 => _energyDelta_1;

	protected override int energyDelta_2 => _energyDelta_2;

	protected override int dmgEnergyDelta => _dmgEnergyDelta;

	protected override Dictionary<int, GridColor> dicGridColor_1 => Config.dicGridColor_1_2_Common;

	protected override int initSeqIndex => _initSeqIndex;
}
