using ACT.UI;
using Runtime.UI.CommonComponent.UIComponentEx;
using Sirenix.Serialization;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Runtime.UI.ViewComponent.CharacterView.SkillUI;

public class SkillLevelCell : MonoBehaviour, IOSAUnit
{
	[SerializeField]
	private Image image;

	[SerializeField]
	private Button button;

	[SerializeField]
	private TextMeshProUGUI messageText;

	[SerializeField]
	private GameObject maxTip;

	[SerializeField]
	private BetterAnimation betterAnim;

	[SerializeField]
	private Color normal = Color.white;

	[SerializeField]
	private Color selected = Color.white;

	[SerializeField]
	private Color ban = Color.white;

	[SerializeField]
	private Color specialColor = Color.white;

	[SerializeField]
	private bool isHorizontal;

	[OdinSerialize]
	public string normalAnimation;

	[OdinSerialize]
	public string disableAnimation;

	private UnityAction m_CachedCallback;

	public void OnInstantiate()
	{
	}

	public void OnShow(int index, object dataContext)
	{
		if (dataContext is SkillLevelCellDataContext)
		{
			SkillLevelCellDataContext context = (SkillLevelCellDataContext)dataContext;
			if (index > context.baseLevel)
			{
				messageText.color = specialColor;
			}
			if (m_CachedCallback != null)
			{
				button.onClick.RemoveListener(m_CachedCallback);
			}
			m_CachedCallback = () =>
			{
				context.onClickCell?.Invoke(index);
			};
			button.onClick.AddListener(m_CachedCallback);
			maxTip.SetActive(index == context.maxLevel);
		}
	}
}
