using UnityEngine;
using UnityEngine.UI;

public class SubAttackButton : MonoBehaviour
{
	public int ValidAttackCount = 1;

	private Button _button;

	private AttackButton[] AttackButtons = new AttackButton[3];

	public void Awake()
	{
		_button.onClick.AddListener(OnClick);
		for (int i = 0; i < 3; i++)
		{
			AttackButtons[i] = base.transform.Find("SubButtons/SubButton" + i).GetComponent<AttackButton>();
		}
	}

	private void OnClick()
	{
		if (AttackButtons != null)
		{
			for (int i = 0; i < ValidAttackCount && i < AttackButtons.Length; i++)
			{
				AttackButtons[i].gameObject.SetActive(value: true);
			}
		}
	}
}
