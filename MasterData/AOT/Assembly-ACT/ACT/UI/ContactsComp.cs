using System.Linq;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ContactsComp : MonoBehaviour
{
	[SerializeField]
	private BImage icon;

	[SerializeField]
	private new LocalizeStringEvent name;

	[SerializeField]
	private TextMeshProUGUI nameText;

	[SerializeField]
	private ActButton btn;

	[SerializeField]
	private RedDotItem redDot;

	[SerializeField]
	private BetterAnimation _animation;

	[SerializeField]
	private GameObject selectGo;

	private const string Normal = "Normal";

	private const string Selected = "Selected";

	private const string SelectedShow = "SelectedShow";

	private const string NormalShow = "NormalShow";

	private const string Hide = "Hide";

	private int _contactsId;

	private string _redDotPath;

	public ActButton Btn => btn;

	public GameObject Select => selectGo;

	public int ContactsId => _contactsId;

	public void Init(int contactsId, ImageAssetStation station, GroupImageData headImageData, LocalizeStringData nameData, bool expand)
	{
		_contactsId = contactsId;
		station.LoadImage(headImageData.GroupId, headImageData.ImageId, icon);
		selectGo.SetActive(expand);
		if (nameData != null)
		{
			name.SetReference(nameData);
		}
		_redDotPath = RedDotPathDefine.SNSMain + $"|{_contactsId}";
		if (redDot != null)
		{
			redDot.fullPath = _redDotPath.Split("|").ToList();
			redDot.BindTrieNode();
			redDot.UpdateDisplay();
		}
	}

	public void SetRedDot()
	{
	}

	public void PlayAnimation(bool expand)
	{
		_animation?.GetSequence(expand ? "Selected" : "Normal").Play();
	}

	public void PlayInitAnimation(bool selected)
	{
		_animation?.GetSequence(selected ? "SelectedShow" : "NormalShow").Play();
	}

	public void PlayUnInitAnimation()
	{
		_animation?.GetSequence("Hide").Play();
	}
}
