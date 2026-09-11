namespace MusicGame;

public abstract class MusicState : State
{
	protected MusicController owner;

	private void Awake()
	{
		owner = GetComponentInParent<MusicController>();
	}

	public override string ToString()
	{
		return GetType().Name;
	}
}
