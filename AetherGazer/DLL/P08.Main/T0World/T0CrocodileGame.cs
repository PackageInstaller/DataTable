using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.Playables;

namespace T0World;

public class T0CrocodileGame : MonoBehaviour
{
	private static T0CrocodileGame mCrocodileGame;

	public T0CrocodileGameContext context;

	public GameObject _sharkGo;

	private T0InterationBaseData waitSelectEventData;

	private const string CROCODILE_TIMELINE_ASSET_PATH = "T0World/UITimeLine/104402/{0}";

	private Dictionary<string, GameObject> timelinePool = new Dictionary<string, GameObject>();

	public static T0CrocodileGame crocodileGame => mCrocodileGame;

	private GameObject sharkGo
	{
		get
		{
			if (_sharkGo == null)
			{
				_sharkGo = GameObject.Find(context.gameData.furnitureBindName);
			}
			return _sharkGo;
		}
	}

	public void SetWaitSelectEventData(T0InterationBaseData data)
	{
		waitSelectEventData = data;
	}

	private void Awake()
	{
		mCrocodileGame = this;
	}

	public void Init()
	{
		if (context == null)
		{
			context = new T0CrocodileGameContext();
		}
		context.Init();
		for (int i = 0; i < context.itemList.Count; i++)
		{
			context.itemList[i].clickCallbak = delegate(int value)
			{
				OnClickItem(value);
			};
		}
	}

	private void OnClickItem(int index)
	{
		PressTargetIndex(index - 1);
		CloseSelectView();
		if (waitSelectEventData != null)
		{
			waitSelectEventData.IsFinish = true;
		}
	}

	public void PressTargetIndex(int index)
	{
		T0CrocodileGameItem t0CrocodileGameItem = context.itemList[index];
		context.currentPressIndex = index + 1;
		t0CrocodileGameItem.isPress = true;
		t0CrocodileGameItem.RefreshUI();
		int num = context.gameData.loseChanceList[context.playCount - 1];
		if (Random.Range(1, 1001) <= num)
		{
			context.gameState = T0CrocodileGameStateEnum.lose;
		}
		else
		{
			context.gameState = T0CrocodileGameStateEnum.win;
		}
	}

	public void OpenSelectView()
	{
		context.itemContent.gameObject.SetActive(value: true);
		context.gameState = T0CrocodileGameStateEnum.waitSelect;
	}

	public void CloseSelectView()
	{
		context.itemContent.gameObject.SetActive(value: false);
	}

	public int GetCurrentPressIndex()
	{
		return context.currentPressIndex;
	}

	public string GetWaitSelectSDKStr()
	{
		if (context == null || context.itemList == null)
		{
			return string.Empty;
		}
		StringBuilder stringBuilder = new StringBuilder();
		bool flag = true;
		for (int i = 0; i < context.itemList.Count; i++)
		{
			T0CrocodileGameItem t0CrocodileGameItem = context.itemList[i];
			if (!t0CrocodileGameItem.isPress || t0CrocodileGameItem.itemIndex == context.currentPressIndex)
			{
				if (!flag)
				{
					stringBuilder.Append(",");
				}
				stringBuilder.Append(t0CrocodileGameItem.itemIndex);
				flag = false;
			}
		}
		return stringBuilder.ToString();
	}

	public void Dispose()
	{
		waitSelectEventData = null;
		if (context != null)
		{
			context.Dispose();
			context = null;
		}
		if (timelinePool != null)
		{
			foreach (GameObject value in timelinePool.Values)
			{
				if (value != null)
				{
					Object.Destroy(value);
				}
			}
			timelinePool.Clear();
			timelinePool = null;
		}
		mCrocodileGame = null;
		Object.Destroy(base.gameObject);
	}

	public GameObject GetTimelineGo(string timeLineName)
	{
		GameObject gameObject = null;
		if (timelinePool.ContainsKey(timeLineName))
		{
			gameObject = timelinePool[timeLineName];
		}
		if (gameObject == null)
		{
			GameObject gameObject2 = Asset.Load<GameObject>($"T0World/UITimeLine/104402/{timeLineName}");
			if (gameObject2 != null)
			{
				gameObject = Object.Instantiate(gameObject2);
				gameObject.name = timeLineName;
			}
			timelinePool.Add(timeLineName, gameObject);
			gameObject.transform.SetParent(context.pressAnimNode);
			gameObject.transform.localPosition = Vector3.zero;
			gameObject.transform.localRotation = Quaternion.Euler(0f, 0f, 0f);
			gameObject.transform.localScale = Vector3.one;
		}
		return gameObject;
	}

	public void TriggerPressAnim()
	{
		int currentIndex = GetCurrentPressIndex();
		string text = context.gameData.pressTimelineDataList.Find((T0CrocodilePressTimelineData item) => item.pressIndex == currentIndex)?.pressAnim;
		if (!string.IsNullOrEmpty(text))
		{
			PlayPressTimeline(text);
		}
	}

	public void PlayPressTimeline(string timelineName = "104402_prop_shayuwanju_X206_crocodile_interaction_107")
	{
		GameObject timelineGo = GetTimelineGo(timelineName);
		timelineGo.SetActive(value: true);
		PlayableDirector component = timelineGo.GetComponent<PlayableDirector>();
		IEnumerator<PlayableBinding> enumerator = component.playableAsset.outputs.GetEnumerator();
		while (enumerator.MoveNext())
		{
			PlayableBinding current = enumerator.Current;
			_ = current.streamName;
			component.SetGenericBinding(current.sourceObject, sharkGo);
		}
		component.extrapolationMode = DirectorWrapMode.None;
		component.Play();
		component.Evaluate();
	}
}
