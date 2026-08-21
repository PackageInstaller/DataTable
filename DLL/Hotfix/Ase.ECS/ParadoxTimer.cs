using GameFramework;

namespace Ase.ECS;

public class ParadoxTimer : IReference
{
	private float _currentTime;

	public float CurrentTime => _currentTime;

	public void Init(float currentTime)
	{
		_currentTime = currentTime;
	}

	public void Update(float deltaTime)
	{
		_currentTime -= deltaTime;
	}

	public void Clear()
	{
		_currentTime = 0f;
	}
}
