namespace Ase;

public interface IStringArgHandler : IArgHandler
{
	bool Handle(string eventName, string arg, int trackIndex);
}
