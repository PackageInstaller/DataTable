using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class ChangerGender : MonoBehaviour
{
	public ActButton BtnChangeGender;

	private void Start()
	{
		BtnChangeGender.SetBtnClick(OpenChangePanel);
	}

	private void OpenChangePanel()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPSWITCHROLES);
	}

	private void Update()
	{
	}
}
