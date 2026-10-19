using System;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CommonEquipTypeComponent : BaseUIComponent, IUIFrameElement
{
	[SerializeField]
	private BImage m_EquipIcon;

	[SerializeField]
	private LocalizeStringEvent m_EquipName;

	public void Init(int equipType)
	{
		LocalizedString stringReference = m_EquipName.StringReference;
		stringReference.TableEntryReference = equipType switch
		{
			1 => LocalizationCommonData.CommonString.Power, 
			2 => LocalizationCommonData.CommonString.Move, 
			3 => LocalizationCommonData.CommonString.Can, 
			4 => LocalizationCommonData.CommonString.Assist, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
		Station.LoadImageAsync(135, equipType, m_EquipIcon).Forget();
	}
}
