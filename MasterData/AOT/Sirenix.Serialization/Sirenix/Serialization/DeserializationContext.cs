using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public sealed class DeserializationContext : ICacheNotificationReceiver
{
	private SerializationConfig config;

	private Dictionary<int, object> internalIdReferenceMap = new Dictionary<int, object>(128);

	private StreamingContext streamingContext;

	private IFormatterConverter formatterConverter;

	private TwoWaySerializationBinder binder;

	public TwoWaySerializationBinder Binder
	{
		get
		{
			if (binder == null)
			{
				binder = TwoWaySerializationBinder.Default;
			}
			return binder;
		}
		set
		{
			binder = value;
		}
	}

	public IExternalStringReferenceResolver StringReferenceResolver { get; set; }

	public IExternalGuidReferenceResolver GuidReferenceResolver { get; set; }

	public IExternalIndexReferenceResolver IndexReferenceResolver { get; set; }

	public StreamingContext StreamingContext => streamingContext;

	public IFormatterConverter FormatterConverter => formatterConverter;

	public SerializationConfig Config
	{
		get
		{
			if (config == null)
			{
				config = new SerializationConfig();
			}
			return config;
		}
		set
		{
			config = value;
		}
	}

	public DeserializationContext()
		: this(default, new FormatterConverter())
	{
	}

	public DeserializationContext(StreamingContext context)
		: this(context, new FormatterConverter())
	{
	}

	public DeserializationContext(FormatterConverter formatterConverter)
		: this(default, formatterConverter)
	{
	}

	public DeserializationContext(StreamingContext context, FormatterConverter formatterConverter)
	{
		if (formatterConverter == null)
		{
			throw new ArgumentNullException("formatterConverter");
		}
		streamingContext = context;
		this.formatterConverter = formatterConverter;
		Reset();
	}

	public void RegisterInternalReference(int id, object reference)
	{
		internalIdReferenceMap[id] = reference;
	}

	public object GetInternalReference(int id)
	{
		internalIdReferenceMap.TryGetValue(id, out var value);
		return value;
	}

	public object GetExternalObject(int index)
	{
		if (IndexReferenceResolver == null)
		{
			Config.DebugContext.LogWarning("Tried to resolve external reference by index (" + index + "), but no index reference resolver is assigned to the deserialization context. External reference has been lost.");
			return null;
		}
		if (IndexReferenceResolver.TryResolveReference(index, out var value))
		{
			return value;
		}
		Config.DebugContext.LogWarning("Failed to resolve external reference by index (" + index + "); the index resolver could not resolve the index. Reference lost.");
		return null;
	}

	public object GetExternalObject(Guid guid)
	{
		Guid guid2;
		if (GuidReferenceResolver == null)
		{
			DebugContext debugContext = Config.DebugContext;
			guid2 = guid;
			debugContext.LogWarning("Tried to resolve external reference by guid (" + guid2.ToString() + "), but no guid reference resolver is assigned to the deserialization context. External reference has been lost.");
			return null;
		}
		for (IExternalGuidReferenceResolver externalGuidReferenceResolver = GuidReferenceResolver; externalGuidReferenceResolver != null; externalGuidReferenceResolver = externalGuidReferenceResolver.NextResolver)
		{
			if (externalGuidReferenceResolver.TryResolveReference(guid, out var value))
			{
				return value;
			}
		}
		DebugContext debugContext2 = Config.DebugContext;
		guid2 = guid;
		debugContext2.LogWarning("Failed to resolve external reference by guid (" + guid2.ToString() + "); no guid resolver could resolve the guid. Reference lost.");
		return null;
	}

	public object GetExternalObject(string id)
	{
		if (StringReferenceResolver == null)
		{
			Config.DebugContext.LogWarning("Tried to resolve external reference by string (" + id + "), but no string reference resolver is assigned to the deserialization context. External reference has been lost.");
			return null;
		}
		for (IExternalStringReferenceResolver externalStringReferenceResolver = StringReferenceResolver; externalStringReferenceResolver != null; externalStringReferenceResolver = externalStringReferenceResolver.NextResolver)
		{
			if (externalStringReferenceResolver.TryResolveReference(id, out var value))
			{
				return value;
			}
		}
		Config.DebugContext.LogWarning("Failed to resolve external reference by string (" + id + "); no string resolver could resolve the string. Reference lost.");
		return null;
	}

	public void Reset()
	{
		if (config != null)
		{
			config.ResetToDefault();
		}
		internalIdReferenceMap.Clear();
		IndexReferenceResolver = null;
		GuidReferenceResolver = null;
		StringReferenceResolver = null;
		binder = null;
	}

	void ICacheNotificationReceiver.OnFreed()
	{
		Reset();
	}

	void ICacheNotificationReceiver.OnClaimed()
	{
	}
}
