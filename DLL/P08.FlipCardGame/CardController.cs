using System;
using System.Collections;
using UnityEngine;

public class CardController : MonoBehaviour
{
	[SerializeField]
	private bool isFaceUp;

	[SerializeField]
	private bool isMatched;

	[SerializeField]
	private bool isFlipping;

	[SerializeField]
	private bool isSettedSprite;

	[SerializeField]
	private SpriteRenderer frontImgSpriteRenderer;

	[SerializeField]
	private SpriteRenderer frontSpriteRenderer;

	public bool canClick;

	private LTDescr tweenFilpUp;

	private LTDescr tweenFilpDown;

	private SpriteRenderer backSpriteRenderer;

	private IEnumerator flipCoroutine;

	private float aniduration;

	private BoxCollider boxCollider;

	public int cardType { get; set; }

	public bool IsFaceUp
	{
		get
		{
			return isFaceUp;
		}
		set
		{
			isFaceUp = value;
		}
	}

	public bool IsMatched
	{
		get
		{
			return isMatched;
		}
		set
		{
			isMatched = value;
		}
	}

	public bool IsFlipping
	{
		get
		{
			return isFlipping;
		}
		set
		{
			isFlipping = value;
		}
	}

	public bool IsSettedSprite
	{
		get
		{
			return isSettedSprite;
		}
		set
		{
			isSettedSprite = value;
		}
	}

	public SpriteRenderer FrontImgSpriteRenderer
	{
		get
		{
			return frontImgSpriteRenderer;
		}
		set
		{
			frontImgSpriteRenderer = value;
		}
	}

	public SpriteRenderer FrontSpriteRenderer
	{
		get
		{
			return frontSpriteRenderer;
		}
		set
		{
			frontSpriteRenderer = value;
		}
	}

	private void Awake()
	{
		frontSpriteRenderer = base.transform.Find("Front").GetComponent<SpriteRenderer>();
		backSpriteRenderer = base.transform.Find("Back").GetComponent<SpriteRenderer>();
		frontImgSpriteRenderer = base.transform.Find("FrontImg").GetComponent<SpriteRenderer>();
		boxCollider = base.transform.GetComponent<BoxCollider>();
		backSpriteRenderer.enabled = true;
		frontSpriteRenderer.enabled = false;
		frontImgSpriteRenderer.enabled = false;
	}

	private void Update()
	{
		if (Input.GetMouseButtonDown(0) && !isFlipping && FlipCardGameController.Instance.GameState == FlipCardGameController.GameStatus.Flipping && Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), out var hitInfo) && hitInfo.collider.gameObject == base.gameObject && !IsFaceUp && !isMatched && !isFlipping)
		{
			flipCoroutine = FlipCard(faceUp: true);
			StartCoroutine(flipCoroutine);
		}
	}

	private void LateUpdate()
	{
		boxCollider.enabled = canClick && !isFaceUp;
	}

	public void SetAniDuration(float duration)
	{
		aniduration = duration;
	}

	public void FlipCardBack()
	{
		if (IsFaceUp || !isFlipping)
		{
			flipCoroutine = FlipCard(faceUp: false);
			StartCoroutine(flipCoroutine);
		}
	}

	public void Reset()
	{
		base.gameObject.transform.eulerAngles = Vector3.zero;
		IsFaceUp = false;
		IsMatched = false;
		IsSettedSprite = false;
		IsFlipping = false;
		ToggleVisibility();
	}

	public IEnumerator FlipCard(bool faceUp, float delay = 0f, Action callBack = null)
	{
		isFlipping = true;
		if (faceUp)
		{
			LeanTween.rotateAroundLocal(base.gameObject, Vector3.up, 180f, aniduration).setDelay(delay);
		}
		else
		{
			LeanTween.rotateAroundLocal(base.gameObject, Vector3.up, -180f, aniduration).setDelay(delay);
		}
		if (faceUp)
		{
			FlipCardGameController.Instance.CheckMatch(this);
		}
		yield return new WaitForSeconds(aniduration / 2f);
		IsFaceUp = faceUp;
		ToggleVisibility();
		yield return new WaitForSeconds(aniduration / 2f);
		isFlipping = false;
		if (callBack != null)
		{
			callBack();
			callBack = null;
		}
		yield return null;
	}

	public void ToggleVisibility()
	{
		frontSpriteRenderer.enabled = IsFaceUp;
		frontImgSpriteRenderer.enabled = IsFaceUp;
		backSpriteRenderer.enabled = !IsFaceUp;
	}

	public void SetCardFaceSprite(Sprite sprite)
	{
	}

	public void DestroyCard()
	{
		UnityEngine.Object.Destroy(base.gameObject);
	}
}
