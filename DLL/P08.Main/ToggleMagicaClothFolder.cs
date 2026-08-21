using UnityEngine;

[RequireComponent(typeof(Animator))]
public class ToggleMagicaClothFolder : MonoBehaviour
{
	private const string CLOTH_FOLDER_NAME = "Magica Cloth";

	private Transform clothFolder;

	private void Awake()
	{
		clothFolder = base.transform.Find("Magica Cloth");
		if (clothFolder == null)
		{
			Debug.LogError("找不到MagicaCloth文件夹！请确保存在名为'Magica Cloth'的子对象", this);
		}
	}

	public void MagicaClothEvent(AnimationEvent evt)
	{
		string stringParameter = evt.stringParameter;
		if (!(stringParameter == "OpenMagicaCloth"))
		{
			if (stringParameter == "CloseMagicaCloth")
			{
				SetMagicaClothActive(enable: false);
			}
			else
			{
				Debug.LogWarning("未知动画事件参数: " + evt.stringParameter, this);
			}
		}
		else
		{
			SetMagicaClothActive(enable: true);
		}
	}

	public void OpenMagicaCloth()
	{
		SetMagicaClothActive(enable: true);
	}

	public void CloseMagicaCloth()
	{
		SetMagicaClothActive(enable: false);
	}

	public void SetMagicaClothActive(int enableFlag)
	{
		SetMagicaClothActive(enableFlag != 0);
	}

	private void SetMagicaClothActive(bool enable)
	{
		if (clothFolder == null)
		{
			Debug.LogWarning("MagicaCloth文件夹未初始化，请检查对象层级", this);
		}
		else
		{
			clothFolder.gameObject.SetActive(enable);
		}
	}
}
