using UnityEngine;
using UnityEngine.UI;

public class BattleTestTogHelp : MonoBehaviour
{
	public GameObject objCheck;

	private Toggle tog;

	private void Awake()
	{
		tog = gameObject.GetComponent<Toggle>();
		if (null != tog)
		{
			SetPrefabActive(tog.isOn);
			tog.onValueChanged.AddListener(OnValueChanged);
		}
	}

	public void OnValueChanged(bool isOn)
	{
		SetPrefabActive(isOn);
	}

	private void SetPrefabActive(bool isShow)
	{
		if (objCheck != null)
		{
			if (!objCheck.activeSelf)
			{
				objCheck.SetActive(value: true);
			}
			objCheck.transform.localScale = (isShow ? Vector3.one : Vector3.zero);
		}
	}
}
