using System;
using System.Collections.Generic;
using Bamboo.AssetField;
using YooAsset;

namespace ACT.Sound.Management;

internal class BankReference
{
	public string Guid { get; set; }

	public int ReferenceCount { get; set; }

	public BankState State { get; set; }

	public float UnloadTimer { get; set; }

	public YooAssetReference AssetReference { get; set; }

	public AssetLoadHandle Handle { get; set; }

	public List<Action<bool>> LoadCompleteCallbacks { get; set; }

	public RawFileHandle PendingHandle { get; set; }
}
