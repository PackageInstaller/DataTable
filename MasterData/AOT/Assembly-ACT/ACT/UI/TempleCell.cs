using System.Linq;
using ACT.Core;
using ACT.Model;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TempleCell : LoopScrollBaseItem
{
	private TempleData m_data;

	private int _id;

	private LargeMapView view;

	private bool _isSelect;

	public TempleMapScrollRect rect;

	public GameObject lockRoot;

	public GameObject selected;

	public GameObject complated;

	public Button self;

	public new LocalizeStringEvent name;

	public StartList templeStars;

	public int Id => _id;

	public bool isSelect
	{
		get
		{
			return _isSelect;
		}
		set
		{
			_isSelect = value;
			selected.SetActive(value);
		}
	}

	public override void Init(object param)
	{
		m_data = param as TempleData;
		_id = m_data.templeId;
		lockRoot.SetActive(!m_data.unLock);
		complated.SetActive(m_data.isComplate);
		name.StringReference.TableEntryReference = CoreUtils.GetData(m_data.templeId, RuntimeConfigs.data.instanceDungeons).name;
		templeStars.QualityInit(m_data.gotStars.Count((bool s) => s));
		view = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_LARGEMAP) as LargeMapView;
		isSelect = false;
	}

	public void OnSelect()
	{
		if (rect.lastSelect != null && rect.lastSelect.Id == _id)
		{
			return;
		}
		foreach (LargeMapInteractObjIcon templeIconData in view.templeIconDatas)
		{
			if (templeIconData.GetDataId() == _id)
			{
				if (view.HasSelectIcon())
				{
					view.UnSelectCurAccurateSelectIcon();
					view.UnSelectCurVagueSelectIcon();
				}
				rect.iconSelectFromScrollMap = false;
				view.SelectIcon(templeIconData);
				view.SetRectTransformToCenter(templeIconData.transform as RectTransform);
			}
		}
		if (rect.lastSelect != null)
		{
			rect.lastSelect.isSelect = false;
		}
		isSelect = true;
		rect.lastSelect = this;
	}
}
