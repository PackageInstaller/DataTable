using UnityEngine;
using UnityEngine.UI;

public class TalkContentButton : MonoBehaviour
{
	public Text ContentText;

	public TalkButton talkButton;

	public Button button;

	public void Init(int id)
	{
		ContentText.text = WorldStateManager.GetTipsContent(id);
		button.onClick.RemoveAllListeners();
		button.onClick.AddListener(delegate
		{
			talkButton.Click(id);
		});
	}
}
