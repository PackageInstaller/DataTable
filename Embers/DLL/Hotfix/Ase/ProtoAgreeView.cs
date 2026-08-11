using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ProtoAgreeView : UGuiView
{
	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private ScrollRect scrollRect;

	[SerializeField]
	private RectTransform content1;

	[SerializeField]
	private RectTransform content2;

	[SerializeField]
	private RectTransform content3;

	[SerializeField]
	private RectTransform content4;

	public void Init()
	{
		btnClose.onClick.AddListener(Hide);
	}

	public void Show(int index)
	{
		switch (index)
		{
		case 1:
			((TMP_Text)title).text = "许可服务协议";
			scrollRect.content = content1;
			break;
		case 2:
			((TMP_Text)title).text = "隐私政策";
			scrollRect.content = content2;
			break;
		case 3:
			((TMP_Text)title).text = "儿童信息及隐私保护政策";
			scrollRect.content = content3;
			break;
		case 4:
			((TMP_Text)title).text = "游戏测试协议";
			scrollRect.content = content4;
			break;
		}
		content1.gameObject.SetActive(index == 1);
		content2.gameObject.SetActive(index == 2);
		content3.gameObject.SetActive(index == 3);
		content4.gameObject.SetActive(index == 4);
		Visibility = true;
	}

	public void Hide()
	{
		Visibility = false;
	}
}
