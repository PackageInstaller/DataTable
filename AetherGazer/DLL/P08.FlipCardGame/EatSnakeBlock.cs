using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class EatSnakeBlock : MonoBehaviour
{
	public enum TYPE
	{
		NONE = 1,
		FLOOR = 2,
		REINFORCE_POINT = 0
	}

	public int x;

	public int y;

	public TYPE type = TYPE.FLOOR;

	public int reinforceFointOrder;

	public int reinforceNeedType;

	public int reinforceNeedCount;

	public Animator animator;

	public Button button;

	public Image image;

	public Text text;

	public List<Sprite> spriteList = new List<Sprite>();

	public List<string> animationName = new List<string>();

	public int[] direction = new int[2];

	private void Start()
	{
		button = base.transform.GetComponent<Button>();
		if (button != null)
		{
			button.onClick.AddListener(delegate
			{
				int num = (int)type;
				type = (TYPE)((num + 1) % 3);
				if (type == TYPE.NONE)
				{
					image.color = Color.black;
				}
				else if (type == TYPE.FLOOR)
				{
					image.color = Color.white;
				}
				else
				{
					image.color = Color.yellow;
				}
			});
			button = GetComponent<Button>();
		}
		if (image == null)
		{
			image = GetComponent<Image>();
		}
	}

	private void Update()
	{
	}

	public void SetType(int type)
	{
		this.type = (TYPE)type;
		if (text != null)
		{
			text.gameObject.SetActive(value: false);
		}
		if (this.type == TYPE.NONE)
		{
			image.sprite = null;
			image.color = Color.black;
			return;
		}
		if (this.type == TYPE.FLOOR)
		{
			image.sprite = null;
			image.color = new Color(1f, 1f, 1f, 1f);
			if (animator != null)
			{
				animator.Play("none", 0, 0f);
				image.color = new Color(1f, 1f, 1f, 0f);
			}
			return;
		}
		image.color = Color.yellow;
		if (text != null)
		{
			text.gameObject.SetActive(value: true);
			text.text = reinforceNeedCount.ToString();
		}
		if (spriteList.Count > 0)
		{
			image.sprite = spriteList[reinforceNeedType - 1];
			image.color = Color.white;
		}
	}

	public void SetData(int x, int y, int type, int reinforceFointOrder, int reinforceNeedType, int reinforceNeedCount)
	{
		if (image == null)
		{
			image = GetComponent<Image>();
		}
		this.x = x;
		this.y = y;
		this.reinforceFointOrder = reinforceFointOrder;
		this.reinforceNeedType = reinforceNeedType;
		this.reinforceNeedCount = reinforceNeedCount;
		SetType(type);
	}

	public void SetPosition(int x, int y)
	{
		this.x = x;
		this.y = y;
	}

	public void SetComplete()
	{
		text.text = "";
		image.color = Color.white;
		image.sprite = spriteList[3];
		animator.Play("cellitem_finish01", 0, 0f);
	}
}
