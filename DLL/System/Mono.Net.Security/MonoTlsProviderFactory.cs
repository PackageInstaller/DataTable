using System;
using System.Collections.Generic;
using Mono.Security.Interface;
using Mono.Unity;

namespace Mono.Net.Security;

internal static class MonoTlsProviderFactory
{
	private static object locker = new object();

	private static bool initialized;

	private static MobileTlsProvider defaultProvider;

	private static Dictionary<string, Tuple<Guid, string>> providerRegistration;

	private static Dictionary<Guid, MobileTlsProvider> providerCache;

	internal static readonly Guid UnityTlsId = new Guid("06414A97-74F6-488F-877B-A6CA9BBEB82E");

	internal static readonly Guid AppleTlsId = new Guid("981af8af-a3a3-419a-9f01-a518e3a17c1c");

	internal static readonly Guid BtlsId = new Guid("432d18c9-9348-4b90-bfbf-9f2a10e1f15b");

	internal static MobileTlsProvider GetProviderInternal()
	{
		lock (locker)
		{
			InitializeInternal();
			return defaultProvider;
		}
	}

	internal static void InitializeInternal()
	{
		lock (locker)
		{
			if (!initialized)
			{
				SystemDependencyProvider.Initialize();
				InitializeProviderRegistration();
				MobileTlsProvider mobileTlsProvider;
				try
				{
					mobileTlsProvider = CreateDefaultProviderImpl();
				}
				catch (Exception innerException)
				{
					throw new NotSupportedException("TLS Support not available.", innerException);
				}
				if (mobileTlsProvider == null)
				{
					throw new NotSupportedException("TLS Support not available.");
				}
				if (!providerCache.ContainsKey(((MonoTlsProvider)mobileTlsProvider).ID))
				{
					providerCache.Add(((MonoTlsProvider)mobileTlsProvider).ID, mobileTlsProvider);
				}
				defaultProvider = mobileTlsProvider;
				initialized = true;
			}
		}
	}

	private static MobileTlsProvider LookupProvider(string name, bool throwOnError)
	{
		lock (locker)
		{
			InitializeProviderRegistration();
			if (!providerRegistration.TryGetValue(name, out var value))
			{
				if (throwOnError)
				{
					throw new NotSupportedException($"No such TLS Provider: `{name}'.");
				}
				return null;
			}
			if (providerCache.TryGetValue(value.Item1, out var value2))
			{
				return value2;
			}
			Type type = Type.GetType(value.Item2, throwOnError: false);
			if ((type == null) & throwOnError)
			{
				throw new NotSupportedException($"Could not find TLS Provider: `{value.Item2}'.");
			}
			try
			{
				value2 = (MobileTlsProvider)Activator.CreateInstance(type, nonPublic: true);
			}
			catch (Exception innerException)
			{
				throw new NotSupportedException($"Unable to instantiate TLS Provider `{type}'.", innerException);
			}
			if (value2 == null)
			{
				if (throwOnError)
				{
					throw new NotSupportedException($"No such TLS Provider: `{name}'.");
				}
				return null;
			}
			providerCache.Add(value.Item1, value2);
			return value2;
		}
	}

	private static void InitializeProviderRegistration()
	{
		lock (locker)
		{
			if (providerRegistration == null)
			{
				providerRegistration = new Dictionary<string, Tuple<Guid, string>>();
				providerCache = new Dictionary<Guid, MobileTlsProvider>();
				if (UnityTls.IsSupported)
				{
					PopulateUnityProviders();
				}
				else
				{
					PopulateProviders();
				}
			}
		}
	}

	private static void PopulateUnityProviders()
	{
		Tuple<Guid, string> value = new Tuple<Guid, string>(UnityTlsId, "Mono.Unity.UnityTlsProvider");
		providerRegistration.Add("default", value);
		providerRegistration.Add("unitytls", value);
	}

	private static void PopulateProviders()
	{
		object obj = null;
		Tuple<Guid, string> tuple = null;
		if (obj == null)
		{
			obj = tuple;
		}
		Tuple<Guid, string> tuple2 = (Tuple<Guid, string>)obj;
		if (tuple2 != null)
		{
			providerRegistration.Add("default", tuple2);
			providerRegistration.Add("legacy", tuple2);
		}
	}

	private static MobileTlsProvider CreateDefaultProviderImpl()
	{
		string text = Environment.GetEnvironmentVariable("MONO_TLS_PROVIDER");
		if (string.IsNullOrEmpty(text))
		{
			text = "default";
		}
		switch (text)
		{
		case "default":
		case "legacy":
			if (!UnityTls.IsSupported)
			{
				throw new NotSupportedException("TLS Support not available.");
			}
			goto case "unitytls";
		case "unitytls":
			return new UnityTlsProvider();
		default:
			return LookupProvider(text, throwOnError: true);
		}
	}

	internal static MobileTlsProvider GetProvider()
	{
		return GetProviderInternal();
	}
}
