using System.Collections;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Text))]
public class LineFeedFixed : MonoBehaviour
{
	private Text textComponent;

	private bool _isProcessing;

	private void Awake()
	{
		if (textComponent == null)
		{
			textComponent = GetComponent<Text>();
		}
		textComponent.RegisterDirtyVerticesCallback(OnTextChanged);
	}

	protected void OnEnable()
	{
		_isProcessing = false;
	}

	private void OnTextChanged()
	{
		if (base.gameObject.activeInHierarchy && !_isProcessing)
		{
			_isProcessing = true;
			StartCoroutine(ModifyTextNextFrame());
		}
	}

	private IEnumerator ModifyTextNextFrame()
	{
		yield return null;
		textComponent.ClearLinePrefixSymbol();
		yield return null;
		_isProcessing = false;
	}
}
