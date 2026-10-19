using System.Collections.Generic;
using UnityEngine.UI;

namespace ACT.UI;

public class PublicToggleGroup : ToggleGroup
{
	public List<Toggle> toggles => m_Toggles;
}
