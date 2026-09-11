using CriMana;
using UnityEngine;

public class CriManaMoviePlayerHolder : CriMonoBehaviour
{
	private Player _player;

	public Player player
	{
		set
		{
			_player = value;
		}
	}

	private void Awake()
	{
		Object.DontDestroyOnLoad(this);
	}

	public override void CriInternalUpdate()
	{
	}

	public override void CriInternalLateUpdate()
	{
	}

	private void Start()
	{
		_ = _player;
	}
}
