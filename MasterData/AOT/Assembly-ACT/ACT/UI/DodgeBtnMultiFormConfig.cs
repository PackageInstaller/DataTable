using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

public class DodgeBtnMultiFormConfig : DodgeBtnConfig
{
	[Header("闪避按钮各形态的配置信息")]
	public List<OperateBtnFormConfig> _formConfigs;
}
