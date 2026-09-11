using ControllerExSpace;
using UnityEngine;

namespace P08.Quiz;

public class QuizChoiceAreaMono : MonoBehaviour
{
	public int choose;

	public GameObject highlightGo;

	public LayerMask mask;

	public ControllerExCollection controllers;

	public ControllerEx highlightController;

	private Collider[] m_Results = new Collider[1];

	[SerializeField]
	private Bounds m_Area = new Bounds(Vector3.zero, Vector3.one);

	private void Start()
	{
		if ((bool)controllers)
		{
			highlightController = controllers.GetController("optionHighlight");
		}
	}

	public bool CheckLocalPlayerInRange()
	{
		if (Physics.OverlapBoxNonAlloc(GetWorldBoxCenter(), GetWorldBoxSize() * 0.5f, orientation: base.transform.rotation, results: m_Results, mask: mask) > 0)
		{
			QuizPlayerMono localPlayer = GetLocalPlayer(m_Results[0]);
			if (localPlayer != null)
			{
				localPlayer.choose = choose;
				HighlightArea(highlight: true);
				return true;
			}
		}
		return false;
	}

	private static QuizPlayerMono GetLocalPlayer(Collider collider)
	{
		if (collider.gameObject.TryGetComponent<QuizPlayerMono>(out var component) && component.IsLocalPlayer)
		{
			return component;
		}
		return null;
	}

	internal void HighlightArea(bool highlight)
	{
		if ((bool)highlightGo)
		{
			highlightGo.SetActive(highlight);
		}
		if (highlight && highlightController != null)
		{
			highlightController.SetSelectedState(choose.ToString());
		}
	}

	private Vector3 GetWorldBoxCenter()
	{
		return base.transform.position + m_Area.center;
	}

	private Vector3 GetWorldBoxSize()
	{
		return m_Area.size;
	}
}
