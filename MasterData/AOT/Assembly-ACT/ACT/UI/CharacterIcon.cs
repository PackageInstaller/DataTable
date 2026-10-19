using ACT.Game.Data;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterIcon : MonoBehaviour
{
	public BImage normalicon;

	public Image selecticon;

	public GameObject iconChoose;

	public GameObject iconNoChoose;

	public Character character;

	public Button button;

	private bool m_IsChoose;

	public bool IsChoose
	{
		get
		{
			return m_IsChoose;
		}
		set
		{
			m_IsChoose = value;
			iconChoose.SetActive(m_IsChoose);
			iconNoChoose.SetActive(!m_IsChoose);
		}
	}
}
