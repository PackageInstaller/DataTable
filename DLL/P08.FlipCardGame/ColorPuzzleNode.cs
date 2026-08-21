using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.UI;

[ExecuteAlways]
public class ColorPuzzleNode : SerializedMonoBehaviour
{
	[SerializeField]
	[HideInInspector]
	private int value = -1;

	public Animator errAnimator;

	[SerializeField]
	[HideInInspector]
	private int hint = -1;

	public bool valueFixed;

	public Image icon;

	public Image hintIcon;

	private ColorPuzzle game;

	private int errAniLayer = -1;

	public int Value
	{
		get
		{
			return value;
		}
		set
		{
			this.value = value;
			RefreshSprite(icon, value);
		}
	}

	public int Hint
	{
		get
		{
			return hint;
		}
		set
		{
			hint = value;
			RefreshSprite(hintIcon, value);
		}
	}

	public int ErrAniLayer
	{
		get
		{
			if (errAniLayer == -1)
			{
				errAniLayer = errAnimator.GetLayerIndex("Base Layer");
			}
			return errAniLayer;
		}
	}

	public int ValueMaxLimit => (game ? game.pallete.Length : 0) - 1;

	private void Start()
	{
		game = GetComponentInParent<ColorPuzzle>();
		if ((bool)game)
		{
			RefreshSprite(icon, value);
		}
	}

	public void RefreshSprite(Image image, int value)
	{
		if ((bool)game && (bool)image)
		{
			image.sprite = game.GetNodeSprite(value);
			image.enabled = image.sprite != null;
		}
	}

	public void OnHintChanged(int value)
	{
		RefreshSprite(hintIcon, value);
	}

	public void OnClickNode()
	{
		OnClickNode(game.CurSelect);
	}

	public void OnClickNode(int value)
	{
		if (!game || valueFixed)
		{
			return;
		}
		game.BeforeNodeApplyValue?.Invoke(Value, value);
		Value = value;
		if (Value != -1)
		{
			bool flag = game.CheckComplete();
			game.OnClickNode?.Invoke(flag);
			if (!flag)
			{
				if (Value != Hint)
				{
					game.Solve();
				}
			}
			else
			{
				game.OnPuzzleComlete?.Invoke();
			}
		}
		else
		{
			game.OnClickNode?.Invoke(obj: false);
		}
		ColorPuzzle.PlaySoundEffect("ui_system_3_0", "ui_battle_level");
	}

	public void OnNotifyConflict()
	{
		OnClickNode(-1);
		errAnimator.Play("Fx_red_cx", errAniLayer, 0f);
	}
}
