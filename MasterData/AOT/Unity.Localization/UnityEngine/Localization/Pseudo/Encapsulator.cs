using System;

namespace UnityEngine.Localization.Pseudo;

[Serializable]
public class Encapsulator : IPseudoLocalizationMethod
{
	[SerializeField]
	private string m_Start = "[";

	[SerializeField]
	private string m_End = "]";

	public string Start
	{
		get
		{
			return m_Start;
		}
		set
		{
			m_Start = value;
		}
	}

	public string End
	{
		get
		{
			return m_End;
		}
		set
		{
			m_End = value;
		}
	}

	public void Transform(Message message)
	{
		ReadOnlyMessageFragment item = message.CreateReadonlyTextFragment(Start);
		ReadOnlyMessageFragment item2 = message.CreateReadonlyTextFragment(End);
		message.Fragments.Insert(0, item);
		message.Fragments.Add(item2);
	}
}
