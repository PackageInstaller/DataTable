using UnityEngine;

namespace ACT.UI;

public class LevelSpaceItem : MonoBehaviour
{
	public GameObject whiteNormal;

	public GameObject greenSelect;

	public GameObject redReduce;

	public void Init(int index)
	{
		switch (index)
		{
		case -1:
			whiteNormal.SetActive(value: false);
			greenSelect.SetActive(value: false);
			redReduce.SetActive(value: false);
			break;
		case 0:
			whiteNormal.SetActive(value: true);
			greenSelect.SetActive(value: false);
			redReduce.SetActive(value: false);
			break;
		case 1:
			whiteNormal.SetActive(value: false);
			greenSelect.SetActive(value: true);
			redReduce.SetActive(value: false);
			break;
		case 2:
			whiteNormal.SetActive(value: false);
			greenSelect.SetActive(value: false);
			redReduce.SetActive(value: true);
			break;
		}
	}
}
