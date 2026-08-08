using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Dorm.Character;

public class InteractAreaScanner : MonoBehaviour
{
	public enum ScanDistinctType
	{
		EntityID,
		InteractArea,
		Custom
	}

	internal DormComplexEntity entity;

	internal ICollection<object> scaned = new HashSet<object>();

	private Func<IProvideInteractArea, object> distincFunc;

	public ScanDistinctType scanDistinct;

	[Range(0f, 1f)]
	public float rndPickChance = 0.5f;

	private bool active;

	public bool scanAtGridCenter;

	public Func<InteractAreaScanner, IProvideInteractArea, bool> onAreaScaned;

	public void StartScan(bool skipClear)
	{
		if (!skipClear)
		{
			ClearScaned();
		}
		active = true;
	}

	public void EndScan()
	{
		active = false;
	}

	private Collider[] ScanAtPos()
	{
		return Physics.OverlapSphere(entity.GetWorldPos(), entity.radius, LayerMask.GetMask("Ignore Raycast"));
	}

	private Collider[] ScanAtSnapGridPos()
	{
		return Physics.OverlapSphere((Vector3)AstarPath.active.GetNearest((Int3)entity.GetWorldPos()).node.position, entity.radius, LayerMask.GetMask("Ignore Raycast"), QueryTriggerInteraction.Collide);
	}

	private static bool DefaultOnAreaScan(InteractAreaScanner scanner, IProvideInteractArea area)
	{
		DormComplexEntity dormComplexEntity = scanner.entity;
		int? num = area.ProvideAction(dormComplexEntity, out var interactPos, out var exitPos);
		if (UnityEngine.Random.value < scanner.rndPickChance && num.HasValue && area.AnyActionAvailable(dormComplexEntity))
		{
			scanner.EndScan();
			DormEntityAction.Notify("ON_DORM_CHARACTER_MOVE_PICK_INTERACT_AREA", dormComplexEntity.id, area.Provider.EntityID, interactPos, exitPos, num.Value);
			return true;
		}
		return false;
	}

	private void Scan()
	{
		foreach (IProvideInteractArea item in (scanAtGridCenter ? ScanAtSnapGridPos() : ScanAtPos()).Select((Collider c) => c.GetComponent<IProvideInteractArea>()).Where(delegate(IProvideInteractArea area)
		{
			Behaviour behaviour = area as Behaviour;
			return (bool)behaviour && behaviour.enabled;
		}))
		{
			if (!scaned.Contains(ScanedKey(item)))
			{
				bool num = (onAreaScaned ?? new Func<InteractAreaScanner, IProvideInteractArea, bool>(DefaultOnAreaScan))(this, item);
				AddScaned(item);
				if (num)
				{
					break;
				}
			}
		}
	}

	private object ScanedKey(IProvideInteractArea area)
	{
		return scanDistinct switch
		{
			ScanDistinctType.EntityID => area.Provider.EntityID, 
			ScanDistinctType.InteractArea => area, 
			_ => distincFunc?.Invoke(area) ?? ((object)area.Provider.EntityID), 
		};
	}

	private void AddScaned(IProvideInteractArea area)
	{
		scaned.Add(ScanedKey(area));
	}

	private void Update()
	{
		if (active)
		{
			Scan();
		}
	}

	public void SetEntityAsScaned(int entityID)
	{
		scaned.Add(entityID);
	}

	public void ClearScaned()
	{
		scaned.Clear();
	}
}
