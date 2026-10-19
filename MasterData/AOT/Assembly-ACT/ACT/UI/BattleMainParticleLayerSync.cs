using System;
using ACT.Event;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

[DisallowMultipleComponent]
public class BattleMainParticleLayerSync : MonoBehaviour
{
	[SerializeField]
	private ParticleSystem[] _particleSystems = Array.Empty<ParticleSystem>();

	private void Start()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_BattleMainCanvasLayerChanged, OnBattleMainCanvasLayer);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_BattleMainCanvasReleased, OnBattleMainReleased);
		if (Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BATTLEMAIN) is MonoBattleMainBaseView monoBattleMainBaseView && monoBattleMainBaseView.ContentCanvas != null)
		{
			SyncLayer(monoBattleMainBaseView.ContentCanvas.gameObject.layer);
		}
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_BattleMainCanvasLayerChanged, OnBattleMainCanvasLayer);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_BattleMainCanvasReleased, OnBattleMainReleased);
	}

	private void OnBattleMainReleased(BaseEventContent content)
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_BattleMainCanvasLayerChanged, OnBattleMainCanvasLayer);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_BattleMainCanvasReleased, OnBattleMainReleased);
	}

	private void OnBattleMainCanvasLayer(BaseEventContent content)
	{
		if (content is BattleMainCanvasLayerEvt battleMainCanvasLayerEvt)
		{
			SyncLayer(battleMainCanvasLayerEvt.Layer);
		}
	}

	private void SyncLayer(int layer)
	{
		bool flag = layer == Singleton<NewUIManager>.instance.HideLayer;
		for (int i = 0; i < _particleSystems.Length; i++)
		{
			ParticleSystem particleSystem = _particleSystems[i];
			if (particleSystem == null)
			{
				continue;
			}
			particleSystem.gameObject.layer = layer;
			if (flag)
			{
				if (particleSystem.isPlaying && !particleSystem.isPaused)
				{
					particleSystem.Pause(withChildren: false);
				}
			}
			else if (particleSystem.isPaused)
			{
				particleSystem.Play(withChildren: false);
			}
		}
	}
}
