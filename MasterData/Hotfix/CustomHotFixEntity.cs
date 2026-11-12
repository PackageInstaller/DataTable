using UnityEngine;

[AddComponentMenu("游戏/冒险模块/特殊实体/自定义热更实体")]
[DisallowMultipleComponent]
public class CustomHotFixEntity : LogicEntity, ISpecialEntity
{
	public string scriptPath;

	public bool needSmoothMove;

	private AdventureActor _owner;

	private AIAdapter _entityAI;

	public AdventureActor Owner => _owner;

	protected override void OnInit()
	{
		base.OnInit();
		if (needSmoothMove)
		{
			AddOrGetMonoLogicComponent<VisualSmooth>();
		}
		if (_entityAI == null)
		{
			_entityAI = new AIAdapter();
			if (!_entityAI.Initialize(scriptPath, gameObject))
			{
				_entityAI = null;
			}
		}
	}

	protected override void OnLogicUpdateEnabled()
	{
		tsTransform.transformSyncEnabled = false;
	}

	protected override void OnLogicUpdatePaused()
	{
		_entityAI?.Pause();
	}

	protected override void OnLogicUpdateResumed()
	{
		_entityAI?.Resume();
	}

	protected override void OnLogicUpdate()
	{
		_entityAI?.Update();
	}

	protected override void OnLogicUpdateDisabled()
	{
		tsTransform.transformSyncEnabled = true;
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		_entityAI?.Disable();
	}

	public void Setup(AdventureActor owner)
	{
		_owner = owner;
		_entityAI?.Start();
		EnableLogicUpdate();
	}

	public void Finish()
	{
		_entityAI?.Disable();
		SceneSingleton<SpecialEntityManager>.Instance.Despawn(transform);
	}
}
