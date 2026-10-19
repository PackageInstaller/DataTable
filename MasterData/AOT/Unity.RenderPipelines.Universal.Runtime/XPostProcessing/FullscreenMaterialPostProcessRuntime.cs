using System.Collections.Generic;

namespace XPostProcessing;

internal static class FullscreenMaterialPostProcessRuntime
{
	private static readonly List<FullscreenMaterialPostProcessController> Controllers = new List<FullscreenMaterialPostProcessController>(4);

	private static readonly List<FullscreenMaterialPostProcessController> ActiveControllers = new List<FullscreenMaterialPostProcessController>(4);

	internal static void Register(FullscreenMaterialPostProcessController controller)
	{
		if (!(controller == null) && !Controllers.Contains(controller))
		{
			Controllers.Add(controller);
		}
	}

	internal static void Unregister(FullscreenMaterialPostProcessController controller)
	{
		if (!(controller == null))
		{
			Controllers.Remove(controller);
		}
	}

	internal static List<FullscreenMaterialPostProcessController> GetActiveControllers()
	{
		ActiveControllers.Clear();
		int num = 0;
		while (num < Controllers.Count)
		{
			FullscreenMaterialPostProcessController fullscreenMaterialPostProcessController = Controllers[num];
			if (fullscreenMaterialPostProcessController == null)
			{
				Controllers.RemoveAt(num);
				continue;
			}
			if (!fullscreenMaterialPostProcessController.isActiveAndEnabled || fullscreenMaterialPostProcessController.Material == null || fullscreenMaterialPostProcessController.Weight <= 0f)
			{
				num++;
				continue;
			}
			InsertActiveController(fullscreenMaterialPostProcessController);
			num++;
		}
		return ActiveControllers;
	}

	private static void InsertActiveController(FullscreenMaterialPostProcessController controller)
	{
		int index = ActiveControllers.Count;
		for (int i = 0; i < ActiveControllers.Count; i++)
		{
			if (controller.Priority < ActiveControllers[i].Priority)
			{
				index = i;
				break;
			}
		}
		ActiveControllers.Insert(index, controller);
	}
}
