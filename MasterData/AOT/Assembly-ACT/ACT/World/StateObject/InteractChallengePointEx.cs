using System.Collections.Generic;
using ACT.BluePrint;
using ACT.Event;
using ACT.Model;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cinemachine;
using Fundamental;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.SmartFormat.PersistentVariables;

namespace ACT.World.StateObject;

public class InteractChallengePointEx : InteractObject
{
	private ChallengePointDataEx m_Data;

	private GameObject bpLoadHandle;

	public override void InitStateObject(int stateId)
	{
		m_Data = entity.GetCompStateObject().StateWorldAssetData as ChallengePointDataEx;
		base.InitStateObject(stateId);
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		bpLoadHandle = BPCommon.CreateBpAsset(m_Data.bpAssetAssetID, transform);
		bpLoadHandle.transform.localPosition = Vector3.zero;
		ScriptMachine component = bpLoadHandle.GetComponent<ScriptMachine>();
		GraphReference pointer = GraphReference.New(component, ensureValid: true);
		List<LocalizeStringEvent> localizeStringEventSet = new List<LocalizeStringEvent>();
		for (int i = 0; i < m_Data.variables.Count; i++)
		{
			Variable variable = m_Data.variables[i];
			if (variable.value is List<LocalizeStringConf> list)
			{
				for (int j = 0; j < list.Count; j++)
				{
					AddLocalizeStringEvent(list[j]);
				}
			}
			else if (variable.value is LocalizeStringConf conf)
			{
				AddLocalizeStringEvent(conf);
			}
		}
		List<LocalizeStringEvent> localizeStringEventList = new List<LocalizeStringEvent>(bpLoadHandle.GetComponentsInChildren<LocalizeStringEvent>());
		for (int k = 0; k < m_Data.variables.Count; k++)
		{
			Variable variable2 = m_Data.variables[k];
			if (variable2.value is List<LocalizeStringConf> list2)
			{
				List<LocalizeStringEvent> list3 = new List<LocalizeStringEvent>();
				list2.ForEach((LocalizeStringConf localizeStringConf2) =>
				{
					for (int l = 0; l < localizeStringEventList.Count; l++)
					{
						LocalizeStringEvent localizeStringEvent2 = localizeStringEventList[l];
						if (localizeStringEvent2.StringReference.TableEntryReference.KeyId == localizeStringConf2.entryId)
						{
							list3.Add(localizeStringEvent2);
						}
					}
				});
				Variables.Object(bpLoadHandle).Set(variable2.name, list3);
			}
			else if (variable2.value is LocalizeStringConf localizeStringConf)
			{
				for (int num = 0; num < localizeStringEventList.Count; num++)
				{
					LocalizeStringEvent localizeStringEvent = localizeStringEventList[num];
					if (localizeStringEvent.StringReference.TableEntryReference.KeyId == localizeStringConf.entryId)
					{
						Variables.Object(bpLoadHandle).Set(variable2.name, localizeStringEvent);
					}
				}
			}
			else if (variable2.value is Bounds bounds)
			{
				GameObject gameObject = new GameObject(variable2.name);
				gameObject.transform.parent = bpLoadHandle.transform;
				BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
				boxCollider.transform.position = Vector3.zero;
				boxCollider.isTrigger = true;
				boxCollider.center = bounds.center;
				boxCollider.size = bounds.size;
				Variables.Object(bpLoadHandle).Set(variable2.name, boxCollider);
			}
			else if (variable2.value is CinemachineVirtualCameraConfig cinemachineVirtualCameraConfig)
			{
				GameObject gameObject2 = new GameObject(variable2.name);
				gameObject2.transform.parent = bpLoadHandle.transform;
				gameObject2.transform.localPosition = cinemachineVirtualCameraConfig.position;
				gameObject2.gameObject.SetActive(value: false);
				CinemachineVirtualCamera cinemachineVirtualCamera = gameObject2.AddComponent<CinemachineVirtualCamera>();
				cinemachineVirtualCamera.Priority = cinemachineVirtualCameraConfig.priority;
				cinemachineVirtualCamera.m_Lens = cinemachineVirtualCameraConfig.lensSettings;
				Variables.Object(bpLoadHandle).Set(variable2.name, cinemachineVirtualCamera);
			}
			else if (variable2.value is List<InteractObjectState>)
			{
				Variables.Graph(pointer).Set(variable2.name, variable2.value);
			}
			else
			{
				Variables.Object(bpLoadHandle).Set(variable2.name, variable2.value);
			}
		}
		component.enabled = true;
		base.Interact(entryIndex, eb, interactSource);
		void AddLocalizeStringEvent(LocalizeStringConf localizeStringConf2)
		{
			bool flag = false;
			localizeStringEventSet.ForEach((LocalizeStringEvent item) =>
			{
				if (item.StringReference.TableEntryReference.KeyId == localizeStringConf2.entryId)
				{
					flag = true;
				}
			});
			if (!flag)
			{
				LocalizeStringEvent localizeStringEvent2 = bpLoadHandle.AddComponent<LocalizeStringEvent>();
				foreach (Variable argument in localizeStringConf2.arguments)
				{
					if (argument.value is string value)
					{
						localizeStringEvent2.StringReference[argument.name] = new StringVariable
						{
							Value = value
						};
					}
					else if (argument.value is int value2)
					{
						localizeStringEvent2.StringReference[argument.name] = new IntVariable
						{
							Value = value2
						};
					}
				}
				localizeStringEvent2.StringReference.TableReference = localizeStringConf2.tableName;
				localizeStringEvent2.StringReference.TableEntryReference = localizeStringConf2.entryId;
				localizeStringEventSet.Add(localizeStringEvent2);
			}
		}
	}

	public override void ReleaseStateObject()
	{
		if (bpLoadHandle != null)
		{
			Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChallengeExit, null);
		}
		Model<BigWorldChallengeProgressModel>.Interface.isInBigWorld = false;
		base.ReleaseStateObject();
	}
}
