using BilliardGame.Spell;
using P08.T0World.Player;
using Sirenix.OdinInspector;
using UnityEngine;

namespace T0World;

public class AITest : SerializedMonoBehaviour
{
	public BTEnv aiBehaviourEnv;

	private EasyObjectPoolManager easyPoolMgr;

	private void Start()
	{
		easyPoolMgr = new EasyObjectPoolManager();
		easyPoolMgr.Init();
	}

	private void Update()
	{
		aiBehaviourEnv?.Run();
	}

	public void InitAI(RuntimeAIConfig config)
	{
		aiBehaviourEnv = BTEnv.Create(config);
		InitParams(aiBehaviourEnv);
	}

	public void SetFollowTarget(Transform target, string name = "Target")
	{
		aiBehaviourEnv?.AddObject(name, target);
	}

	public void StopAllTask()
	{
		aiBehaviourEnv?.EndAllTask();
	}

	public void DisposeAI()
	{
		aiBehaviourEnv?.Dispose();
	}

	private void OnDestroy()
	{
		aiBehaviourEnv?.Dispose();
	}

	private void InitParams(BTEnv env)
	{
		env.AddObject("Self", base.gameObject);
	}
}
