using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public sealed class SerializationContext : ICacheNotificationReceiver
{
	private SerializationConfig config;

	private Dictionary<object, int> internalReferenceIdMap = new Dictionary<object, int>(128, ReferenceEqualityComparer<object>.Default);

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

	public StreamingContext StreamingContext => streamingContext;

	public IFormatterConverter FormatterConverter => formatterConverter;

	public IExternalIndexReferenceResolver IndexReferenceResolver { get; set; }

	public IExternalStringReferenceResolver StringReferenceResolver { get; set; }

	public IExternalGuidReferenceResolver GuidReferenceResolver { get; set; }

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

	public SerializationContext()
		: this(default, new FormatterConverter())
	{
	}

	public SerializationContext(StreamingContext context)
		: this(context, new FormatterConverter())
	{
	}

	public SerializationContext(FormatterConverter formatterConverter)
		: this(default, formatterConverter)
	{
	}

	public SerializationContext(StreamingContext context, FormatterConverter formatterConverter)
	{
		if (formatterConverter == null)
		{
			throw new ArgumentNullException("formatterConverter");
		}
		streamingContext = context;
		this.formatterConverter = formatterConverter;
		ResetToDefault();
	}

	public bool TryGetInternalReferenceId(object reference, out int id)
	{
		return internalReferenceIdMap.TryGetValue(reference, out id);
	}

	public bool TryRegisterInternalReference(object reference, out int id)
	{
		if (!internalReferenceIdMap.TryGetValue(reference, out id))
		{
			id = internalReferenceIdMap.Count;
			internalReferenceIdMap.Add(reference, id);
			return true;
		}
		return false;
	}

	public bool TryRegisterExternalReference(object obj, out int index)
	{
		if (IndexReferenceResolver == null)
		{
			index = -1;
			return false;
		}
		if (IndexReferenceResolver.CanReference(obj, out index))
		{
			return true;
		}
		index = -1;
		return false;
	}

	public bool TryRegisterExternalReference(object obj, out Guid guid)
	{
		if (GuidReferenceResolver == null)
		{
			guid = Guid.Empty;
			return false;
		}
		for (IExternalGuidReferenceResolver externalGuidReferenceResolver = GuidReferenceResolver; externalGuidReferenceResolver != null; externalGuidReferenceResolver = externalGuidReferenceResolver.NextResolver)
		{
			if (externalGuidReferenceResolver.CanReference(obj, out guid))
			{
				return true;
			}
		}
		guid = Guid.Empty;
		return false;
	}

	public bool TryRegisterExternalReference(object obj, out string id)
	{
		if (StringReferenceResolver == null)
		{
			id = null;
			return false;
		}
		for (IExternalStringReferenceResolver externalStringReferenceResolver = StringReferenceResolver; externalStringReferenceResolver != null; externalStringReferenceResolver = externalStringReferenceResolver.NextResolver)
		{
			if (externalStringReferenceResolver.CanReference(obj, out id))
			{
				return true;
			}
		}
		id = null;
		return false;
	}

	public void ResetInternalReferences()
	{
		internalReferenceIdMap.Clear();
	}

	public void ResetToDefault()
	{
		if (config != null)
		{
			config.ResetToDefault();
		}
		internalReferenceIdMap.Clear();
		IndexReferenceResolver = null;
		GuidReferenceResolver = null;
		StringReferenceResolver = null;
		binder = null;
	}

	void ICacheNotificationReceiver.OnFreed()
	{
		ResetToDefault();
	}

	void ICacheNotificationReceiver.OnClaimed()
	{
	}
}
