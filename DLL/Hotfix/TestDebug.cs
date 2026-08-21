using Ase;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("测试Log", 0)]
public class TestDebug : ActionTaskBase
{
	public BBParameter<string> Content;

	[Name("是否添加时间戳", 0)]
	public bool IsAddTimeStamp;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"测试Log  世界帧 ： {ownerEntity.GetWorld().Tick} 打印 : {Content.value} ", ownerEntity);
		}
		_ = IsAddTimeStamp;
		EndAction();
	}
}
