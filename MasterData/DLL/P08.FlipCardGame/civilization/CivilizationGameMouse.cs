using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

namespace civilization;

public class CivilizationGameMouse : MonoBehaviour
{
	private CivilizationGameBlock block;

	private CivilizationGameSkillBlock skill;

	private bool isShow;

	public RectTransform prefabRect;

	private void Start()
	{
		block = base.transform.Find("clutureGridItem/civilizationBlockItem").GetComponent<CivilizationGameBlock>();
		skill = base.transform.Find("skillGridItem/civilizationBlockItem").GetComponent<CivilizationGameSkillBlock>();
		prefabRect = base.transform.parent.parent.transform.GetComponent<RectTransform>();
	}

	private void Update()
	{
		if (isShow)
		{
			RectTransformUtility.ScreenPointToLocalPointInRectangle(prefabRect, Input.mousePosition, CanvasManager.Instance.uiCamera, out var localPoint);
			base.transform.localPosition = localPoint;
		}
	}

	public void SetMouseBlock(CivilizationGameBlockBase b)
	{
		isShow = true;
		if (b.IsSkill)
		{
			skill.skillID = (b as CivilizationGameSkillBlock).skillID;
			skill.FreshBlock(newBlock: false, isMouse: true);
			block.transform.parent.gameObject.SetActive(value: false);
			skill.transform.parent.gameObject.SetActive(value: true);
		}
		else
		{
			block.kind = (b as CivilizationGameBlock).kind;
			block.number = (b as CivilizationGameBlock).number;
			block.level = (b as CivilizationGameBlock).level;
			block.FreshBlock(newBlock: false, isMouse: true);
			block.transform.parent.gameObject.SetActive(value: true);
			skill.transform.parent.gameObject.SetActive(value: false);
		}
	}

	public void HideBlock()
	{
		block.transform.parent.gameObject.SetActive(value: false);
		skill.transform.parent.gameObject.SetActive(value: false);
		isShow = false;
	}
}
