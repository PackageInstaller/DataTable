using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/其它/显示距离")]
public class AdventureShowInDistance : MonoBehaviour
{
	public FP _showDistace;

	private Vector3 _startScale;

	private Vector3 _currentScale;

	private FP _currentDistance;

	private TSVector2 tsTransPos;

	private FP _sqDis;

	private void Start()
	{
		Transform transform = base.transform;
		_startScale = transform.localScale;
		_currentScale = _startScale;
		Vector3 position = transform.position;
		tsTransPos = new TSVector2(position.x, position.z);
	}

	private void OnEnable()
	{
		_sqDis = _showDistace * _showDistace;
	}

	private void Update()
	{
		if (!(SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor != null))
		{
			return;
		}
		_currentDistance = TSVector2.DistanceSquared(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position, tsTransPos);
		if (_currentDistance > _sqDis)
		{
			if (_currentScale.x != 0f)
			{
				transform.localScale = Vector3.zero;
				_currentScale = Vector3.zero;
			}
		}
		else if (_currentScale.x != _startScale.x)
		{
			transform.localScale = _startScale;
			_currentScale = _startScale;
		}
	}
}
