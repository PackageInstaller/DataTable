using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using UnityEngine;

namespace ACT.LocalLoader;

public static class AotConstValues
{
	private static List<JObject> _taPublicProperties;

	public const string VERSIONFILENAME = "version.json";

	public const string ROOTVERSIONNAME = "root_version";

	public const string LATESTVERSIONNAME = "last_version";

	public const string BRANCHNAME = "branch";

	public const string BUILDNAME = "build_name";

	public const string REMOTEVERSIONURL = "remoteAddress";

	public const string INITSCENE = "initScene_Name";

	public const string UISAFEAREA_CHANGE = "UISAFEAREA_CHANGE";

	public const string UISAFEAREA_CHANGE2 = "UISAFEAREA_CHANGE2";

	public const string WHITELIST_VALIDATE_URL = "https://bamboo.zhuziplay.com/lvmeng/validate";

	public static List<JObject> TaPublicProperties
	{
		get
		{
			if (_taPublicProperties == null)
			{
				_taPublicProperties = new List<JObject>
				{
					new JObject
					{
						["is_editor"] = false,
						["client_version"] = LuminApplication.DisplayVersion,
						["cpu_name"] = SystemInfo.processorType,
						["gpu_name"] = SystemInfo.graphicsDeviceName
					}
				};
			}
			return _taPublicProperties;
		}
	}

	public static void ClearProperties()
	{
		_taPublicProperties = null;
	}
}
