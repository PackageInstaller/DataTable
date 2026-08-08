using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class LoadingBar : UIBehaviour
{
	public enum BarType
	{
		Rect,
		Graph
	}

	public enum ProgressType
	{
		none,
		precent,
		loading,
		custom
	}

	[SerializeField]
	public Slider slider;

	[SerializeField]
	public Text progressTxt;

	[SerializeField]
	public Text descriptTxt;

	[HideInInspector]
	[SerializeField]
	public BarType barType;

	[HideInInspector]
	[SerializeField]
	public ProgressType progressType = ProgressType.custom;

	[HideInInspector]
	[SerializeField]
	public bool isUseHangdler = true;

	protected void UpdateBar()
	{
		if (!slider)
		{
			Debug.LogError("未绑定Slider组件！");
		}
		if (!progressTxt)
		{
			Debug.LogError("未绑定progressTxt！");
		}
		if (!descriptTxt)
		{
			Debug.LogError("未绑定descriptTxt！");
		}
		if (barType == BarType.Rect)
		{
			Mask component = base.transform.GetComponent<Mask>();
			if (component != null)
			{
				component.enabled = false;
			}
			if (slider.handleRect != null)
			{
				if (isUseHangdler)
				{
					slider.handleRect.gameObject.SetActive(value: true);
				}
				else
				{
					slider.handleRect.gameObject.SetActive(value: false);
				}
			}
			RectTransform component2 = base.transform.GetComponent<RectTransform>();
			if (component2 != null)
			{
				component2.anchorMax = new Vector2(0f, 0f);
				component2.anchorMax = new Vector2(1f, 1f);
				component2.offsetMin = new Vector2(0f, 0f);
				component2.offsetMax = new Vector2(0f, 0f);
			}
		}
		else if (barType == BarType.Graph)
		{
			Mask component3 = base.transform.GetComponent<Mask>();
			if (!component3)
			{
				base.transform.gameObject.AddComponent<Mask>();
			}
			component3.enabled = true;
			if (slider.handleRect != null)
			{
				slider.handleRect.gameObject.SetActive(value: false);
			}
			if (slider.targetGraphic != null)
			{
				slider.targetGraphic.SetNativeSize();
			}
		}
		switch (progressType)
		{
		case ProgressType.none:
			progressTxt.text = "";
			break;
		case ProgressType.precent:
			progressTxt.text = "100%";
			break;
		case ProgressType.loading:
			progressTxt.text = "Loading...";
			break;
		case ProgressType.custom:
			progressTxt.text = "自定义";
			break;
		default:
			progressTxt.text = "";
			break;
		}
	}

	public void SetProgress(float value, string str = "")
	{
		slider.value = value / 100f;
		switch (progressType)
		{
		case ProgressType.precent:
			progressTxt.text = $"{slider.value * 100f:0}" + "%";
			break;
		case ProgressType.custom:
			progressTxt.text = str;
			break;
		default:
			progressTxt.text = str;
			break;
		}
	}

	public void SetDescription(string str = "")
	{
		descriptTxt.text = str;
	}

	public void Validate()
	{
	}
}
