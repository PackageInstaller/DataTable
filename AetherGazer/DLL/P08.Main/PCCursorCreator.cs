using UnityEngine;

public class PCCursorCreator : MonoBehaviour
{
	private const string parent = "UICamera_DontDestroy/Canvas";

	private const string instName = "PCCursor";

	private const string cursorPath = "PCCursor";

	private const string prefab = "Widget/System/UIScreenTap/PCCursor.prefab";

	private PCCursor _cursor;

	private void OnEnable()
	{
		if (PlatformHelper.IsPC())
		{
			GameObject gameObject = GameObject.Find("PCCursor");
			if (gameObject == null)
			{
				_ = GameObject.Find("UICamera_DontDestroy/Canvas").transform;
				gameObject = Asset.InstantiateWithoutCache("Widget/System/UIScreenTap/PCCursor.prefab", dontDestroy: true);
				gameObject.name = "PCCursor";
			}
			_cursor = gameObject.GetComponent<PCCursor>();
		}
	}
}
