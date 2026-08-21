using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using MessagePack.Resolvers;

namespace MessagePack;

public class MessagePackSerializerOptions
{
	private static class MessagePackSerializerOptionsDefaultSettingsLazyInitializationHelper
	{
		public static readonly MessagePackSerializerOptions Standard = new MessagePackSerializerOptions(StandardResolver.Instance);
	}

	internal static readonly Regex AssemblyNameVersionSelectorRegex = new Regex(", Version=\\d+.\\d+.\\d+.\\d+, Culture=[\\w-]+, PublicKeyToken=(?:null|[a-f0-9]{16})", RegexOptions.Compiled);

	private static readonly HashSet<string> DisallowedTypes = new HashSet<string> { "System.CodeDom.Compiler.TempFileCollection", "System.Management.IWbemClassObjectFreeThreaded" };

	public static MessagePackSerializerOptions Standard => MessagePackSerializerOptionsDefaultSettingsLazyInitializationHelper.Standard;

	public IFormatterResolver Resolver { get; private set; }

	public MessagePackCompression Compression { get; private set; }

	public bool? OldSpec { get; private set; }

	public bool OmitAssemblyVersion { get; private set; }

	public bool AllowAssemblyVersionMismatch { get; private set; }

	public MessagePackSecurity Security { get; private set; } = MessagePackSecurity.TrustedData;

	public SequencePool SequencePool { get; private set; } = SequencePool.Shared;

	protected internal MessagePackSerializerOptions(IFormatterResolver resolver)
	{
		Resolver = resolver ?? throw new ArgumentNullException("resolver");
	}

	protected MessagePackSerializerOptions(MessagePackSerializerOptions copyFrom)
	{
		if (copyFrom == null)
		{
			throw new ArgumentNullException("copyFrom");
		}
		Resolver = copyFrom.Resolver;
		Compression = copyFrom.Compression;
		OldSpec = copyFrom.OldSpec;
		OmitAssemblyVersion = copyFrom.OmitAssemblyVersion;
		AllowAssemblyVersionMismatch = copyFrom.AllowAssemblyVersionMismatch;
		Security = copyFrom.Security;
		SequencePool = copyFrom.SequencePool;
	}

	public virtual Type LoadType(string typeName)
	{
		Type type = Type.GetType(typeName, throwOnError: false);
		if (type == null && AllowAssemblyVersionMismatch)
		{
			string text = AssemblyNameVersionSelectorRegex.Replace(typeName, string.Empty);
			if (text != typeName)
			{
				type = Type.GetType(text, throwOnError: false);
			}
		}
		return type;
	}

	public virtual void ThrowIfDeserializingTypeIsDisallowed(Type type)
	{
		if (DisallowedTypes.Contains(type.FullName))
		{
			throw new MessagePackSerializationException("Deserialization attempted to create the type " + type.FullName + " which is not allowed.");
		}
	}

	public MessagePackSerializerOptions WithResolver(IFormatterResolver resolver)
	{
		if (Resolver == resolver)
		{
			return this;
		}
		MessagePackSerializerOptions messagePackSerializerOptions = Clone();
		messagePackSerializerOptions.Resolver = resolver;
		return messagePackSerializerOptions;
	}

	public MessagePackSerializerOptions WithCompression(MessagePackCompression compression)
	{
		if (Compression == compression)
		{
			return this;
		}
		MessagePackSerializerOptions messagePackSerializerOptions = Clone();
		messagePackSerializerOptions.Compression = compression;
		return messagePackSerializerOptions;
	}

	public MessagePackSerializerOptions WithOldSpec(bool? oldSpec = true)
	{
		if (OldSpec == oldSpec)
		{
			return this;
		}
		MessagePackSerializerOptions messagePackSerializerOptions = Clone();
		messagePackSerializerOptions.OldSpec = oldSpec;
		return messagePackSerializerOptions;
	}

	public MessagePackSerializerOptions WithOmitAssemblyVersion(bool omitAssemblyVersion)
	{
		if (OmitAssemblyVersion == omitAssemblyVersion)
		{
			return this;
		}
		MessagePackSerializerOptions messagePackSerializerOptions = Clone();
		messagePackSerializerOptions.OmitAssemblyVersion = omitAssemblyVersion;
		return messagePackSerializerOptions;
	}

	public MessagePackSerializerOptions WithAllowAssemblyVersionMismatch(bool allowAssemblyVersionMismatch)
	{
		if (AllowAssemblyVersionMismatch == allowAssemblyVersionMismatch)
		{
			return this;
		}
		MessagePackSerializerOptions messagePackSerializerOptions = Clone();
		messagePackSerializerOptions.AllowAssemblyVersionMismatch = allowAssemblyVersionMismatch;
		return messagePackSerializerOptions;
	}

	public MessagePackSerializerOptions WithSecurity(MessagePackSecurity security)
	{
		if (security == null)
		{
			throw new ArgumentNullException("security");
		}
		if (Security == security)
		{
			return this;
		}
		MessagePackSerializerOptions messagePackSerializerOptions = Clone();
		messagePackSerializerOptions.Security = security;
		return messagePackSerializerOptions;
	}

	public MessagePackSerializerOptions WithPool(SequencePool pool)
	{
		if (pool == null)
		{
			throw new ArgumentNullException("pool");
		}
		if (SequencePool == pool)
		{
			return this;
		}
		MessagePackSerializerOptions messagePackSerializerOptions = Clone();
		messagePackSerializerOptions.SequencePool = pool;
		return messagePackSerializerOptions;
	}

	protected virtual MessagePackSerializerOptions Clone()
	{
		if (GetType() != typeof(MessagePackSerializerOptions))
		{
			throw new NotSupportedException("The derived type " + GetType().FullName + " did not override the Clone method as required.");
		}
		return new MessagePackSerializerOptions(this);
	}
}
