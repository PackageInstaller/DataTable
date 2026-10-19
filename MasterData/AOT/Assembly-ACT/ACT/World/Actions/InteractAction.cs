using System.Collections;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public abstract class InteractAction : MonoBehaviour, IInteractActionListAssignable, IEnumerable<InteractActionList>, IEnumerable
{
	public enum InteractSource
	{
		Player,
		Others
	}

	protected StateObjectBase stateObjectBase;

	protected abstract AbilityAuth auth { get; }

	public virtual IEnumerator<InteractActionList> GetEnumerator()
	{
		yield break;
	}

	public void BindInteractObject(StateObjectBase stateObjectBase, GameObject workSpace = null)
	{
		this.stateObjectBase = stateObjectBase;
		using IEnumerator<InteractActionList> enumerator = GetEnumerator();
		while (enumerator.MoveNext())
		{
			InteractActionList current = enumerator.Current;
			if (current == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"必须在调用BindInteractObject前完成{this}的所有InteractActionList赋值！");
				}
			}
			else
			{
				current.BindInteractObject(stateObjectBase);
			}
		}
	}

	public UniTask TryInteract(Entity entity, InteractSource interactSource = InteractSource.Player)
	{
		if (stateObjectBase != null)
		{
			return OnInteract(entity, InteractSource.Player);
		}
		return UniTask.CompletedTask;
	}

	protected abstract UniTask OnInteract(Entity behave, InteractSource interactSource);
}
