using System;
using System.Collections.Generic;
using DG.Tweening;
using TrueSync;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.UI.Extensions;

public class AdventureTargetBlob : MonoBehaviour
{
	public enum AttackRangeGraphicState
	{
		Normal,
		Highlight
	}

	public static Action<AttackRangeGraphicState> onAttackRangeGraphicStateChange;

	public float blobScale = 1f;

	public float blobOffset = 0.05f;

	public bool isSwichTarget;

	[Space]
	public RectTransform attackTargetGraphic;

	public float attackTargetGraphicSizeOffset;

	[Space]
	public RectTransform attackRangeGraphic;

	public float attackRangeGraphicSizeOffset;

	public UIFan attackRangeGraphicRenderer;

	public Image attackRangeArrowRenderer;

	public UIFan hintAttackRangeGraphicRenderer;

	public Image hintAttackRangeArrowRenderer;

	[Space]
	public Sprite attackRangeGraphicNormalImage;

	public Sprite attackRangeGraphicHighlightImage;

	public Sprite attackRangeGraphicHintImage;

	[Space]
	public Sprite attackRangeArrowNormalImage;

	public Sprite attackRangeArrowHighlightImage;

	public Sprite attackRangeArrowHintImage;

	private float _originAttackRangeGraphicColorAlpha;

	private float _originHintAttackRangeGraphicColorAlpha;

	private readonly List<DeterministicCollider> _attackableEntities = new List<DeterministicCollider>(10);

	private void Start()
	{
		_originAttackRangeGraphicColorAlpha = attackRangeGraphicRenderer.color.a;
		_originHintAttackRangeGraphicColorAlpha = hintAttackRangeGraphicRenderer.color.a;
		hintAttackRangeGraphicRenderer.gameObject.SetActive(value: false);
		if (MonoSingleton<GameController>.Instance.entryLevelUIFadeIn)
		{
			Color color = attackRangeGraphicRenderer.color;
			attackRangeGraphicRenderer.color = new Color(color.r, color.g, color.b, 0f);
			attackRangeArrowRenderer.color = new Color(color.r, color.g, color.b, 0f);
		}
	}

	private void OnDestroy()
	{
		onAttackRangeGraphicStateChange = null;
	}

	public void FadeInAttackRangeGraphic()
	{
		DOTween.Sequence().Append(attackRangeGraphicRenderer.DOFade(_originAttackRangeGraphicColorAlpha, 0.7f)).Insert(0f, attackRangeArrowRenderer.DOFade(_originAttackRangeGraphicColorAlpha, 0.7f))
			.SetTarget(attackRangeGraphicRenderer);
	}

	public void HintAttackRangeGraphic(float fadeInTime = 0.3f, float duration = 0.7f, Action onFinish = null)
	{
		DOTween.Kill(hintAttackRangeGraphicRenderer);
		hintAttackRangeGraphicRenderer.gameObject.SetActive(value: true);
		Color color = hintAttackRangeGraphicRenderer.color;
		hintAttackRangeGraphicRenderer.color = new Color(color.r, color.g, color.b, 0f);
		hintAttackRangeArrowRenderer.color = new Color(color.r, color.g, color.b, 0f);
		DOTween.Sequence().Append(hintAttackRangeGraphicRenderer.DOFade(_originHintAttackRangeGraphicColorAlpha, fadeInTime)).Insert(0f, hintAttackRangeArrowRenderer.DOFade(_originHintAttackRangeGraphicColorAlpha, fadeInTime))
			.AppendInterval(duration)
			.Append(hintAttackRangeGraphicRenderer.DOFade(0f, fadeInTime))
			.Insert(duration, hintAttackRangeArrowRenderer.DOFade(0f, fadeInTime))
			.OnComplete(() =>
			{
				hintAttackRangeGraphicRenderer.gameObject.SetActive(value: false);
				onFinish?.Invoke();
			})
			.SetTarget(hintAttackRangeGraphicRenderer);
	}

	public void StartHintAttackRangeGraphic(float fadeInTime = 0.3f)
	{
		DOTween.Kill(hintAttackRangeGraphicRenderer);
		hintAttackRangeGraphicRenderer.gameObject.SetActive(value: true);
		Color color = hintAttackRangeGraphicRenderer.color;
		hintAttackRangeGraphicRenderer.color = new Color(color.r, color.g, color.b, 0f);
		hintAttackRangeArrowRenderer.color = new Color(color.r, color.g, color.b, 0f);
		DOTween.Sequence().Append(hintAttackRangeGraphicRenderer.DOFade(_originHintAttackRangeGraphicColorAlpha, fadeInTime)).Insert(0f, hintAttackRangeArrowRenderer.DOFade(_originHintAttackRangeGraphicColorAlpha, fadeInTime))
			.SetTarget(hintAttackRangeGraphicRenderer);
	}

