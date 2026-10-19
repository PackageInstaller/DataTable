using System;
using System.Collections.Generic;
using Runtime.Model;

namespace ACT.UI;

public class UI_InviteCharacterConfirmViewData : UIViewData
{
	public int topTipsCommonId;

	public int redTipsCommonId;

	public int bottomCommonId;

	public List<InviteCharacterConfirmPanelData> characterList;

	public Action confirmClick;
}
