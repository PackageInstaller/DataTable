using UnityEngine;

public class ZumaItemManager : MonoBehaviour
{
	public ZumaGoldItem goldItem;

	private bool isInit;

	public void Init()
	{
		isInit = true;
		goldItem.Init();
	}

	public void Process()
	{
		if (isInit)
		{
			goldItem.Process();
		}
	}
}
