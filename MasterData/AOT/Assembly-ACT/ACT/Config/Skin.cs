using System;

namespace ACT.Config;

[Serializable]
public class Skin
{
	public readonly int id;

	public readonly int roleid;

	public readonly int skinname;

	public readonly int skindetail;

	public readonly int skinQuality;

	public readonly string model = "";

	public readonly string battleMapping = "";

	public readonly string characterAnimator = "";

	public readonly string teamAnimator = "";

	public readonly string loungeAnimator = "";

	public readonly string avgAnimator = "";

	public readonly string skinUIAnimator = "";

	public readonly int skinType;

	public readonly int skinJump;

	public Skin(int id, int roleid, int skinname, int skindetail, int skinQuality, string model, string battleMapping, string characterAnimator, string teamAnimator, string loungeAnimator, string avgAnimator, string skinUIAnimator, int skinType, int skinJump)
	{
		this.id = id;
		this.roleid = roleid;
		this.skinname = skinname;
		this.skindetail = skindetail;
		this.skinQuality = skinQuality;
		this.model = model;
		this.battleMapping = battleMapping;
		this.characterAnimator = characterAnimator;
		this.teamAnimator = teamAnimator;
		this.loungeAnimator = loungeAnimator;
		this.avgAnimator = avgAnimator;
		this.skinUIAnimator = skinUIAnimator;
		this.skinType = skinType;
		this.skinJump = skinJump;
	}
}
