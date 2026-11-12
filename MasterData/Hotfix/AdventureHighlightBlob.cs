using DG.Tweening;
using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

public class AdventureHighlightBlob : AdventureBlobIndicator
{
	public float blobScale = 1.5f;

	public float blobOffset = 0.05f;

	public bool isShow;

	private float colorAlpha;

	protected Vector4? _blobUV;

	protected override void Start()
	{
		base.Start();
		if (MonoSingleton<GameController>.Instance != null && MonoSingleton<GameController>.Instance.entryLevelUIFadeIn)
		{
			Color color = this.color;
			colorAlpha = this.color.a;
			this.color = new Color(color.r, color.g, color.b, 0f);
		}
	}

	public void Show()
	{
		isShow = true;
		gameObject.SetActive(value: true);
	}

	public void Hide()
	{
		isShow = false;
		gameObject.SetActive(value: false);
	}

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		vh.Clear();
		if (!Application.isPlaying || !isShow)
		{
			return;
		}
		_uiVert = UIVertex.simpleVert;
		if (!_blobUV.HasValue)
		{
			_blobUV = ((_blobSprite != null) ? DataUtility.GetOuterUV(_blobSprite) : new Vector4(0f, 0f, 1f, 1f));
		}
		Vector4 value = _blobUV.Value;
		int num = 0;
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (!(activedPlayerActor == null))
		{
			ActorHealthInfo actorHealthInfo = ((activedPlayerActor == null) ? null : activedPlayerActor.actorHealthInfo);
			if (activedPlayerActor != null && actorHealthInfo.isAlive)
			{
				Transform transform = activedPlayerActor.transform;
				Vector3 blobCenterPos = new Vector3(transform.position.x, transform.position.z, 0f - transform.position.y - blobOffset);
				float y = transform.rotation.eulerAngles.y;
				float num2 = (float)activedPlayerActor.dtCollider.Radius * 2f * blobScale;
				Vector2 blobSize = new Vector2(num2, num2);
				num += DrawBlobPolygon(vh, blobCenterPos, y, blobSize, color, value, num);
			}
		}
	}

	public void FadeInHighlight()
	{
		this.DOFade(colorAlpha, 0.7f);
	}
}
