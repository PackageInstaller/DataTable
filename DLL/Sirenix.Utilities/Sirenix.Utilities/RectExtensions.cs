using System;
using UnityEngine;

namespace Sirenix.Utilities;

public static class RectExtensions
{
	public static Rect TakeFromDir(this ref Rect rect, float width, Direction direction)
	{
		return direction switch
		{
			Direction.Left => rect.TakeFromLeft(width), 
			Direction.Right => rect.TakeFromRight(width), 
			Direction.Top => rect.TakeFromTop(width), 
			Direction.Bottom => rect.TakeFromBottom(width), 
			_ => throw new NotImplementedException(direction.ToString()), 
		};
	}

	public static Rect TakeFromLeft(this ref Rect rect, float width)
	{
		float num = Math.Min(rect.width, width);
		Rect result = rect;
		result.width = num;
		rect.x += num;
		rect.width -= num;
		return result;
	}

	public static Rect TakeFromRight(this ref Rect rect, float width)
	{
		float num = Math.Min(rect.width, width);
		Rect result = rect.AlignRight(num);
		rect.width -= num;
		return result;
	}

	public static Rect TakeFromTop(this ref Rect rect, float height)
	{
		float num = Math.Min(rect.height, height);
		Rect result = rect;
		result.height = num;
		rect.y += num;
		rect.height -= num;
		return result;
	}

	public static Rect TakeFromBottom(this ref Rect rect, float height)
	{
		float height2 = Math.Min(rect.height, height);
		Rect result = rect.AlignBottom(height2);
		rect.height -= height;
		return result;
	}

	public static Rect SetWidth(this Rect rect, float width)
	{
		rect.width = width;
		return rect;
	}

	public static Rect SetHeight(this Rect rect, float height)
	{
		rect.height = height;
		return rect;
	}

	public static Rect SetSize(this Rect rect, float width, float height)
	{
		rect.width = width;
		rect.height = height;
		return rect;
	}

	public static Rect SetSize(this Rect rect, float widthAndHeight)
	{
		rect.width = widthAndHeight;
		rect.height = widthAndHeight;
		return rect;
	}

	public static Rect SetSize(this Rect rect, Vector2 size)
	{
		rect.size = size;
		return rect;
	}

	public static Rect HorizontalPadding(this Rect rect, float padding)
	{
		rect.x += padding;
		rect.width -= padding * 2f;
		return rect;
	}

	public static Rect HorizontalPadding(this Rect rect, float left, float right)
	{
		rect.x += left;
		rect.width -= left + right;
		return rect;
	}

	public static Rect VerticalPadding(this Rect rect, float padding)
	{
		rect.y += padding;
		rect.height -= padding * 2f;
		return rect;
	}

	public static Rect VerticalPadding(this Rect rect, float top, float bottom)
	{
		rect.y += top;
		rect.height -= top + bottom;
		return rect;
	}

	public static Rect Padding(this Rect rect, float padding)
	{
		rect.position += new Vector2(padding, padding);
		rect.size -= new Vector2(padding, padding) * 2f;
		return rect;
	}

	public static Rect Padding(this Rect rect, float horizontal, float vertical)
	{
		rect.position += new Vector2(horizontal, vertical);
		rect.size -= new Vector2(horizontal, vertical) * 2f;
		return rect;
	}

	public static Rect Padding(this Rect rect, float left, float right, float top, float bottom)
	{
		rect.position += new Vector2(left, top);
		rect.size -= new Vector2(left + right, top + bottom);
		return rect;
	}

	public static Rect AlignLeft(this Rect rect, float width)
	{
		rect.width = width;
		return rect;
	}

	public static Rect AlignCenter(this Rect rect, float width)
	{
		rect.x = rect.x + rect.width * 0.5f - width * 0.5f;
		rect.width = width;
		return rect;
	}

	public static Rect AlignCenter(this Rect rect, float width, float height)
	{
		rect.x = rect.x + rect.width * 0.5f - width * 0.5f;
		rect.y = rect.y + rect.height * 0.5f - height * 0.5f;
		rect.width = width;
		rect.height = height;
		return rect;
	}

	public static Rect AlignRight(this Rect rect, float width)
	{
		rect.x = rect.x + rect.width - width;
		rect.width = width;
		return rect;
	}

