using UnityEngine;

public class BossDistance : MonoBehaviour
{
	public float bossHUDVisibleDistance = 12.5f;

	private bool _bindHud;

	public long id;

	public int skinId;

	public bool hideByFlowNode;

	private Transform _transform;

	private void Awake()
	{
		_transform = transform;
	}

	private void OnDisable()
	{
		if (_bindHud)
		{
			MonoSingleton<LuaManager>.Instance?.FireEvent("CloseBoss");
			_bindHud = false;
		}
	}

	private void Update()
	{
		Vector3 position = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.transform.position;
		Vector3 position2 = _transform.position;
		Vector2.Distance(new Vector2(position.x, position.z), new Vector2(position2.x, position2.z));
	}
}
