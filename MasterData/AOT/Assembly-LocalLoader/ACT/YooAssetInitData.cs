using System.Collections.Generic;
using YooAsset;

namespace ACT;

public class YooAssetInitData
{
	public DownloadData DownloadData { get; set; }

	public YooAssetParam YooAssetParam { get; set; }

	public ZipDownloadParam ZipDownloadParam { get; set; }

	public Dictionary<AssetType, PackageInfo> PackageInfos { get; set; }

	public void InitPackageData()
	{
		if (PackageInfos == null)
		{
			EPlayMode playMode = YooAssetParam.PlayMode;
			if (playMode == EPlayMode.HostPlayMode || playMode == EPlayMode.OfflinePlayMode)
			{
				PackageInfos = new Dictionary<AssetType, PackageInfo>
				{
					{
						AssetType.Dll,
						new PackageInfo
						{
							PackageName = "Dll"
						}
					},
					{
						AssetType.ClientStatic,
						new PackageInfo
						{
							PackageName = "ClientStatic"
						}
					},
					{
						AssetType.Assets,
						new PackageInfo
						{
							PackageName = "Assets"
						}
					},
					{
						AssetType.RawFile,
						new PackageInfo
						{
							PackageName = "RawFile"
						}
					}
				};
			}
			else
			{
				PackageInfos = new Dictionary<AssetType, PackageInfo>
				{
					{
						AssetType.ClientStatic,
						new PackageInfo
						{
							PackageName = "ClientStatic"
						}
					},
					{
						AssetType.Assets,
						new PackageInfo
						{
							PackageName = "Assets"
						}
					},
					{
						AssetType.RawFile,
						new PackageInfo
						{
							PackageName = "RawFile"
						}
					}
				};
			}
		}
	}
}
