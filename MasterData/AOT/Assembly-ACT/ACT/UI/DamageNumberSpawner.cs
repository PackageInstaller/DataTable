using System.Collections.Generic;
using ACT.Core;
using ACT.Event;
using ACT.MultiPlayer;
using Bamboo.AssetField;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class DamageNumberSpawner : MonoBehaviour
{
	public const int MaxSpawnCount = 16;

	public DamageNumberConfig config;

	public YooAssetReference sourceAssetAssetID;

	private AssetLoadHandle m_SourceAssetHandle;

	private GameObject m_SourcePrefab;

	private List<DamageNumber> m_AllTexts;

	private List<DamageNumber> m_AvailableTexts;

	private List<DamageNumber> m_RunningTexts;

	private Transform root;

	private void OnDamageNumberSpawn(BaseEventContent obj)
	{
		if (obj is DamageNumberSpawnEvt damageNumberSpawnEvt)
		{
			SpawnText(damageNumberSpawnEvt.cmdDamageNumber);
		}
	}

	public void Start()
	{
		root = transform;
		m_AllTexts = ListPool<DamageNumber>.Get();
		m_AvailableTexts = ListPool<DamageNumber>.Get();
		m_RunningTexts = ListPool<DamageNumber>.Get();
		m_SourceAssetHandle = AssetStationManager.BattleStation.Load<GameObject>(sourceAssetAssetID.GUID);
		m_SourcePrefab = m_SourceAssetHandle.AsGameObject();
		if (m_SourcePrefab == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("伤害数字 prefab 加载失败，guid=" + sourceAssetAssetID.GUID);
			}
		}
		else
		{
			for (int i = 0; i < 16; i++)
			{
				CreateDamageNumber();
			}
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.DamageNumberSpawn, OnDamageNumberSpawn);
	}

	public void Update()
	{
		for (int num = m_RunningTexts.Count - 1; num >= 0; num--)
		{
			DamageNumber damageNumber = m_RunningTexts[num];
			if (!damageNumber.Evaluate(Time.deltaTime))
			{
				DeSpawn(damageNumber);
			}
		}
	}

	private DamageNumber CreateDamageNumber()
	{
		GameObject gameObject = Object.Instantiate(m_SourcePrefab, root, worldPositionStays: false);
		DamageNumber component = gameObject.GetComponent<DamageNumber>();
		if (component == null)
		{
			Object.Destroy(gameObject);
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("伤害数字 prefab 缺少 DamageNumber 组件");
			}
			return null;
		}
		gameObject.SetActive(value: false);
		m_AllTexts.Add(component);
		m_AvailableTexts.Add(component);
		return component;
	}

	private void DeSpawn(DamageNumber spawnText)
	{
		if (!(spawnText == null))
		{
			m_RunningTexts.Remove(spawnText);
			spawnText.OnDespawn();
			spawnText.gameObject.SetActive(value: false);
			m_AvailableTexts.Add(spawnText);
		}
	}

	public void SpawnText(CmdDamageNumber cmd)
	{
		if (cmd.damage == 0 && cmd.damageFeature != DamageFeature.Block && cmd.damageFeature != DamageFeature.Resistance && cmd.damageFeature != DamageFeature.Sprint && cmd.damageFeature != DamageFeature.Deflect)
		{
			return;
		}
		if (m_AvailableTexts.Count == 0)
		{
			if (m_RunningTexts.Count == 0)
			{
				return;
			}
			DeSpawn(m_RunningTexts[0]);
		}
		int index = m_AvailableTexts.Count - 1;
		DamageNumber damageNumber = m_AvailableTexts[index];
		m_AvailableTexts.RemoveAt(index);
		m_RunningTexts.Add(damageNumber);
		damageNumber.gameObject.SetActive(value: true);
		damageNumber.OnSpawn(cmd, config);
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.DamageNumberSpawn, OnDamageNumberSpawn);
		if (m_AllTexts != null)
		{
			for (int i = 0; i < m_AllTexts.Count; i++)
			{
				if (m_AllTexts[i] != null)
				{
					Object.Destroy(m_AllTexts[i].gameObject);
				}
			}
		}
		if (AssetLoadHandleExtensions.IsValid(m_SourceAssetHandle))
		{
			AssetStationManager.BattleStation.Release(m_SourceAssetHandle, showError: false);
		}
		if (m_AllTexts != null)
		{
			ListPool<DamageNumber>.Release(m_AllTexts);
		}
		if (m_AvailableTexts != null)
		{
			ListPool<DamageNumber>.Release(m_AvailableTexts);
		}
		if (m_RunningTexts != null)
		{
			ListPool<DamageNumber>.Release(m_RunningTexts);
		}
	}
}
