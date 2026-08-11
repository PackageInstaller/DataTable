using UnityEngine;
using UnityEngine.UI;

public class SwordActiveShowing : MonoBehaviour
{
	public Image slider;

	[SerializeField]
	private Animator animator;

	private bool isActive;

	private int layerState;

	public bool IsActive
	{
		get
		{
			return isActive;
		}
		set
		{
			if (isActive != value)
			{
				isActive = value;
				if (value)
				{
					SwordActive();
				}
				else
				{
					SwordInactive();
				}
			}
		}
	}

	public int LayerState
	{
		get
		{
			return layerState;
		}
		set
		{
			if (layerState != value)
			{
				layerState = value;
				SetLayerParam(layerState);
			}
		}
	}

	public void Init()
	{
		slider.fillAmount = 0f;
	}

	public void SwordActive()
	{
		animator.SetBool("End", false);
	}

	public void SwordInactive()
	{
		animator.SetBool("End", true);
	}

	public void SetLayerParam(int layer)
	{
		animator.SetInteger("Layer", layer);
	}
}
