using System.Collections.Generic;

namespace AIScript.LevelAndGroupController.Group;

public class S1_KuiLeiShiGroupController_Lv2 : KuiLeiShiGroupController
{
	protected override int BossID_XiaoMoXiang => 7010321;

	protected override int BossID_JuXingMoXiang => 7010322;

	protected override Dictionary<int, List<int>> GetSequenceDict()
	{
		return new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1004, 1016, 1002, 1004, 1011, 1002, 1004, 1012, 1003 },
			[2] = new List<int> { 1101 },
			[3] = new List<int> { 1051, 1052, 1053 }
		};
	}
}
