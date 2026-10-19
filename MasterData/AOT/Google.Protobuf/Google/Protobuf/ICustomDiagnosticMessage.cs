namespace Google.Protobuf;

public interface ICustomDiagnosticMessage : IMessage
{
	string ToDiagnosticString();
}
