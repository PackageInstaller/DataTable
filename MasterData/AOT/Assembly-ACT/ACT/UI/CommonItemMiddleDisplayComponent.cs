using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class CommonItemMiddleDisplayComponent : MonoBehaviour
{
	[Tooltip("动态列表需等待列表内容生成完毕后刷新，也可手动调用UpdateDisplay")]
	public bool IsAutoUpdate;

	private int cacheLayoutGroupLeftPadding;

	private LoopHorizontalScrollRect _loopHorizontalScrollRect;

	private ScrollRect _scrollRect;

	private RectTransform _content;

	private HorizontalLayoutGroup _horizontalLayoutGroup;

	private void Awake()
	{
		if (_content == null)
		{
			_loopHorizontalScrollRect = transform.GetComponent<LoopHorizontalScrollRect>();
			if (_loopHorizontalScrollRect != null)
			{
				_content = _loopHorizontalScrollRect.content;
			}
		}
		if (_content == null)
		{
			_scrollRect = transform.GetComponent<ScrollRect>();
			if (_scrollRect != null)
			{
				_content = _scrollRect.content;
			}
		}
		if (!(_content == null))
		{
			_horizontalLayoutGroup = _content.GetComponent<HorizontalLayoutGroup>();
			if (_horizontalLayoutGroup != null)
			{
				cacheLayoutGroupLeftPadding = _horizontalLayoutGroup.padding.left;
			}
		}
	}

	public async void OnEnable()
	{
		if (IsAutoUpdate)
		{
			await UniTask.DelayFrame(1);
			UpdateDisplay();
		}
	}

	public void UpdateDisplay()
	{
		if (!(_horizontalLayoutGroup == null))
		{
			bool flag = true;
			float num = 0f;
			float num2 = 0f;
			if (_loopHorizontalScrollRect != null)
			{
				num = CalculateContentWidth(_loopHorizontalScrollRect.totalCount, _loopHorizontalScrollRect.item.GetComponent<RectTransform>(), _horizontalLayoutGroup);
				flag = num > _loopHorizontalScrollRect.viewport.rect.width;
				num2 = _loopHorizontalScrollRect.viewport.rect.width;
			}
			else if (_scrollRect != null)
			{
				num = CalculateContentWidth(_scrollRect.content.childCount, _scrollRect.content.GetChild(0).GetComponent<RectTransform>(), _horizontalLayoutGroup);
				flag = num > _scrollRect.viewport.rect.width;
				num2 = _scrollRect.viewport.rect.width;
			}
			if (flag)
			{
				_horizontalLayoutGroup.padding.left = cacheLayoutGroupLeftPadding;
			}
			else
			{
				_horizontalLayoutGroup.padding.left = (int)((float)cacheLayoutGroupLeftPadding + (num2 - num) / 2f);
			}
			LayoutRebuilder.ForceRebuildLayoutImmediate(_horizontalLayoutGroup.GetComponent<RectTransform>());
		}
	}

	private float CalculateContentWidth(int itemCount, RectTransform item, HorizontalLayoutGroup horizontalLayoutGroup)
	{
		if (itemCount <= 0)
		{
			return 0f;
		}
		float num = (int)item.rect.width;
		LayoutElement component = item.GetComponent<LayoutElement>();
		if (component != null)
		{
			num = component.preferredWidth;
		}
		return (float)itemCount * num + (float)(itemCount - 1) * horizontalLayoutGroup.spacing + (float)cacheLayoutGroupLeftPadding + (float)horizontalLayoutGroup.padding.right;
	}
}
