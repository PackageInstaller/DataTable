using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Serialization.Formatters.Binary;

[ComVisible(true)]
public sealed class BinaryFormatter
{
	internal ISurrogateSelector m_surrogates;

	internal StreamingContext m_context;

	internal SerializationBinder m_binder;

	internal FormatterTypeStyle m_typeFormat = FormatterTypeStyle.TypesAlways;

	internal FormatterAssemblyStyle m_assemblyFormat;

	internal TypeFilterLevel m_securityLevel = TypeFilterLevel.Full;

	internal object[] m_crossAppDomainArray;

	private static Dictionary<Type, TypeInformation> typeNameCache = new Dictionary<Type, TypeInformation>();

	public FormatterAssemblyStyle AssemblyFormat
	{
		set
		{
			m_assemblyFormat = value;
		}
	}

	public ISurrogateSelector SurrogateSelector
	{
		set
		{
			m_surrogates = value;
		}
	}

	public BinaryFormatter()
	{
		m_surrogates = null;
		m_context = new StreamingContext(StreamingContextStates.All);
	}

	public BinaryFormatter(ISurrogateSelector selector, StreamingContext context)
	{
		m_surrogates = selector;
		m_context = context;
	}

	public object Deserialize(Stream serializationStream)
	{
		return Deserialize(serializationStream, null);
	}

	internal object Deserialize(Stream serializationStream, HeaderHandler handler, bool fCheck)
	{
		if (serializationStream == null)
		{
			throw new ArgumentNullException("serializationStream", Environment.GetResourceString("Parameter '{0}' cannot be null.", serializationStream));
		}
		if (serializationStream.CanSeek && serializationStream.Length == 0L)
		{
			throw new SerializationException(Environment.GetResourceString("Attempting to deserialize an empty stream."));
		}
		InternalFE internalFE = new InternalFE();
		internalFE.FEtypeFormat = m_typeFormat;
		internalFE.FEserializerTypeEnum = InternalSerializerTypeE.Binary;
		internalFE.FEassemblyFormat = m_assemblyFormat;
		internalFE.FEsecurityLevel = m_securityLevel;
		ObjectReader objectReader = new ObjectReader(serializationStream, m_surrogates, m_context, internalFE, m_binder);
		objectReader.crossAppDomainArray = m_crossAppDomainArray;
		return objectReader.Deserialize(handler, new __BinaryParser(serializationStream, objectReader), fCheck);
	}

	public object Deserialize(Stream serializationStream, HeaderHandler handler)
	{
		return Deserialize(serializationStream, handler, fCheck: true);
	}

	public void Serialize(Stream serializationStream, object graph)
	{
		Serialize(serializationStream, graph, null);
	}

	public void Serialize(Stream serializationStream, object graph, Header[] headers)
	{
		Serialize(serializationStream, graph, headers, fCheck: true);
	}

	internal void Serialize(Stream serializationStream, object graph, Header[] headers, bool fCheck)
	{
		if (serializationStream == null)
		{
			throw new ArgumentNullException("serializationStream", Environment.GetResourceString("Parameter '{0}' cannot be null.", serializationStream));
		}
		InternalFE internalFE = new InternalFE();
		internalFE.FEtypeFormat = m_typeFormat;
		internalFE.FEserializerTypeEnum = InternalSerializerTypeE.Binary;
		internalFE.FEassemblyFormat = m_assemblyFormat;
		ObjectWriter objectWriter = new ObjectWriter(m_surrogates, m_context, internalFE, m_binder);
		__BinaryWriter serWriter = new __BinaryWriter(serializationStream, objectWriter, m_typeFormat);
		objectWriter.Serialize(graph, headers, serWriter, fCheck);
		m_crossAppDomainArray = objectWriter.crossAppDomainArray;
	}

	internal static TypeInformation GetTypeInformation(Type type)
	{
		lock (typeNameCache)
		{
			TypeInformation value = null;
			if (!typeNameCache.TryGetValue(type, out value))
			{
				string clrAssemblyName = FormatterServices.GetClrAssemblyName(type, out var hasTypeForwardedFrom);
				value = new TypeInformation(FormatterServices.GetClrTypeFullName(type), clrAssemblyName, hasTypeForwardedFrom);
				typeNameCache.Add(type, value);
			}
			return value;
		}
	}
}
