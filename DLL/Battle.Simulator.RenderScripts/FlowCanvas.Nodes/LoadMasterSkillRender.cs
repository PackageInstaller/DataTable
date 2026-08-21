using Config;
using NetProcol;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("加载芯片技能演出(渲染)", 0)]
[Category("Render/UI")]
[Description("加载芯片技能表现效果")]
public class LoadMasterSkillRender : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		ValueInput<string> trackPathInput = AddValueInput<string>("高级演出轨道路径", "trackPath").SetDefaultAndSerializedValue("StoryTimeline/MasterSkill/High/BaseTrack/masterskill_1001_track0");
		ValueInput<string> highPathInput = AddValueInput<string>("高级资源路径", "hightPath").SetDefaultAndSerializedValue("StoryTimeline/Win/{0}_win_battletpose");
		ValueInput<string> mediumPathInput = AddValueInput<string>("中级资源路径", "mediumPath").SetDefaultAndSerializedValue("TextureConfig/Character/Icon/{0}");
		ValueInput<string> lowPathInput = AddValueInput<string>("低级资源路径", "lowPath").SetDefaultAndSerializedValue("TextureConfig/Character/LittleIcon/{0}");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			RoleDataForExchangeInfo roleDataForExchangeInfo = battleScene.ready.SceneDataForExcehange.RoleDataInLua.get_Item(0);
			if (roleDataForExchangeInfo == null || roleDataForExchangeInfo.AIChip == null || roleDataForExchangeInfo.AIChip.Count <= 0)
			{
				errorOut.Call(f);
			}
			else
			{
				bool forceLow = false;
				if (battleScene.roleSkinID == 0)
				{
					for (int i = 0; i < roleDataForExchangeInfo.AIChip.Count; i++)
					{
						int num = roleDataForExchangeInfo.AIChip.get_Item(i);
						if (num == 0)
						{
							break;
						}
						if (!ConfigHelper.GetInstance().TryGetConfig<ai_chip>(num, out var config))
						{
							Debug.LogError($"芯片ID {num} 在ai_chip表里查询不到");
						}
						else
						{
							if (config.TypeId == 1)
							{
								forceLow = true;
								switch (config.ID)
								{
								case 1:
									battleScene.roleSkinID = 6066;
									break;
								case 2:
									battleScene.roleSkinID = 6063;
									break;
								case 3:
									battleScene.roleSkinID = 6064;
									break;
								case 4:
									battleScene.roleSkinID = 6062;
									break;
								case 5:
									battleScene.roleSkinID = 6065;
									break;
								case 6:
									battleScene.roleSkinID = 6061;
									break;
								}
								break;
							}
							if (config.TypeId == 4)
							{
								battleScene.roleSkinID = int.Parse(config.PictureId);
								break;
							}
						}
					}
				}
				if (battleScene.roleSkinID == 0)
				{
					errorOut.Call(f);
				}
				else
				{
					if (battleScene.roleSkinID == 6061 || battleScene.roleSkinID == 6062 || battleScene.roleSkinID == 6063 || battleScene.roleSkinID == 6064 || battleScene.roleSkinID == 6065 || battleScene.roleSkinID == 6066)
					{
						forceLow = true;
					}
					if (battleScene.masterSkinID == 0)
					{
						battleScene.masterSkinID = 1001;
					}
					string hightTrackPath = GetHightTrackPath(battleScene, trackPathInput.value);
					LoadMasterSkill(battleScene, hightTrackPath, highPathInput.value, mediumPathInput.value, lowPathInput.value, forceLow);
					f.Call(output);
				}
			}
		});
	}

	public void LoadMasterSkill(BattleScene bs, string trackPath, string highPath, string mediumPath, string lowPath, bool forceLow = false)
	{
		RoleDataForExchangeInfo roleDataForExchangeInfo = bs.ready.SceneDataForExcehange.RoleDataInLua.get_Item(0);
		if (roleDataForExchangeInfo == null || roleDataForExchangeInfo.AIChip == null)
		{
			return;
		}
		string text = bs.masterSkinID.ToString();
		string arg = bs.roleSkinID.ToString();
		EEffectQuality eEffectQuality = (EEffectQuality)bs.masterSkillLevel;
		if (forceLow)
		{
			eEffectQuality = EEffectQuality.Low;
		}
		switch (eEffectQuality)
		{
		case EEffectQuality.High:
		{
			GameObject gameObject2 = Asset.Instantiate(trackPath);
			if (!(gameObject2 != null))
			{
				break;
			}
			MSDynamicTimelineTrackBinding component = gameObject2.GetComponent<MSDynamicTimelineTrackBinding>();
			if (!(component != null))
			{
				break;
			}
			component.CharBindings[0].path = "Char/" + text + "ms_tpose";
			component.CharBindings[0].key = text + "ms_tpose";
			component.SceneBindings[0].key = text + "ms_tpose";
			component.ManualInit();
			if (component.ChangeMasterPose)
			{
				bs.masterSkillRenderHigh = gameObject2.GetComponent<MasterSkillRenderHigh>();
				bs.masterSkillRenderHigh.effectController.SetActive(active: false);
			}
			if (component.ChangeChipRolePose)
			{
				gameObject2 = Asset.Instantiate(string.Format(highPath, arg));
				EffectController component2 = gameObject2.GetComponent<EffectController>();
				if (component2 != null && bs.masterSkillRenderHigh != null)
				{
					component2.SetActive(active: false);
					bs.masterSkillRenderHigh.SetEffectControllerPlayer(component2);
				}
			}
			break;
		}
		case EEffectQuality.Medium:
		{
			GameObject gameObject = Asset.InstantiateWithoutCache("StoryTimeline/MasterSkill/Medium/QTE_Portrait", bs.battlePanelGameObject.transform);
			if (gameObject == null)
			{
				return;
			}
			bs.masterSkillRenderMedium = gameObject.GetComponent<MasterSkillRenderMedium>();
			Transform transform = bs.battlePanelGameObject.transform.Find(bs.masterSkillRenderMedium.parentPath);
			if (transform != null)
			{
				gameObject.transform.parent = transform;
			}
			string mainPath = string.Format(mediumPath, text);
			string playerPath = string.Format(mediumPath, arg);
			bs.masterSkillRenderMedium.SetPath(mainPath, playerPath);
			break;
		}
		}
		GameObject gameObject3 = Asset.InstantiateWithoutCache("StoryTimeline/MasterSkill/Low/QTE_Head", bs.battlePanelGameObject.transform);
		if (!(gameObject3 == null))
		{
			bs.masterSkillRenderLow = gameObject3.GetComponent<MasterSkillRenderMedium>();
			Transform transform2 = bs.battlePanelGameObject.transform.Find(bs.masterSkillRenderLow.parentPath);
			if (transform2 != null)
			{
				gameObject3.transform.parent = transform2;
			}
			string mainPath2 = string.Format(lowPath, text);
			string playerPath2 = string.Format(lowPath, arg);
			bs.masterSkillRenderLow.SetPath(mainPath2, playerPath2);
		}
	}

	public string GetHightTrackPath(BattleScene bs, string baseTrackPath)
	{
		if (bs.isMasterSkillVow)
		{
			if (ConfigHelper.GetInstance().TryGetConfig<Skin>(bs.roleSkinID, out var config))
			{
				return $"StoryTimeline/MasterSkill/High/MarriedTrack/masterskill_{config.Hero}";
			}
			Debug.LogError("=====>>>>> 找不到誓约角色的 Battle/Skin 表数据，id为 " + bs.roleSkinID);
		}
		for (int i = 0; i < bs.ready.SceneDataForExcehange.RoleDataInLua.Count; i++)
		{
			RoleDataForExchangeInfo roleDataForExchangeInfo = bs.ready.SceneDataForExcehange.RoleDataInLua.get_Item(i);
			if (roleDataForExchangeInfo != null && roleDataForExchangeInfo.ID != 0 && ConfigHelper.GetInstance().TryGetConfig<Skin>(roleDataForExchangeInfo.ID, out var config2) && ConfigHelper.GetInstance().TryGetConfig<charactor_param>(config2.Hero, out var config3) && config3.EnergyType == 5)
			{
				return "StoryTimeline/MasterSkill/High/BaseTrack/masterskill_1001_track1";
			}
		}
		return baseTrackPath;
	}
}
