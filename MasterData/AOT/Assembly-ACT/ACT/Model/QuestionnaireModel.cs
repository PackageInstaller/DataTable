using System.Collections.Generic;
using ACT.Game.Data;
using ACT.UI;
using Fundamental;
using Pb;

namespace ACT.Model;

public class QuestionnaireModel : Model<QuestionnaireModel>
{
	private List<QuestionnaireInfo> _questionnaires = new List<QuestionnaireInfo>();

	private Dictionary<int, bool> _read = new Dictionary<int, bool>();

	private int _newQuestionnaireId = -1;

	public bool HasQuestionnaire()
	{
		return _questionnaires.Count > 0;
	}

	public string WebUrl()
	{
		if (!HasQuestionnaire())
		{
			return null;
		}
		return _questionnaires[0].Url;
	}

	public string Title()
	{
		if (!HasQuestionnaire())
		{
			return null;
		}
		return _questionnaires[0].Title;
	}

	public int GetQuestionnaireId()
	{
		if (!HasQuestionnaire())
		{
			return -1;
		}
		return _questionnaires[0].Id;
	}

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
	}

	public void MergeQuestionnaireInfo(QuestionnaireNtf ntf)
	{
		bool flag = false;
		_questionnaires.Clear();
		foreach (QuestionnaireInfo questionnaire in ntf.Questionnaires)
		{
			_questionnaires.Add(questionnaire);
			flag |= !(ntf.Read.TryGetValue(questionnaire.Id, out var value) & value);
		}
		_read.Clear();
		foreach (KeyValuePair<int, bool> item in ntf.Read)
		{
			_read.Add(item.Key, item.Value);
		}
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.HasQuestionnaire, flag);
	}

	public void Read(int id)
	{
		if (!_read.TryAdd(id, value: true))
		{
			_read[id] = true;
		}
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.HasQuestionnaire, active: false);
	}
}
