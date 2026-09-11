using UnityEngine;

namespace Chess;

public class CountDownUI : MonoBehaviour
{
	private Camera _mainCamera;

	private SpriteRenderer _spriteRenderer;

	private bool m_dirty;

	private void Awake()
	{
		if (_mainCamera == null)
		{
			_mainCamera = Camera.main;
		}
		if (_spriteRenderer == null)
		{
			Transform transform = base.transform.Find("num");
			_spriteRenderer = transform.GetComponent<SpriteRenderer>();
		}
	}

	public void SetText(int num)
	{
		_spriteRenderer.sprite = AtlasManager.GetSprite("Atlas/WarChess_BattleAtlas", $"step_countdown_{num}");
	}

	private void LateUpdate()
	{
		_ = Camera.main.transform.position - base.transform.position;
		base.transform.rotation = Quaternion.LookRotation(new Vector3(0f, 0.7071f, -0.7071f));
	}
}
