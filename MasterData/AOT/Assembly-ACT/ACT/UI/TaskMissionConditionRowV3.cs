using ACT.MissionSystem;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TaskMissionConditionRowV3 : MonoBehaviour
{
	[SerializeField]
	private GameObject _dot;

	[SerializeField]
	private LocalizeStringEvent _contentLocalize;

	[SerializeField]
	private TMP_Text _contentText;

	private ConditionDescription _description;

	private bool _bound;

	public void Bind(ConditionDescription description)
	{
		Unbind();
		if (!description.HaveContent || (description.DescriptionContentId <= 0 && description.DescriptionContent == null))
		{
			return;
		}
		_description = description;
		_bound = true;
		_dot.SetActive(value: true);
		_contentLocalize.OnUpdateString.RemoveListener(OnUpdateString);
		_contentLocalize.OnUpdateString.AddListener(OnUpdateString);
		if (description.DescriptionContent != null)
		{
			_contentLocalize.StringReference.Clear();
			_contentLocalize.StringReference.TableReference = description.DescriptionContent.TableReference;
			_contentLocalize.StringReference.TableEntryReference = description.DescriptionContent.TableEntryReference;
			foreach (string key in description.DescriptionContent.Keys)
			{
				_contentLocalize.StringReference.Add(key, description.DescriptionContent.GetVariable(key));
			}
		}
		else
		{
			_contentLocalize.StringReference.Clear();
			_contentLocalize.StringReference.TableReference = LocalizationUtility.localizeTableName_shortcommon;
			_contentLocalize.StringReference.TableEntryReference = description.DescriptionContentId;
		}
		_contentLocalize.RefreshString();
		gameObject.SetActive(value: true);
	}

	public void Unbind()
	{
		_contentLocalize.OnUpdateString.RemoveListener(OnUpdateString);
		_contentLocalize.StringReference.TableReference = null;
		_contentLocalize.StringReference.TableEntryReference = null;
		_contentText.text = string.Empty;
		_dot.SetActive(value: false);
		_description = default;
		_bound = false;
		gameObject.SetActive(value: false);
	}

	private void OnUpdateString(string value)
	{
		if (!_bound || !_description.HaveContent || (_description.DescriptionContentId <= 0 && _description.DescriptionContent == null))
		{
			_contentText.text = string.Empty;
		}
		else
		{
			_contentText.text = (_description.HaveProgress ? $"{value} ({_description.Progress}/{_description.TotalProgress})" : value);
		}
	}
}
