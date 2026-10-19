using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

public class PromptProcessConfig : ScriptableObject
{
	public int id;

	public List<OperateNodeConfig> operateNodeConfigs;

	public LocalizeStringConfig describeLocalizeConfig;

	public LocalizeStringConfig titleLocalizeConfig;
}
