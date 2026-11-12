using System.Collections;
using System.Collections.Generic;
using AK.Wwise;
using UnityEngine;

public class AkPrefabTrigger : MonoBehaviour
{
	public enum EventTriggerType
	{
		onTick,
		onExit,
		onBeginOverlarp,
		onEndOverlarp
	}

	public string _WiseEvent;

	public string _WwiseStateGroup;

	public string _WwiseStateGroupSate;

	public string[] _swichLs;

	public Event WiseEvent;

	public State WwiseState;

	public List<Switch> WwiseSwitchs = new List<Switch>();

	public EventTriggerType _EventTriggerType;

	public GameObject TargetTiggerObj;

	public string TargetTiggerName;

	public bool FxObjFindOwner;

	public GameObject FxObjOwner;

	public AkAmbientLargeModePositioner[] LargeModePositions;

	public MultiPositionTypeLabel multiPositionType;

	public float _delayTime;

	private AkGameObj _AkGameObj;

	private int triggerIndex;

	private bool iExit;

	public string _rtpcName;

	public int _rtpcValue;

	public int _rtpcDuration;

	public bool _rtpcGloabel;

	public bool saveBankRes;

	private WaitForEndOfFrame wait;

	private AdventureFXPlayer akFx;

	private float _duration;

	private AkPositionArray BuildAkPositionArray()
	{
		List<AkAmbientLargeModePositioner> list = new List<AkAmbientLargeModePositioner>();
		for (int i = 0; i < LargeModePositions.Length; i++)
		{
			if (LargeModePositions[i] != null && !list.Contains(LargeModePositions[i]))
			{
				list.Add(LargeModePositions[i]);
			}
		}
		AkPositionArray akPositionArray = new AkPositionArray((uint)list.Count);
		for (int j = 0; j < list.Count; j++)
		{
			akPositionArray.Add(list.get_Item(j).Position, list.get_Item(j).Forward, list.get_Item(j).Up);
		}
		return akPositionArray;
	}

	private void Awake()
	{
		if (_AkGameObj == null)
		{
			_AkGameObj = getAkObj().GetComponent<AkGameObj>();
			if (_AkGameObj == null)
			{
				_AkGameObj = getAkObj().AddComponent<AkGameObj>();
			}
		}
	}

	private void OnEnable()
	{
		if (multiPositionType == MultiPositionTypeLabel.Large_Mode)
		{
			if (LargeModePositions.Length != 0)
			{
				_AkGameObj.enabled = false;
			}
		}
		else if (multiPositionType == MultiPositionTypeLabel.MultiPosition_Mode)
		{
			_AkGameObj.enabled = false;
			if (AkAmbient.multiPosEventTree.TryGetValue(getId(), out var value))
			{
				if (!value.listObj.Contains(gameObject))
				{
					value.listObj.Add(gameObject);
				}
			}
			else
			{
				value = new AkMultiPosEvent();
				value.listObj.Add(gameObject);
				AkAmbient.multiPosEventTree.Add(getId(), value);
			}
			AkPositionArray akPositionArray = BuildMultiDirectionArray(value);
			AkSoundEngine.SetMultiplePositions(value.listObj.get_Item(0), akPositionArray, (ushort)akPositionArray.Count, AkMultiPositionType.MultiPositionType_MultiDirections);
		}
		_duration = 0f;
		OnTick();
	}

	public AkPositionArray BuildMultiDirectionArray(AkMultiPosEvent eventPosList)
	{
		AkPositionArray akPositionArray = new AkPositionArray((uint)eventPosList.list.Count);
		for (int i = 0; i < eventPosList.list.Count; i++)
		{
			akPositionArray.Add(eventPosList.list.get_Item(i).transform.position, eventPosList.list.get_Item(i).transform.forward, eventPosList.list.get_Item(i).transform.up);
		}
		return akPositionArray;
	}

