namespace Ase;

public interface IFloatArgHandler : IArgHandler
{
	bool Handle(string eventName, float arg, int trackIndex);
}
