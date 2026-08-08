using ControllerExSpace;
using UnityEngine;

public class BlisterNode : BlisterEntity
{
	public int posX;

	public int posY;

	public BlisterData blisterData;

	public SpriteRenderer bgSprite;

	protected ControllerEx dispeaerController;

	public bool isHide;

	public void Awake()
	{
		AddEventListenner();
		dispeaerController = base.transform.GetComponent<ControllerExCollection>().GetController("dispeaer");
	}

	public override void RefreshNodeState()
	{
		if (blisterData.blisterNodeState >= BlisterNodeState.Node4 || blisterData.blisterNodeState < BlisterNodeState.Node1)
		{
			if (!isHide)
			{
				dispeaerController.SetSelectedState((blisterData.blisterNodeState >= BlisterNodeState.Node4) ? "boom" : "dispear");
			}
			bgSprite.gameObject.SetActive(value: false);
			isHide = true;
		}
		else
		{
			bgSprite.gameObject.SetActive(value: true);
			bgSprite.sprite = AtlasManager.GetSprite("Atlas/Summer2024Atlas", "BlisterNormal" + blisterData.blisterNodeState);
		}
	}

	public void AddWater()
	{
		if (blisterData.blisterNodeState < BlisterNodeState.Node4 && blisterData.blisterNodeState >= BlisterNodeState.Node1)
		{
			blisterData.blisterNodeState++;
			RefreshNodeState();
			if (blisterData.blisterNodeState >= BlisterNodeState.Node4)
			{
				BlisterController.Instance.ChangenowBlisterNum();
				BlisterBoom();
			}
			else
			{
				BlisterController.Instance.BigNode();
			}
		}
	}

	public void ReduceWater()
	{
		if (blisterData.blisterNodeState < BlisterNodeState.Node4 && blisterData.blisterNodeState >= BlisterNodeState.Node1)
		{
			blisterData.blisterNodeState--;
			RefreshNodeState();
			if (blisterData.blisterNodeState < BlisterNodeState.Node1)
			{
				BlisterController.Instance.ChangenowBlisterNum();
				BlisterController.Instance.SpecialBlisterBoom();
			}
		}
	}

	public override void OnClick()
	{
		if (!BlisterController.Instance.IsGameOver() && BlisterController.Instance.IsPerform() && blisterData.blisterNodeState < BlisterNodeState.Node4)
		{
			AddWater();
			BlisterController.Instance.AddWater();
		}
	}

	public override void OnCollision(BlisterEntity otherObj)
	{
		AddWater();
	}

	public bool IsBeBoomed()
	{
		if (blisterData.blisterNodeState < BlisterNodeState.Node4)
		{
			return blisterData.blisterNodeState < BlisterNodeState.Node1;
		}
		return true;
	}

	public override void BlisterBoom()
	{
		bgSprite.gameObject.SetActive(value: false);
		BlisterController.Instance.AddBlisterBullet(this);
	}

	public void SetData(int x, int y, BlisterData mapData)
	{
		blisterData = mapData;
		posX = x;
		posY = y;
		if (isHide)
		{
			dispeaerController.SetSelectedState("hide");
		}
		RefreshNodeState();
	}
}
