using ACT.Battle;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Sound;

public class TriggerSound : ObjectSound
{
	private async void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (component.entity.IsValid && component.entity.GetEntityType() == EntityType.Character)
		{
			await UniTask.WaitUntil(() => this == null || MonoECS.instance.isStartWorld);
			if (!(this == null))
			{
				ParticalSystemSound();
			}
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (component.entity.IsValid && component.entity.GetEntityType() == EntityType.Character)
		{
			OnDestroy();
		}
	}

	private void OnEnable()
	{
		m_curIndex = 0;
		for (int num = references.Count - 1; num >= 0; num--)
		{
			if (references[num].IsNull)
			{
				references.RemoveAt(num);
			}
		}
	}
}
