namespace AIScript.LevelAndGroupController.Group;

public class JiJuXieGroupController_Lv4 : JiJuXieGroupController
{
	private int _BossID = 31301;

	private int _AI_Difficulty = 4;

	private int _Phase = 1;

	protected override int BossID => _BossID;

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
}
