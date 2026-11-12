using TrueSync;

namespace AIScript.LevelAndGroupController.Group;

public class ShuangZiQiGroupController_P3_Lv4 : ShuangZiQiGroupController_P3
{
	private int _BossID_Red = 7010113;

	private int _BossID_Green = 7010114;

	private int _AI_Difficulty = 4;

	private int _Phase = 3;

	private FP _interval = 1;

	private int _energyDelta = 1;

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

	protected override int EnergyDelta => _energyDelta;

	protected override int dmgEnergyDelta => _dmgEnergyDelta;

	protected override int initSeqIndex => _initSeqIndex;
}
