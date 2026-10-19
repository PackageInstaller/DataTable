using System;
using System.Collections.Generic;
using UnityEngine;

namespace Sirenix.OdinInspector;

public static class SelfValidationResultItemExtensions
{
	public static ref SelfValidationResult.ResultItem WithFix(this ref SelfValidationResult.ResultItem item, string title, Action fix, bool offerInInspector = true)
	{
		item.Fix = SelfFix.Create(title, fix, offerInInspector);
		return ref item;
	}

	public static ref SelfValidationResult.ResultItem WithFix<T>(this ref SelfValidationResult.ResultItem item, string title, Action<T> fix, bool offerInInspector = true) where T : new()
	{
		item.Fix = SelfFix.Create(title, fix, offerInInspector);
		return ref item;
	}

	public static ref SelfValidationResult.ResultItem WithFix(this ref SelfValidationResult.ResultItem item, Action fix, bool offerInInspector = true)
	{
		item.Fix = SelfFix.Create(fix, offerInInspector);
		return ref item;
	}

	public static ref SelfValidationResult.ResultItem WithFix<T>(this ref SelfValidationResult.ResultItem item, Action<T> fix, bool offerInInspector = true) where T : new()
	{
		item.Fix = SelfFix.Create(fix, offerInInspector);
		return ref item;
	}

	public static ref SelfValidationResult.ResultItem WithFix(this ref SelfValidationResult.ResultItem item, SelfFix fix)
	{
		item.Fix = fix;
		return ref item;
	}

	public static ref SelfValidationResult.ResultItem WithContextClick(this ref SelfValidationResult.ResultItem item, Func<IEnumerable<SelfValidationResult.ContextMenuItem>> onContextClick)
	{
		ref Func<IEnumerable<SelfValidationResult.ContextMenuItem>> onContextClick2 = ref item.OnContextClick;
		onContextClick2 = (Func<IEnumerable<SelfValidationResult.ContextMenuItem>>)Delegate.Combine(onContextClick2, onContextClick);
		return ref item;
	}

	public static ref SelfValidationResult.ResultItem WithContextClick(this ref SelfValidationResult.ResultItem item, string path, Action onClick)
	{
		ref Func<IEnumerable<SelfValidationResult.ContextMenuItem>> onContextClick = ref item.OnContextClick;
		onContextClick = (Func<IEnumerable<SelfValidationResult.ContextMenuItem>>)Delegate.Combine(onContextClick, (Func<IEnumerable<SelfValidationResult.ContextMenuItem>>)(() => new SelfValidationResult.ContextMenuItem[1]
		{
			new SelfValidationResult.ContextMenuItem
			{
				Path = path,
				OnClick = onClick
			}
		}));
		return ref item;
	}

	public static ref SelfValidationResult.ResultItem WithContextClick(this ref SelfValidationResult.ResultItem item, string path, bool on, Action onClick)
	{
		ref Func<IEnumerable<SelfValidationResult.ContextMenuItem>> onContextClick = ref item.OnContextClick;
		onContextClick = (Func<IEnumerable<SelfValidationResult.ContextMenuItem>>)Delegate.Combine(onContextClick, (Func<IEnumerable<SelfValidationResult.ContextMenuItem>>)(() => new SelfValidationResult.ContextMenuItem[1]
		{
			new SelfValidationResult.ContextMenuItem
			{
				Path = path,
				On = on,
				OnClick = onClick
			}
		}));
		return ref item;
	}

	public static ref SelfValidationResult.ResultItem WithContextClick(this ref SelfValidationResult.ResultItem item, SelfValidationResult.ContextMenuItem onContextClick)
	{
		ref Func<IEnumerable<SelfValidationResult.ContextMenuItem>> onContextClick2 = ref item.OnContextClick;
		onContextClick2 = (Func<IEnumerable<SelfValidationResult.ContextMenuItem>>)Delegate.Combine(onContextClick2, (Func<IEnumerable<SelfValidationResult.ContextMenuItem>>)(() => new SelfValidationResult.ContextMenuItem[1] { onContextClick }));
		return ref item;
	}

	public static ref SelfValidationResult.ResultItem WithSceneGUI(this ref SelfValidationResult.ResultItem item, Action onSceneGUI)
	{
		item.OnSceneGUI = onSceneGUI;
		return ref item;
	}

	public static ref SelfValidationResult.ResultItem SetSelectionObject(this ref SelfValidationResult.ResultItem item, UnityEngine.Object uObj)
	{
		item.SelectionObject = uObj;
		return ref item;
	}

	public static ref SelfValidationResult.ResultItem EnableRichText(this ref SelfValidationResult.ResultItem item)
	{
		item.RichText = true;
		return ref item;
	}

	public static ref SelfValidationResult.ResultItem WithMetaData(this ref SelfValidationResult.ResultItem resultItem, string name, object value, params Attribute[] attributes)
	{
		resultItem.MetaData = resultItem.MetaData ?? new SelfValidationResult.ResultItemMetaData[0];
		Array.Resize(ref resultItem.MetaData, resultItem.MetaData.Length + 1);
		resultItem.MetaData[resultItem.MetaData.Length - 1] = new SelfValidationResult.ResultItemMetaData(name, value, attributes);
		return ref resultItem;
	}

	public static ref SelfValidationResult.ResultItem WithMetaData(this ref SelfValidationResult.ResultItem resultItem, object value, params Attribute[] attributes)
	{
		resultItem.MetaData = resultItem.MetaData ?? new SelfValidationResult.ResultItemMetaData[0];
		Array.Resize(ref resultItem.MetaData, resultItem.MetaData.Length + 1);
		resultItem.MetaData[resultItem.MetaData.Length - 1] = new SelfValidationResult.ResultItemMetaData(null, value, attributes);
		return ref resultItem;
	}

	public static ref SelfValidationResult.ResultItem WithButton(this ref SelfValidationResult.ResultItem resultItem, string name, Action onClick)
	{
		resultItem.MetaData = resultItem.MetaData ?? new SelfValidationResult.ResultItemMetaData[0];
		Array.Resize(ref resultItem.MetaData, resultItem.MetaData.Length + 1);
		resultItem.MetaData[resultItem.MetaData.Length - 1] = new SelfValidationResult.ResultItemMetaData(name, onClick);
		return ref resultItem;
	}
}
