using System.Collections.Generic;

namespace Ase.ECS;

public class BulletHitData
{
	public int bulletConfigId;

	public List<string> bulletLabel;

	public int hitEntityId;

	public HitVolume hitVolumeData;
}
