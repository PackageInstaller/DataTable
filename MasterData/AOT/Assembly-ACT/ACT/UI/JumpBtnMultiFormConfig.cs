using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

public class JumpBtnMultiFormConfig : JumpBtnConfig
{
	[Header("跳跃按钮各形态的配置信息")]
	public List<OperateBtnFormConfig> _formConfigs;
}
