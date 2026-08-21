using UnityEngine;
using UnityEngine.UI;

public class UILoadingProcessEffect : MonoBehaviour
{
	private Transform effect;

	private Image _progress;

	private Image _progressBg;

	public void Awake()
	{
		_progress = base.transform.Find("BG/Progress").GetComponent<Image>();
		_progressBg = base.transform.Find("BG/progressBg").GetComponent<Image>();
		effect = base.transform.Find("BG/duckEffect/duck");
	}

	private void Start()
	{
		if ((bool)effect)
		{
			SetProcess(_progress.fillAmount);
		}
	}

	private void Update()
	{
		if ((bool)effect)
		{
			SetProcess(_progress.fillAmount);
		}
	}

	private void LateUpdate()
	{
		if ((bool)effect)
		{
			SetProcess(_progress.fillAmount);
		}
	}

	public void SetProcess(float value)
	{
		if ((bool)effect)
		{
			float x = _progressBg.GetComponent<RectTransform>().sizeDelta.x;
			effect.GetComponent<RectTransform>().anchoredPosition = new Vector3(x * value, 0f, 0f);
		}
	}
}
