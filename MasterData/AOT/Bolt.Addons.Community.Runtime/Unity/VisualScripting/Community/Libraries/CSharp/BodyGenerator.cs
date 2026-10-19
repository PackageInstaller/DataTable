namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.BodyGenerator")]
public abstract class BodyGenerator : ConstructGenerator
{
	public bool hideBrackets;

	public override string Generate(int indent)
	{
		string text = GenerateBefore(indent);
		string text2 = GenerateBody(indent + ((!hideBrackets) ? 1 : 0));
		string text3 = GenerateAfter(indent);
		string text4 = ((string.IsNullOrEmpty(text) || string.IsNullOrWhiteSpace(text)) ? string.Empty : (text + "\n"));
		if (!hideBrackets)
		{
			text4 = text4 + CodeBuilder.OpenBody(indent) + "\n";
		}
		bool flag = text2.LastIndexOf("\\") == text2.Length - 2 && text2.LastIndexOf("n") == text2.Length - 1;
		text4 += ((string.IsNullOrEmpty(text2) || string.IsNullOrWhiteSpace(text2)) ? string.Empty : ((flag ? text2.Remove(text2.Length - 2, 1) : string.Empty) + text2 + "\n"));
		if (!hideBrackets)
		{
			text4 += CodeBuilder.CloseBody(indent);
		}
		return text4 + ((string.IsNullOrEmpty(text3) || string.IsNullOrWhiteSpace(text3)) ? string.Empty : (text3 + "\n"));
	}

	protected abstract string GenerateBefore(int indent);

	protected abstract string GenerateBody(int indent);

	protected abstract string GenerateAfter(int indent);
}
