using System;
using ACT.Config;
using ACT.Utility;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SessionOptionComp : MonoBehaviour
{
	[SerializeField]
	private LocalizeStringEvent choiceLocalize;

	[SerializeField]
	private ActButton btn;

	public void Init(MessageChoose messageChoose, Action<int> chooseAction)
	{
		gameObject.SetActive(value: true);
		choiceLocalize.SetReference(LocalizeTable.MainStory, messageChoose.chooseText);
		btn.OnClick.RemoveAllListeners();
		btn.OnClick.AddListener(() =>
		{
			chooseAction(messageChoose.id);
		});
	}
}
