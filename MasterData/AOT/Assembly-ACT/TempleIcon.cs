using ACT.Model;
using UnityEngine;

public class TempleIcon : MonoBehaviour
{
	public GameObject iconGo;

	public GameObject selectGo;

	public GameObject lockGo;

	private TempleData _templeData;

	public TempleData TempleData => _templeData;

	public void SetInfo(TempleData templeData)
	{
		_templeData = templeData;
		transform.localPosition = new Vector3(templeData.staticData.location[0], templeData.staticData.location[1]);
		SetLocked(!templeData.unLock);
	}

	public void SetSelected(bool flag)
	{
		selectGo.SetActive(flag);
	}

	public void SetLocked(bool flag)
	{
		iconGo.SetActive(!flag);
		lockGo.SetActive(flag);
	}
}