	public static Rect AlignRight(this Rect rect, float width, bool clamp)
	{
		if (clamp)
		{
			rect.xMin = Mathf.Max(rect.xMax - width, rect.xMin);
			return rect;
		}
		rect.x = rect.x + rect.width - width;
		rect.width = width;
		return rect;
	}

	public static Rect AlignTop(this Rect rect, float height)
	{
		rect.height = height;
		return rect;
	}

	public static Rect AlignMiddle(this Rect rect, float height)
	{
		rect.y = rect.y + rect.height * 0.5f - height * 0.5f;
		rect.height = height;
		return rect;
	}

	public static Rect AlignBottom(this Rect rect, float height)
	{
		rect.y = rect.y + rect.height - height;
		rect.height = height;
		return rect;
	}

	public static Rect AlignCenterX(this Rect rect, float width)
	{
		rect.x = rect.x + rect.width * 0.5f - width * 0.5f;
		rect.width = width;
		return rect;
	}

	public static Rect AlignCenterY(this Rect rect, float height)
	{
		rect.y = rect.y + rect.height * 0.5f - height * 0.5f;
		rect.height = height;
		return rect;
	}

	public static Rect AlignCenterXY(this Rect rect, float size)
	{
		rect.y = rect.y + rect.height * 0.5f - size * 0.5f;
		rect.x = rect.x + rect.width * 0.5f - size * 0.5f;
		rect.height = size;
		rect.width = size;
		return rect;
	}

	public static Rect AlignCenterXY(this Rect rect, float width, float height)
	{
		rect.y = rect.y + rect.height * 0.5f - height * 0.5f;
		rect.x = rect.x + rect.width * 0.5f - width * 0.5f;
		rect.width = width;
		rect.height = height;
		return rect;
	}

	public static Rect Expand(this Rect rect, float expand)
	{
		rect.x -= expand;
		rect.y -= expand;
		rect.height += expand * 2f;
		rect.width += expand * 2f;
		return rect;
	}

	public static Rect Expand(this Rect rect, float horizontal, float vertical)
	{
		rect.position -= new Vector2(horizontal, vertical);
		rect.size += new Vector2(horizontal, vertical) * 2f;
		return rect;
	}

	public static Rect Expand(this Rect rect, float left, float right, float top, float bottom)
	{
		rect.position -= new Vector2(left, top);
		rect.size += new Vector2(left + right, top + bottom);
		return rect;
	}

	public static Rect Split(this Rect rect, int index, int count)
	{
		int num = (int)rect.width;
		int num2 = num / count;
		int num3 = num - num2 * count;
		float num4 = rect.x + (float)(num2 * index);
		if (index < num3)
		{
			num4 += (float)index;
			num2++;
		}
		else
		{
			num4 += (float)num3;
		}
		rect.x = num4;
		rect.width = num2;
		return rect;
	}

	public static Rect SplitVertical(this Rect rect, int index, int count)
	{
		float num = (rect.height /= count);
		rect.y += num * (float)index;
		return rect;
	}

	public static Rect SplitGrid(this Rect rect, float width, float height, int index)
	{
		int num = (int)(rect.width / width);
		num = ((num <= 0) ? 1 : num);
		int num2 = index % num;
		int num3 = index / num;
		rect.x += (float)num2 * width;
		rect.y += (float)num3 * height;
		rect.width = width;
		rect.height = height;
		return rect;
	}

	public static Rect SplitTableGrid(this Rect rect, int columnCount, float rowHeight, int index)
	{
		int num = index % columnCount;
		int num2 = index / columnCount;
		float num3 = rect.width / (float)columnCount;
		rect.x += (float)num * num3;
		rect.y += (float)num2 * rowHeight;
		rect.width = num3;
		rect.height = rowHeight;
		return rect;
	}

	public static Rect SetCenterX(this Rect rect, float x)
	{
		rect.center = new Vector2(x, rect.center.y);
		return rect;
	}

	public static Rect SetCenterY(this Rect rect, float y)
	{
		rect.center = new Vector2(rect.center.x, y);
		return rect;
	}

	public static Rect SetCenter(this Rect rect, float x, float y)
	{
		rect.center = new Vector2(x, y);
		return rect;
	}

	public static Rect SetCenter(this Rect rect, Vector2 center)
	{
		rect.center = center;
		return rect;
	}

	public static Rect SetPosition(this Rect rect, Vector2 position)
	{
		rect.position = position;
		return rect;
	}

