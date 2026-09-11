using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace Pathfinding;

public class ObjImporter
{
	private struct meshStruct
	{
		public Vector3[] vertices;

		public Vector3[] normals;

		public Vector2[] uv;

		public Vector2[] uv1;

		public Vector2[] uv2;

		public int[] triangles;

		public int[] faceVerts;

		public int[] faceUVs;

		public Vector3[] faceData;

		public string name;

		public string fileName;
	}

	public static Mesh ImportFile(string filePath)
	{
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_008d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0106: Expected O, but got Unknown
		//IL_00bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00de: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e3: Unknown result type (might be due to invalid IL or missing references)
		if (!File.Exists(filePath))
		{
			Debug.LogError((object)("No file was found at '" + filePath + "'"));
			return null;
		}
		meshStruct mesh = createMeshStruct(filePath);
		populateMeshStruct(ref mesh);
		Vector3[] array = (Vector3[])(object)new Vector3[mesh.faceData.Length];
		Vector2[] array2 = (Vector2[])(object)new Vector2[mesh.faceData.Length];
		Vector3[] array3 = (Vector3[])(object)new Vector3[mesh.faceData.Length];
		int num = 0;
		Vector3[] faceData = mesh.faceData;
		foreach (Vector3 val in faceData)
		{
			array[num] = mesh.vertices[(int)val.x - 1];
			if (val.y >= 1f)
			{
				array2[num] = mesh.uv[(int)val.y - 1];
			}
			if (val.z >= 1f)
			{
				array3[num] = mesh.normals[(int)val.z - 1];
			}
			num++;
		}
		Mesh val2 = new Mesh();
		val2.vertices = array;
		val2.uv = array2;
		val2.normals = array3;
		val2.triangles = mesh.triangles;
		val2.RecalculateBounds();
		return val2;
	}

	private static meshStruct createMeshStruct(string filename)
	{
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		int num5 = 0;
		meshStruct result = new meshStruct
		{
			fileName = filename
		};
		StreamReader streamReader = File.OpenText(filename);
		string s = streamReader.ReadToEnd();
		streamReader.Dispose();
		using (StringReader stringReader = new StringReader(s))
		{
			string text = stringReader.ReadLine();
			char[] separator = new char[1] { ' ' };
			while (text != null)
			{
				if (!text.StartsWith("f ") && !text.StartsWith("v ") && !text.StartsWith("vt ") && !text.StartsWith("vn "))
				{
					text = stringReader.ReadLine();
					if (text != null)
					{
						text = text.Replace("  ", " ");
					}
					continue;
				}
				text = text.Trim();
				string[] array = text.Split(separator, 50);
				switch (array[0])
				{
				case "v":
					num2++;
					break;
				case "vt":
					num3++;
					break;
				case "vn":
					num4++;
					break;
				case "f":
					num5 = num5 + array.Length - 1;
					num += 3 * (array.Length - 2);
					break;
				}
				text = stringReader.ReadLine();
				if (text != null)
				{
					text = text.Replace("  ", " ");
				}
			}
		}
		result.triangles = new int[num];
		result.vertices = (Vector3[])(object)new Vector3[num2];
		result.uv = (Vector2[])(object)new Vector2[num3];
		result.normals = (Vector3[])(object)new Vector3[num4];
		result.faceData = (Vector3[])(object)new Vector3[num5];
		return result;
	}

	private static void populateMeshStruct(ref meshStruct mesh)
	{
		//IL_0329: Unknown result type (might be due to invalid IL or missing references)
		//IL_032e: Unknown result type (might be due to invalid IL or missing references)
		//IL_02cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_02d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_0390: Unknown result type (might be due to invalid IL or missing references)
		//IL_0395: Unknown result type (might be due to invalid IL or missing references)
		//IL_0358: Unknown result type (might be due to invalid IL or missing references)
		//IL_035d: Unknown result type (might be due to invalid IL or missing references)
		//IL_02fa: Unknown result type (might be due to invalid IL or missing references)
		//IL_02ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_03b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_0423: Unknown result type (might be due to invalid IL or missing references)
		//IL_0425: Unknown result type (might be due to invalid IL or missing references)
		StreamReader streamReader = File.OpenText(mesh.fileName);
		string s = streamReader.ReadToEnd();
		streamReader.Close();
		using StringReader stringReader = new StringReader(s);
		string text = stringReader.ReadLine();
		char[] separator = new char[1] { ' ' };
		char[] separator2 = new char[1] { '/' };
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		int num5 = 0;
		int num6 = 0;
		int num7 = 0;
		while (text != null)
		{
			if (!text.StartsWith("f ") && !text.StartsWith("v ") && !text.StartsWith("vt ") && !text.StartsWith("vn ") && !text.StartsWith("g ") && !text.StartsWith("usemtl ") && !text.StartsWith("mtllib ") && !text.StartsWith("vt1 ") && !text.StartsWith("vt2 ") && !text.StartsWith("vc ") && !text.StartsWith("usemap "))
			{
				text = stringReader.ReadLine();
				if (text != null)
				{
					text = text.Replace("  ", " ");
				}
				continue;
			}
			text = text.Trim();
			string[] array = text.Split(separator, 50);
			switch (array[0])
			{
			case "v":
				mesh.vertices[num3] = new Vector3(Convert.ToSingle(array[1]), Convert.ToSingle(array[2]), Convert.ToSingle(array[3]));
				num3++;
				break;
			case "vt":
				mesh.uv[num5] = new Vector2(Convert.ToSingle(array[1]), Convert.ToSingle(array[2]));
				num5++;
				break;
			case "vt1":
				mesh.uv[num6] = new Vector2(Convert.ToSingle(array[1]), Convert.ToSingle(array[2]));
				num6++;
				break;
			case "vt2":
				mesh.uv[num7] = new Vector2(Convert.ToSingle(array[1]), Convert.ToSingle(array[2]));
				num7++;
				break;
			case "vn":
				mesh.normals[num4] = new Vector3(Convert.ToSingle(array[1]), Convert.ToSingle(array[2]), Convert.ToSingle(array[3]));
				num4++;
				break;
			case "f":
			{
				int num8 = 1;
				List<int> list = new List<int>();
				while (num8 < array.Length && (array[num8] ?? "").Length > 0)
				{
					Vector3 val = default(Vector3);
					string[] array2 = array[num8].Split(separator2, 3);
					val.x = Convert.ToInt32(array2[0]);
					if (array2.Length > 1)
					{
						if (array2[1] != "")
						{
							val.y = Convert.ToInt32(array2[1]);
						}
						val.z = Convert.ToInt32(array2[2]);
					}
					num8++;
					mesh.faceData[num2] = val;
					list.Add(num2);
					num2++;
				}
				for (num8 = 1; num8 + 2 < array.Length; num8++)
				{
					mesh.triangles[num] = list[0];
					num++;
					mesh.triangles[num] = list[num8];
					num++;
					mesh.triangles[num] = list[num8 + 1];
					num++;
				}
				break;
			}
			}
			text = stringReader.ReadLine();
			if (text != null)
			{
				text = text.Replace("  ", " ");
			}
		}
	}
}
