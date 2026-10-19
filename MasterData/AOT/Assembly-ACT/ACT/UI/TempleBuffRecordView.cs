using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using UnityEngine;

namespace ACT.UI;

public class TempleBuffRecordView : BaseUIView<TempleRecordInputController>
{
	public List<TempleBuffNode> buffNodes;

	public GameObject btnPromptRoot;

	public ActButton closeBtn;

	private TempleBuffRecordViewData m_data;

	protected override void Init()
	{
		closeBtn?.SetBtnClick(Close);
		btnPromptRoot?.SetActive(MonoECS.instance.IsGamePadMode());
		List<TempleBuffNode> list = buffNodes;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		TempleData curChallengeTempleData = Model<TempleModel>.Interface.GetCurChallengeTempleData();
		if (curChallengeTempleData != null)
		{
			InstanceDungeon staticData = curChallengeTempleData.staticData;
			if (staticData != null && staticData.type == 1)
			{
				Dictionary<int, int> battleTempleBuffMap = curChallengeTempleData.battleTempleBuffMap;
				if (battleTempleBuffMap == null || battleTempleBuffMap.Count <= 0)
				{
					buffNodes.ForEach((TempleBuffNode i) =>
					{
						i.Init(null, Station);
					});
					return;
				}
				Dictionary<int, int> battleTempleBuffMap2 = curChallengeTempleData.battleTempleBuffMap;
				for (int num = 0; num < buffNodes.Count; num++)
				{
					TempleBuffNodeData data = (battleTempleBuffMap2.TryGetValue(num, out var value) ? new TempleBuffNodeData
					{
						buffId = value,
						iconId = CoreUtils.GetData(battleTempleBuffMap2[num], RuntimeConfigs.data.instanceDungeonSkills).skillIcon
					} : null);
					buffNodes[num].Init(data, Station);
				}
				return;
			}
		}
		Close();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		btnPromptRoot?.SetActive(type == DeviceInputMode.Gamepad);
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}
}
