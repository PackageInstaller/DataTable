using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[] { "mode", "gradientMax", "gradientMin", "colorMax", "colorMin", "color", "gradient" })]
[Preserve]
public class ES3Type_MinMaxGradient : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_MinMaxGradient()
		: base(typeof(MinMaxGradient))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		MinMaxGradient val = (MinMaxGradient)obj;
		writer.WriteProperty("mode", ((MinMaxGradient)(ref val)).mode);
		writer.WriteProperty("gradientMax", ((MinMaxGradient)(ref val)).gradientMax, ES3Type_Gradient.Instance);
		writer.WriteProperty("gradientMin", ((MinMaxGradient)(ref val)).gradientMin, ES3Type_Gradient.Instance);
		writer.WriteProperty("colorMax", ((MinMaxGradient)(ref val)).colorMax, ES3Type_Color.Instance);
		writer.WriteProperty("colorMin", ((MinMaxGradient)(ref val)).colorMin, ES3Type_Color.Instance);
		writer.WriteProperty("color", ((MinMaxGradient)(ref val)).color, ES3Type_Color.Instance);
		writer.WriteProperty("gradient", ((MinMaxGradient)(ref val)).gradient, ES3Type_Gradient.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0187: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f0: Unknown result type (might be due to invalid IL or missing references)
		MinMaxGradient val = default(MinMaxGradient);
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "mode":
				((MinMaxGradient)(ref val)).mode = reader.Read<ParticleSystemGradientMode>();
				break;
			case "gradientMax":
				((MinMaxGradient)(ref val)).gradientMax = reader.Read<Gradient>(ES3Type_Gradient.Instance);
				break;
			case "gradientMin":
				((MinMaxGradient)(ref val)).gradientMin = reader.Read<Gradient>(ES3Type_Gradient.Instance);
				break;
			case "colorMax":
				((MinMaxGradient)(ref val)).colorMax = reader.Read<Color>(ES3Type_Color.Instance);
				break;
			case "colorMin":
				((MinMaxGradient)(ref val)).colorMin = reader.Read<Color>(ES3Type_Color.Instance);
				break;
			case "color":
				((MinMaxGradient)(ref val)).color = reader.Read<Color>(ES3Type_Color.Instance);
				break;
			case "gradient":
				((MinMaxGradient)(ref val)).gradient = reader.Read<Gradient>(ES3Type_Gradient.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return val;
	}
}
