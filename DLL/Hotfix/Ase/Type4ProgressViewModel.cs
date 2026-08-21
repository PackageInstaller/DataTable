using System.Collections.Generic;

namespace Ase;

public class Type4ProgressViewModel : OptionBase
{
	private int curIndex;

	private bool isAllComplete;

	private bool isWin;

	private List<int> curStarState;

	private bool nextChallenge;

	private CopyItemViewModel copyItem1;

	private CopyItemViewModel copyItem2;

	private int curCopyId1;

	private int curCopyId2;

	public int CurIndex => curIndex;

	public List<int> CurStarState => curStarState;

	public bool IsAllComplete => isAllComplete;

	public CopyItemViewModel CopyItem1 => copyItem1;

	public CopyItemViewModel CopyItem2 => copyItem2;

	public bool NextChallenge => nextChallenge;

	public bool IsWin => isWin;

	public override void ItemOnClick(object obj)
	{
		_ = obj is CopyItemViewModel;
	}

	public Type4ProgressViewModel()
	{
	}

	public Type4ProgressViewModel(OptionBase parent, CopyData curCopy, List<CopyData> copyDatas, bool isWin)
	{
		base.parent = parent;
		curStarState = new List<int>();
		if (curCopy.IsAccessed)
		{
			CopyData copyData = null;
			CopyData copyData2 = null;
			if (copyDatas.Count >= 1)
			{
				copyData = copyDatas[copyDatas.Count - 1];
			}
			if (copyDatas.Count >= 2)
			{
				copyData2 = copyDatas[copyDatas.Count - 2];
			}
			if (copyData == null || copyData2 == null)
			{
				isAllComplete = true;
			}
			else if (copyData == curCopy)
			{
				if (copyData.CopyRank != copyData2.CopyRank)
				{
					isAllComplete = true;
				}
				else if (copyData.CopyRank == copyData2.CopyRank)
				{
					isAllComplete = copyData.IsAccessed && copyData2.IsAccessed;
				}
			}
			else if (copyData2 == curCopy && copyData.CopyRank == copyData2.CopyRank)
			{
				isAllComplete = copyData.IsAccessed && copyData2.IsAccessed;
			}
		}
		if (copyDatas != null)
		{
			for (int i = 0; i < copyDatas.Count; i++)
			{
				if (copyDatas[i].Id == curCopy.Id)
				{
					curIndex = i;
				}
				curStarState.Add((copyDatas[i].StarMax != 0) ? ((copyDatas[i].StarMax != copyDatas[i].StarConfigMax) ? 1 : 2) : 0);
			}
		}
		this.isWin = isWin;
		if (isAllComplete || !isWin)
		{
			return;
		}
		for (int j = 0; j < copyDatas.Count; j++)
		{
			if (j != curIndex && !copyDatas[j].IsAccessed && copyDatas[curIndex].CopyRank == copyDatas[j].CopyRank)
			{
				nextChallenge = true;
				copyItem1 = new CopyItemViewModel(this, curCopy);
				copyItem1.SetSelect(isSelect: true);
				copyItem1.SetQuality(1);
				copyItem1.SetBossName();
				copyItem2 = new CopyItemViewModel(this, copyDatas[j]);
				copyItem2.SetSelect(isSelect: false);
				copyItem2.SetQuality(1);
				copyItem2.SetBossName();
			}
		}
		if (nextChallenge)
		{
			return;
		}
		for (int k = 0; k < copyDatas.Count; k++)
		{
			if (k != curIndex && copyDatas[curIndex].Id < copyDatas[k].Id && copyDatas[curIndex].CopyRank + 1 == copyDatas[k].CopyRank)
			{
				if (copyItem1 == null)
				{
					copyItem1 = new CopyItemViewModel(this, copyDatas[k]);
					copyItem1.SetBossName();
				}
				else if (copyItem2 == null)
				{
					copyItem2 = new CopyItemViewModel(this, copyDatas[k]);
					copyItem2.SetBossName();
					break;
				}
			}
		}
		int num = 0;
		int num2 = 0;
		for (int l = 0; l < copyDatas.Count; l++)
		{
			if (num != 0 && num2 != 0)
			{
				break;
			}
			if (copyDatas[l].IsAccessed && copyDatas[curIndex].CopyRank == copyDatas[l].CopyRank)
			{
				if (num == 0)
				{
					num = copyDatas[l].Id;
				}
				else
				{
					num2 = copyDatas[l].Id;
				}
			}
		}
		if (num2 == 0 || num == num2)
		{
			curCopyId1 = num;
			return;
		}
		curCopyId1 = ((num < num2) ? num : num2);
		curCopyId2 = ((num > num2) ? num : num2);
	}

	public int GetCurId(int index)
	{
		if (index == 1)
		{
			return curCopyId1;
		}
		return curCopyId2;
	}

	public OptionArg GetNextCopyData()
	{
		if (nextChallenge)
		{
			if (copyItem2 != null)
			{
				return new OptionArg(copyItem2.Data, "EnterNextBattle");
			}
		}
		else if (copyItem1 != null)
		{
			List<CopyData> list = new List<CopyData>();
			list.Add(copyItem1.Data);
			if (copyItem2 != null)
			{
				list.Add(copyItem2.Data);
			}
			return new OptionArg(list, "ReturnNextCopy");
		}
		return null;
	}
}
