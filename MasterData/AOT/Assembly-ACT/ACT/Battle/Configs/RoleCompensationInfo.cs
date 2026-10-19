using UnityEngine;

namespace ACT.Battle.Configs;

public class RoleCompensationInfo
{
	public RoleCompensationType roleCompensationType;

	public bool needCompensationMirror = true;

	public bool inputPriority = true;

	[Tooltip("默认可以设置朝向，只有少部分情况才不需要设置朝向")]
	public bool forceFaceDir = true;

	public bool frontNeedChangeDir;

	public RoleCompensationInfo()
	{
		roleCompensationType = RoleCompensationType.Compensation;
		needCompensationMirror = true;
		forceFaceDir = true;
		inputPriority = true;
	}
}
