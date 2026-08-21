using UnityEngine;
using UnityEngine.UI;

namespace civilization;

public class CivilizationGameBlockBase : MonoBehaviour
{
	public int x;

	public int y;

	public GameObject blockGo;

	public GameObject buildGo;

	public Image image;

	public virtual bool IsSkill { get; private set; }

	public virtual void ResetBlock()
	{
		x = 0;
		y = 0;
		FreshBlock(newBlock: false);
	}

	public virtual void FreshBlock(bool newBlock, bool isMouse = false)
	{
	}

	public virtual void CheckMask(CivilizationGameBlock block, ref int count)
	{
	}

	public virtual void StartDrag()
	{
		blockGo.SetActive(value: false);
	}
}
