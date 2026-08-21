using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class SoundData : IReference
{
	public int AudioId;

	public List<string> ParamNameList;

	public List<float> ParamValueList;

	public bool ApplyFollowParentType;

	public float DelayStart;

	public bool DelayStartBaseFrozen;

	public void Clear()
	{
		AudioId = 0;
		ParamNameList = null;
		ParamValueList = null;
		ApplyFollowParentType = false;
		DelayStart = 0f;
		DelayStartBaseFrozen = false;
	}
}
