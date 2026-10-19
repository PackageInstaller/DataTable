using ACT.UI.CommonComponent.FancyScrollView.Core;
using Bamboo.NumberString;
using Sirenix.Serialization;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class Cell : FancyCell<LevelNumData, Context>
{
	[SerializeField]
	private Image image;

	[SerializeField]
	private Button button;

	[SerializeField]
	private TextMeshProUGUI messageText;

	[SerializeField]
	private GameObject max;

	[SerializeField]
	private GameObject maxMax;

	[SerializeField]
	private GameObject banLevel;

	[SerializeField]
	private BetterAnimation betterAnim;

	[SerializeField]
	private Color normal = Color.white;

	[SerializeField]
	private Color selected = Color.white;

	[SerializeField]
	private Color ban = Color.white;

	[SerializeField]
	private bool isHorizontal;

	[OdinSerialize]
	public string normalAnimation;

	[OdinSerialize]
	public string disableAnimation;

	private float currentPosition;

	public int maxMaxNum => Context.TotalCount;

	public override void Initialize()
	{
		button.onClick.AddListener(() =>
		{
			Context.OnCellClicked?.Invoke(Index);
		});
	}

	public void PlayTarAnim(string animName, bool pause = true)
	{
		if (Context.MinIndex < maxMaxNum || Index != maxMaxNum - 1)
		{
			if (pause)
			{
				betterAnim.GetSequenceLastPlayPause(animName).Play();
			}
			else
			{
				betterAnim.GetSequence(animName).Play();
			}
		}
	}

	public override void UpdateContent(LevelNumData levelNumData)
	{
		if (Context.SelectedIndex == Index)
		{
			Context.CurrSelectedCell = this;
		}
		messageText.text = (Index + 1).FastToString();
		maxMax.gameObject.SetActive(Context.MinIndex >= maxMaxNum && Index == maxMaxNum - 1);
		max.gameObject.SetActive(Index == Context.TotalCount - 1 && Context.MinIndex < maxMaxNum);
		betterAnim.GetSequenceLastPlayPause((Index < Context.MinIndex) ? disableAnimation : normalAnimation).Play().Complete();
	}

	public override void UpdatePosition(float position)
	{
		currentPosition = position;
		betterAnim.GetSequenceLastPlayKeep(isHorizontal ? "CellScrollHorizontal" : "CellScrollVertical").Play().Goto(position);
	}

	private void OnEnable()
	{
		UpdatePosition(currentPosition);
	}
}
