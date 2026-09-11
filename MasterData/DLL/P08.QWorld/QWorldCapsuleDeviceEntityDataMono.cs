public class QWorldCapsuleDeviceEntityDataMono : QWorldThingEntityDataMono
{
	protected override void InitData()
	{
		base.InitData();
		if (data.otherData == null)
		{
			data.otherData = new QWorldCapsuleDeviceEntityData();
		}
	}
}
