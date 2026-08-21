using System.Configuration.Assemblies;
using System.Globalization;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Security;
using System.Text;
using Mono;

namespace System.Reflection;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[ClassInterface(ClassInterfaceType.None)]
[ComDefaultInterface(typeof(_AssemblyName))]
[ComVisible(true)]
public sealed class AssemblyName : ICloneable, ISerializable, IDeserializationCallback, _AssemblyName
{
	private string name;

	private string codebase;

	private int major;

	private int minor;

	private int build;

	private int revision;

	private CultureInfo cultureinfo;

	private AssemblyNameFlags flags;

	private AssemblyHashAlgorithm hashalg;

	private StrongNameKeyPair keypair;

	private byte[] publicKey;

	private byte[] keyToken;

	private AssemblyVersionCompatibility versioncompat;

	private Version version;

	private ProcessorArchitecture processor_architecture;

	private AssemblyContentType contentType;

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			name = value;
		}
	}

	public string CodeBase => codebase;

	public CultureInfo CultureInfo
	{
		get
		{
			return cultureinfo;
		}
		set
		{
			cultureinfo = value;
		}
	}

	public AssemblyNameFlags Flags
	{
		get
		{
			return flags;
		}
		set
		{
			flags = value;
		}
	}

	public string FullName
	{
		get
		{
			if (name == null)
			{
				return string.Empty;
			}
			StringBuilder stringBuilder = new StringBuilder();
			if (char.IsWhiteSpace(name[0]))
			{
				stringBuilder.Append("\"" + name + "\"");
			}
			else
			{
				stringBuilder.Append(name);
			}
			if (Version != null)
			{
				stringBuilder.Append(", Version=");
				stringBuilder.Append(Version.ToString());
			}
			if (cultureinfo != null)
			{
				stringBuilder.Append(", Culture=");
				if (cultureinfo.LCID == CultureInfo.InvariantCulture.LCID)
				{
					stringBuilder.Append("neutral");
				}
				else
				{
					stringBuilder.Append(cultureinfo.Name);
				}
			}
			byte[] array = InternalGetPublicKeyToken();
			if (array != null)
			{
				if (array.Length == 0)
				{
					stringBuilder.Append(", PublicKeyToken=null");
				}
				else
				{
					stringBuilder.Append(", PublicKeyToken=");
					for (int i = 0; i < array.Length; i++)
					{
						stringBuilder.Append(array[i].ToString("x2"));
					}
				}
			}
			if ((Flags & AssemblyNameFlags.Retargetable) != AssemblyNameFlags.None)
			{
				stringBuilder.Append(", Retargetable=Yes");
			}
			return stringBuilder.ToString();
		}
	}

	public Version Version
	{
		get
		{
			return version;
		}
		set
		{
			version = value;
			if (value == null)
			{
				major = (minor = (build = (revision = 0)));
				return;
			}
			major = value.Major;
			minor = value.Minor;
			build = value.Build;
			revision = value.Revision;
		}
	}

	private bool IsPublicKeyValid
	{
		get
		{
			if (publicKey.Length == 16)
			{
				int num = 0;
				int num2 = 0;
				while (num < publicKey.Length)
				{
					num2 += publicKey[num++];
				}
				if (num2 == 4)
				{
					return true;
				}
			}
			switch (publicKey[0])
			{
			case 0:
				if (publicKey.Length > 12 && publicKey[12] == 6)
				{
					return true;
				}
				break;
			case 6:
				return true;
			}
			return false;
		}
	}

	[ComVisible(false)]
	public AssemblyContentType ContentType => contentType;

	public AssemblyName()
	{
		versioncompat = AssemblyVersionCompatibility.SameMachine;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool ParseAssemblyName(IntPtr name, out MonoAssemblyName aname, out bool is_version_definited, out bool is_token_defined);

	public unsafe AssemblyName(string assemblyName)
	{
		if (assemblyName == null)
		{
			throw new ArgumentNullException("assemblyName");
		}
		if (assemblyName.Length < 1)
		{
			throw new ArgumentException("assemblyName cannot have zero length.");
		}
		using SafeStringMarshal safeStringMarshal = RuntimeMarshal.MarshalString(assemblyName);
		if (!ParseAssemblyName(safeStringMarshal.Value, out var aname, out var is_version_definited, out var is_token_defined))
		{
			throw new FileLoadException("The assembly name is invalid.");
		}
		try
		{
			FillName(&aname, null, is_version_definited, addPublickey: false, is_token_defined, assemblyRef: false);
		}
		finally
		{
			RuntimeMarshal.FreeAssemblyName(ref aname, freeStruct: false);
		}
	}

	internal AssemblyName(SerializationInfo si, StreamingContext sc)
	{
		name = si.GetString("_Name");
		codebase = si.GetString("_CodeBase");
		version = (Version)si.GetValue("_Version", typeof(Version));
		publicKey = (byte[])si.GetValue("_PublicKey", typeof(byte[]));
		keyToken = (byte[])si.GetValue("_PublicKeyToken", typeof(byte[]));
		hashalg = (AssemblyHashAlgorithm)si.GetValue("_HashAlgorithm", typeof(AssemblyHashAlgorithm));
		keypair = (StrongNameKeyPair)si.GetValue("_StrongNameKeyPair", typeof(StrongNameKeyPair));
		versioncompat = (AssemblyVersionCompatibility)si.GetValue("_VersionCompatibility", typeof(AssemblyVersionCompatibility));
		flags = (AssemblyNameFlags)si.GetValue("_Flags", typeof(AssemblyNameFlags));
		int @int = si.GetInt32("_CultureInfo");
		if (@int != -1)
		{
			cultureinfo = new CultureInfo(@int);
		}
	}

	public override string ToString()
	{
		string fullName = FullName;
		if (fullName == null)
		{
			return base.ToString();
		}
		return fullName;
	}

	public byte[] GetPublicKey()
	{
		return publicKey;
	}

	public byte[] GetPublicKeyToken()
	{
		if (keyToken != null)
		{
			return keyToken;
		}
		if (publicKey == null)
		{
			return null;
		}
		if (publicKey.Length == 0)
		{
			return EmptyArray<byte>.Value;
		}
		if (!IsPublicKeyValid)
		{
			throw new SecurityException("The public key is not valid.");
		}
		keyToken = ComputePublicKeyToken();
		return keyToken;
	}

	private byte[] InternalGetPublicKeyToken()
	{
		if (keyToken != null)
		{
			return keyToken;
		}
		if (publicKey == null)
		{
			return null;
		}
		if (publicKey.Length == 0)
		{
			return EmptyArray<byte>.Value;
		}
		if (!IsPublicKeyValid)
		{
			throw new SecurityException("The public key is not valid.");
		}
		return ComputePublicKeyToken();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void get_public_token(byte* token, byte* pubkey, int len);

	private unsafe byte[] ComputePublicKeyToken()
	{
		byte[] array = new byte[8];
		fixed (byte* token = array)
		{
			fixed (byte* pubkey = publicKey)
			{
				get_public_token(token, pubkey, publicKey.Length);
			}
		}
		return array;
	}

	public static bool ReferenceMatchesDefinition(AssemblyName reference, AssemblyName definition)
	{
		if (reference == null)
		{
			throw new ArgumentNullException("reference");
		}
		if (definition == null)
		{
			throw new ArgumentNullException("definition");
		}
		return string.Equals(reference.Name, definition.Name, StringComparison.OrdinalIgnoreCase);
	}

	public void SetPublicKey(byte[] publicKey)
	{
		if (publicKey == null)
		{
			flags ^= AssemblyNameFlags.PublicKey;
		}
		else
		{
			flags |= AssemblyNameFlags.PublicKey;
		}
		this.publicKey = publicKey;
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("_Name", name);
		info.AddValue("_PublicKey", publicKey);
		info.AddValue("_PublicKeyToken", keyToken);
		info.AddValue("_CultureInfo", (cultureinfo != null) ? cultureinfo.LCID : (-1));
		info.AddValue("_CodeBase", codebase);
		info.AddValue("_Version", Version);
		info.AddValue("_HashAlgorithm", hashalg);
		info.AddValue("_HashAlgorithmForControl", AssemblyHashAlgorithm.None);
		info.AddValue("_StrongNameKeyPair", keypair);
		info.AddValue("_VersionCompatibility", versioncompat);
		info.AddValue("_Flags", flags);
		info.AddValue("_HashForControl", null);
	}

	public object Clone()
	{
		return new AssemblyName
		{
			name = name,
			codebase = codebase,
			major = major,
			minor = minor,
			build = build,
			revision = revision,
			version = version,
			cultureinfo = cultureinfo,
			flags = flags,
			hashalg = hashalg,
			keypair = keypair,
			publicKey = publicKey,
			keyToken = keyToken,
			versioncompat = versioncompat,
			processor_architecture = processor_architecture
		};
	}

	public void OnDeserialization(object sender)
	{
		Version = version;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern MonoAssemblyName* GetNativeName(IntPtr assembly_ptr);

	internal unsafe void FillName(MonoAssemblyName* native, string codeBase, bool addVersion, bool addPublickey, bool defaultToken, bool assemblyRef)
	{
		name = RuntimeMarshal.PtrToUtf8String(native->name);
		major = native->major;
		minor = native->minor;
		build = native->build;
		revision = native->revision;
		flags = (AssemblyNameFlags)native->flags;
		hashalg = (AssemblyHashAlgorithm)native->hash_alg;
		versioncompat = AssemblyVersionCompatibility.SameMachine;
		processor_architecture = (ProcessorArchitecture)native->arch;
		if (addVersion)
		{
			version = new Version(major, minor, build, revision);
		}
		codebase = codeBase;
		if (native->culture != IntPtr.Zero)
		{
			cultureinfo = CultureInfo.CreateCulture(RuntimeMarshal.PtrToUtf8String(native->culture), assemblyRef);
		}
		if (native->public_key != IntPtr.Zero)
		{
			publicKey = RuntimeMarshal.DecodeBlobArray(native->public_key);
			flags |= AssemblyNameFlags.PublicKey;
		}
		else if (addPublickey)
		{
			publicKey = EmptyArray<byte>.Value;
			flags |= AssemblyNameFlags.PublicKey;
		}
		if (*native->public_key_token != 0)
		{
			byte[] array = new byte[8];
			int i = 0;
			int num = 0;
			for (; i < 8; i++)
			{
				array[i] = (byte)(RuntimeMarshal.AsciHexDigitValue(native->public_key_token[num++]) << 4);
				array[i] |= (byte)RuntimeMarshal.AsciHexDigitValue(native->public_key_token[num++]);
			}
			keyToken = array;
		}
		else if (defaultToken)
		{
			keyToken = EmptyArray<byte>.Value;
		}
	}

	internal unsafe static AssemblyName Create(Assembly assembly, bool fillCodebase)
	{
		AssemblyName assemblyName = new AssemblyName();
		MonoAssemblyName* nativeName = GetNativeName(assembly.MonoAssembly);
		assemblyName.FillName(nativeName, fillCodebase ? assembly.CodeBase : null, addVersion: true, addPublickey: true, defaultToken: true, assemblyRef: false);
		return assemblyName;
	}
}
