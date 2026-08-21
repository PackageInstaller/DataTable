using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GravitySensingView : MonoBehaviour
{
	public RectTransform outer;

	public RectTransform inner;

	public Vector4 Outer_Range = new Vector4(-10000f, 10000f, -10000f, 10000f);

	public Vector4 Inner_Range = new Vector4(-10000f, 10000f, -10000f, 10000f);

	public float Sensitivity_Outer_Hor = 1f;

	public float Sensitivity_Outer_Ver = 1f;

	public float Sensitivity_Inner_Hor = 0.3f;

	public float Sensitivity_Inner_Ver = 0.3f;

	public float LerpTime = 0.1f;

	public float Magnification = 110f;

	public Toggle toggle;

	public GameObject panel;

	public InputField inputField1;

	public InputField inputField2;

	public InputField inputField3;

	public InputField inputField4;

	public InputField inputField5;

	public InputField inputField6;

	public InputField inputField7;

	public InputField inputField8;

	public InputField inputField9;

	public InputField inputField10;

	public InputField inputField11;

	public InputField inputField12;

	public InputField inputField13;

	public InputField inputField14;

	public InputField inputField15;

	[HideInInspector]
	public bool UpdateEnable = true;

	private void Awake()
	{
		toggle.onValueChanged.AddListener(delegate(bool v)
		{
			panel.SetActive(v);
		});
		toggle.isOn = false;
		panel.SetActive(value: false);
		inputField1.text = Outer_Range.x.ToString();
		inputField1.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Outer_Range = new Vector4(result, Outer_Range.y, Outer_Range.z, Outer_Range.w);
			}
		});
		inputField2.text = Outer_Range.y.ToString();
		inputField2.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Outer_Range = new Vector4(Outer_Range.x, result, Outer_Range.z, Outer_Range.w);
			}
		});
		inputField3.text = Outer_Range.z.ToString();
		inputField3.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Outer_Range = new Vector4(Outer_Range.x, Outer_Range.y, result, Outer_Range.w);
			}
		});
		inputField4.text = Outer_Range.w.ToString();
		inputField4.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Outer_Range = new Vector4(Outer_Range.x, Outer_Range.y, Outer_Range.z, result);
			}
		});
		inputField5.text = Inner_Range.x.ToString();
		inputField5.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Inner_Range = new Vector4(result, Inner_Range.y, Inner_Range.z, Inner_Range.w);
			}
		});
		inputField6.text = Inner_Range.y.ToString();
		inputField6.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Inner_Range = new Vector4(Inner_Range.x, result, Inner_Range.z, Inner_Range.w);
			}
		});
		inputField7.text = Inner_Range.z.ToString();
		inputField7.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Inner_Range = new Vector4(Inner_Range.x, Inner_Range.y, result, Inner_Range.w);
			}
		});
		inputField8.text = Inner_Range.w.ToString();
		inputField8.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Inner_Range = new Vector4(Inner_Range.x, Inner_Range.y, Inner_Range.z, result);
			}
		});
		inputField9.text = Sensitivity_Outer_Hor.ToString();
		inputField9.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Sensitivity_Outer_Hor = result;
			}
		});
		inputField10.text = Sensitivity_Outer_Ver.ToString();
		inputField10.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Sensitivity_Outer_Ver = result;
			}
		});
		inputField11.text = Sensitivity_Inner_Hor.ToString();
		inputField11.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Sensitivity_Inner_Hor = result;
			}
		});
		inputField12.text = Sensitivity_Inner_Ver.ToString();
		inputField12.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Sensitivity_Inner_Ver = result;
			}
		});
		inputField13.text = Magnification.ToString();
		inputField13.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				Magnification = result;
			}
		});
		inputField14.text = LerpTime.ToString();
		inputField14.onEndEdit.AddListener(delegate(string text)
		{
			if (float.TryParse(text, out var result))
			{
				LerpTime = result;
			}
		});
	}

	private void Update()
	{
		if (UpdateEnable)
		{
			float x = Input.acceleration.x;
			float y = Input.acceleration.y;
			float num = x * Magnification * Sensitivity_Outer_Hor;
			if (num > Outer_Range.y)
			{
				num = Outer_Range.y;
			}
			else if (num < Outer_Range.x)
			{
				num = Outer_Range.x;
			}
			float num2 = y * Magnification * Sensitivity_Outer_Ver;
			if (num2 > Outer_Range.w)
			{
				num2 = Outer_Range.w;
			}
			else if (num2 < Outer_Range.z)
			{
				num2 = Outer_Range.z;
			}
			outer.anchoredPosition = new Vector2(Mathf.Lerp(outer.anchoredPosition.x, num, LerpTime), Mathf.Lerp(outer.anchoredPosition.y, num2, LerpTime));
			float num3 = x * Magnification * Sensitivity_Inner_Hor;
			if (num3 > Inner_Range.y)
			{
				num3 = Inner_Range.y;
			}
			else if (num3 < Inner_Range.x)
			{
				num3 = Inner_Range.x;
			}
			float num4 = y * Magnification * Sensitivity_Inner_Ver;
			if (num4 > Inner_Range.w)
			{
				num4 = Inner_Range.w;
			}
			else if (num4 < Inner_Range.z)
			{
				num4 = Inner_Range.z;
			}
			inner.anchoredPosition = new Vector2(Mathf.Lerp(inner.anchoredPosition.x, num3, LerpTime), Mathf.Lerp(inner.anchoredPosition.y, num4, LerpTime));
		}
	}
}
