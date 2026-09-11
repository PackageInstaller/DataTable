using UnityEngine;

public class WeaponLine : MonoBehaviour
{
	public Transform StartPoint;

	public Transform EndPoint;

	private SpringCurve _rope;

	private void Start()
	{
		if (_rope == null)
		{
			Initialize();
		}
	}

	public void Initialize()
	{
		_rope = U3DUtil.Get<SpringCurve>(base.gameObject);
		_rope.Initialize();
		_rope.From = StartPoint.position;
		_rope.To = EndPoint.position;
	}

	private void Update()
	{
		_rope.From = StartPoint.position;
		_rope.To = EndPoint.position;
	}

	private void OnDestroy()
	{
		_rope = null;
	}

	public void ShowLine(bool show = true)
	{
		if (_rope != null)
		{
			_rope.ShowLine(show);
		}
	}
}
