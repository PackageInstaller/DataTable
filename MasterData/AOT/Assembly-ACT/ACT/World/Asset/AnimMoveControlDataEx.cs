using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class AnimMoveControlDataEx : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	[Tooltip("-1 隐藏 0 待机 1 重新运行 2 完成 3 暂停 4 继续")]
	internal int m_initialStateId = -1;

	[SerializeReference]
	public AnimMoveControlConfigEx behaveConfig = new AnimMoveControlConfigEx();

	public AnimEventInfoEx behavePosInfo;

	public override bool isStatic => false;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override void Bake(object assetComp)
	{
	}

	public override bool IsServiceSaveState(int stateId)
	{
		if (stateId != 0 && stateId != 2)
		{
			return stateId == -1;
		}
		return true;
	}
}
