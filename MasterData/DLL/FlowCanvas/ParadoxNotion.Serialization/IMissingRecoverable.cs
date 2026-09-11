namespace ParadoxNotion.Serialization;

public interface IMissingRecoverable
{
	string missingType { get; set; }

	string recoveryState { get; set; }
}
