using System;

namespace ACT.Config;

[Serializable]
public class EffectDress
{
	public readonly int id;

	public readonly int roleid;

	public readonly int dressName;

	public readonly int dressDetail;

	public readonly int dressQuality;

	public readonly int dressType;

	public readonly string dressPath = "";

	public readonly int skinType;

	public readonly int skinJump;

	public EffectDress(int id, int roleid, int dressName, int dressDetail, int dressQuality, int dressType, string dressPath, int skinType, int skinJump)
	{
		this.id = id;
		this.roleid = roleid;
		this.dressName = dressName;
		this.dressDetail = dressDetail;
		this.dressQuality = dressQuality;
		this.dressType = dressType;
		this.dressPath = dressPath;
		this.skinType = skinType;
		this.skinJump = skinJump;
	}
}
