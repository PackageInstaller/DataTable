using Cysharp.Text;
using TMPro;
using UnityEngine;

namespace Ase;

public class NormalSingleTextDamage : MonoBehaviour
{
	[SerializeField]
	public RectTransform RectTransform;

	[SerializeField]
	protected TextMeshProUGUI[] textUIs;

	[SerializeField]
	protected Animation[] textAnimations;

	protected char[] textContents = new char[3];

	protected float[] timeConfigs = new float[3];

	private float showTimer;

	protected bool mergeDamage;

	public string PlayAniName
	{
		get
		{
			if (!mergeDamage)
			{
				return "Normal";
			}
			return "Merge";
		}
	}

	public virtual void SetTextContent(char content, float time, int index, GameObject glowObj, bool merge)
	{
		showTimer = 0f;
		textContents[index] = content;
		timeConfigs[index] = time;
		mergeDamage = merge;
	}

	public void ShowContent(string numPrefixIndex)
	{
		base.gameObject.SetActive(value: true);
		for (int i = 0; i < textUIs.Length; i++)
		{
			if (textContents[i] != 0)
			{
				TextMeshProUGUI obj = textUIs[i];
				if (obj != null)
				{
					((TMP_Text)obj).SetText(ZString.Format("<sprite={0}{1}>", numPrefixIndex, textContents[i]), true);
				}
			}
			((Component)(object)textUIs[i])?.gameObject.SetActive(textContents[i] != '\0');
			if (timeConfigs[i] == 0f)
			{
				ExcuteTextShowAni(i, PlayAniName);
			}
			else if (timeConfigs[i] < 0f)
			{
				ExcuteTextShowAni(i, "Stand");
			}
		}
	}

	public virtual void ShowOutLightContent(string numPrefixIndex)
	{
	}

	private void Update()
	{
		showTimer += Time.deltaTime;
		for (int i = 0; i < timeConfigs.Length; i++)
		{
			if (showTimer >= timeConfigs[i] && timeConfigs[i] > 0f)
			{
				ExcuteTextShowAni(i, PlayAniName);
				timeConfigs[i] = 0f;
			}
		}
	}

	public virtual void ExcuteTextShowAni(int index, string aniName)
	{
		if (textAnimations.Length > index)
		{
			Animation obj = textAnimations[index];
			if (obj != null)
			{
				obj.Play(aniName);
			}
		}
	}

	public virtual void ClearData()
	{
		base.gameObject.SetActive(value: false);
		if (textContents != null)
		{
			for (int i = 0; i < textContents.Length; i++)
			{
				textContents[i] = '\0';
			}
		}
		if (timeConfigs != null)
		{
			for (int j = 0; j < timeConfigs.Length; j++)
			{
				timeConfigs[j] = 0f;
			}
		}
		if (textAnimations == null)
		{
			return;
		}
		for (int k = 0; k < textAnimations.Length; k++)
		{
			Animation obj = textAnimations[k];
			if (obj != null)
			{
				obj.Stop();
			}
		}
	}
}
