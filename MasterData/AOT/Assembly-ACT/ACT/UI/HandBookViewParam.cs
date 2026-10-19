using System;

namespace ACT.UI;

public class HandBookViewParam : UIViewData
{
	public Action OnClose;

	public int H1TabIndex { get; set; } = -1;

	public int H2TabIndex { get; set; } = -1;

	public int WildBossUseId { get; set; }

	public int PowerExchangeId { get; set; }
}
