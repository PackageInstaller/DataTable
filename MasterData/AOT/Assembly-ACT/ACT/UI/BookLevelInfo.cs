using TMPro;
using UnityEngine;

namespace ACT.UI;

public class BookLevelInfo : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI m_desc;

	public void Init(string desc)
	{
		m_desc.text = desc;
	}
}
