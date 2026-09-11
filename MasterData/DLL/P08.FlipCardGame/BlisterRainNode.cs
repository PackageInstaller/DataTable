using UnityEngine;

public class BlisterRainNode : BlisterNode
{
	public BlisterNodeType blisterNodeType = BlisterNodeType.rain;

	public Transform icon;

	public override void BlisterBoom()
	{
		BlisterController.Instance.SpecialBlisterBoom();
		BlisterController.Instance.AddSortedList(posX * BlisterController.Instance.ColumnCount + posY, isAdd: true);
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
			icon.gameObject.SetActive(value: false);
			isHide = true;
			return;
		}
		bgSprite.gameObject.SetActive(value: true);
		bgSprite.sprite = AtlasManager.GetSprite("Atlas/Alone_Summer2024_BlisterGameAtlas", "Alone_Summer2024_BlisterGame_000" + (blisterData.blisterNodeState + 43));
		if (blisterData.blisterNodeState == BlisterNodeState.Node1)
		{
			icon.localScale = new Vector3(0.5f, 0.5f, 0.5f);
		}
		else if (blisterData.blisterNodeState == BlisterNodeState.Node2)
		{
			icon.localScale = new Vector3(0.85f, 0.85f, 0.85f);
		}
		else
		{
			icon.localScale = new Vector3(1f, 1f, 1f);
		}
	}
}
