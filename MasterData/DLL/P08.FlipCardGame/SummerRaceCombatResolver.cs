using System;
using System.Collections.Generic;
using UnityEngine;

public static class SummerRaceCombatResolver
{
	public static bool TryResolveStatusHost(Collider2D other, out ICombatStatusHost statusHost)
	{
		statusHost = null;
		if (other == null)
		{
			return false;
		}
		SummerRaceEnemy componentInParent = other.GetComponentInParent<SummerRaceEnemy>();
		if (componentInParent != null)
		{
			statusHost = componentInParent;
			return true;
		}
		SummerRacePlayerController componentInParent2 = other.GetComponentInParent<SummerRacePlayerController>();
		if (componentInParent2 != null)
		{
			statusHost = componentInParent2;
			return true;
		}
		return false;
	}

	public static bool IsHostile(ICombatSourceContext sourceContext, ICombatStatusHost target)
	{
		if (sourceContext == null || target == null)
		{
			return false;
		}
		if (!target.IsCombatAlive)
		{
			return false;
		}
		if (sourceContext.CombatTeam == SummerRaceCombatTeam.None || target.CombatTeam == SummerRaceCombatTeam.None)
		{
			return true;
		}
		return sourceContext.CombatTeam != target.CombatTeam;
	}

	public static void ResolveTargets(ICombatSourceContext sourceContext, CombatTargetSelector selector, Vector2 aimDirection, float radius, List<ICombatStatusHost> results)
	{
		if (results == null)
		{
			throw new ArgumentNullException("results");
		}
		results.Clear();
		if (sourceContext == null || sourceContext.CombatSourceTransform == null)
		{
			return;
		}
		switch (selector)
		{
		case CombatTargetSelector.Self:
		{
			ICombatStatusHost combatStatusHost2 = sourceContext as ICombatStatusHost;
			if ((combatStatusHost2 == null || !combatStatusHost2.IsCombatAlive) && sourceContext.CombatSourceTransform != null)
			{
				combatStatusHost2 = sourceContext.CombatSourceTransform.GetComponentInParent<ICombatStatusHost>();
			}
			if (combatStatusHost2 != null && combatStatusHost2.IsCombatAlive)
			{
				results.Add(combatStatusHost2);
			}
			break;
		}
		case CombatTargetSelector.FrontSingle:
		{
			ICombatStatusHost combatStatusHost = FindFrontSingleTarget(sourceContext, aimDirection, radius);
			if (combatStatusHost != null)
			{
				results.Add(combatStatusHost);
			}
			break;
		}
		case CombatTargetSelector.FrontRadius:
			CollectTargetsInRadius(sourceContext, sourceContext.CombatSourceTransform.position + (Vector3)(NormalizeOrForward(aimDirection) * 1.1f), radius, results);
			break;
		}
	}

	public static void CollectTargetsNearPoint(ICombatSourceContext sourceContext, Vector2 center, float radius, List<ICombatStatusHost> results)
	{
		if (results == null)
		{
			throw new ArgumentNullException("results");
		}
		results.Clear();
		CollectTargetsInRadius(sourceContext, center, radius, results);
	}

	private static ICombatStatusHost FindFrontSingleTarget(ICombatSourceContext sourceContext, Vector2 aimDirection, float radius)
	{
		List<ICombatStatusHost> list = new List<ICombatStatusHost>(8);
		CollectTargetsInRadius(sourceContext, sourceContext.CombatSourceTransform.position, radius, list);
		Vector2 lhs = NormalizeOrForward(aimDirection);
		float num = float.MaxValue;
		ICombatStatusHost result = null;
		for (int i = 0; i < list.Count; i++)
		{
			ICombatStatusHost combatStatusHost = list[i];
			if (combatStatusHost == null || !combatStatusHost.IsCombatAlive)
			{
				continue;
			}
			Vector2 vector = combatStatusHost.CombatTransform.position - sourceContext.CombatSourceTransform.position;
			if (!(vector.sqrMagnitude <= 0.0001f) && !(Vector2.Dot(lhs, vector.normalized) <= 0.05f))
			{
				float sqrMagnitude = vector.sqrMagnitude;
				if (sqrMagnitude < num)
				{
					num = sqrMagnitude;
					result = combatStatusHost;
				}
			}
		}
		return result;
	}

	private static void CollectTargetsInRadius(ICombatSourceContext sourceContext, Vector2 center, float radius, List<ICombatStatusHost> results)
	{
		if (sourceContext == null)
		{
			return;
		}
		float num = Mathf.Max(0.01f, radius);
		float radiusSqr = num * num;
		if (sourceContext.CombatTeam == SummerRaceCombatTeam.Player)
		{
			for (int i = 0; i < SummerRaceEnemyRegistry.Count; i++)
			{
				SummerRaceEnemy summerRaceEnemy = SummerRaceEnemyRegistry.Get(i);
				if (!(summerRaceEnemy == null) && summerRaceEnemy.IsCombatAlive && IsHostWithinRadius(summerRaceEnemy, center, radiusSqr))
				{
					results.Add(summerRaceEnemy);
				}
			}
		}
		else if (sourceContext.CombatTeam == SummerRaceCombatTeam.Enemy)
		{
			SummerRacePlayerController summerRacePlayerController = ((SummerRaceFightManager.Instance != null) ? SummerRaceFightManager.Instance.CurrentPlayer : null);
			if (!(summerRacePlayerController == null) && summerRacePlayerController.IsCombatAlive && IsHostWithinRadius(summerRacePlayerController, center, radiusSqr))
			{
				results.Add(summerRacePlayerController);
			}
		}
	}

	private static bool IsHostWithinRadius(ICombatStatusHost host, Vector2 center, float radiusSqr)
	{
		if (host == null || host.CombatTransform == null)
		{
			return false;
		}
		if (((Vector2)host.CombatTransform.position - center).sqrMagnitude <= radiusSqr)
		{
			return true;
		}
		return IsAnyHostColliderWithinRadius(host, center, radiusSqr);
	}

	private static bool IsAnyHostColliderWithinRadius(ICombatStatusHost host, Vector2 center, float radiusSqr)
	{
		if (host == null || host.CombatTransform == null)
		{
			return false;
		}
		Collider2D[] componentsInChildren = host.CombatTransform.GetComponentsInChildren<Collider2D>(includeInactive: true);
		if (componentsInChildren == null || componentsInChildren.Length == 0)
		{
			return false;
		}
		foreach (Collider2D collider2D in componentsInChildren)
		{
			if (!(collider2D == null) && collider2D.enabled && collider2D.gameObject.activeInHierarchy && (collider2D.ClosestPoint(center) - center).sqrMagnitude <= radiusSqr)
			{
				return true;
			}
		}
		return false;
	}

	private static Vector2 NormalizeOrForward(Vector2 direction)
	{
		if (direction.sqrMagnitude > 0.0001f)
		{
			return direction.normalized;
		}
		return Vector2.right;
	}
}
