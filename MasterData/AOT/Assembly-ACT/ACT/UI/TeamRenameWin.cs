using System.Text;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class TeamRenameWin : BaseUIView<TeamRenameWinViewInputController>
{
	public class Param
	{
		public PresetTeam teamProfile;

		public int index;

		public TeamItemV3 teamItem;
	}

	public TextMeshProUGUI teamName;

	public TMP_InputField inputField;

	[SerializeField]
	private GameObject tip2;

	[SerializeField]
	private ActButton _confirmBtn;

	[SerializeField]
	private ActButton _closeBtn;

	private int[] m_Ids = new int[3];

	private Param m_Param;

	protected override void Init()
	{
		base.Init();
		m_Param = (Param)uiViewData;
		teamName.text = m_Param.teamProfile.Name;
		inputField.text = teamName.text;
		inputField.characterLimit = 0;
		inputField.onValidateInput = ((Application.platform == RuntimePlatform.IPhonePlayer || Application.platform == RuntimePlatform.tvOS) ? null : new TMP_InputField.OnValidateInput(OnValidateInput));
		inputField.onValueChanged.RemoveAllListeners();
		inputField.onValueChanged.AddListener(OnValueChanged);
		inputField.onEndEdit.RemoveListener(OnEndEdit);
		inputField.onEndEdit.AddListener(OnEndEdit);
		_confirmBtn.SetBtnClick(ConfirmEvent, "event:/UI/Interface/Team/Click");
		_closeBtn.SetBtnClick(CloseView, "event:/UI/Common/Popup_Close");
	}

	private void OnEndEdit(string _)
	{
		if (inputField == null)
		{
			return;
		}
		string text = inputField.text ?? string.Empty;
		StringBuilder stringBuilder = new StringBuilder(text.Length);
		for (int i = 0; i < text.Length; i++)
		{
			char c = OnValidateInput(text, i, text[i]);
			if (c != '\0')
			{
				stringBuilder.Append(c);
			}
		}
		string text2 = stringBuilder.ToString();
		if (text2 != inputField.text)
		{
			inputField.text = text2;
		}
	}

	private void OnValueChanged(string value)
	{
		int num = UIUtility.StrLength(value);
		int[] nickNameLengthLimit = RuntimeConfigs.data.game.nickNameLengthLimit;
		tip2.SetActive(num > nickNameLengthLimit[1]);
		_confirmBtn.Interactable(num <= nickNameLengthLimit[1]);
	}

	private char OnValidateInput(string text, int charIndex, char addedChar)
	{
		if (char.IsWhiteSpace(addedChar))
		{
			return '\0';
		}
		if (IsEmoji(addedChar))
		{
			return '\0';
		}
		return addedChar;
	}

	private bool IsEmoji(char c)
	{
		if (char.IsHighSurrogate(c) || char.IsLowSurrogate(c))
		{
			return true;
		}
		if (c >= 127744 && c <= 129750)
		{
			return true;
		}
		if (c >= '℀' && c <= '➿')
		{
			return true;
		}
		return false;
	}

	private int GetTransCharNum(string text)
	{
		int num = 0;
		char[] array = text.ToCharArray();
		foreach (char singChar in array)
		{
			num += SingleCharTrans(singChar);
		}
		return num;
	}

	private int SingleCharTrans(char singChar)
	{
		int num = Encoding.UTF8.GetBytes(singChar.ToString()).Length;
		if (num >= 2)
		{
			num = 2;
		}
		return num;
	}

	public static int StrLength(string inputString)
	{
		ASCIIEncoding aSCIIEncoding = new ASCIIEncoding();
		int num = 0;
		byte[] bytes = aSCIIEncoding.GetBytes(inputString);
		for (int i = 0; i < bytes.Length; i++)
		{
			num = ((bytes[i] != 63) ? (num + 1) : (num + 2));
		}
		return num;
	}

	private void ConfirmEvent()
	{
		if (Singleton<SensitiveWordManager>.instance._Trie.Check(inputField.text))
		{
			GameUtility.OpenToolTip(1486);
			return;
		}
		if (inputField.text == teamName.text)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("名字相同不发Req");
			}
			Close();
			return;
		}
		m_Param.teamProfile.Name = inputField.text;
		ServerTeamCharacterChange evt = Singleton<EventManager>.instance.GetEvt<ServerTeamCharacterChange>();
		evt.teamProfile = m_Param.teamProfile;
		evt.index = m_Param.index;
		evt.finishAction = Close;
		evt.changeType = ProfileChangeType.Name;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Team_ServerInfoChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void SelectInputFieldByGamePad()
	{
		if (!(inputField == null))
		{
			EventSystemHelper.SetSelectedGameObject(inputField.gameObject);
			inputField.Select();
			inputField.ActivateInputField();
		}
	}

	public void ConfirmByGamePad()
	{
		if (!(_confirmBtn == null) && _confirmBtn.interactable)
		{
			_confirmBtn.OnSubmit(null);
		}
	}

	public void CloseByGamePad()
	{
		_closeBtn.OnSubmit(null);
	}

	private void Close(bool r)
	{
		if (r)
		{
			m_Param.teamItem.teamNameText.text = inputField.text;
			Model<TeamModel>.Interface.uiTeamProfiles[m_Param.index].Name = inputField.text;
			Close();
		}
		else
		{
			GameUtility.OpenToolTip(1486);
		}
	}

	private void CloseView()
	{
		inputField.text = "";
		Close();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}
}
