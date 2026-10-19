using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

[RequireComponent(typeof(Selectable))]
public class SystemUnLockCheck : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
{
	[SerializeField]
	private int systemId;

	public Selectable selectable;

	private bool mIsUnlocked;

	public int Id
	{
		get
		{
			return systemId;
		}
		set
		{
			systemId = value;
			Check();
		}
	}

	private void Start()
	{
		selectable.enabled = false;
	}

	private void Check()
	{
		mIsUnlocked = Id == 0 || Singleton<SystemUnlockManager>.instance.IsUnlock(Id);
		if ((bool)selectable)
		{
			selectable.enabled = mIsUnlocked;
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError(name + "上的SystemUnlockCheck缺失Selectabl组件，请确认SystemUnlockCheck挂在了带有Button、Toggle等组件的物体上！");
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		Check();
		if (!mIsUnlocked)
		{
			Singleton<SystemUnlockManager>.instance.ShowUnlockTip(Id);
		}
	}
}
