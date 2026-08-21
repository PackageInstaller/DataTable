using Sirenix.Utilities;
using UnityEngine;

namespace Ase;

public class WorldMapItemBlock : MonoBehaviour
{
	[SerializeField]
	private GameObject playerMark;

	[SerializeField]
	private GameObject tagTask;

	[SerializeField]
	private GameObject unlockIcon;

	[SerializeField]
	private GameObject lockIcon;

	[SerializeField]
	private Transform wholeTransform;

	private DRSectionMap drData;

	private UIAudioPlayer audioPlayer;

	private Material tagMaterial;

	private string assetTag = "WorldMapItemBlock";

	private string tagIconAssetPath;

	public DRSectionMap DrData => drData;

	public Transform WholeTransform => wholeTransform;

	public UIAudioPlayer AudioPlayer => audioPlayer;

	public void Init(DRSectionMap data)
	{
		drData = data;
		float x = ((data.SectionPos.Count > 0) ? data.SectionPos[0] : 0f);
		float y = ((data.SectionPos.Count > 1) ? data.SectionPos[1] : 0f);
		float z = ((data.SectionPos.Count > 2) ? data.SectionPos[2] : 0f);
		wholeTransform.localPosition = new Vector3(x, y, z);
		audioPlayer = wholeTransform.GetComponent<UIAudioPlayer>();
		tagMaterial = tagTask.GetComponent<Renderer>().material;
		SetPlayerMarkVisible(visible: false);
		Hide();
	}

	public async void RefreshTag(bool isMainTask, bool isDailyTask = false, bool isSideTask = false, bool isMonsterTask = false)
	{
		string assetName;
		if (isMainTask)
		{
			assetName = "Map/WorldMap/TaskTagMain.png";
			tagTask.SetActive(value: true);
		}
		else if (isDailyTask)
		{
			assetName = "Map/WorldMap/TaskTagDaily.png";
			tagTask.SetActive(value: true);
		}
		else
		{
			if (!isSideTask)
			{
				tagTask.SetActive(value: false);
				return;
			}
			assetName = "Map/WorldMap/TaskTagSide.png";
			tagTask.SetActive(value: true);
		}
		if (!string.IsNullOrEmpty(tagIconAssetPath))
		{
			GameEntry.Resource.UnloadAsset(AssetUtility.GetTextureAsset(tagIconAssetPath));
		}
		tagIconAssetPath = assetName;
		Texture value = await GameEntry.Resource.LoadAssetAsync<Texture>(AssetUtility.GetTextureAsset(assetName));
		tagMaterial.SetTexture("_MainTex", value);
	}

	public void RefreshState(bool unlock)
	{
		unlockIcon.SetActive(unlock);
		lockIcon.SetActive(!unlock);
	}

	public void Show()
	{
		wholeTransform.gameObject.SetActive(value: true);
	}

	public void Hide()
	{
		wholeTransform.gameObject.SetActive(value: false);
	}

	public void SetPlayerMarkVisible(bool visible)
	{
		if (!playerMark.SafeIsUnityNull())
		{
			playerMark.SetActive(visible);
		}
	}

	private void OnDestroy()
	{
		if (!string.IsNullOrEmpty(tagIconAssetPath))
		{
			GameEntry.Resource.UnloadAsset(AssetUtility.GetTextureAsset(tagIconAssetPath));
		}
	}
}
