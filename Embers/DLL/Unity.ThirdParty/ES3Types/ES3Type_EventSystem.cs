using UnityEngine.EventSystems;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3Type_EventSystem : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_EventSystem()
		: base(typeof(EventSystem))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		foreach (string property in reader.Properties)
		{
			_ = property;
			reader.Skip();
		}
	}
}
