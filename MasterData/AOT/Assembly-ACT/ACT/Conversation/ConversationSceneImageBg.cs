using System.Threading;
using ACT.Core;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.Conversation;

public class ConversationSceneImageBg : ConversationSceneBg, IConversationSceneBgFade
{
	private static ObjectPool<ConversationSceneImageBg> s_Pool = new ObjectPool<ConversationSceneImageBg>(() => new ConversationSceneImageBg());

	private int m_Id;

	private MeshRenderer m_MeshRenderer;

	private AssetLoadHandle m_BGAssetHandle;

	private CancellationTokenSource m_CTS;

	public override int BgId => m_Id;

	protected override Vector3 OriginalSize => new Vector3(19.5f, 9f, 1f);

	protected override Vector3 OriginalScale => new Vector3(19.5f, 9f, 1f);

	public override float OriginalZOffset { get; set; } = 20f;

	public override bool IsShow
	{
		get
		{
			if ((bool)m_MeshRenderer)
			{
				return m_MeshRenderer.gameObject.activeSelf;
			}
			return false;
		}
	}

	public static ConversationSceneImageBg Create(int id, MeshRenderer meshRenderer)
	{
		ConversationSceneImageBg conversationSceneImageBg = s_Pool.Get();
		conversationSceneImageBg.m_Id = id;
		conversationSceneImageBg.m_MeshRenderer = meshRenderer;
		return conversationSceneImageBg;
	}

	public override async UniTask Show()
	{
		m_CTS = new CancellationTokenSource();
		if (RuntimeConfigs.data.dialogueBackgroundDatas.TryGetValue(m_Id, out var value))
		{
			string assetID = "Conversation/" + value.path;
			m_BGAssetHandle = AssetStationManager.BattleStation.LoadAsync<Texture2D>(assetID);
			await m_BGAssetHandle;
			if (!m_CTS.IsCancellationRequested)
			{
				m_MeshRenderer.material.SetTexture("_Texture", m_BGAssetHandle.As<Texture2D>());
				SetMaterialAlpha(1f);
				m_MeshRenderer.gameObject.SetActive(value: true);
			}
		}
		else
		{
			m_MeshRenderer.material.SetTexture("_Texture", null);
			m_MeshRenderer.gameObject.SetActive(value: false);
		}
	}

	public override void HideAndRelease()
	{
		m_CTS?.Cancel();
		m_CTS?.Dispose();
		m_CTS = null;
		m_MeshRenderer.gameObject.SetActive(value: false);
		SetMaterialAlpha(1f);
		m_MeshRenderer.material.SetTexture("_Texture", null);
		m_Id = 0;
		if (m_BGAssetHandle.IsValid)
		{
			AssetStationManager.BattleStation.Release(m_BGAssetHandle);
		}
		m_BGAssetHandle = default;
		Object.Destroy(m_MeshRenderer.material);
		s_Pool.Release(this);
		Object.Destroy(m_MeshRenderer.gameObject);
	}

	public override void SetOrder(int sortingOrder)
	{
		m_MeshRenderer.sortingOrder = sortingOrder;
	}

	private void SetMaterialAlpha(float alpha)
	{
		Material material = m_MeshRenderer.material;
		string colorPropertyName = GetColorPropertyName(material);
		if (!string.IsNullOrEmpty(colorPropertyName))
		{
			Color color = material.GetColor(colorPropertyName);
			color.a = alpha;
			material.SetColor(colorPropertyName, color);
		}
	}

	private static string GetColorPropertyName(Material material)
	{
		if (material == null)
		{
			return null;
		}
		if (material.HasProperty("_BaseColor"))
		{
			return "_BaseColor";
		}
		if (material.HasProperty("_Color"))
		{
			return "_Color";
		}
		return null;
	}

	protected override void SetScale(Vector3 scale)
	{
		m_MeshRenderer.transform.localScale = scale;
	}

	protected override void SetPosition(Vector3 position)
	{
		m_MeshRenderer.transform.localPosition = position;
	}

	public async UniTask FadeTo(float alpha, float duration, CancellationToken token)
	{
		if (!m_MeshRenderer)
		{
			return;
		}
		Material material = m_MeshRenderer.material;
		string propertyName = GetColorPropertyName(material);
		Color color = material.GetColor(propertyName);
		if (string.IsNullOrEmpty(propertyName))
		{
			return;
		}
		if (duration <= 0f)
		{
			color.a = alpha;
			material.SetColor(propertyName, color);
			return;
		}
		await DOTween.To(() => color.a, (float _alpha) =>
		{
			color.a = _alpha;
			material.SetColor(propertyName, color);
		}, 0f, duration).ToUniTask(TweenCancelBehaviour.Kill, token);
	}
}