	public void StopHintAttackRangeGraphic(float fadeInTime = 0.3f)
	{
		DOTween.Kill(hintAttackRangeGraphicRenderer);
		if (hintAttackRangeGraphicRenderer.gameObject.activeSelf)
		{
			DOTween.Sequence().Append(hintAttackRangeGraphicRenderer.DOFade(0f, fadeInTime)).Insert(0f, hintAttackRangeArrowRenderer.DOFade(0f, fadeInTime))
				.OnComplete(() =>
				{
					hintAttackRangeGraphicRenderer.gameObject.SetActive(value: false);
				})
				.SetTarget(hintAttackRangeGraphicRenderer);
		}
	}

	public void OnRefresh()
	{
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		ActorHealthInfo actorHealthInfo = ((activedPlayerActor == null) ? null : activedPlayerActor.actorHealthInfo);
		if (actorHealthInfo == null || !actorHealthInfo.isAlive)
		{
			attackTargetGraphic.localScale = new Vector3(0f, 0f, 0f);
			attackRangeGraphic.localScale = new Vector3(0f, 0f, 0f);
			hintAttackRangeGraphicRenderer.rectTransform.localScale = new Vector3(0f, 0f, 0f);
			return;
		}
		if (SceneSingleton<AdventurePlayerController>.Instance.showVisionAttackRange)
		{
			Vector3 position = activedPlayerActor.transform.position;
			position += new Vector3(0f, blobOffset, 0f);
			Vector3 eulerAngles = activedPlayerActor.transform.rotation.eulerAngles;
			float num = (float)activedPlayerActor.actorSearchTargetInfo.hearAttackRange;
			float num2 = (float)activedPlayerActor.dtCollider.Radius;
			float num3 = (num + num2 + attackRangeGraphicSizeOffset) * 2f * blobScale;
			attackRangeGraphic.localScale = new Vector3(1f, 1f, 1f);
			attackRangeGraphic.position = position;
			attackRangeGraphic.rotation = Quaternion.Euler(90f, 0f, 0f - eulerAngles.y);
			attackRangeGraphic.sizeDelta = new Vector2(num3, num3);
			if (IsPlayerActorAttackable(activedPlayerActor, activedPlayerActor.actorSearchTargetInfo.hearAttackRange))
			{
				if (attackRangeGraphicRenderer.overrideSprite != attackRangeGraphicHighlightImage)
				{
					attackRangeGraphicRenderer.overrideSprite = attackRangeGraphicHighlightImage;
					attackRangeArrowRenderer.overrideSprite = attackRangeArrowHighlightImage;
					onAttackRangeGraphicStateChange?.Invoke(AttackRangeGraphicState.Highlight);
				}
			}
			else if (attackRangeGraphicRenderer.overrideSprite != attackRangeGraphicNormalImage)
			{
				attackRangeGraphicRenderer.overrideSprite = attackRangeGraphicNormalImage;
				attackRangeArrowRenderer.overrideSprite = attackRangeArrowNormalImage;
				onAttackRangeGraphicStateChange?.Invoke(AttackRangeGraphicState.Normal);
			}
		}
		else
		{
			attackRangeGraphic.localScale = new Vector3(0f, 0f, 0f);
		}
		if (hintAttackRangeGraphicRenderer.gameObject.activeSelf)
		{
			RectTransform rectTransform = hintAttackRangeGraphicRenderer.rectTransform;
			rectTransform.localScale = attackRangeGraphic.localScale;
			rectTransform.position = attackRangeGraphic.position;
			rectTransform.rotation = attackRangeGraphic.rotation;
			rectTransform.sizeDelta = attackRangeGraphic.sizeDelta;
		}
	}

	private bool IsPlayerActorAttackable(AdventureActor playerActor, FP attackRange)
	{
		FP radius = attackRange + playerActor.actorSearchTargetInfo.actorRadius;
		if (SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(radius, playerActor.tsTransform.Position, _attackableEntities, 256))
		{
			for (int i = 0; i < _attackableEntities.Count; i++)
			{
				LogicEntity entity = _attackableEntities.get_Item(i).Entity;
				if (!(entity == null) && !(entity == playerActor))
				{
					ActorHealthInfo logicComponent = entity.GetLogicComponent<ActorHealthInfo>();
					if (logicComponent != null && logicComponent.isAlive && playerActor.IsConfrontWith(entity) && !entity.IsSearchedImmunity())
					{
						_attackableEntities.Clear();
						return true;
					}
				}
			}
		}
		_attackableEntities.Clear();
		return false;
	}
}
