using System;
using System.Collections.Generic;

namespace Ase.ECS;

public static class CollisionSetting
{
	[Flags]
	public enum CollisionLayer
	{
		None = 0,
		Hero = 2,
		Monster = 4,
		Boss = 8,
		Interactive = 0x10,
		Wall = 0x20,
		AirWall = 0x40,
		ShadowHero = 0x80,
		ShadowMonster = 0x100,
		ShadowBoss = 0x200,
		IgnoreBoss = 0x400,
		MonsterWall = 0x800,
		All = Hero | Monster | Boss | Interactive | Wall | AirWall | MonsterWall
	}

	public static Dictionary<CollisionLayer, CollisionLayer> MaskSetting = new Dictionary<CollisionLayer, CollisionLayer>
	{
		[CollisionLayer.Hero] = CollisionLayer.Monster | CollisionLayer.Boss | CollisionLayer.Interactive | CollisionLayer.Wall | CollisionLayer.AirWall,
		[CollisionLayer.Monster] = CollisionLayer.All,
		[CollisionLayer.Boss] = CollisionLayer.All,
		[CollisionLayer.Interactive] = CollisionLayer.All,
		[CollisionLayer.Wall] = CollisionLayer.None,
		[CollisionLayer.AirWall] = CollisionLayer.None,
		[CollisionLayer.IgnoreBoss] = CollisionLayer.None,
		[CollisionLayer.ShadowHero] = CollisionLayer.Monster | CollisionLayer.Boss | CollisionLayer.Interactive | CollisionLayer.Wall | CollisionLayer.AirWall,
		[CollisionLayer.ShadowMonster] = CollisionLayer.Interactive | CollisionLayer.Wall | CollisionLayer.AirWall | CollisionLayer.ShadowHero | CollisionLayer.ShadowMonster | CollisionLayer.ShadowBoss,
		[CollisionLayer.ShadowBoss] = CollisionLayer.Interactive | CollisionLayer.Wall | CollisionLayer.AirWall | CollisionLayer.ShadowHero | CollisionLayer.ShadowMonster | CollisionLayer.ShadowBoss
	};

	public static Dictionary<CollisionLayer, CollisionLayer> ObstacleSetting = new Dictionary<CollisionLayer, CollisionLayer>
	{
		[CollisionLayer.Hero] = CollisionLayer.Monster | CollisionLayer.Boss | CollisionLayer.Interactive | CollisionLayer.Wall | CollisionLayer.AirWall | CollisionLayer.IgnoreBoss,
		[CollisionLayer.Monster] = CollisionLayer.Boss | CollisionLayer.Interactive | CollisionLayer.Wall | CollisionLayer.AirWall | CollisionLayer.IgnoreBoss | CollisionLayer.MonsterWall,
		[CollisionLayer.Boss] = CollisionLayer.Interactive | CollisionLayer.Wall | CollisionLayer.AirWall | CollisionLayer.MonsterWall,
		[CollisionLayer.Interactive] = CollisionLayer.Wall | CollisionLayer.AirWall,
		[CollisionLayer.Wall] = CollisionLayer.None,
		[CollisionLayer.AirWall] = CollisionLayer.None,
		[CollisionLayer.IgnoreBoss] = CollisionLayer.None,
		[CollisionLayer.ShadowHero] = CollisionLayer.Monster | CollisionLayer.Boss | CollisionLayer.Interactive | CollisionLayer.Wall | CollisionLayer.AirWall | CollisionLayer.IgnoreBoss,
		[CollisionLayer.ShadowMonster] = CollisionLayer.Interactive | CollisionLayer.Wall | CollisionLayer.AirWall | CollisionLayer.ShadowBoss | CollisionLayer.IgnoreBoss,
		[CollisionLayer.ShadowBoss] = CollisionLayer.Interactive | CollisionLayer.Wall | CollisionLayer.AirWall | CollisionLayer.IgnoreBoss
	};

	public static CollisionLayer GetMaskLayer(CollisionLayer aLayer)
	{
		if (MaskSetting.ContainsKey(aLayer))
		{
			return MaskSetting[aLayer];
		}
		return CollisionLayer.None;
	}

	public static CollisionLayer GetObstacleLayer(CollisionLayer aLayer)
	{
		if (ObstacleSetting.ContainsKey(aLayer))
		{
			return ObstacleSetting[aLayer];
		}
		return CollisionLayer.None;
	}

	public static bool ObstacleCheck(CollisionLayer layer1, CollisionLayer layer2)
	{
		return (layer1 & layer2) == layer2;
	}

	public static bool CollisionCheck(CollisionLayer layer1, CollisionLayer layer2)
	{
		return (layer1 & layer2) == layer2;
	}
}
