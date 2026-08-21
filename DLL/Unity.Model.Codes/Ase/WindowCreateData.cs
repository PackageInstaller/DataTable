#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class WindowCreateData
{
	private string viewPath;

	private ProcessType processType;

	private OuterModule outerModule;

	private Type type;

	private object viewModel;

	private UGuiWindow view;

	public Type Type => type;

	public ProcessType ProcessType => processType;

	public UGuiWindow View => view;

	public object ViewModel => viewModel;

	public string ViewPath => viewPath;

	public OuterModule OuterModule => outerModule;

	public WindowCreateData(string path, object userData, IWindow window)
	{
		try
		{
			if (window is UGuiWindow uGuiWindow)
			{
				outerModule = uGuiWindow.OuterModule;
				viewPath = path;
				view = uGuiWindow;
				processType = view.ProcessType;
				type = view.GetType();
				if (userData != null)
				{
					viewModel = userData;
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error("界面创建数据添加失败 " + path + " " + ex.StackTrace + " / " + ex.Message);
		}
	}

	public void SetViewAlpha(bool isShow)
	{
		if (!(view == null))
		{
			view.SetViewAlpha(isShow ? 1 : 0);
		}
	}

	public void ClearView()
	{
		if (view != null && !view.Dismissed)
		{
			view.OnCached();
			view = null;
		}
	}

	public void Clear()
	{
		viewPath = null;
		viewModel = null;
		if (view != null && !view.Dismissed)
		{
			if (!view.CloseInversion())
			{
				view.Dismiss();
			}
			view = null;
		}
	}
}
