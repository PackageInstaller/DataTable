using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Conversation;

public class ConversationSceneDefaultBg : ConversationSceneBg
{
	private Transform m_Transform;

	private MeshRenderer m_MeshRenderer;

	private Vector3 m_OriginalSize = new Vector3(19.5f, 9f, 1f);

	private Vector3 m_OriginalScale = new Vector3(19.5f, 9f, 1f);

	public override int BgId => 0;

	protected override Vector3 OriginalSize => m_OriginalSize;

	protected override Vector3 OriginalScale => m_OriginalScale;

	public override float OriginalZOffset
	{
		get
		{
			return m_Transform.localPosition.z;
		}
		set
		{
			m_Transform.localPosition = new Vector3(m_Transform.localPosition.x, m_Transform.localPosition.y, value);
		}
	}

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

	public ConversationSceneDefaultBg(Transform transform, MeshRenderer meshRenderer)
	{
		m_Transform = transform;
		m_MeshRenderer = meshRenderer;
	}

	public void SetOriginalSize(Vector3 originalSize)
	{
		m_OriginalSize = originalSize;
	}

	public void SetOriginalScale(Vector3 originalScale)
	{
		m_OriginalScale = originalScale;
	}

	public override UniTask Show()
	{
		m_Transform.gameObject.SetActive(value: true);
		return UniTask.CompletedTask;
	}

	public override void HideAndRelease()
	{
		m_Transform.gameObject.SetActive(value: false);
		m_Transform = null;
	}

	protected override void SetScale(Vector3 scale)
	{
		m_Transform.localScale = scale;
	}

	protected override void SetPosition(Vector3 position)
	{
		m_Transform.localPosition = position;
	}

	public override void SetOrder(int sortingOrder)
	{
		m_MeshRenderer.sortingOrder = sortingOrder;
	}
}
