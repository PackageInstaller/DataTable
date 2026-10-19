using System;
using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class EquipFeatureTab : BaseUIComponent
{
	[SerializeField]
	private BImage m_AttributeIcon;

	[SerializeField]
	private LocalizeStringEvent m_AttributeName;

	[SerializeField]
	private CommonNumberComponent m_LevelComp;

	[SerializeField]
	public ActToggle m_ToggleComp;

	[SerializeField]
	private GameObject m_OverloadTip;

	public Action OnSelect { get; set; }

	private void Awake()
	{
		m_ToggleComp.onToggleOn.AddListener(OnSelectedCallBack);
	}

	private void OnDestroy()
	{
		m_ToggleComp.onToggleOn.RemoveListener(OnSelectedCallBack);
	}

	private void OnSelectedCallBack()
	{
		OnSelect?.Invoke();
	}

	public void Init(int equipFeatureId, int currentLevel, bool defaultIsOn = false, bool hideCurrentLevel = false)
	{
		EquipFeatureData data = CoreUtils.GetData(equipFeatureId, RuntimeConfigs.data.equipFeatureDatas);
		if (data != null)
		{
			Station.LoadImageAsync(130, data.icon, m_AttributeIcon).Forget();
			m_AttributeName.StringReference.TableEntryReference = CoreUtils.GetEquipFeatureNameLocalId(data);
			m_LevelComp.gameObject.SetActive(!hideCurrentLevel);
			if (!hideCurrentLevel)
			{
				m_LevelComp.UpdateNumber(currentLevel, data.maxLv);
			}
			m_OverloadTip.SetActive(!hideCurrentLevel && currentLevel > data.maxLv);
			m_ToggleComp.SetIsOn(defaultIsOn);
		}
	}
}
