using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cinemachine.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public abstract class MissionArrow : MonoBehaviour
{
	public const float MERGE_DISTANCE = 3f;

	public const float SPLITE_DISTANCE = 5f;

	[SerializeReference]
	protected GameObject arrow;

	[SerializeReference]
	protected Transform steadyPosition;

	[SerializeReference]
	protected TMP_Text distanceText;

	[SerializeReference]
	protected LayoutGroup layoutGroup;

	[SerializeReference]
	protected RectTransform distanceRoot;

	[SerializeReference]
	protected BImage missionImage;

	[SerializeReference]
	protected CanvasGroup canvasGroup;

	[Header("动画")]
	[SerializeReference]
	protected BetterAnimation animation;

	[Header("合并任务点相关")]
	[SerializeReference]
	protected GameObject mergeRoot;

	[SerializeReference]
	protected TMP_Text mergeText;

	protected bool _inScreen;

	protected bool _inScreenLeft;

	protected MissionArrow _mergeParent;

	public bool IsInsideScreen => _inScreen;

	public int Count { get; set; }

	public bool IsShow
	{
		get
		{
			if (gameObject.activeSelf)
			{
				return canvasGroup.alpha > 0f;
			}
			return false;
		}
	}

	protected abstract Vector3 InScreenOffset { get; }

	public virtual void Init(int spriteId)
	{
		canvasGroup.alpha = 1f;
		Count = 1;
		distanceRoot.gameObject.SetActive(value: true);
		mergeRoot.SetActive(value: false);
		SetMissionTypeImage(spriteId);
		_inScreen = false;
		SetInScreenImply(inScreen: false);
	}

	public virtual void UnInit()
	{
	}

	public void HighLight()
	{
		if (_mergeParent != null)
		{
			_mergeParent.HighLight();
		}
		else
		{
			animation.GetSequence("HighLight")?.Play();
		}
	}

	public void SetDistance(long preVal, long curVal)
	{
		distanceText.SetText(Mathf.Max(0f, curVal).FastToString());
		if (AlgorithmUtility.GetIntegerBitCount(curVal) - AlgorithmUtility.GetIntegerBitCount(preVal) != 0)
		{
			ReCalculateTextSize();
		}
	}

	public virtual void SetPosInScreen(Vector3 missionPointWorldPos)
	{
		Camera uiCamera = GameUtility.uiCamera;
		Vector3 vector = GameUtility.mainCamera.WorldToScreenPoint(missionPointWorldPos);
		Vector3 normalized = (uiCamera.ScreenToWorldPoint(vector + InScreenOffset) - uiCamera.gameObject.transform.position).normalized;
		Vector3 vector2 = 100f / normalized.z * normalized;
		transform.position = (vector2.IsNaN() ? Vector3.zero : vector2);
	}

	public void SetPosOutScreen(Vector3 worldPos)
	{
		transform.position = worldPos;
	}

	public void SetRot(Quaternion rot)
	{
		transform.rotation = rot;
		steadyPosition.transform.rotation = Quaternion.identity;
	}

	public void SetInScreen(bool inScreen)
	{
		if (_inScreen != inScreen)
		{
			_inScreen = inScreen;
			SetInScreenImply(inScreen);
		}
	}

	public virtual void SetInScreenLeft(bool inScreenLeft)
	{
		if (_inScreenLeft != inScreenLeft)
		{
			_inScreenLeft = inScreenLeft;
		}
	}

	public virtual void NormalStyle()
	{
		Count = 1;
		_mergeParent = null;
		Show();
		distanceRoot.gameObject.SetActive(value: true);
		mergeRoot.SetActive(value: false);
	}

	public virtual void MergeIntoOtherArrowStyle(MissionArrow parent)
	{
		Hide();
		_mergeParent = ((parent._mergeParent != null) ? parent._mergeParent : parent);
		_mergeParent.MergeStyle(_mergeParent.Count + Count);
	}

	public void Hide()
	{
		canvasGroup.alpha = 0f;
	}

	protected void SetMissionTypeImage(int spriteId)
	{
		this.GetImageStation().LoadImage(200, spriteId, missionImage);
	}

	protected virtual void SetInScreenImply(bool inScreen)
	{
		distanceRoot.gameObject.SetActive(!inScreen);
		arrow.gameObject.SetActive(!inScreen);
		ReCalculateTextSize();
	}

	private void ReCalculateTextSize()
	{
		layoutGroup.enabled = false;
		LayoutRebuilder.ForceRebuildLayoutImmediate(distanceRoot);
		layoutGroup.enabled = true;
	}

	private void Show()
	{
		if (!gameObject.activeSelf)
		{
			gameObject.SetActive(value: true);
		}
		canvasGroup.alpha = 1f;
	}

	private void MergeStyle(int count)
	{
		Count = count;
		canvasGroup.alpha = 1f;
		distanceRoot.gameObject.SetActive(value: false);
		mergeRoot.SetActive(value: true);
		mergeText.SetText(Count.FastToString());
	}
}
