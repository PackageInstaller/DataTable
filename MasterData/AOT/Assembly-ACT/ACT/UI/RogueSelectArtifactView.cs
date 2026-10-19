using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace ACT.UI;

public class RogueSelectArtifactView : BaseUIView
{
	private RogueSelectArtifactViewData m_data;

	public List<RogueArtfactSelectItem> _rogueArtfactSelectItem = new List<RogueArtfactSelectItem>();

	private RogueArtifactCard CurrentSelectArtifact;

	private List<RogueArtifactCard> _rogueArtifactslist = new List<RogueArtifactCard>();

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		GetRogueArtifactList();
	}

	protected override void Init()
	{
		base.Init();
		SetRogueArtifacts();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	public void GetRogueArtifactList()
	{
		_rogueArtifactslist.Clear();
		Dictionary<int, RogueArtifact> dictionary = new Dictionary<int, RogueArtifact>(RuntimeConfigs.data.rogueArtifacts);
		foreach (KeyValuePair<int, RogueArtifactCard> rogueArtifact in Model<RoGueModel>.Interface._RogueArtifacts)
		{
			dictionary.Remove(rogueArtifact.Key);
		}
		List<RogueArtifact> list = dictionary.ValuesToList();
		List<RogueArtifact> randomElements = Model<RoGueModel>.Interface.GetRandomElements(list, 3);
		for (int i = 0; i < randomElements.Count; i++)
		{
			_rogueArtifactslist.Add(new RogueArtifactCard(randomElements[i].id));
		}
	}

	public void SetRogueArtifacts()
	{
		for (int i = 0; i < _rogueArtfactSelectItem.Count; i++)
		{
			_rogueArtfactSelectItem[i].gameObject.SetActive(_rogueArtifactslist.Count - 1 >= i);
			if (_rogueArtifactslist.Count - 1 < i)
			{
				continue;
			}
			RogueArtfactSelectItem item = _rogueArtfactSelectItem[i];
			item.Init(_rogueArtifactslist[i]);
			item.BtnClick.SetBtnClick(() =>
			{
				CurrentSelectArtifact = item.RogueArtifact;
				for (int j = 0; j < _rogueArtfactSelectItem.Count; j++)
				{
					if (_rogueArtfactSelectItem[j].RogueArtifact != null)
					{
						_rogueArtfactSelectItem[j].GoSelect.SetActive(item.RogueArtifact.id == _rogueArtfactSelectItem[j].RogueArtifact.id);
					}
				}
			});
		}
	}

	public void SelectCard()
	{
		if (_rogueArtifactslist.Count > 0)
		{
			if (CurrentSelectArtifact == null)
			{
				return;
			}
			Model<RoGueModel>.Interface.AddRogueArtifacts(CurrentSelectArtifact);
		}
		Close();
	}
}
