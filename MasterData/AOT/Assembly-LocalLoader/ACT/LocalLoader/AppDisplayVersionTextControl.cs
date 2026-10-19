using TMPro;
using UnityEngine;

namespace ACT.LocalLoader;

[RequireComponent(typeof(TMP_Text))]
public class AppDisplayVersionTextControl : MonoBehaviour
{
	[SerializeField]
	private TMP_Text _versionText;

	private void Start()
	{
		if (_versionText == null)
		{
			_versionText = GetComponent<TMP_Text>();
		}
		LuminApplication.OnDisplayVersionUpdate.AddListener(Refresh);
		Refresh();
	}

	private void OnDestroy()
	{
		LuminApplication.OnDisplayVersionUpdate.RemoveListener(Refresh);
	}

	protected virtual void Refresh()
	{
		if (!(_versionText == null))
		{
			_versionText.text = LuminApplication.DisplayVersion;
		}
	}
}
