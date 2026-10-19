using System;
using ACT.Config;
using ACT.Sound;
using FMODUnity;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.Asset;

[Serializable]
public class InteractScenicSpotData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	internal int m_initialStateId;

	public int weight;

	public LocalizedString name;

	public int iconId;

	public YooAssetReference timelineAssetReferenceAssetID;

	public YooAssetReference idleEffectAssetID;

	public EventReference interactSoundEvent;

	public AudioEventReference audioInteractSoundEvent;

	public EventReference recoverSoundEvent;

	public AudioEventReference audioRecoverSoundEvent;

	public EventReference uncollectedSoundEvent;

	public AudioEventReference audioUncollectedSoundEvent;

	public YooAssetReference uncollectedEffectAssetID;

	[Header("靠近未收集时的触发范围")]
	public BoxColliderParameters uncollectedBoxColliderParameters;

	[Header("交互物触发范围")]
	public BoxColliderParameters interactTriggerField;

	public int unLockTextLibraryId;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override void Bake(object assetComp)
	{
	}
}
