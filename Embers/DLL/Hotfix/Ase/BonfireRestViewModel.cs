using System.Collections.Generic;

namespace Ase;

public class BonfireRestViewModel : OptionBase
{
	private bool readyClose;

	private int selectIndex;

	private List<PeripheryHeroData> heroConfigIdList;

	public int SelectIndex => selectIndex;

	public bool ReadyClose
	{
		get
		{
			return readyClose;
		}
		set
		{
			Set(ref readyClose, value, "ReadyClose");
		}
	}

	public List<PeripheryHeroData> HeroConfigIdList => heroConfigIdList;

	public BonfireRestViewModel()
	{
	}

	public BonfireRestViewModel(int selectIndex, List<PeripheryHeroData> heroConfigIdList = null)
	{
		this.selectIndex = selectIndex;
		this.heroConfigIdList = heroConfigIdList;
	}

	public void Ready2Close()
	{
		ReadyClose = true;
	}
}
