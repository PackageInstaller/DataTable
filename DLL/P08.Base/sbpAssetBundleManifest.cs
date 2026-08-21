using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

[Serializable]
public sealed class sbpAssetBundleManifest : ScriptableObject, ISerializationCallbackReceiver
{
	private Dictionary<string, BundleRef> m_Details;

	[SerializeField]
	private List<string> m_Bundles;

	[SerializeField]
	private List<BundleRef> m_BundleRefs;

	public void SetResults(List<BundleRef> bundleRefs, List<string> bundles)
	{
		m_Bundles = bundles;
		m_BundleRefs = bundleRefs;
		OnAfterDeserialize();
	}

	public string[] GetAllAssetBundles()
	{
		return m_Bundles.ToArray();
	}

	public string[] GetAllAssetBundlesWithVariant()
	{
		return new string[0];
	}

	public string[] GetDirectDependencies(string assetBundleName)
	{
		return GetAllDependencies(assetBundleName);
	}

	public string[] GetAllDependencies(string assetBundleName)
	{
		if (m_Details.TryGetValue(assetBundleName, out var value))
		{
			return value.Deps.Select((int index) => m_Bundles[index]).ToArray();
		}
		return new string[0];
	}

	public int[] GetAllDependenciesIndices(string assetBundleName)
	{
		if (m_Details.TryGetValue(assetBundleName, out var value))
		{
			return value.Deps;
		}
		return new int[0];
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("ManifestFileVersion: 1\n");
		stringBuilder.Append("CompatibilityAssetBundleManifest:\n");
		if (m_Details != null && m_Details.Count > 0)
		{
			stringBuilder.Append("  AssetBundleInfos:\n");
			int num = 0;
			foreach (KeyValuePair<string, BundleRef> detail in m_Details)
			{
				stringBuilder.AppendFormat("    Info_{0}:\n", num++);
				stringBuilder.AppendFormat("      Name: {0}\n", detail.Key);
				int num2 = 0;
				if (detail.Value.Deps != null && detail.Value.Deps.Length != 0)
				{
					stringBuilder.Append("      Dependencies:\n");
					int[] deps = detail.Value.Deps;
					foreach (int index in deps)
					{
						stringBuilder.AppendFormat("        Dependency_{0}: {1}\n", num2++, m_Bundles[index]);
					}
				}
				else
				{
					stringBuilder.Append("      Dependencies: {}\n");
				}
			}
		}
		else
		{
			stringBuilder.Append("  AssetBundleInfos: {}\n");
		}
		return stringBuilder.ToString();
	}

	public void OnBeforeSerialize()
	{
	}

	public void OnAfterDeserialize()
	{
		m_Details = new Dictionary<string, BundleRef>();
		for (int i = 0; i < m_BundleRefs.Count; i++)
		{
			BundleRef value = m_BundleRefs[i];
			m_Details.Add(m_Bundles[value.Bundle], value);
		}
	}
}
