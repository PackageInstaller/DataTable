using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
public struct CachedAssetBundle(string name, Hash128 hash)
{
	private string m_Name = name;

	private Hash128 m_Hash = hash;

	public string name => m_Name;

	public Hash128 hash => m_Hash;
}