	private void OnDisable()
	{
		OnExit();
		StopCoroutine(toWaitoRestar());
		if (multiPositionType == MultiPositionTypeLabel.MultiPosition_Mode)
		{
			AkMultiPosEvent akMultiPosEvent = AkAmbient.multiPosEventTree.get_Item(getId());
			if (akMultiPosEvent.listObj.Count == 1)
			{
				AkAmbient.multiPosEventTree.Remove(getId());
				return;
			}
			akMultiPosEvent.listObj.Remove(gameObject);
			AkPositionArray akPositionArray = BuildMultiDirectionArray(akMultiPosEvent);
			AkSoundEngine.SetMultiplePositions(akMultiPosEvent.listObj.get_Item(0), akPositionArray, (ushort)akPositionArray.Count, AkMultiPositionType.MultiPositionType_MultiDirections);
		}
	}

	private bool haveAkGameObj()
	{
		if (_AkGameObj != null)
		{
			return true;
		}
		_AkGameObj = getAkObj().GetComponent<AkGameObj>();
		return _AkGameObj != null;
	}

	private IEnumerator toWaitoRestar()
	{
		if (wait == null)
		{
			wait = new WaitForEndOfFrame();
		}
		if (_delayTime <= 0f)
		{
			yield return wait;
			if (gameObject.activeSelf)
			{
				toPostSet();
			}
		}
		else
		{
			yield return null;
			if (gameObject.activeSelf)
			{
				while (!CheckDelayExcute())
				{
					yield return null;
				}
			}
		}
		yield return null;
	}

	private bool CheckDelayExcute()
	{
		_duration += Time.deltaTime;
		if (akFx == null && _duration < 0.5f)
		{
			akFx = GetComponent<AdventureFXPlayer>();
		}
		if (akFx != null && akFx.playbackTime >= _delayTime)
		{
			toPostSet();
			return true;
		}
		if (_duration >= _delayTime)
		{
			toPostSet();
			return true;
		}
		return false;
	}

	private GameObject getAkObj()
	{
		if (FxObjOwner != null)
		{
			return FxObjOwner;
		}
		if (FxObjFindOwner)
		{
			AdventureFXPlayer component = GetComponent<AdventureFXPlayer>();
			if (component != null && component.owner != null)
			{
				return component.owner;
			}
		}
		return gameObject;
	}

	private WwiseAudioManager.RTPC_MonsterType GetRTPC_Type()
	{
		AdventureFXPlayer component = GetComponent<AdventureFXPlayer>();
		if (component != null && (component.bindActor != null || component.owner != null))
		{
			if (component.ownerActor is MonsterAdventureActor monsterAdventureActor)
			{
				if (monsterAdventureActor.monsterInfo.originEpicType == HotfixEnum.monsterEpicType.LEADER)
				{
					return WwiseAudioManager.RTPC_MonsterType.Boss;
				}
				return WwiseAudioManager.RTPC_MonsterType.Normal;
			}
			if (component.bindActor is MonsterAdventureActor monsterAdventureActor2)
			{
				if (monsterAdventureActor2.monsterInfo.originEpicType == HotfixEnum.monsterEpicType.LEADER)
				{
					return WwiseAudioManager.RTPC_MonsterType.Boss;
				}
				return WwiseAudioManager.RTPC_MonsterType.Normal;
			}
		}
		return WwiseAudioManager.RTPC_MonsterType.None;
	}

