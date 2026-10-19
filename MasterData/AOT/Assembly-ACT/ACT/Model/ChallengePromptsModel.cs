using System.Collections.Generic;
using Fundamental;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.Model;

public class ChallengePromptsModel : Model<ChallengePromptsModel>
{
	public bool useString;

	public List<LocalizeStringEvent> eventList { get; private set; }

	public List<LocalizedString> stringList { get; private set; }

	protected override void Init()
	{
		eventList = ListPool<LocalizeStringEvent>.Get();
		stringList = ListPool<LocalizedString>.Get();
	}

	protected override void UnInit()
	{
		ListPool<LocalizeStringEvent>.Release(eventList);
		ListPool<LocalizedString>.Release(stringList);
	}

	public void SetStringList(List<LocalizedString> list)
	{
		useString = true;
		stringList.Clear();
		stringList.AddRange(list);
	}

	public void SetEventList(List<LocalizeStringEvent> list)
	{
		useString = false;
		eventList.Clear();
		eventList.AddRange(list);
	}
}
