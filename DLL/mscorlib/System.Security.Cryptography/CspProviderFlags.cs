using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[Serializable]
[Flags]
[ComVisible(true)]
public enum CspProviderFlags
{
	NoFlags = 0,
	UseMachineKeyStore = 1,
	UseDefaultKeyContainer = 2,
	UseNonExportableKey = 4,
	UseExistingKey = 8,
	UseArchivableKey = 0x10,
	UseUserProtectedKey = 0x20,
	NoPrompt = 0x40,
	CreateEphemeralKey = 0x80
}
