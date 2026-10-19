using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

public class AttackBtnMultiFormConfig : AttackBtnConfig
{
	[Header("普攻按钮各形态的配置信息")]
	public List<OperateBtnFormConfig> _formConfigs;
}
