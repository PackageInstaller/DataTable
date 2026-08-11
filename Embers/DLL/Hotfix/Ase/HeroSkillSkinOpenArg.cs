namespace Ase;

public class HeroSkillSkinOpenArg
{
	public int HeroId;

	public int SkillId;

	public int SkinId;

	public int PropId;

	public static HeroSkillSkinOpenArg CreateByPropId(int propId)
	{
		if (propId <= 0)
		{
			return null;
		}
		DRHeroSkillSkin skinRow = GameEntry.DataTable.GetDataRow((DRHeroSkillSkin p) => p.PropId == propId);
		if (skinRow == null)
		{
			return null;
		}
		DRSkillSkinList dataRow = GameEntry.DataTable.GetDataRow((DRSkillSkinList p) => p.Id == skinRow.SkillId);
		if (dataRow == null)
		{
			return null;
		}
		return new HeroSkillSkinOpenArg
		{
			HeroId = dataRow.HeroId,
			SkillId = skinRow.Id,
			SkinId = skinRow.Id,
			PropId = propId
		};
	}
}
