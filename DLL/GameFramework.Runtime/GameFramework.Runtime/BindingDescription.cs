using System;
using System.Text;

namespace GameFramework.Runtime;

[Serializable]
public class BindingDescription
{
	public string TargetName { get; set; }

	public Type TargetType { get; set; }

	public string UpdateTrigger { get; set; }

	public IConverter Converter { get; set; }

	public BindingMode Mode { get; set; }

	public SourceDescription Source { get; set; }

	public object CommandParameter { get; set; }

	public BindingDescription()
	{
	}

	public BindingDescription(string targetName, Path path, IConverter converter = null, BindingMode mode = BindingMode.Default)
	{
		TargetName = targetName;
		Mode = mode;
		Converter = converter;
		Source = new ObjectSourceDescription
		{
			Path = path
		};
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("{binding ").Append(TargetName);
		if (!string.IsNullOrEmpty(UpdateTrigger))
		{
			stringBuilder.Append(" UpdateTrigger:").Append(UpdateTrigger);
		}
		if (Converter != null)
		{
			stringBuilder.Append(" Converter:").Append(Converter.GetType().Name);
		}
		if (Source != null)
		{
			stringBuilder.Append(" ").Append(Source.ToString());
		}
		if (CommandParameter != null)
		{
			stringBuilder.Append(" CommandParameter:").Append(CommandParameter);
		}
		stringBuilder.Append(" Mode:").Append(Mode.ToString());
		stringBuilder.Append(" }");
		return stringBuilder.ToString();
	}
}
