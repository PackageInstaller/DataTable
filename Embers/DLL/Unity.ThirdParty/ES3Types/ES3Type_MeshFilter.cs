using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "sharedMesh" })]
public class ES3Type_MeshFilter : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_MeshFilter()
		: base(typeof(MeshFilter))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		MeshFilter meshFilter = (MeshFilter)obj;
		writer.WritePropertyByRef("sharedMesh", meshFilter.sharedMesh);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		MeshFilter meshFilter = (MeshFilter)obj;
		foreach (string property in reader.Properties)
		{
			if (property == "sharedMesh")
			{
				meshFilter.sharedMesh = reader.Read<Mesh>(ES3Type_Mesh.Instance);
			}
			else
			{
				reader.Skip();
			}
		}
	}
}
