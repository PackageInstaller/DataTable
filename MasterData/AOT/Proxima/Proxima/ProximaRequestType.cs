using System;

namespace Proxima;

[Serializable]
internal enum ProximaRequestType
{
	Command,
	StartStream,
	StopStream,
	List,
	Select
}
