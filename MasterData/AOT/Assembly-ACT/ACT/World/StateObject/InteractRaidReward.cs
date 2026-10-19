using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using Runtime.Model.PowerModel;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractRaidReward")]
public class InteractRaidReward : StateObjectBase
{
	public InteractEntry entry;

	[FormerlySerializedAs("LeaveEntry")]
	public InteractEntry leaveEntry;

	private Animator m_animator;

	[NonSerialized]
	[HideInInspector]
	public DropItemAddNtf dropItemAddNtf;

	protected bool m_isOption;

	protected bool m_isInInteract;

	private int m_BehaveId;

	private bool m_noLeaveBtn;

	private AssetLoadHandle m_Handle;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (!(compStateObject?.StateWorldAssetData is RaidRewardPointData raidRewardPointData))
		{
			return;
		}
		m_isInInteract = false;
		m_isOption = false;
		ResetEntryInteractType(entry, raidRewardPointData.InteractType);
		ResetEntryInteractType(leaveEntry, InteractType.Button);
		if (raidRewardPointData.InteractType == InteractType.Button)
		{
			InteractEntry interactEntry = entry;
			interactEntry.onInteract = (Action<Entity>)Delegate.Combine(interactEntry.onInteract, new Action<Entity>(OnInteract));
			entry.BindInteractObjectBase(this);
			entry.BindData(compStateObject.StateWorldAssetData);
			entry.BindInteractState(1, 0);
			InteractEntry interactEntry2 = leaveEntry;
			interactEntry2.onInteract = (Action<Entity>)Delegate.Combine(interactEntry2.onInteract, new Action<Entity>(LeaveRaid));
			leaveEntry.BindInteractObjectBase(this);
			leaveEntry.BindData(compStateObject.StateWorldAssetData);
			leaveEntry.BindInteractState(1, 2);
		}
		else
		{
			InteractEntry interactEntry3 = entry;
			interactEntry3.onInteract = (Action<Entity>)Delegate.Combine(interactEntry3.onInteract, new Action<Entity>(TriggerEnter));
			entry.BindInteractObjectBase(this);
			entry.BindData(compStateObject.StateWorldAssetData);
			entry.BindInteractState(1, 2);
			m_noLeaveBtn = true;
		}
		m_Handle = AssetStationManager.BattleStation.Instantiate(raidRewardPointData.modelAssetID, transform);
		m_Handle.AsGameObject().TryGetComponent<Animator>(out m_animator);
		m_animator?.SetInteger("state", stateId);
		if (m_Handle.AsGameObject().TryGetComponent<AniRaidRewardEvent>(out var component))
		{
			component?.SetReward(() =>
			{
				OnInteract(default);
			});
		}
		base.InitStateObject(stateId);
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
	}

	public void LeaveRaid(Entity eb)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			OnConfirm = () =>
			{
				G.service.LeaveRaid((bool r) =>
				{
					if (r)
					{
						Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
					}
				});
			},
			commonId = 1660
		});
	}

	public void TriggerEnter(Entity eb)
	{
		m_animator?.SetInteger("state", 2);
	}

	public virtual async void OnInteract(Entity eb)
	{
		if (m_isInInteract)
		{
			return;
		}
		m_isInInteract = true;
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		ACT.Config.Raid raid = RuntimeConfigs.data.raids[currentRaidId];
		ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(currentRaidId);
		if (raid.firstReward != null && raid.firstReward.Count != 0 && (raidInfo == null || raidInfo.CleanNum == 0))
		{
			OnceRaid();
			m_isInInteract = false;
			return;
		}
		RaidEntranceData raidEntranceData = GameUtility.GetRaidEntranceData(currentRaidId);
		int num = 0;
		for (int i = 0; i < raidEntranceData.raidId.Length; i++)
		{
			if (raidInfo != null)
			{
				num += raidInfo.CleanNum;
			}
		}
		if (!Model<RaidModel>.Interface.HasLeftTimes())
		{
			GameUtility.OpenToolTip(790);
			m_isInInteract = false;
			return;
		}
		if (currentStateId == 1)
		{
			int value = 0;
			foreach (KeyValuePair<int, RaidEntranceData> raidEntranceData2 in RuntimeConfigs.data.raidEntranceDatas)
			{
				if (raidEntranceData2.Value.raidId.Contains(currentRaidId))
				{
					value = raidEntranceData2.Key;
				}
			}
			RaidTypeData raidTypeData = null;
			foreach (KeyValuePair<int, RaidTypeData> raidTypeData2 in RuntimeConfigs.data.raidTypeDatas)
			{
				if (raidTypeData2.Value.raidEntranceId.Contains(value))
				{
					raidTypeData = raidTypeData2.Value;
				}
			}
			if (raidTypeData.rewardType == 1 || raidTypeData.rewardType == 2)
			{
				OpenRaidSettleView();
			}
			else
			{
				TextPanel.Param param = new TextPanel.Param();
				param.texts = new string[2]
				{
					Model<RaidModel>.Interface.PowerCost.ToString(),
					"1"
				};
				param.OnConfirm = OnConfirm;
				param.needPause = true;
				param.commonId = 1611;
				param.titleId = 483;
				List<TextPanel.ButtonInfo> list = new List<TextPanel.ButtonInfo>();
				param = new TextPanel.Param();
				param.texts = new string[1] { Model<RaidModel>.Interface.PowerCost.ToString() };
				param.btnInfos = list;
				param.OnConfirm = OnConfirm;
				param.needPause = true;
				param.commonId = 696;
				param.titleId = 483;
				TextPanel.Param uiData = param;
				if (Model<RaidModel>.Interface.PowerCost == 0)
				{
					OnConfirm();
					return;
				}
				if (Model<PowerModel>.Interface.PowerCount >= Model<RaidModel>.Interface.PowerCost)
				{
					OpenRaidSettleView();
				}
				else
				{
					list.Add(new TextPanel.ButtonInfo
					{
						id = 14,
						closeUI = true
					});
					list.Add(new TextPanel.ButtonInfo
					{
						id = 486,
						action = () =>
						{
							G.service.LeaveRaid((bool r) =>
							{
								if (r)
								{
									Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
								}
							});
						},
						closeUI = true
					});
					list.Add(new TextPanel.ButtonInfo
					{
						id = 499,
						action = async () =>
						{
							Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ADDPOWER, new TextPanel.Param());
						},
						closeUI = true
					});
					await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANELWITHPOWER, uiData);
				}
			}
		}
		m_isInInteract = false;
	}

	private void OnConfirm()
	{
		if (!m_isOption)
		{
			m_isOption = true;
			NetEnterState(2).Forget();
			OpenRaidSettleView();
		}
	}

	private void ChangeState(int stateId)
	{
		NetEnterState(stateId).Forget();
	}

	private void OnceRaid()
	{
		ACT.Game.Data.Raid curChallengeRaidInfo = Model<RaidModel>.Interface.CurChallengeRaidInfo;
		if (curChallengeRaidInfo != null && curChallengeRaidInfo.EnterByGM)
		{
			return;
		}
		if (curChallengeRaidInfo != null && curChallengeRaidInfo.CleanNum != 0)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_COMMONWORLDSUCCESS, new CommonWorldSuccessView.CommonWorldSuccessData
			{
				scrollBagParam = default
			});
			return;
		}
		if (Model<ChallengeTargetTrackerModel>.HasInstance())
		{
			Model<ChallengeTargetTrackerModel>.Interface.MarkChallengeCompleted();
		}
		G.service.GetRaidRewardInfo(1, async (bool r, RepeatedField<UniversalItem> ack) =>
		{
			if (r)
			{
				NetEnterState(2).Forget();
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_COMMONWORLDSUCCESS, GameUtility.CreateWorldSuccessRewardData(ack));
			}
		});
	}

	public override async void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 1 && entryIndex == 0)
		{
			entry.HandleInteract(eb, InteractAction.InteractSource.Player);
		}
		if (currentStateId == 1 && entryIndex == 2)
		{
			if (!m_noLeaveBtn)
			{
				leaveEntry.HandleInteract(eb, InteractAction.InteractSource.Player);
			}
			else
			{
				entry.HandleInteract(eb, InteractAction.InteractSource.Player);
			}
		}
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 1)
		{
			entry.HandleEnter();
			if (!m_noLeaveBtn)
			{
				leaveEntry.HandleEnter();
			}
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 1)
		{
			entry.HandleExit();
			if (!m_noLeaveBtn)
			{
				leaveEntry.HandleExit();
			}
		}
	}

	protected override void HandleInitState(int stateId)
	{
		m_animator?.SetInteger("state", stateId);
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		m_animator?.SetInteger("state", toStateId);
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		if (currentStateId == 1)
		{
			entry.HandleUninit();
			if (!m_noLeaveBtn)
			{
				leaveEntry.HandleUninit();
			}
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (-4 <= stateId)
		{
			return stateId <= 2;
		}
		return false;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return entry;
	}

	private void OpenRaidSettleView()
	{
		Model<RaidModel>.Interface.RaidSettlement();
	}

	public override ShowType GetInteractBtnShowType()
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist)
		{
			return ShowType.Show;
		}
		return ShowType.Hide;
	}

	public override bool ShowInteractTip()
	{
		return !Singleton<ProtagonistManager>.instance.IsProtagonist;
	}

	public override bool CanInteract()
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist)
		{
			return base.CanInteract();
		}
		return false;
	}
}
