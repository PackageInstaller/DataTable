using System;
using GameFramework.Runtime;

namespace Ase;

public class ToastDropdown
{
	public static async void Show(IUIViewGroup viewGroup, string text, float duration, string configData, UILayout layout, Action callback)
	{
		IUIView view = viewGroup.GetView("ToastDropdownView");
		ToastDropdownView toastDropdownView2;
		if (view != null && view is ToastDropdownView toastDropdownView)
		{
			toastDropdownView2 = toastDropdownView;
		}
		else
		{
			toastDropdownView2 = await GameEntry.UI.OpenUIView<ToastDropdownView>("Common/ToastDropdownView");
			toastDropdownView2.Init(viewGroup, layout);
		}
		if (toastDropdownView2 == null)
		{
			throw new NotFoundException("Not found the \"ToastDropdownView\".");
		}
		toastDropdownView2.ShowToast(text, duration, callback, configData);
	}
}
