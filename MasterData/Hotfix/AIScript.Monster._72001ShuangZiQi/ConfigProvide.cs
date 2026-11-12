using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class ConfigProvide
{
	private static ConfigProvide instance;

	private int phase;

	private int lv;

	public static ConfigProvide Inst
	{
		get
		{
			if (instance == null)
			{
				instance = new ConfigProvide();
			}
			return instance;
		}
		set
		{
			instance = value;
		}
	}

	public int buffId_red => Config.buffId_red.get_Item(lv).get_Item(phase - 1);

	public int buffId_green => Config.buffId_green.get_Item(lv).get_Item(phase - 1);

	public int buffMaxCount => Config.buffMaxCount.get_Item(lv).get_Item(phase - 1);

	public FP interval => Config.interval.get_Item(lv).get_Item(phase - 1);

	public void SetPhase(int phase)
	{
		this.phase = phase;
	}

	public void SetLv(int lv)
	{
		this.lv = lv;
	}
}
