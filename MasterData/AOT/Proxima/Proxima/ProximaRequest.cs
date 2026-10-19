using System;

namespace Proxima;

[Serializable]
internal class ProximaRequest
{
	public string Id;

	public ProximaRequestType Type;

	public string Cmd;

	public string[] Args;
}
