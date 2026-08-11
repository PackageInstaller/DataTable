using System.Collections.Generic;

namespace Ase;

public class BuffRuntimeConfigData
{
	public List<string> BuffLabel;

	public void InitConfig(DRBuff config)
	{
		BuffLabel = ((config?.BuffLabelEnum != null) ? new List<string>(config.BuffLabelEnum) : new List<string>());
	}
}
