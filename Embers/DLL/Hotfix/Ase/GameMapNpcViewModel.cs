using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GameMapNpcViewModel : OptionBase
{
	private List<TabItemNormalData> npcDataList;

	private TabItemNormalData curNpc;

	private string name;

	private string desc;

	private string imgPath;

	private InteractionRequest refreshRequest;

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public string ImgPath
	{
		get
		{
			return imgPath;
		}
		private set
		{
			Set(ref imgPath, value, "ImgPath");
		}
	}

	public TabItemNormalData CurNpc => curNpc;

	public List<TabItemNormalData> NpcDataList => npcDataList;

	public InteractionRequest RefreshRequest => refreshRequest;

	public GameMapNpcViewModel(OptionBase parent, int id, List<TabItemNormalData> npcDataList, string mapImgPath)
	{
		base.parent = parent;
		imgPath = mapImgPath;
		refreshRequest = new InteractionRequest();
		this.npcDataList = new List<TabItemNormalData>();
		foreach (TabItemNormalData npcData in npcDataList)
		{
			TabItemNormalData item = new TabItemNormalData(this, npcData.Img, npcData.ID, isSelected: false, npcData.Text)
			{
				RedPoint = npcData.RedPoint
			};
			this.npcDataList.Add(item);
		}
		for (int i = 0; i < this.npcDataList.Count; i++)
		{
			if (npcDataList[i].ID == id)
			{
				NPCOnClick(this.npcDataList[i]);
			}
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemNormalData npcData)
		{
			NPCOnClick(npcData);
			refreshRequest.Raise();
		}
	}

	private void NPCOnClick(TabItemNormalData npcData)
	{
		curNpc?.SetSelected(value: false);
		curNpc = npcData;
		curNpc.SetSelected(value: true);
		ClearRedPoint();
		curNpc.RedPoint = false;
		DRNPCNote dataRow = GameEntry.DataTable.GetDataRow((DRNPCNote p) => p.NpcId == npcData.ID);
		Name = dataRow.Name;
		Desc = dataRow.Desc;
		parent?.ItemOnClick(this);
	}

	private void ClearRedPoint()
	{
		Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().SaveRedPoint(6, curNpc.ID);
	}
}
