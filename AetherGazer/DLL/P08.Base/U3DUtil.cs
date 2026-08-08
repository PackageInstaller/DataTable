using System;
using System.Collections;
using System.Collections.Generic;
using Config;
using UnityEngine;

public static class U3DUtil
{
	public delegate void Callback(GameObject ob);

	public delegate bool Callback<T, U>(T a, U b);

	private static int sSeqNum = 100000;

	public static int DiffArrays<T>(ref T[] A, ref T[] B, Callback<T, T> callback)
	{
		if (A == null || A.Length == 0)
		{
			return -1;
		}
		if (B == null || B.Length == 0)
		{
			return -1;
		}
		int num = 0;
		int i = 0;
		int num2 = A.Length - 1;
		while (num <= num2)
		{
			if (i >= B.Length)
			{
				num2 = num - 1;
				break;
			}
			bool flag = false;
			for (; i < B.Length; i++)
			{
				if (callback(A[num], B[i]))
				{
					if (num != i)
					{
						T val = B[num];
						B[num] = B[i];
						B[i] = val;
					}
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				T val2 = A[num];
				A[num] = A[num2];
				A[num2] = val2;
				num2--;
			}
			else
			{
				num++;
			}
			i = num;
		}
		return num2;
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

	public static void FindStaticChildren(GameObject ob, ref List<GameObject> allChildren, bool clearFlag)
	{
		int childCount = ob.transform.childCount;
		for (int i = 0; i < childCount; i++)
		{
			Transform child = ob.transform.GetChild(i);
			if (child.gameObject.isStatic)
			{
				allChildren.Add(child.gameObject);
				if (clearFlag)
				{
					child.gameObject.isStatic = false;
				}
				FindStaticChildren(child.gameObject, ref allChildren, clearFlag);
			}
		}
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

	public static void ClearMemory()
	{
		Dictionary<string, LoadedAssetBundle> loadedAssetbundle = AssetManager.GetLoadedAssetbundle();
		if (loadedAssetbundle != null)
		{
			Debug.Log("剩余未清理AB数量：" + loadedAssetbundle.Count);
		}
		Resources.UnloadUnusedAssets();
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

	public static Config.Int3 ToInt3(this Vector3 vector)
	{
		return new Config.Int3
		{
			X = (int)Math.Round(vector.x * 1000f),
			Y = (int)Math.Round(vector.y * 1000f),
			Z = (int)Math.Round(vector.z * 1000f)
		};
	}

	public static Component GetComponentFromStrToType(GameObject go, string compName)
	{
		Component result = null;
		Component[] components = go.GetComponents<Component>();
		Type type = null;
		for (int i = 0; i < components.Length; i++)
		{
			if (components[i] == null)
			{
				continue;
			}
			Type type2 = components[i].GetType();
			List<Type> list = new List<Type>();
			Type type3 = type2;
			while (type3 != null)
			{
				list.Add(type3);
				type3 = type3.BaseType;
				if (type3 == typeof(UnityEngine.Object))
				{
					break;
				}
			}
			for (int j = 0; j < list.Count; j++)
			{
				if (list[j].Name == compName || list[j].FullName == compName)
				{
					type = type2;
					break;
				}
			}
			if (type != null)
			{
				break;
			}
		}
		if (type != null)
		{
			result = go.GetComponent(type);
		}
		return result;
	}

	public static Component GetComponentFromStrToType(Component obj, string compName)
	{
		Component result = null;
		Component[] components = obj.GetComponents<Component>();
		Type type = null;
		for (int i = 0; i < components.Length; i++)
		{
			if (components[i] == null)
			{
				continue;
			}
			Type type2 = components[i].GetType();
			List<Type> list = new List<Type>();
			Type type3 = type2;
			while (type3 != null)
			{
				list.Add(type3);
				type3 = type3.BaseType;
				if (type3 == typeof(UnityEngine.Object))
				{
					break;
				}
			}
			for (int j = 0; j < list.Count; j++)
			{
				if (list[j].Name == compName || list[j].FullName == compName)
				{
					type = type2;
					break;
				}
			}
			if (type != null)
			{
				break;
			}
		}
		if (type != null)
		{
			result = obj.GetComponent(type);
		}
		return result;
	}
}
