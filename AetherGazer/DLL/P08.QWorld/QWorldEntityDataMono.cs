using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

public abstract class QWorldEntityDataMono<T> : QWorldEntityMono where T : QWorldEntityData, new()
{
	public T data;

	protected bool isEditorData { get; private set; }

	protected virtual void InitData()
	{
		if (data == null)
		{
			data = new T();
		}
	}

	internal static Mono CreateFromData<Mono>(T loadData) where Mono : QWorldEntityDataMono<T>
	{
		GameObject gameObject = new GameObject(loadData.editor_prefab_name);
		Mono com = gameObject.AddComponent<Mono>();
		com.isEditorData = false;
		com.data = loadData;
		com.transform.position = loadData.position;
		com.transform.rotation = loadData.rotation;
		if (loadData.localScale == Vector3.zero)
		{
			loadData.localScale = Vector3.one;
		}
		com.transform.localScale = loadData.localScale;
		com.id = loadData.id;
		com.entity_child_list = new List<int>();
		if (loadData.entity_child_list != null)
		{
			loadData.entity_child_list.ForEach(delegate(int i)
			{
				com.entity_child_list.Add(i);
			});
		}
		com.Size = loadData.size;
		com.group_index = loadData.group_index;
		com.OnAfterLoadState(loadData);
		return com;
	}

	public void LoadState(T loadData)
	{
		isEditorData = true;
		InitData();
		OnLoadState(loadData);
		id = loadData.id;
		base.transform.position = loadData.position;
		base.transform.rotation = loadData.rotation;
		if (loadData.localScale == Vector3.zero)
		{
			loadData.localScale = Vector3.one;
		}
		base.transform.localScale = loadData.localScale;
		base.gameObject.name = loadData.editor_prefab_name;
		entity_child_list = new List<int>();
		if (loadData.entity_child_list != null)
		{
			loadData.entity_child_list.ForEach(delegate(int i)
			{
				entity_child_list.Add(i);
			});
		}
		Size = loadData.size;
		group_index = loadData.group_index;
		OnAfterLoadState(loadData);
	}

	public T SaveState(string prefab)
	{
		T saveData = new T();
		OnSaveState(ref saveData);
		saveData.id = id;
		saveData.editor_prefab = prefab;
		saveData.editor_prefab_name = base.gameObject.name;
		saveData.position = base.gameObject.transform.position;
		saveData.rotation = base.gameObject.transform.rotation;
		saveData.entity_child_list = new List<int>();
		saveData.localScale = base.gameObject.transform.localScale;
		if (entity_child_list != null)
		{
			entity_child_list.ForEach(delegate(int i)
			{
				saveData.entity_child_list.Add(i);
			});
		}
		saveData.size = Size.GetValueOrDefault();
		saveData.group_index = group_index;
		OnAfterSaveState(ref saveData);
		return saveData;
	}

	protected virtual void OnLoadState(T loadData)
	{
		FieldInfo[] fields = typeof(T).GetFields(BindingFlags.Instance | BindingFlags.Public);
		foreach (FieldInfo fieldInfo in fields)
		{
			fieldInfo.SetValue(data, fieldInfo.GetValue(loadData));
		}
	}

	protected virtual void OnSaveState(ref T saveData)
	{
		FieldInfo[] fields = typeof(T).GetFields(BindingFlags.Instance | BindingFlags.Public);
		foreach (FieldInfo fieldInfo in fields)
		{
			fieldInfo.SetValue(saveData, fieldInfo.GetValue(data));
		}
	}

	protected virtual void OnAfterLoadState(T loadData)
	{
	}

	protected virtual void OnAfterSaveState(ref T saveData)
	{
	}
}
