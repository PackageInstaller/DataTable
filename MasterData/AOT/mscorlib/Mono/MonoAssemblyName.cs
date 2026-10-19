using System;

namespace Mono;

internal struct MonoAssemblyName
{
	internal IntPtr name;

	internal IntPtr culture;

	internal IntPtr hash_value;

	internal IntPtr public_key;

	internal unsafe fixed byte public_key_token[17];

	internal uint hash_alg;

	internal uint hash_len;

	internal uint flags;

	internal ushort major;

	internal ushort minor;

	internal ushort build;

	internal ushort revision;

	internal ushort arch;
}
