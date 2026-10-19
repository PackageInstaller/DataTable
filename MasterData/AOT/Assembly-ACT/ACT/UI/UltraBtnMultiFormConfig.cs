using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

public class UltraBtnMultiFormConfig : UltraBtnConfig
{
	[Header("大招按钮各形态的配置信息")]
	public List<OperateBtnFormConfig> _formConfigs;
}
