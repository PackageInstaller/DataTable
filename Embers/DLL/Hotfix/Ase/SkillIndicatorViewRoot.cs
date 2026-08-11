using UnityEngine;

namespace Ase;

public class SkillIndicatorViewRoot : MonoBehaviour
{
	private SkillIndicatorView rangeView;

	private SkillIndicatorView directionView;

	private SkillIndicatorData indicatorData;

	public void InitData(SkillIndicatorData data)
	{
		indicatorData = data;
	}

	public void AddSkillDirectionIndicator(GameObject viewRoot)
	{
		directionView = viewRoot.GetComponent<SkillIndicatorView>();
		directionView.transform.SetParent(base.transform);
	}

	public void Show()
	{
		rangeView.gameObject.SetActive(value: true);
		directionView.gameObject.SetActive(value: true);
		base.gameObject.SetActive(value: true);
	}

	public void UpdatePosition(Vector3 point)
	{
		base.transform.position = point;
	}

	public void Close()
	{
		if (rangeView != null)
		{
			rangeView.FreeBack();
			rangeView = null;
		}
		if (directionView != null)
		{
			directionView.FreeBack();
			directionView = null;
		}
		base.gameObject.SetActive(value: false);
		indicatorData = null;
	}
}
