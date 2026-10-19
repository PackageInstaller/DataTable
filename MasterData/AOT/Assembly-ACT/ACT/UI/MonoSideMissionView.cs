using System;
using ACT.MissionSystem;
using ACT.Model;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MonoSideMissionView : BaseUIComponent, IBattleMainComponent
{
	public class SideMissionData
	{
		public int missionId;

		public bool isOpen = true;
	}

	public MonoSideMissionUnit side;

	public MonoSideMissionUnit daily;

	public MonoSideMissionUnit main;

	private bool m_Paused;

	public void Initialize(MonoBattleMainBaseView view)
	{
		gameObject.SetActive(value: true);
		side.gameObject.SetActive(value: false);
		daily.gameObject.SetActive(value: false);
		main.gameObject.SetActive(value: false);
		onClose = () =>
		{
			Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.Center);
		};
	}

	public void UnInitialize()
	{
		gameObject.SetActive(value: false);
		side.gameObject.SetActive(value: false);
		daily.gameObject.SetActive(value: false);
		main.gameObject.SetActive(value: false);
		onClose?.Invoke();
		onClose = null;
	}

	public void Pause()
	{
		m_Paused = true;
		side?.Pause();
		daily?.Pause();
		main?.Pause();
	}

	public void Resume()
	{
		m_Paused = false;
		side?.Resume();
		daily?.Resume();
		main?.Resume();
	}

	public async UniTask Show(SideMissionData data, Action onShowFail)
	{
		Resume();
		onClose = (Action)Delegate.Combine(onClose, (Action)(() =>
		{
			Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.Center);
		}));
		try
		{
			MissionData missionData = Singleton<MissionManager>.instance.GetMissionData(data.missionId);
			side.gameObject.SetActive(value: false);
			daily.gameObject.SetActive(value: false);
			main.gameObject.SetActive(value: false);
			switch (missionData.Config.MissionTypeEnum)
			{
			case MissionType.Main:
			case MissionType.MainActivity:
				main.gameObject.SetActive(value: true);
				await main.PlayAnimation(data.missionId, data.isOpen).SuppressCancellationThrow();
				break;
			case MissionType.Side:
			case MissionType.SideActivity:
				side.gameObject.SetActive(value: true);
				await side.PlayAnimation(data.missionId, data.isOpen).SuppressCancellationThrow();
				break;
			case MissionType.Daily:
			case MissionType.DailyActivity:
				daily.gameObject.SetActive(value: true);
				await daily.PlayAnimation(data.missionId, data.isOpen).SuppressCancellationThrow();
				break;
			default:
				await UniTask.WaitForSeconds(0.5f);
				break;
			}
			onClose?.Invoke();
		}
		catch (Exception message)
		{
			Debug.LogError(message);
			onShowFail?.Invoke();
		}
		finally
		{
			side.gameObject.SetActive(value: false);
			daily.gameObject.SetActive(value: false);
			main.gameObject.SetActive(value: false);
			onClose?.Invoke();
			onClose = null;
		}
	}

	[Obsolete]
	public void OpenComponent()
	{
	}

	[Obsolete]
	public void CloseComponent()
	{
	}

	public void PushStack()
	{
		Pause();
	}

	public void PopStack()
	{
		Resume();
	}
}
