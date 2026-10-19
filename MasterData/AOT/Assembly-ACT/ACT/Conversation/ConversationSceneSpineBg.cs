using System.Threading;
using ACT.Core;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.Conversation;

public class ConversationSceneSpineBg : ConversationSceneBg
{
	private static readonly Vector3 SpineBaseSize = new Vector3(46.8f, 21.6f, 1f);

	private static ObjectPool<ConversationSceneSpineBg> s_Pool = new ObjectPool<ConversationSceneSpineBg>(() => new ConversationSceneSpineBg());

	private int m_Id;

	private Transform m_SpineParent;

	private MeshRenderer m_MeshRenderer;

	private AssetLoadHandle m_BGAssetHandle;

	private CancellationTokenSource m_CTS;

	private GameObject m_SpineObject;

	public override int BgId => m_Id;

	protected override Vector3 OriginalSize => SpineBaseSize;

	protected override Vector3 OriginalScale => new Vector3(1f, 1f, 1f);

	public override float OriginalZOffset { get; set; } = 20f;

	public override bool IsShow
	{
		get
		{
			if ((bool)m_SpineObject)
			{
				return m_SpineObject.activeSelf;
			}
			return false;
		}
	}

	public Transform SpineParent => m_SpineParent;

	public static ConversationSceneSpineBg Create(int id, Transform spineRoot)
	{
		ConversationSceneSpineBg conversationSceneSpineBg = s_Pool.Get();
		conversationSceneSpineBg.m_Id = id;
		conversationSceneSpineBg.m_SpineParent = spineRoot;
		return conversationSceneSpineBg;
	}

	public override async UniTask Show()
	{
		m_CTS = new CancellationTokenSource();
		if (RuntimeConfigs.data.dialogueBackgroundDatas.TryGetValue(m_Id, out var value))
		{
			string assetID = "Conversation/" + value.path;
			m_BGAssetHandle = AssetStationManager.BattleStation.LoadAsync<GameObject>(assetID);
			await m_BGAssetHandle;
			if (m_CTS.IsCancellationRequested)
			{
				return;
			}
			m_SpineObject = Object.Instantiate(m_BGAssetHandle.As<GameObject>(), m_SpineParent);
			m_SpineObject.transform.localPosition = Vector3.down * (SpineBaseSize.y * 0.5f);
			m_SpineObject.transform.localRotation = Quaternion.identity;
			m_SpineParent.gameObject.SetActive(value: true);
		}
		else
		{
			m_SpineParent.gameObject.SetActive(value: false);
		}
		if ((bool)m_SpineObject)
		{
			m_MeshRenderer = m_SpineObject.GetComponent<MeshRenderer>();
		}
	}

	public override void HideAndRelease()
	{
		m_CTS?.Cancel();
		m_CTS?.Dispose();
		m_CTS = null;
		m_Id = 0;
		m_SpineParent.gameObject.SetActive(value: false);
		if (m_BGAssetHandle.IsValid)
		{
			AssetStationManager.BattleStation.Release(m_BGAssetHandle);
		}
		m_BGAssetHandle = default;
		Object.Destroy(m_SpineObject);
		s_Pool.Release(this);
		Object.Destroy(m_SpineParent.gameObject);
	}

	public override void SetOrder(int sortingOrder)
	{
		m_MeshRenderer.sortingOrder = sortingOrder;
	}

	protected override void SetScale(Vector3 scale)
	{
		m_SpineParent.localScale = scale;
	}

	protected override void SetPosition(Vector3 position)
	{
		m_SpineParent.localPosition = position;
	}
}
