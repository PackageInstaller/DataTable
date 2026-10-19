using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using TMPro;
using UnityEngine;

public class InscriptionItemLevel : MonoBehaviour
{
	public List<GameObject> levels = new List<GameObject>();

	public Color ActiveColor;

	public Color UnactiveColor;

	public void Init(int[] les, int currentlevel)
	{
		for (int i = 0; i < levels.Count; i++)
		{
			levels[i].SetActive(i < les.Length);
			if (i >= les.Length)
			{
				continue;
			}
			Synergy data = CoreUtils.GetData(les[i], RuntimeConfigs.data.synergys);
			if (data != null)
			{
				TextMeshProUGUI componentInChildren = levels[i].GetComponentInChildren<TextMeshProUGUI>();
				int threshold = data.threshold;
				componentInChildren.text = threshold.ToString();
				if (currentlevel >= data.threshold)
				{
					componentInChildren.color = ActiveColor;
				}
				else
				{
					componentInChildren.color = UnactiveColor;
				}
			}
		}
	}
}
