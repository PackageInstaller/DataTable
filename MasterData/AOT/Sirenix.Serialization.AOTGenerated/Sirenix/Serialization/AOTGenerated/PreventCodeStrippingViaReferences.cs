using UnityEngine;
using UnityEngine.Scripting;

namespace Sirenix.Serialization.AOTGenerated;

[Preserve]
internal static class PreventCodeStrippingViaReferences
{
	static PreventCodeStrippingViaReferences()
	{
		bool flag = false;
		float num = default;
		SingleSerializer singleSerializer = new SingleSerializer();
		if (flag)
		{
			singleSerializer.ReadValueWeak(null);
			singleSerializer.WriteValueWeak(null, null, null);
		}
		Color color = default;
		new ColorFormatter();
		new ReflectionFormatter<Color>();
		ComplexTypeSerializer<Color> complexTypeSerializer = new ComplexTypeSerializer<Color>();
		if (flag)
		{
			complexTypeSerializer.ReadValueWeak(null);
			complexTypeSerializer.WriteValueWeak(null, null, null);
		}
	}
}
