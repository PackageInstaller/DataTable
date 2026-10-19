using System;
using System.Collections.Generic;
using ACT;
using ACT.Utility;
using Bamboo.ECS;
using Unity.VisualScripting;

public static class DebugMenuEx
{
	private static bool SelectedAll = true;

	private static HashSet<Entity> SelectedEntities = new HashSet<Entity>();

	private static void OnAddEntity(Entity obj)
	{
	}

	private static void OnRemoveEntity(Entity obj)
	{
		SelectedEntities.Remove(obj);
	}

	public static void SetSelectAll(bool selectAll)
	{
		if (SelectedAll != selectAll)
		{
			SelectedEntities.Clear();
			try
			{
				if (selectAll)
				{
					CustomExtension.AddRange(SelectedEntities, GameManager.entities.GetAllEntities());
				}
			}
			catch (Exception)
			{
			}
		}
		SelectedAll = selectAll;
	}

	public static bool GetSelectAll()
	{
		return SelectedAll;
	}

	public static void SetSelect(Entity entityBehave, bool selected)
	{
		if (selected)
		{
			SelectedEntities.Add(entityBehave);
			return;
		}
		if (SelectedAll)
		{
			SelectedAll = false;
			try
			{
				CustomExtension.AddRange(SelectedEntities, GameManager.entities.GetAllEntities());
			}
			catch (Exception)
			{
			}
		}
		SelectedEntities.Remove(entityBehave);
	}

	public static bool ValidEntity(Entity entityBehave)
	{
		return true;
	}

	public static ICollection<Entity> GetSelectedEntities()
	{
		return SelectedEntities.AsReadOnlyCollection();
	}
}
