using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI.ViewComponent.EquipBuildView;

public class EquipFeatureCell : MonoBehaviour
{
	public LocalizeStringEvent equipFeatureName;

	public void SetName(int localizeId)
	{
		equipFeatureName.SetTable("shortcommon");
		equipFeatureName.StringReference.TableEntryReference = localizeId;
	}
}
