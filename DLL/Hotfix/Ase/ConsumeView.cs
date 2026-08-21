using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class ConsumeView : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI val;

	public void Init(SkillCoolingData data)
	{
	}

	public void RefreshData(SkillCoolingData data)
	{
		this.SetDataContext(data);
	}
}
