using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class UnityUtils
{
	public delegate void Callback(GameObject ob);

	public static readonly bool isPro = true;

	private static int sSeqNum = 100000;

	public static bool IsTooSmall(this Vector3 vector)
	{
		if (!Mathf.Approximately(vector.x, 0f))
		{
			return false;
		}
		if (!Mathf.Approximately(vector.y, 0f))
		{
			return false;
		}
		if (!Mathf.Approximately(vector.z, 0f))
		{
			return false;
		}
		return true;
	}

	public static bool IsTooSmall(this Vector2 vector)
	{
		if (!Mathf.Approximately(vector.x, 0f))
		{
			return false;
		}
		if (!Mathf.Approximately(vector.y, 0f))
		{
			return false;
		}
		return true;
	}

	public static Vector3 AddX(this Vector3 vector, float deltaX)
	{
		vector.x += deltaX;
		return vector;
	}

	public static Vector3 NewX(this Vector3 vector, float x)
	{
		vector.x = x;
		return vector;
	}

	public static Vector3 AddY(this Vector3 vector, float deltaY)
	{
		vector.y += deltaY;
		return vector;
	}

	public static Vector3 NewY(this Vector3 vector, float y)
	{
		vector.y = y;
		return vector;
	}

	public static Vector3 AddZ(this Vector3 vector, float deltaZ)
	{
		vector.z += deltaZ;
		return vector;
	}

	public static Vector3 NewZ(this Vector3 vector, float z)
	{
		vector.z = z;
		return vector;
	}

	public static Vector2 NewX(this Vector2 vector, float x)
	{
		vector.x = x;
		return vector;
	}

	public static Vector2 NewY(this Vector2 vector, float y)
	{
		vector.y = y;
		return vector;
	}

	public static Vector2 ToVec2(this Vector3 vector)
	{
		return new Vector2(vector.x, vector.z);
	}

	public static Vector3 toVec3(this Vector2 vector)
	{
		return new Vector3(vector.x, 0f, vector.y);
	}

	public static Vector3 toVec3(this Vector2 vector, float y)
	{
		return new Vector3(vector.x, y, vector.y);
	}

	public static Color NewAlpha(this Color color, float alpha)
	{
		color.a = alpha;
		return color;
	}

	public static T[] SubArray<T>(this T[] data, int index, int length)
	{
		T[] array = new T[length];
		Array.Copy(data, index, array, 0, length);
		return array;
	}

	public static void NewX(this Transform transform, float x)
	{
		Vector3 position = new Vector3(x, transform.position.y, transform.position.z);
		transform.position = position;
	}

	public static void NewY(this Transform transform, float y)
	{
		Vector3 position = new Vector3(transform.position.x, y, transform.position.z);
		transform.position = position;
	}

	public static void NewZ(this Transform transform, float z)
	{
		Vector3 position = new Vector3(transform.position.x, transform.position.y, z);
		transform.position = position;
	}

	public static void ResetTransformation(this Transform trans)
	{
		trans.position = Vector3.zero;
		trans.localPosition = Vector3.zero;
		trans.localRotation = Quaternion.identity;
		trans.localScale = Vector3.one;
	}

	public static Bounds GetBoundsByRender(this GameObject go)
	{
		Vector3 zero = Vector3.zero;
		Renderer[] componentsInChildren = go.GetComponentsInChildren<Renderer>();
		Renderer[] array = componentsInChildren;
		foreach (Renderer renderer in array)
		{
			zero += renderer.bounds.center;
		}
		zero /= (float)componentsInChildren.Length;
		Bounds result = new Bounds(zero, Vector3.zero);
		array = componentsInChildren;
		foreach (Renderer renderer2 in array)
		{
			result.Encapsulate(renderer2.bounds);
		}
		return result;
	}

	public static T GetSafeComponent<T>(this GameObject obj) where T : MonoBehaviour
	{
		T component = obj.GetComponent<T>();
		if (component == null)
		{
			Debug.LogError("Expected to find component of type " + typeof(T)?.ToString() + " but found none", obj);
		}
		return component;
	}

	public static float AngleAroundAxis(Vector3 dirA, Vector3 dirB, Vector3 axis)
	{
		dirA -= Vector3.Project(dirA, axis);
		dirB -= Vector3.Project(dirB, axis);
		return Vector3.Angle(dirA, dirB) * (float)((!(Vector3.Dot(axis, Vector3.Cross(dirA, dirB)) < 0f)) ? 1 : (-1));
	}

	public static ushort AngleAroundAxisRange360(Vector3 dirA, Vector3 dirB, Vector3 axis)
	{
		dirA -= Vector3.Project(dirA, axis);
		dirB -= Vector3.Project(dirB, axis);
		short num = (short)(Vector3.Angle(dirA, dirB) * (float)((!(Vector3.Dot(axis, Vector3.Cross(dirA, dirB)) < 0f)) ? 1 : (-1)));
		if (num <= 0)
		{
			return (ushort)(num + 360);
		}
		return (ushort)num;
	}

	public static bool PointInPolygon(ref Vector2[] polygon, Vector2 point)
	{
		bool flag = false;
		int num = polygon.Length;
		int num2 = 0;
		int num3 = num - 1;
		while (num2 < num)
		{
			if (polygon[num2].y > point.y != polygon[num3].y > point.y && point.x < (polygon[num3].x - polygon[num2].x) * (point.y - polygon[num2].y) / (polygon[num3].y - polygon[num2].y) + polygon[num2].x)
			{
				flag = !flag;
			}
			num3 = num2++;
		}
		return flag;
	}

	public static GameObject FindChild(GameObject ob, string name)
	{
		if (ob == null)
		{
			return GameObject.Find("/" + name);
		}
		Transform transform = ob.transform.Find(name);
		if (transform == null)
		{
			return null;
		}
		return transform.gameObject;
	}

	public static GameObject FindChildDeep(GameObject ob, string name)
	{
		GameObject gameObject = FindChild(ob, name);
		if (gameObject != null)
		{
			return gameObject;
		}
		if (ob == null)
		{
			return null;
		}
		IEnumerator enumerator = ob.transform.GetEnumerator();
		while (enumerator.MoveNext())
		{
			gameObject = FindChildDeep(((Transform)enumerator.Current).gameObject, name);
			if (gameObject != null)
			{
				return gameObject;
			}
		}
		return null;
	}

	public static Transform FindChildDeep(this Transform pTransform, string pName)
	{
		Transform transform = pTransform.Find(pName);
		if (transform != null)
		{
			return transform;
		}
		IEnumerator enumerator = pTransform.GetEnumerator();
		while (enumerator.MoveNext())
		{
			transform = ((Transform)enumerator.Current).FindChildDeep(pName);
			if (transform != null)
			{
				return transform;
			}
		}
		return null;
	}

	public static GameObject FindChildPath(GameObject ob, string path)
	{
		string[] array = Explode(path, "/");
		for (int i = 0; i < array.Length; i++)
		{
			ob = FindChild(ob, array[i]);
			if (ob == null)
			{
				break;
			}
		}
		return ob;
	}

	public static void FindChildComponents<T>(GameObject ob, List<T> coms) where T : Component
	{
		if (!(ob == null))
		{
			List<T> list = new List<T>();
			ob.GetComponents(list);
			coms.AddRange(list);
			IEnumerator enumerator = ob.transform.GetEnumerator();
			while (enumerator.MoveNext())
			{
				FindChildComponents(((Transform)enumerator.Current).gameObject, coms);
			}
		}
	}

	public static void FindParentComponents<T>(GameObject ob, List<T> coms) where T : Component
	{
		if (!(ob == null))
		{
			List<T> list = new List<T>();
			Transform parent = ob.transform.parent;
			if (!(parent == null))
			{
				parent.GetComponents(list);
				coms.AddRange(list);
				FindParentComponents(parent.gameObject, coms);
			}
		}
	}

	public static string GetObjectPath(GameObject ob)
	{
		string text = "/" + ob.name;
		Transform parent = ob.transform.parent;
		while (parent != null)
		{
			text = parent.name + "/" + text;
			parent = parent.transform.parent;
		}
		return text;
	}

	public static T GetComponentInChildren<T>(GameObject ob)
	{
		IEnumerator enumerator = ob.transform.GetEnumerator();
		while (enumerator.MoveNext())
		{
			T val = (T)(object)((Transform)enumerator.Current).GetComponent(typeof(T));
			if (val != null)
			{
				return val;
			}
		}
		enumerator = ob.transform.GetEnumerator();
		while (enumerator.MoveNext())
		{
			T componentInChildren = GetComponentInChildren<T>(((Transform)enumerator.Current).gameObject);
			if (componentInChildren != null)
			{
				return componentInChildren;
			}
		}
		return (T)(object)null;
	}

	public static T Get<T>(GameObject go) where T : Component
	{
		T val = go.GetComponent<T>();
		if (val == null)
		{
			val = go.AddComponent<T>();
		}
		return val;
	}

	public static GameObject Load(string resPath, Transform parent)
	{
		return null;
	}

	public static void SetLayer(GameObject ob, int layer)
	{
		ob.layer = layer;
		for (int i = 0; i < ob.transform.childCount; i++)
		{
			SetLayer(ob.transform.GetChild(i).gameObject, layer);
		}
	}

	public static void SetTag(GameObject ob, string tag)
	{
		ob.tag = tag;
		for (int i = 0; i < ob.transform.childCount; i++)
		{
			SetTag(ob.transform.GetChild(i).gameObject, tag);
		}
	}

	public static void SetLayerTag(GameObject ob, int layer, string tag)
	{
		ob.layer = layer;
		ob.tag = tag;
		for (int i = 0; i < ob.transform.childCount; i++)
		{
			SetLayerTag(ob.transform.GetChild(i).gameObject, layer, tag);
		}
	}

	public static T[] GetComponentsInChildren<T>(GameObject ob)
	{
		List<T> list = new List<T>();
		IEnumerator enumerator = ob.transform.GetEnumerator();
		while (enumerator.MoveNext())
		{
			T val = (T)(object)((Transform)enumerator.Current).GetComponent(typeof(T));
			if (val != null)
			{
				list.Add(val);
			}
		}
		enumerator = ob.transform.GetEnumerator();
		while (enumerator.MoveNext())
		{
			T[] componentsInChildren = GetComponentsInChildren<T>(((Transform)enumerator.Current).gameObject);
			if (componentsInChildren == null)
			{
				continue;
			}
			int num = componentsInChildren.Length;
			for (int i = 0; i < num; i++)
			{
				if (componentsInChildren[i] != null)
				{
					list.Add(componentsInChildren[i]);
				}
			}
		}
		return list.ToArray();
	}

	public static bool IsSamePoint(Vector3 p1, Vector3 p2)
	{
		return (p1 - p2).magnitude < 0.01f;
	}

	public static GameObject Instantiate(GameObject ob, Transform parent)
	{
		if (ob == null)
		{
			return null;
		}
		Vector3 localPosition = ob.transform.localPosition;
		Quaternion localRotation = ob.transform.localRotation;
		Vector3 localScale = ob.transform.localScale;
		GameObject gameObject = UnityEngine.Object.Instantiate(ob);
		gameObject.name = gameObject.name.Replace("(Clone)", string.Empty);
		gameObject.transform.parent = parent;
		gameObject.transform.localPosition = localPosition;
		gameObject.transform.localRotation = localRotation;
		gameObject.transform.localScale = localScale;
		return gameObject;
	}

	public static void Attach(GameObject ob, Transform parent)
	{
		Vector3 localPosition = ob.transform.localPosition;
		Quaternion localRotation = ob.transform.localRotation;
		Vector3 localScale = ob.transform.localScale;
		ob.transform.parent = parent;
		ob.transform.localPosition = localPosition;
		ob.transform.localRotation = localRotation;
		ob.transform.localScale = localScale;
	}

	public static void Visible(GameObject gobj, bool v)
	{
		if (gobj == null)
		{
			return;
		}
		SkinnedMeshRenderer[] componentsInChildren = gobj.GetComponentsInChildren<SkinnedMeshRenderer>();
		if (componentsInChildren != null)
		{
			int num = componentsInChildren.Length;
			for (int i = 0; i < num; i++)
			{
				componentsInChildren[i].enabled = v;
			}
		}
		MeshRenderer[] componentsInChildren2 = gobj.GetComponentsInChildren<MeshRenderer>();
		if (componentsInChildren2 != null)
		{
			int num2 = componentsInChildren2.Length;
			for (int j = 0; j < num2; j++)
			{
				componentsInChildren2[j].enabled = v;
			}
		}
	}

	public static bool IsVisible(GameObject gobj)
	{
		if (gobj == null || !gobj.activeSelf)
		{
			return false;
		}
		SkinnedMeshRenderer[] componentsInChildren = gobj.GetComponentsInChildren<SkinnedMeshRenderer>();
		if (componentsInChildren != null)
		{
			int num = componentsInChildren.Length;
			for (int i = 0; i < num; i++)
			{
				if (componentsInChildren[i].isVisible)
				{
					return true;
				}
			}
		}
		MeshRenderer[] componentsInChildren2 = gobj.GetComponentsInChildren<MeshRenderer>();
		if (componentsInChildren2 != null)
		{
			int num2 = componentsInChildren2.Length;
			for (int j = 0; j < num2; j++)
			{
				if (componentsInChildren2[j].isVisible)
				{
					return true;
				}
			}
		}
		return false;
	}

	public static Vector3 TransToOrth(Camera cameraPorj, Camera cameraOrth, Vector3 p, float z)
	{
		Vector3 point = cameraPorj.WorldToViewportPoint(p);
		point.x = (point.x - 0.5f) * cameraOrth.orthographicSize * 2f * cameraPorj.aspect;
		point.y = (point.y - 0.5f) * cameraOrth.orthographicSize * 2f;
		point.z = z;
		return cameraOrth.transform.localToWorldMatrix.MultiplyPoint3x4(point);
	}

	public static float ConvertEulerAngles(float a)
	{
		if (a > 360f || a < -360f)
		{
			a %= 360f;
		}
		if (a > 180f)
		{
			a -= 360f;
		}
		if (a < -180f)
		{
			a += 360f;
		}
		return a;
	}

	public static float FixedPrecision(float f)
	{
		return (float)(int)(f * 1000f) * 0.001f;
	}

	public static string CovertMoneyFormat(float f)
	{
		int num = Mathf.CeilToInt(f);
		float num2 = f - (float)num;
		if (f.ToString().IndexOf('.') != -1)
		{
			if (num == 0)
			{
				return num + "." + num2;
			}
			return num.ToString("#,###") + "." + num2;
		}
		if (num == 0)
		{
			return num.ToString();
		}
		return num.ToString("#,###");
	}

	public static string CovertMoneyFormat(int f)
	{
		return f.ToString("N");
	}

	public static string CovertMoneyFormat(string money)
	{
		string[] array = money.Split('.');
		int result = 0;
		if (!int.TryParse(array[0], out result))
		{
			return money;
		}
		if (array.Length == 2)
		{
			if (result == 0)
			{
				return result + "." + array[1].ToString();
			}
			return result.ToString("#,###") + "." + array[1].ToString();
		}
		if (result == 0)
		{
			return result.ToString();
		}
		return result.ToString("#,###");
	}

	public static Vector3 FixedPrecision(Vector3 v)
	{
		v.x = FixedPrecision(v.x);
		v.y = FixedPrecision(v.y);
		v.z = FixedPrecision(v.z);
		return v;
	}

	public static string GetUniqueName(string prefix)
	{
		return $"{prefix}_{sSeqNum++}";
	}

	public static string[] Explode(string path, string seperator)
	{
		return path.Split(seperator.ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
	}

	public static int[] ParseStringToInt(string source, char split)
	{
		string[] array = source.Split(split);
		int[] array2 = new int[array.Length];
		for (int i = 0; i < array.Length; i++)
		{
			if (!string.IsNullOrEmpty(array[i]))
			{
				array2[i] = int.Parse(array[i]);
			}
		}
		return array2;
	}

	public static bool MaterialCompare(this Renderer render, ref Material[] b)
	{
		if (b != null && render.materials.Length == b.Length)
		{
			for (int i = 0; i < render.materials.Length; i++)
			{
				if (render.materials[i].shader != b[i].shader)
				{
					return false;
				}
			}
			return true;
		}
		return false;
	}

	public static bool MaterialCompare(this Renderer render, ref Material b)
	{
		if ((bool)b)
		{
			return render.material.shader == b.shader;
		}
		return false;
	}
}
