using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

public class SpAttackBtnMultiFormConfig : SpAttackBtnConfig
{
	[Header("技能按钮各形态的配置信息")]
	public List<OperateBtnFormConfig> _formConfigs;
}
