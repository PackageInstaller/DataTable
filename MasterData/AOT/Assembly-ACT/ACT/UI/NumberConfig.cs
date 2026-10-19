using System;
using System.Collections.Generic;

namespace ACT.UI;

[Serializable]
public struct NumberConfig
{
	public List<RichTagConfig> frontFontConfig;

	public List<RichTagConfig> slashFontConfig;

	public List<RichTagConfig> backFontConfig;
}