	public void toPostSet()
	{
		if (multiPositionType == MultiPositionTypeLabel.Large_Mode && LargeModePositions.Length != 0)
		{
			_AkGameObj.enabled = false;
			AkPositionArray akPositionArray = BuildAkPositionArray();
			AkSoundEngine.SetMultiplePositions(gameObject, akPositionArray, (ushort)akPositionArray.Count, AkMultiPositionType.MultiPositionType_MultiDirections);
		}
		if (!string.IsNullOrEmpty(_WwiseStateGroup) && !string.IsNullOrEmpty(_WwiseStateGroupSate))
		{
			MonoSingleton<WwiseAudioManager>.Instance?.SetState_Custom(_WwiseStateGroup, _WwiseStateGroupSate);
		}
		else
		{
			MonoSingleton<WwiseAudioManager>.Instance?.SetState_Custom(WwiseState);
		}
		if (_swichLs != null && _swichLs.Length > 1)
		{
			for (int i = 0; i < _swichLs.Length / 2; i++)
			{
				MonoSingleton<WwiseAudioManager>.Instance?.SetSwicth(_swichLs[2 * i], _swichLs[2 * i + 1], getAkObj());
			}
		}
		else if (WwiseSwitchs.Count > 0)
		{
			for (int j = 0; j < WwiseSwitchs.Count; j++)
			{
				MonoSingleton<WwiseAudioManager>.Instance?.SetSwicth(WwiseSwitchs.get_Item(j), getAkObj());
			}
		}
		if (!string.IsNullOrEmpty(_WiseEvent) || (WiseEvent != null && !string.IsNullOrEmpty(WiseEvent.Name)))
		{
			if (multiPositionType == MultiPositionTypeLabel.MultiPosition_Mode)
			{
				AkMultiPosEvent akMultiPosEvent = AkAmbient.multiPosEventTree.get_Item(getId());
				if (!AdventureStateProxy.IsLoadingLevel)
				{
					GameObject akObj = akMultiPosEvent.listObj.get_Item(0);
					MonoSingleton<WwiseAudioManager>.Instance?.PlaySound(GetWwiseName(), akObj, !saveBankRes, GetRTPC_Type());
				}
			}
			else if (!AdventureStateProxy.IsLoadingLevel)
			{
				MonoSingleton<WwiseAudioManager>.Instance?.PlaySound(GetWwiseName(), getAkObj(), !saveBankRes, GetRTPC_Type());
			}
		}
		if (!string.IsNullOrEmpty(_rtpcName))
		{
			AkSoundEngine.SetRTPCValue(_rtpcName, _rtpcValue, _rtpcGloabel ? null : getAkObj(), _rtpcDuration);
		}
	}

	public string GetWwiseName()
	{
		if (!string.IsNullOrEmpty(_WiseEvent))
		{
			return _WiseEvent;
		}
		return WiseEvent.Name;
	}

	private uint getId()
	{
		if (!string.IsNullOrEmpty(_WiseEvent))
		{
			WwiseObjectReference wwiseObjBankRef = AllWwiseScriptableObject.Instance.GetWwiseObjBankRef(_WiseEvent);
			if (!(wwiseObjBankRef != null))
			{
				return 0u;
			}
			return wwiseObjBankRef.Id;
		}
		if (WiseEvent != null)
		{
			return WiseEvent.Id;
		}
		return 0u;
	}

	private void OnTick()
	{
		iExit = false;
		triggerIndex++;
		if (_EventTriggerType != EventTriggerType.onExit && haveAkGameObj())
		{
			_AkGameObj.SetPosition();
		}
		if (_EventTriggerType == EventTriggerType.onTick)
		{
			if (!FxObjFindOwner && _delayTime <= 0f && triggerIndex < 2)
			{
				toPostSet();
			}
			else
			{
				StartCoroutine(toWaitoRestar());
			}
		}
	}

	public void OnExit()
	{
		if (!iExit)
		{
			iExit = true;
			if (_EventTriggerType == EventTriggerType.onExit)
			{
				toPostSet();
			}
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		if (_EventTriggerType == EventTriggerType.onBeginOverlarp && (other.name == TargetTiggerName || TargetTiggerObj == other.gameObject))
		{
			toPostSet();
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (_EventTriggerType == EventTriggerType.onEndOverlarp && (other.name == TargetTiggerName || TargetTiggerObj == other.gameObject))
		{
			toPostSet();
		}
	}
}
