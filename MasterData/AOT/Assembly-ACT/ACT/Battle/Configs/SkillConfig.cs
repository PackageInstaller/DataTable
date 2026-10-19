using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class SkillConfig
{
	public string name;

	public int maxCount;

	public int addCount;

	public bool CDUseTable;

	[SerializeField]
	private float cd;

	public int switchSkillId;

	public bool whenUseResetCD;

	public uint cdProperty;

	public string[] motions;

	[Tooltip("是否被冷却缩减影响，如果勾选，则技能的CD会受到冷却缩减的影响")]
	public bool affectByCDR;

	public bool needSync;

	public float CD
	{
		get
		{
			if (CDUseTable)
			{
				Dictionary<int, EntityCharacterData> entityCharacterDatas = RuntimeConfigs.data.entityCharacterDatas;
				if (entityCharacterDatas.ContainsKey(switchSkillId))
				{
					return entityCharacterDatas[switchSkillId].switchSkillCD;
				}
				_ = LuminApplication.LogEnabled;
				return 0f;
			}
			return cd;
		}
		set
		{
			CDUseTable = false;
			cd = value;
		}
	}
}
