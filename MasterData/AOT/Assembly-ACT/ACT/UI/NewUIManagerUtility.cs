using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ACT.UI;

public static class NewUIManagerUtility
{
	public static string FormatUI(this IBaseUIController uiController)
	{
		if (uiController == null)
		{
			return "null";
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append($"[{uiController.UIType}] ");
		stringBuilder.Append($"State:{uiController.State} ");
		stringBuilder.Append($"Expected:{uiController.ExpectedState} ");
		stringBuilder.Append($"Uid:{uiController.Uid} ");
		stringBuilder.Append($"PanelType:{uiController.PanelType} ");
		stringBuilder.Append($"Layer:{uiController.SortingLayer} ");
		stringBuilder.Append($"Loaded:{uiController.IsLoadOver} ");
		stringBuilder.Append($"Hidden:{uiController.IsInHideRoot} ");
		stringBuilder.Append($"Blur:{uiController.IsBlurEnabled} ");
		stringBuilder.Append($"Strategy:{uiController.TransitionStrategy} ");
		stringBuilder.Append($"Lifetime:{uiController.LifetimePolicy} ");
		if (uiController.Parent != 0)
		{
			stringBuilder.Append($"Parent:{uiController.Parent} ");
		}
		if (uiController.Children.Count > 0)
		{
			stringBuilder.Append($"Children:{uiController.Children.Count} ");
		}
		return stringBuilder.ToString();
	}

	public static string FormatUIQueue(IEnumerable<IBaseUIController> uis, string name)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine($"{name} (Count: {uis.Count()}):");
		int num = 0;
		int num2 = uis.Count();
		foreach (IBaseUIController ui in uis)
		{
			stringBuilder.AppendLine($"  [{num}] {ui.FormatUI()}" + ((num == num2 - 1) ? " <Top>" : string.Empty));
			num++;
		}
		return stringBuilder.ToString();
	}
}
