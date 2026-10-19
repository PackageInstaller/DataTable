using System.Collections.Generic;
using Unity;

namespace System.Runtime.Serialization;

public sealed class SafeSerializationEventArgs : EventArgs
{
	private StreamingContext m_streamingContext;

	private List<object> m_serializedStates;

	internal IList<object> SerializedStates => m_serializedStates;

	internal SafeSerializationEventArgs(StreamingContext streamingContext)
	{
		m_serializedStates = new List<object>();
		base._002Ector();
		m_streamingContext = streamingContext;
	}

	internal SafeSerializationEventArgs()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
