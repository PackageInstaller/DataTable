namespace Ase;

public interface IIntArgHandler : IArgHandler
{
	bool Handle(string eventName, int arg, int trackIndex);
}
