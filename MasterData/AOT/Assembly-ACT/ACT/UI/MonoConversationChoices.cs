using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoConversationChoices : MonoBehaviour
{
	[Header("选项相关")]
	public GameObject btnPrefab;

	public GameObject btnGroup;

	private List<(Button, InteractBtn)> m_choiceBtns;
}
