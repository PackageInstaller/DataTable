using System.Collections.Generic;

namespace System.Runtime.Serialization;

public sealed class SafeSerializationEventArgs : EventArgs
{
	private StreamingContext m_streamingContext;

	private List<object> m_serializedStates = new List<object>();

	internal IList<object> SerializedStates => m_serializedStates;

	internal SafeSerializationEventArgs(StreamingContext streamingContext)
	{
		m_streamingContext = streamingContext;
	}
}
