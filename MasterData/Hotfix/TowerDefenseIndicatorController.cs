using UnityEngine;

public class TowerDefenseIndicatorController : MonoBehaviour
{
	[Space]
	public RectTransform attackRangeGraphic1;

	[Space]
	public RectTransform attackRangeGraphic2;

	public float blobOffset = 0.05f;

	public float attackRangeGraphicSizeOffset = 0.1f;

	public float blobScale = 100f;

	private float rawRange1;

	private float rawRange2;

	private GameObject bindObject;

	private bool sizeDirty;

	public void InitIndicator()
	{
		SceneSingleton<AdventureIndicatorController>.Instance.SetupBlobIndicators(gameObject);
		attackRangeGraphic1.localScale = new Vector3(1f, 1f, 1f);
		attackRangeGraphic1.rotation = Quaternion.Euler(90f, 0f, 0f);
		attackRangeGraphic2.localScale = new Vector3(1f, 1f, 1f);
		attackRangeGraphic2.rotation = Quaternion.Euler(90f, 0f, 0f);
	}

	public void BindValue(float size1, float size2 = 0f, GameObject bindObj = null)
	{
		rawRange1 = size1;
		rawRange2 = size2;
		bindObject = bindObj;
		gameObject.SetActive(value: true);
		ApplySize();
	}

	public void RefreshRange1(float size1)
	{
		if (!Mathf.Approximately(rawRange1, size1))
		{
			rawRange1 = size1;
			sizeDirty = true;
		}
	}

	private void Update()
	{
		if (sizeDirty)
		{
			ApplySize();
		}
	}

	private void ApplySize()
	{
		sizeDirty = false;
		float num = rawRange1;
		float num2 = rawRange2;
		if (null != bindObject && bindObject.TryGetComponent<Collider>(out var component) && component is CapsuleCollider capsuleCollider)
		{
			num += capsuleCollider.radius;
			if (num2 > 0f)
			{
				num2 += capsuleCollider.radius;
			}
		}
		num = (num + attackRangeGraphicSizeOffset) * 2f * blobScale;
		attackRangeGraphic1.sizeDelta = new Vector2(num, num);
		if (num2 > 0f)
		{
			num2 = (num2 + attackRangeGraphicSizeOffset) * 2f * blobScale;
			attackRangeGraphic2.sizeDelta = new Vector2(num2, num2);
		}
		attackRangeGraphic2.gameObject.SetActive(num2 > 0f);
	}

	public void UpdateIndicator(Vector3 position)
	{
		position += new Vector3(0f, blobOffset, 0f);
		attackRangeGraphic1.position = position;
		if (rawRange2 > 0f)
		{
			attackRangeGraphic2.position = position;
		}
	}

	public void Hide()
	{
		gameObject.SetActive(value: false);
	}

	public void Clear()
	{
		SceneSingleton<AdventureIndicatorController>.Instance.SetupBlobIndicators(null);
	}
}
