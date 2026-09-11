using P08.T0World.Player;
using UnityEngine;

namespace T0World;

public class T0CharacterBlackborad : T0WorldBlackboard
{
	public int characterID;

	public GameObject collisionTestCollider;

	public float moveSpeed = 1f;

	public bool executeFollow;

	public AITest aiNode;

	public string loadResPath = "";

	public bool isOpenAi;

	public T0CharacterIkBehavior ikBehavior;

	public T0CharacterBehaviorAI aiBehaviour;

	private RuntimeAIConfig _config;

	public RuntimeAIConfig config
	{
		get
		{
			if (_config == null)
			{
				string path = $"T0World/Data/{T0WorldScene.Scene.characterID}/AI/Move-Runtime";
				_config = Asset.Load<RuntimeAIConfig>(path);
			}
			return _config;
		}
	}

	public void SetCollisionTestColliderState(bool show)
	{
		if (!(collisionTestCollider == null))
		{
			collisionTestCollider.gameObject.SetActive(show);
		}
	}

	public override void InitBlackboard()
	{
		base.InitBlackboard();
		ikBehavior?.InitCharaterIk(T0WorldScene.Scene.player.slowFollowNode);
	}

	public void InitAI()
	{
		if (characterID == 104402)
		{
			InitNewAI();
		}
		else
		{
			InitOldAI();
		}
		if (config != null && !base.EventContext.IsHaveEvent())
		{
			OpenAI();
		}
	}

	public void CloseAI()
	{
		isOpenAi = false;
		if (characterID == 104402)
		{
			CloseNewAI();
		}
		else
		{
			CloseOldAI();
		}
	}

	public void OpenAI()
	{
		isOpenAi = true;
		if (characterID == 104402)
		{
			OpenNewAI();
		}
		else
		{
			OpenOldAI();
		}
	}

	public void InitOldAI()
	{
		aiNode = U3DUtil.Get<AITest>(base.gameObject);
	}

	public void InitNewAI()
	{
		aiBehaviour = U3DUtil.Get<T0CharacterBehaviorAI>(base.gameObject);
	}

	public void CloseOldAI()
	{
		if ((bool)aiNode)
		{
			aiNode.StopAllTask();
			aiNode.DisposeAI();
		}
	}

	public void OpenOldAI()
	{
		if ((bool)aiNode)
		{
			aiNode.InitAI(config);
			aiNode.SetFollowTarget(T0WorldScene.Scene.player.transform);
		}
	}

	public void CloseNewAI()
	{
		if ((bool)aiBehaviour)
		{
			aiBehaviour.StopAllTask();
			aiBehaviour.DisposeAI();
		}
	}

	public void OpenNewAI()
	{
		if ((bool)aiBehaviour)
		{
			aiBehaviour.InitAI(config);
			aiBehaviour.SetFollowTarget(T0WorldScene.Scene.player.transform);
		}
	}
}
