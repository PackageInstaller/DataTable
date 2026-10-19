using UnityEngine;

namespace Com.ForbiddenByte.OSA.Core;

public class LayoutInfo
{
	public readonly Vector2 constantAnchorPosForAllItems = new Vector2(0f, 1f);

	public Vector2 scrollViewSize { get; private set; }

	public double vpSize { get; private set; }

	public double transversalContentSize { get; private set; }

	public double paddingContentStart { get; private set; }

	public double transversalPaddingContentStart { get; private set; }

	public double transversalPaddingContentEnd { get; private set; }

	public double paddingContentEnd { get; private set; }

	public double paddingStartPlusEnd { get; private set; }

	public double transversalPaddingStartPlusEnd { get; private set; }

	public double spacing { get; private set; }

	public double itemsConstantTransversalSize { get; private set; }

	public RectTransform.Edge startEdge { get; private set; }

	public RectTransform.Edge endEdge { get; private set; }

	public RectTransform.Edge transvStartEdge { get; private set; }

	public int hor0_vert1 { get; private set; }

	public int hor1_vertMinus1 { get; private set; }

	internal void CacheScrollViewInfo(BaseParams parameters)
	{
		scrollViewSize = parameters.ScrollViewRT.rect.size;
		Rect rect = parameters.Viewport.rect;
		Rect rect2 = parameters.Content.rect;
		if (parameters.IsHorizontal)
		{
			startEdge = RectTransform.Edge.Left;
			endEdge = RectTransform.Edge.Right;
			transvStartEdge = RectTransform.Edge.Top;
			hor0_vert1 = 0;
			hor1_vertMinus1 = 1;
			vpSize = rect.width;
			paddingContentStart = parameters.ContentPadding.left;
			paddingContentEnd = parameters.ContentPadding.right;
			transversalPaddingContentStart = parameters.ContentPadding.top;
			transversalPaddingContentEnd = parameters.ContentPadding.bottom;
		}
		else
		{
			startEdge = RectTransform.Edge.Top;
			endEdge = RectTransform.Edge.Bottom;
			transvStartEdge = RectTransform.Edge.Left;
			hor0_vert1 = 1;
			hor1_vertMinus1 = -1;
			vpSize = rect.height;
			paddingContentStart = parameters.ContentPadding.top;
			paddingContentEnd = parameters.ContentPadding.bottom;
			transversalPaddingContentStart = parameters.ContentPadding.left;
			transversalPaddingContentEnd = parameters.ContentPadding.right;
		}
		transversalContentSize = rect2.size[1 - hor0_vert1];
		if (transversalPaddingContentStart == -1.0 || transversalPaddingContentEnd == -1.0)
		{
			if (parameters.ItemTransversalSize == 0f)
			{
				throw new OSAException("ItemTransversalSize is 0, meaning the item should fill the available space transversally, but the transversal padding is not specified (it's -1, which is a reserved value)");
			}
			double num = (transversalPaddingContentEnd = -1.0);
			double num3 = (transversalPaddingContentStart = num);
			double num5 = (transversalPaddingStartPlusEnd = num3);
			itemsConstantTransversalSize = num5;
		}
		else
		{
			transversalPaddingStartPlusEnd = transversalPaddingContentStart + transversalPaddingContentEnd;
			itemsConstantTransversalSize = transversalContentSize - transversalPaddingStartPlusEnd;
		}
		spacing = parameters.ContentSpacing;
		if (parameters.effects.LoopItems && (paddingContentStart != spacing || paddingContentEnd != spacing))
		{
			throw new OSAException("When looping is active, the content padding should be the same as content spacing. This is handled automatically in Params.InitIfNeeded(). If you overrode method, please call base's implementation first");
		}
		paddingStartPlusEnd = paddingContentStart + paddingContentEnd;
	}
}
