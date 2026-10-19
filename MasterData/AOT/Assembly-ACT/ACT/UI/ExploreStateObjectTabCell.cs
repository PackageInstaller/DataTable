using System;
using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ExploreStateObjectTabCell : MonoBehaviour
{
	public BetterAnimation anim;

	public LocalizeStringEvent groupName;

	public BImage iconType;

	public ActButton btn;

	public GameObject select;

	private int _groupId;

	private int _mapArea;

	private ImageAssetStation _imageAssetStation;

	public int GroupId => _groupId;

	public void Init(int groupId, int mapArea, Action<int> buttonAction = null)
	{
		_imageAssetStation = this.GetImageStation();
		gameObject.SetActive(value: true);
		_groupId = groupId;
		_mapArea = mapArea;
		StateObjectGroup data = CoreUtils.GetData(groupId, RuntimeConfigs.data.stateObjectGroups);
		if (data != null)
		{
			groupName.StringReference.TableEntryReference = data.groupName;
			if (data.id == 4)
			{
				MapArea data2 = CoreUtils.GetData(_mapArea, RuntimeConfigs.data.mapAreas);
				if (data2 != null)
				{
					ExploreType data3 = CoreUtils.GetData(data2.exploreType, RuntimeConfigs.data.exploreTypes);
					if (data3 != null)
					{
						groupName.StringReference.TableEntryReference = data3.name;
					}
				}
			}
			_imageAssetStation.LoadImage(184, groupId, iconType);
		}
		btn.OnClick.RemoveAllListeners();
		btn.OnClick.AddListener(() =>
		{
			buttonAction?.Invoke(_groupId);
		});
	}

	public void SetSelected(bool selected)
	{
		if (select != null)
		{
			select.SetActive(selected);
			if (selected)
			{
				PlayAnim("Select");
			}
		}
	}

	public void GotoShow()
	{
		anim?.GetSequence("Show")?.Goto(0f);
	}

	public void PlayAnim(string animName)
	{
		anim?.GetSequence(animName)?.Play();
	}
}