	public static Rect ResetPosition(this Rect rect)
	{
		rect.position = Vector2.zero;
		return rect;
	}

	public static Rect AddPosition(this Rect rect, Vector2 move)
	{
		rect.position += move;
		return rect;
	}

	public static Rect AddPosition(this Rect rect, float x, float y)
	{
		rect.x += x;
		rect.y += y;
		return rect;
	}

	public static Rect SetX(this Rect rect, float x)
	{
		rect.x = x;
		return rect;
	}

	public static Rect AddX(this Rect rect, float x)
	{
		rect.x += x;
		return rect;
	}

	public static Rect SubX(this Rect rect, float x)
	{
		rect.x -= x;
		return rect;
	}

	public static Rect SetY(this Rect rect, float y)
	{
		rect.y = y;
		return rect;
	}

	public static Rect AddY(this Rect rect, float y)
	{
		rect.y += y;
		return rect;
	}

	public static Rect SubY(this Rect rect, float y)
	{
		rect.y -= y;
		return rect;
	}

	public static Rect SetMin(this Rect rect, Vector2 min)
	{
		rect.min = min;
		return rect;
	}

	public static Rect AddMin(this Rect rect, Vector2 value)
	{
		rect.min += value;
		return rect;
	}

	public static Rect SubMin(this Rect rect, Vector2 value)
	{
		rect.min -= value;
		return rect;
	}

	public static Rect SetMax(this Rect rect, Vector2 max)
	{
		rect.max = max;
		return rect;
	}

	public static Rect AddMax(this Rect rect, Vector2 value)
	{
		rect.max += value;
		return rect;
	}

	public static Rect SubMax(this Rect rect, Vector2 value)
	{
		rect.max -= value;
		return rect;
	}

	public static Rect SetXMin(this Rect rect, float xMin)
	{
		rect.xMin = xMin;
		return rect;
	}

	public static Rect AddXMin(this Rect rect, float value)
	{
		rect.xMin += value;
		return rect;
	}

	public static Rect SubXMin(this Rect rect, float value)
	{
		rect.xMin -= value;
		return rect;
	}

	public static Rect SetXMax(this Rect rect, float xMax)
	{
		rect.xMax = xMax;
		return rect;
	}

	public static Rect AddXMax(this Rect rect, float value)
	{
		rect.xMax += value;
		return rect;
	}

	public static Rect SubXMax(this Rect rect, float value)
	{
		rect.xMax -= value;
		return rect;
	}

	public static Rect SetYMin(this Rect rect, float yMin)
	{
		rect.yMin = yMin;
		return rect;
	}

	public static Rect AddYMin(this Rect rect, float value)
	{
		rect.yMin += value;
		return rect;
	}

	public static Rect SubYMin(this Rect rect, float value)
	{
		rect.yMin -= value;
		return rect;
	}

	public static Rect SetYMax(this Rect rect, float yMax)
	{
		rect.yMax = yMax;
		return rect;
	}

	public static Rect AddYMax(this Rect rect, float value)
	{
		rect.yMax += value;
		return rect;
	}

	public static Rect SubYMax(this Rect rect, float value)
	{
		rect.yMax -= value;
		return rect;
	}

	public static Rect MinWidth(this Rect rect, float minWidth)
	{
		rect.width = Mathf.Max(rect.width, minWidth);
		return rect;
	}

	public static Rect MaxWidth(this Rect rect, float maxWidth)
	{
		rect.width = Mathf.Min(rect.width, maxWidth);
		return rect;
	}

	public static Rect MinHeight(this Rect rect, float minHeight)
	{
		rect.height = Mathf.Max(rect.height, minHeight);
		return rect;
	}

	public static Rect MaxHeight(this Rect rect, float maxHeight)
	{
		rect.height = Mathf.Min(rect.height, maxHeight);
		return rect;
	}

	public static Rect ExpandTo(this Rect rect, Vector2 pos)
	{
		if (pos.x < rect.xMin)
		{
			rect.xMin = pos.x;
		}
		else if (pos.x > rect.xMax)
		{
			rect.xMax = pos.x;
		}
		if (pos.y < rect.yMin)
		{
			rect.yMin = pos.y;
		}
		else if (pos.y > rect.yMax)
		{
			rect.yMax = pos.y;
		}
		return rect;
	}
}
