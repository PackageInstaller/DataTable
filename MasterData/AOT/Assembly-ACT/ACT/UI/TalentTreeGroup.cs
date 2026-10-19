using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TalentTreeGroup : MonoBehaviour
{
	public TalentType type;

	public List<RogueTalentNodeItem> TalentOneGroupList;

	public LocalizeStringEvent TextGroupNum;
}
