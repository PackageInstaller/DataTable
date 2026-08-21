using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class EntryInfoViewModel : OptionBase
{
	private EntryItemData itemData;

	private Vector2 pos;

	private InteractionRequest refreshRequest = new InteractionRequest();

	public EntryItemData ItemData => itemData;

	public Vector2 Pos => pos;

	public InteractionRequest RefreshRequest => refreshRequest;

	public EntryInfoViewModel()
	{
	}

	public EntryInfoViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public void RefreshData(EntryItemData itemData)
	{
		this.itemData = itemData;
		refreshRequest.Raise();
	}

	public void SetPos(Vector2 pos)
	{
		this.pos = pos;
	}

	public void Hide()
	{
		parent?.ItemOnClick(new OptionArg(this, "HideEntryPanelLevel"));
	}
}
