namespace ACT.World.StateObject;

public interface IExposeEntrySetting : ICommonInteractEntrySetting
{
	float ExposeTime { get; }

	float Timer { get; set; }

	InteractActionList OnExposeActionList { get; }
}
