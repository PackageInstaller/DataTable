public class MSDynamicTimelineTrackBinding : DynamicTimelineTrackBinding
{
	public bool ChangeMasterPose = true;

	public bool ChangeChipRolePose = true;

	public override void AutoInit()
	{
	}

	public override void ManualInit()
	{
		LoadDict();
		BuildBindings();
	}

	public void UpdateMasterSkinInfo(string roleSkinID)
	{
	}
}
