public class BlisterBoomNode : BlisterNode
{
	public BlisterNodeType blisterNodeType = BlisterNodeType.boom;

	public override void BlisterBoom()
	{
		bgSprite.gameObject.SetActive(value: false);
		BlisterController.Instance.AddBlisterBoom(this);
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
			bgSprite.sprite = AtlasManager.GetSprite("Atlas/Summer2024Atlas", "BlisterBoom" + blisterData.blisterNodeState);
		}
	}
}
