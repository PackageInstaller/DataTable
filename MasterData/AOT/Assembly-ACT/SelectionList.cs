using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class SelectionList : MonoBehaviour
{
	public Button BtnPre;

	public Button BtnNext;

	public Transform Content;

	[SerializeField]
	private int m_CurrentSelection;

	public UnityEvent<int> OnSelectionChanged;

	private void OnEnable()
	{
		Refresh();
	}

	public void SetSelection(int selection)
	{
		if (selection != m_CurrentSelection)
		{
			m_CurrentSelection = selection;
			Refresh();
			OnSelectionChanged?.Invoke(selection);
		}
	}

	private void Refresh()
	{
		int childCount = Content.childCount;
		for (int i = 0; i < childCount; i++)
		{
			Content.GetChild(i).gameObject.SetActive(i == m_CurrentSelection);
		}
	}
}
