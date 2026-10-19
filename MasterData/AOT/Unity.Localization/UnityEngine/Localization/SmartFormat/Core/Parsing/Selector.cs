namespace UnityEngine.Localization.SmartFormat.Core.Parsing;

public class Selector : FormatItem
{
	private string m_Operator;

	internal int operatorStart;

	public int SelectorIndex { get; internal set; }

	public string Operator
	{
		get
		{
			if (m_Operator == null)
			{
				m_Operator = baseString.Substring(operatorStart, startIndex - operatorStart);
			}
			return m_Operator;
		}
	}

	public override void Clear()
	{
		base.Clear();
		m_Operator = null;
	}
}
