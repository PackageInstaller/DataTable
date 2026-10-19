using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.Chronos;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class BattleMainTempleComponent : MonoBehaviour, IBattleMainComponent
{
	[SerializeField]
	private GameObject templeTargetRoot;

	public TextMeshProUGUI CurrentTime;

	public LocalizeStringEvent Title;

	public List<CommonSubWorldTargetItem> targetItems;

	public ActButton templeBuffRecordEntry;

	private Looper _currentTimeLooper;

	private StringBuilder _stringBuilder;

	public void Initialize(MonoBattleMainBaseView view)
	{
		if (MonoECS.instance.sceneStatus == SceneStatus.Temple)
		{
			SetTempleBuffRecordEntry();
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.ShowTargetRoot, ShowTempleTarget);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.HideTargetRoot, HideTempleTarget);
			if (!_currentTimeLooper.IsValid())
			{
				_currentTimeLooper = UpdateTimer.Default.LoopMs(100, OnUpdateCurrentTime);
			}
			_stringBuilder = new StringBuilder();
		}
	}

	private void SetTempleBuffRecordEntry()
	{
		templeBuffRecordEntry?.SetBtnClick(() =>
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEMPLEBUFFRECORD);
		});
	}

	public void UnInitialize()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ShowTargetRoot, ShowTempleTarget);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.HideTargetRoot, HideTempleTarget);
		if (_currentTimeLooper.IsValid())
		{
			_currentTimeLooper.Cancel();
		}
		_stringBuilder = null;
	}

	public void OpenComponent()
	{
		if (Model<BattleMainModel>.Interface.hudType == HudType.TempleType)
		{
			ShowTempleTarget(null);
		}
	}

	public void CloseComponent()
	{
		HideTempleTarget(null);
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private void ShowTempleTarget(BaseEventContent obj)
	{
		templeTargetRoot.SetActive(value: true);
		SetTempleUI(Model<TempleModel>.Interface.CurChallengeTempleId);
		GameObject gameObject = templeBuffRecordEntry.gameObject;
		TempleData curChallengeTempleData = Model<TempleModel>.Interface.GetCurChallengeTempleData();
		gameObject.SetActive(curChallengeTempleData != null && curChallengeTempleData.staticData.type == 1);
	}

	private void HideTempleTarget(BaseEventContent obj)
	{
		templeTargetRoot.SetActive(value: false);
	}

	public void SetTempleUI(int templeId)
	{
		if (templeId == 0)
		{
			return;
		}
		InstanceDungeon data = CoreUtils.GetData(templeId, RuntimeConfigs.data.instanceDungeons);
		Title.StringReference.TableEntryReference = data.name;
		List<int> list = new List<int>();
		for (int i = 0; i < data.reward.Count; i++)
		{
			list.Add(data.reward[i].id);
		}
		for (int j = 0; j < targetItems.Count; j++)
		{
			if (j < list.Count)
			{
				targetItems[j].gameObject.SetActive(value: true);
				targetItems[j].UpdateState(list[j]);
			}
			else
			{
				targetItems[j].gameObject.SetActive(value: false);
			}
		}
		OnUpdateCurrentTime();
	}

	private void OnUpdateCurrentTime()
	{
		int num = (int)Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime();
		int num2 = num / 60;
		int num3 = num % 60;
		_stringBuilder.Clear();
		_stringBuilder.AppendFormat("{0:d2}:{1:d2}", num2, num3);
		CurrentTime.SetText(_stringBuilder);
	}
}
