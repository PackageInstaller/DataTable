using System;
using System.ComponentModel;

namespace UnityEngine.ResourceManagement.ResourceProviders;

[DisplayName("JSON Asset Provider")]
public class JsonAssetProvider : TextDataProvider
{
	public override object Convert(Type type, string text)
	{
		return JsonUtility.FromJson(text, type);
	}
}
