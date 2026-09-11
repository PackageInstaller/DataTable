using UnityEngine;
using UnityEngine.UI;

public class InputfieldTextLimitHelper : MonoBehaviour
{
	private InputField input;

	private int textLimit;

	private void Start()
	{
		input = base.gameObject.GetComponent<InputField>();
		if (input != null)
		{
			textLimit = input.characterLimit;
			input.characterLimit = 0;
			input.onEndEdit.AddListener(delegate
			{
				AfterTreatment();
			});
		}
	}

	private void AfterTreatment()
	{
		if (textLimit != 0 && input.text.Length > textLimit)
		{
			input.text = input.text.Substring(0, textLimit);
		}
	}
}
