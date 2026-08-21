namespace System.Diagnostics.Tracing;

[Flags]
public enum EventKeywords : long
{
	None = 0L,
	All = -1L,
	MicrosoftTelemetry = 0x2000000000000L,
	WdiContext = MicrosoftTelemetry,
	WdiDiagnostic = 0x4000000000000L,
	Sqm = 0x8000000000000L,
	AuditFailure = 0x10000000000000L,
	AuditSuccess = 0x20000000000000L,
	CorrelationHint = AuditFailure,
	EventLogClassic = 0x80000000000000L
}
