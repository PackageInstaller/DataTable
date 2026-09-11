using UnityEngine;
using UnityEngine.UI;

[ExecuteAlways]
public class QWorldStoryEditorMgr : MonoBehaviour
{
	private static QWorldStoryEditorMgr Instance;

	private GameObject StoryUI;

	public Canvas canvas;

	private Text content;

	private new Text name;

	private Image headIcon;

	private RectTransform choiceRect;

	private QWorldConfigStoryReader reader;

	private bool IsInit => StoryUI == null;

	public static QWorldStoryEditorMgr GetInstance()
	{
		if (Instance == null)
		{
			Instance = GameObject.Find("Preview").GetComponent<QWorldStoryEditorMgr>();
		}
		return Instance;
	}

	public void InitStoryUI()
	{
	}

	public void ShowTalk(string ct, string icon, string talkName)
	{
	}

	public void ShowChoice(QWorldBranchCallback[] choices)
	{
		InitStoryUI();
	}

	public void HideChoice()
	{
		if (!(choiceRect == null))
		{
			choiceRect.gameObject.SetActive(value: false);
		}
	}

	public void HideTalk()
	{
		if (!(StoryUI == null))
		{
			StoryUI.SetActive(value: false);
		}
	}

	private void OnDestroy()
	{
		Instance = null;
	}
}
