using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using ACT.World;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class OpenTempleMapBtn : MonoBehaviour
{
	public LargeMapView view;

	public Button btn;

	private MapArea mapArea;

	public void Init(MapArea area)
	{
		bool flag = RuntimeConfigs.data.instanceDungeonMaps.ContainsKey((int)area);
		gameObject.SetActive(flag);
		mapArea = area;
		if (flag)
		{
			btn.onClick.RemoveAllListeners();
			btn.onClick.AddListener(() =>
			{
				OpenTempleMap();
			});
			UpdateAreaRewardEvt evt = Singleton<EventManager>.instance.GetEvt<UpdateAreaRewardEvt>();
			evt.AreaId = (int)area;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UpdateAreaRewardState, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void UnInit()
	{
		btn.onClick.RemoveAllListeners();
		if (gameObject.activeSelf)
		{
			gameObject.SetActive(value: false);
		}
	}

	public void OpenTempleMap()
	{
		if (gameObject.activeSelf)
		{
			view.EnterTempleAreaMap(mapArea, fromAreaMap: true);
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.OpenTempleMap);
		}
	}
}
