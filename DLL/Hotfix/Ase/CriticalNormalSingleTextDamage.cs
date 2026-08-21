using Cysharp.Text;
using TMPro;
using UnityEngine;

namespace Ase;

public class CriticalNormalSingleTextDamage : NormalSingleTextDamage
{
	[SerializeField]
	protected TextMeshProUGUI[] outLightTexts;

	[SerializeField]
	protected Animation[] outLighTextAnimations;

	public override void SetTextContent(char content, float time, int index, GameObject glowObj, bool merge)
	{
		base.SetTextContent(content, time, index, glowObj, merge);
		((TMP_Text)textUIs[index]).transform.localScale = Vector3.zero;
		((TMP_Text)outLightTexts[index]).transform.localScale = Vector3.zero;
	}

	public override void ExcuteTextShowAni(int index, string aniName)
	{
		((TMP_Text)textUIs[index]).transform.localScale = Vector3.one;
		((TMP_Text)outLightTexts[index]).transform.localScale = Vector3.one;
		base.ExcuteTextShowAni(index, aniName);
		Animation obj = outLighTextAnimations[index];
		if (obj != null)
		{
			obj.Play(aniName);
		}
	}

	public override void ShowOutLightContent(string numPrefixIndex)
	{
		base.ShowOutLightContent(numPrefixIndex);
		for (int i = 0; i < textUIs.Length; i++)
		{
			if (textContents[i] != 0)
			{
				TextMeshProUGUI obj = outLightTexts[i];
				if (obj != null)
				{
					((TMP_Text)obj).SetText(ZString.Format("<sprite={0}{1}>", numPrefixIndex, textContents[i]), true);
				}
			}
			((Component)(object)outLightTexts[i])?.gameObject.SetActive(textContents[i] != '\0');
		}
	}

	public override void ClearData()
	{
		base.ClearData();
		for (int i = 0; i < textUIs.Length; i++)
		{
			((TMP_Text)textUIs[i]).transform.localScale = Vector3.zero;
			((TMP_Text)outLightTexts[i]).transform.localScale = Vector3.zero;
		}
	}
}
