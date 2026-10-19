using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class ElementalResonanceView : BaseUIView
{
	private ElementalResonanceViewData m_data;

	public GameObject unactivated;

	public List<ElementaliconCell> unactivatedlist;

	public GameObject activated;

	public List<ElementaliconCell> activatedlist;

	public BImage CenterIcon;

	public GameObject GoLevel2;

	public GameObject GoLevel3;

	public List<GameObject> GOLevel3List;

	public List<ElementalCell> elementalcelllist;

	private PresetTeam _teamProfile;

	private Element _element;

	private int _elementCount;

	private Dictionary<Element, int> dicelement = new Dictionary<Element, int>();

	private ElementResonanceData _elementResonanceData;

	private List<int> list = new List<int>();

	private BetterAnimation level3BetterAnimation;

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
		m_data = uiViewData as ElementalResonanceViewData;
		GetData();
		RestRightSort();
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		InitView();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
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
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
		if (_elementCount == 3)
		{
			level3BetterAnimation.GetSequence("Hide").Play();
		}
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ElementallView_Close, null);
	}

	public void InitView()
	{
		SetLeft();
		SetRight();
	}

	public void SetLeft()
	{
		unactivated.SetActive(_element == Element.Owner);
		activated.SetActive(_element != Element.Owner);
		if (_element == Element.Owner)
		{
			for (int i = 0; i < unactivatedlist.Count; i++)
			{
				bool isactive = dicelement.TryGetValue(unactivatedlist[i].element, out var _);
				unactivatedlist[i].Init(isactive);
			}
			return;
		}
		Dictionary<int, ElementResonanceData> elementResonanceDatas = RuntimeConfigs.data.elementResonanceDatas;
		List<ElementResonanceData> list = new List<ElementResonanceData>();
		foreach (KeyValuePair<int, ElementResonanceData> item in elementResonanceDatas)
		{
			if (item.Value.id != (int)_element)
			{
				list.Add(item.Value);
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			activatedlist[j].element = (Element)list[j].id;
			bool isactive2 = dicelement.TryGetValue(activatedlist[j].element, out var _);
			activatedlist[j].Init(isactive2);
		}
		if (_elementCount == 2)
		{
			Station.LoadSprite(GameLoader.meta.elementalResonanceAtlasAssetID, _elementResonanceData.activatedBigIcon, CenterIcon);
		}
		if (_elementCount == 3)
		{
			for (int k = 0; k < GOLevel3List.Count; k++)
			{
				GOLevel3List[k].SetActive(k == (int)(_element - 1));
				level3BetterAnimation = GOLevel3List[k].GetComponent<BetterAnimation>();
				level3BetterAnimation.GetSequence("Show").Play();
				GOLevel3List[k].GetComponent<UpdateSortingLayer>().UpdateLayer();
			}
		}
		GoLevel2.SetActive(_elementCount == 2);
		GoLevel3.SetActive(_elementCount == 3);
	}

	public void GetData()
	{
		GetCurentElementalByTeam();
		dicelement.Clear();
		_element = Element.Owner;
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i] == 0)
			{
				continue;
			}
			EntityData data = CoreUtils.GetData(list[i], RuntimeConfigs.data.entityDatas);
			if (data != null)
			{
				Element element = (Element)data.element;
				if (dicelement.TryGetValue(element, out var value))
				{
					value++;
					dicelement[element] = value;
					_element = element;
					_elementCount = value;
					_elementResonanceData = CoreUtils.GetData(data.element, RuntimeConfigs.data.elementResonanceDatas);
				}
				else
				{
					dicelement.Add(element, 1);
				}
			}
		}
	}

	public void SetRight()
	{
		int num = -1;
		for (int i = 0; i < elementalcelllist.Count; i++)
		{
			if (dicelement.TryGetValue(elementalcelllist[i].element, out var value))
			{
				elementalcelllist[i].Init(value);
				if (value > 1)
				{
					num = i;
				}
			}
			else
			{
				elementalcelllist[i].Init(0);
			}
		}
		if (num >= 0)
		{
			elementalcelllist[num].transform.SetSiblingIndex(0);
		}
	}

	public void RestRightSort()
	{
		for (int i = 0; i < elementalcelllist.Count; i++)
		{
			elementalcelllist[i].transform.SetSiblingIndex((int)elementalcelllist[i].element);
		}
	}

	public void GetCurentElementalByTeam()
	{
		if (m_data.CurrentIndex == -1)
		{
			list = m_data.list;
			return;
		}
		_teamProfile = G.localPlayer.teamInfo.PresetTeams[m_data.CurrentIndex];
		list = _teamProfile.CharacterIds.ToList();
	}
}
