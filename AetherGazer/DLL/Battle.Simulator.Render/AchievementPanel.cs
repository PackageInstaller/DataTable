using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class AchievementPanel : MonoBehaviour
{
	public Text titleContent;

	public Text time;

	public ScrollRect scrollRect;

	public Button close;

	public AchievementTemplate stageNumber;

	public AchievementTemplate stageTime;

	public AchievementTemplate tmp;

	private Stack<AchievementTemplate> pools = new Stack<AchievementTemplate>();

	private Stack<AchievementTemplate> running = new Stack<AchievementTemplate>();

	public CanvasGroup canvasGroup;

	public GameObject settlement;

	public float alphaTime = 0.1f;

	public float startX = -246f;

	public float targetX = 2f;

	public float startScale = 0.78788f;

	public float moveTime = 0.13f;

	private bool start;

	private float currentTime;

	private int index;

	public float interval = 1f;

	public int maxAchievementNumber = 3;

	private List<int> currentList = new List<int>();

	public AchievementTemplate Get()
	{
		if (pools.Count > 0)
		{
			return pools.Pop();
		}
		return Object.Instantiate(tmp.gameObject, tmp.transform.parent).GetComponent<AchievementTemplate>();
	}

	private void Awake()
	{
		close.onClick.AddListener(delegate
		{
			base.gameObject.SetActive(value: false);
		});
	}

	public void Init(string title, string time, int stageAchieve, int timeAchieve)
	{
		while (running.Count > 0)
		{
			AchievementTemplate achievementTemplate = running.Pop();
			achievementTemplate.gameObject.SetActive(value: false);
			pools.Push(achievementTemplate);
		}
		titleContent.text = title;
		this.time.text = time;
		stageNumber.Init(stageAchieve);
		stageTime.Init(timeAchieve);
		index = 0;
		start = true;
		currentTime = 0f;
		scrollRect.verticalNormalizedPosition = 1f;
		currentList.Clear();
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		if (worldStateManager != null && worldStateManager.data != null)
		{
			for (int i = 0; i < worldStateManager.data.currentAchievement.Count; i++)
			{
				currentList.Add(worldStateManager.data.currentAchievement[i]);
			}
		}
	}

	private void OnDisable()
	{
		start = false;
		index = 0;
		start = true;
		currentTime = 0f;
	}

	private void ShowNextAchievement()
	{
		List<int> list = currentList;
		if (index < list.Count)
		{
			AchievementTemplate achievementTemplate = Get();
			if (achievementTemplate != null)
			{
				achievementTemplate.Init(list[index]);
				achievementTemplate.gameObject.SetActive(value: true);
				running.Push(achievementTemplate);
			}
			else
			{
				Debug.LogError("出错");
			}
			index++;
			currentTime = 0f;
			scrollRect.verticalNormalizedPosition = 1f;
		}
	}

	private void Update()
	{
		if (start)
		{
			currentTime += Time.deltaTime;
			if (currentTime > interval && index < maxAchievementNumber)
			{
				ShowNextAchievement();
			}
		}
	}

	private void OnEnable()
	{
		if (canvasGroup != null)
		{
			canvasGroup.alpha = 0f;
			LeanTween.alphaCanvas(canvasGroup, 1f, alphaTime);
		}
		if (settlement != null)
		{
			Vector3 localPosition = settlement.transform.localPosition;
			settlement.transform.localPosition = localPosition.NewX(startX);
			LeanTween.moveLocalX(settlement, targetX, moveTime);
			settlement.transform.localScale = new Vector3(startScale, startScale, startScale);
			LeanTween.scale(settlement, Vector3.one, moveTime);
		}
	}
}
