using System;
using System.Collections.Generic;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class ChallengePointDataEx : InteractObjectDataBase
{
	[SerializeField]
	private int m_initialStateId;

	public YooAssetReference wrapAssetID;

	public YooAssetReference bpAssetAssetID;

	[SerializeField]
	public List<InteractObjectChangeInfo> iteractObjectChangeList;

	[SerializeField]
	public List<Variable> variables = new List<Variable>();

	public override YooAssetReference addressAssetID => wrapAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
