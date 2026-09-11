using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI;

public class Controller : MonoBehaviour, IUIController
{
	public Action<int> OnSelectChange = delegate
	{
	};

	[HideInInspector]
	[SerializeField]
	public new string name;

	[HideInInspector]
	[SerializeField]
	public List<string> stateValues = new List<string>();

	[HideInInspector]
	[SerializeField]
	public List<GameObject> objects = new List<GameObject>();

	[HideInInspector]
	[SerializeField]
	public List<ControllerProperty> properties = new List<ControllerProperty>();

	[HideInInspector]
	[SerializeField]
	public List<bool> tweens = new List<bool>();

	[HideInInspector]
	[SerializeField]
	public List<float> durings = new List<float>();

	[HideInInspector]
	[SerializeField]
	public List<LeanTweenType> eases = new List<LeanTweenType>();

	[HideInInspector]
	public int selectedIndex;

	[HideInInspector]
	public int defaultIndex;

	[SerializeField]
	[Tooltip("请勿编辑！！！！")]
	public List<ControllerRelateItem> relateItems = new List<ControllerRelateItem>();

	[HideInInspector]
	[SerializeField]
	public string desc;

	private void Awake()
	{
	}

	private void Start()
	{
	}

	public void AddEmptyControl()
	{
		objects.Add(null);
		properties.Add(ControllerProperty.Active);
		tweens.Add(item: false);
		durings.Add(0.3f);
		eases.Add(LeanTweenType.linear);
		CheckUselessRelateItems();
	}

	public void SetGameObject(int index, GameObject go, ControllerProperty property, Component target)
	{
		if (objects[index] != null && objects[index] != go)
		{
			RemoveRelateItem(objects[index], properties[index]);
		}
		objects[index] = go;
		if (go != null)
		{
			AddRelateItem(go, property, target);
		}
		CheckUselessRelateItems();
	}

	public void RemoveControl(int index)
	{
		GameObject gameObject = objects[index];
		if (gameObject == null)
		{
			objects.RemoveAt(index);
			properties.RemoveAt(index);
			tweens.RemoveAt(index);
			CheckUselessRelateItems();
			return;
		}
		ControllerProperty property = properties[index];
		int index2 = GetIndex(gameObject, property);
		if (index2 >= 0)
		{
			relateItems.RemoveAt(index2);
		}
		objects.RemoveAt(index);
		properties.RemoveAt(index);
		tweens.RemoveAt(index);
		CheckUselessRelateItems();
	}

	public void SaveProperties()
	{
		for (int i = 0; i < objects.Count; i++)
		{
			if (objects[i] != null)
			{
				UpdateRelateItem(objects[i], properties[i], objects[i].GetComponent(GetTypeByProperty(properties[i])));
			}
		}
	}

	public void LoadFromProperties(bool immediately)
	{
		for (int i = 0; i < objects.Count; i++)
		{
			if (!(objects[i] == null))
			{
				GetNewControllerValue(objects[i], properties[i]).PasteToComponent(objects[i].GetComponent(GetTypeByProperty(properties[i])), immediately);
			}
		}
	}

	public void LoadFromPropertiesWithCallback(Action callback)
	{
		int len = objects.Count;
		int completeCount = 0;
		for (int i = 0; i < len; i++)
		{
			if (objects[i] == null)
			{
				completeCount++;
				continue;
			}
			GetNewControllerValue(objects[i], properties[i]).PasteToComponentWithCallback(objects[i].GetComponent(GetTypeByProperty(properties[i])), delegate
			{
				completeCount++;
				if (completeCount >= len)
				{
					callback?.Invoke();
				}
			});
		}
	}

	public string[] GetValues()
	{
		return stateValues.ToArray();
	}

	public void AddSelectChangeListener(Action<int> handler)
	{
		OnSelectChange = (Action<int>)Delegate.Combine(OnSelectChange, handler);
	}

	public void RemoveAllListeners()
	{
		OnSelectChange = delegate
		{
		};
	}

	public void RemoveSelectChangeHandler(Action<int> handler)
	{
		OnSelectChange = (Action<int>)Delegate.Remove(OnSelectChange, handler);
	}

	public void SetSelectedIndex(int newIndex, bool immediately = false)
	{
		if (newIndex >= stateValues.Count)
		{
			Debug.LogWarning($"控制器{name}的状态总共有{stateValues.Count}个，但是传来的index = {newIndex}，设置index = {stateValues.Count - 1}");
			newIndex = stateValues.Count - 1;
		}
		if (newIndex < 0)
		{
			newIndex = 0;
		}
		if (selectedIndex != newIndex)
		{
			selectedIndex = newIndex;
			if (OnSelectChange != null)
			{
				OnSelectChange(newIndex);
			}
			LoadFromProperties(immediately);
		}
	}

	public void SetSelectedIndexWithCallback(int newIndex, Action callback)
	{
		if (newIndex >= stateValues.Count)
		{
			Debug.LogWarning($"控制器{name}的状态总共有{stateValues.Count}个，但是传来的index = {newIndex}，设置index = {stateValues.Count - 1}");
			newIndex = stateValues.Count - 1;
		}
		if (selectedIndex != newIndex)
		{
			selectedIndex = newIndex;
			if (OnSelectChange != null)
			{
				OnSelectChange(newIndex);
			}
			LoadFromPropertiesWithCallback(callback);
		}
	}

	public int GetStateIndex(string stateValue)
	{
		return stateValues.IndexOf(stateValue);
	}

	public void SetSelectedState(string value, bool immediately = false)
	{
		int num = stateValues.IndexOf(value);
		if (num >= 0)
		{
			SetSelectedIndex(num, immediately);
		}
	}

	public void SetSelectedStateWithCallback(string value, Action callback)
	{
		int num = stateValues.IndexOf(value);
		if (num >= 0)
		{
			SetSelectedIndexWithCallback(num, callback);
		}
	}

	public void ChangeStateValue(int valueIndex, string newVal)
	{
		int num = stateValues.IndexOf(newVal);
		string value = newVal;
		if (num >= 0 && num != valueIndex)
		{
			value = newVal + "_1";
			Debug.LogError("状态名重复~，重新命名为" + value);
			ChangeStateValue(valueIndex, value);
			return;
		}
		_ = stateValues[valueIndex];
		for (int i = 0; i < relateItems.Count; i++)
		{
			relateItems[i].stateValues = stateValues;
		}
		stateValues[valueIndex] = value;
	}

	public void DeleteStateValue(string value)
	{
		int num = stateValues.IndexOf(value);
		if (stateValues.Count == 1 && num >= 0)
		{
			Debug.LogError("状态值必须留一个！");
			return;
		}
		for (int i = 0; i < relateItems.Count; i++)
		{
			for (int num2 = relateItems[i].stateValues.Count - 1; num2 >= 0; num2--)
			{
				if (relateItems[i].stateValues[num2] == value)
				{
					relateItems[i].controllerValues.RemoveAt(num2);
					break;
				}
			}
		}
		stateValues.RemoveAt(num);
		for (int j = 0; j < relateItems.Count; j++)
		{
			relateItems[j].stateValues = stateValues;
		}
		if (selectedIndex == num)
		{
			selectedIndex = 0;
		}
		else if (selectedIndex > num)
		{
			selectedIndex--;
		}
	}

	public void AddStateValue(string value)
	{
		int num = stateValues.IndexOf(value);
		string text = value;
		if (num >= 0)
		{
			text = value + "_1";
			Debug.LogError("状态名重复~，重新命名为" + text);
			AddStateValue(text);
			return;
		}
		stateValues.Add(value);
		if (relateItems.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < relateItems.Count; i++)
		{
			if (relateItems[i].controllerValues.Count < stateValues.Count)
			{
				NewControllerValue newControllerValue = NewControllerValue.CreateFromComponent(relateItems[i].property, relateItems[i].go.GetComponent(GetTypeByProperty(relateItems[i].property)));
				NewControllerValue newControllerValue2 = relateItems[i].controllerValues[relateItems[i].controllerValues.Count - 1];
				newControllerValue.during = newControllerValue2.during;
				newControllerValue.ease = newControllerValue2.ease;
				relateItems[i].controllerValues.Add(newControllerValue);
			}
			relateItems[i].stateValues = stateValues;
		}
	}

	public void UpdateByValue(string name, string[] stateValues)
	{
		this.name = name;
		this.stateValues = stateValues.ToList();
	}

	public string GetSelectedState()
	{
		return stateValues[selectedIndex];
	}

	public string GetName()
	{
		return name;
	}

	public void AddRelateItem(GameObject go, ControllerProperty property, Component target)
	{
		CheckToRemoveMissingItems();
		string key = GetKey(go, property);
		if (GetIndex(go, property) < 0)
		{
			if (target == null)
			{
				Debug.LogError("target是空的！！！");
				return;
			}
			ControllerRelateItem controllerRelateItem = new ControllerRelateItem(go, property, key, stateValues.GetRange(0, stateValues.Count), target);
			controllerRelateItem.AddOrUpdateNewValue(GetSelectedState(), target);
			relateItems.Add(controllerRelateItem);
		}
	}

	private void CheckToRemoveMissingItems()
	{
		for (int num = relateItems.Count - 1; num >= 0; num--)
		{
			if (relateItems[num].go == null || objects.IndexOf(relateItems[num].go) < 0)
			{
				relateItems.RemoveAt(num);
			}
		}
	}

	public void UpdateRelateItem(GameObject go, ControllerProperty property, Component newValue)
	{
		int index = GetIndex(go, property);
		if (index >= 0)
		{
			relateItems[index].AddOrUpdateNewValue(GetSelectedState(), newValue);
		}
	}

	public void RemoveRelateItem(GameObject go, ControllerProperty property)
	{
		if (!(go == null))
		{
			int index = GetIndex(go, property);
			if (index >= 0)
			{
				relateItems.RemoveAt(index);
			}
		}
	}

	public void UpdateTween(int index, bool isTween, float during, LeanTweenType ease)
	{
		tweens[index] = isTween;
		while (durings.Count <= index)
		{
			durings.Add(0.3f);
		}
		while (eases.Count <= index)
		{
			eases.Add(LeanTweenType.linear);
		}
		durings[index] = during;
		eases[index] = ease;
		if (index < relateItems.Count)
		{
			for (int i = 0; i < relateItems[index].controllerValues.Count; i++)
			{
				relateItems[index].controllerValues[i].isTween = isTween;
				relateItems[index].controllerValues[i].during = during;
				relateItems[index].controllerValues[i].ease = ease;
			}
		}
	}

	private string GetKey(GameObject go, ControllerProperty property)
	{
		string text = "";
		Transform parent = go.transform;
		do
		{
			text = "->" + parent.gameObject.name + text;
			parent = parent.parent;
		}
		while (parent != null && parent.gameObject != base.gameObject);
		return text + "_" + property;
	}

	public NewControllerValue GetNewControllerValue(GameObject go, ControllerProperty property)
	{
		int index = GetIndex(go, property);
		if (index >= 0)
		{
			return relateItems[index].GetNewValue(GetSelectedState());
		}
		return null;
	}

	public static Type GetTypeByProperty(ControllerProperty property)
	{
		return property switch
		{
			ControllerProperty.TextStyle => typeof(Text), 
			ControllerProperty.TextValue => typeof(Text), 
			ControllerProperty.RectTransform => typeof(RectTransform), 
			ControllerProperty.Active => typeof(RectTransform), 
			ControllerProperty.ToggleOn => typeof(Toggle), 
			ControllerProperty.Image => typeof(Image), 
			ControllerProperty.CanvasGroup => typeof(CanvasGroup), 
			_ => null, 
		};
	}

	public int GetIndex(GameObject go, ControllerProperty property)
	{
		if (go != null)
		{
			for (int i = 0; i < relateItems.Count; i++)
			{
				ControllerRelateItem controllerRelateItem = relateItems[i];
				if (controllerRelateItem.go.GetInstanceID() == go.GetInstanceID() && controllerRelateItem.property == property)
				{
					return i;
				}
			}
		}
		return -1;
	}

	public bool ContainsObject(GameObject go)
	{
		for (int i = 0; i < relateItems.Count; i++)
		{
			if (relateItems[i].go.GetInstanceID() == go.GetInstanceID())
			{
				return true;
			}
		}
		return false;
	}

	public void SwapStates(int fromIndex, int toIndex)
	{
		string value = stateValues[fromIndex];
		stateValues[fromIndex] = stateValues[toIndex];
		stateValues[toIndex] = value;
		for (int i = 0; i < relateItems.Count; i++)
		{
			relateItems[i].stateValues = stateValues;
			NewControllerValue value2 = relateItems[i].controllerValues[fromIndex];
			relateItems[i].controllerValues[fromIndex] = relateItems[i].controllerValues[toIndex];
			relateItems[i].controllerValues[toIndex] = value2;
		}
		if (selectedIndex == fromIndex)
		{
			SetSelectedIndex(toIndex);
		}
		else if (selectedIndex == toIndex)
		{
			SetSelectedIndex(fromIndex);
		}
	}

	private void CheckUselessRelateItems()
	{
		for (int num = relateItems.Count - 1; num >= 0; num--)
		{
			bool flag = false;
			for (int i = 0; i < objects.Count; i++)
			{
				if (relateItems[num].go != null && relateItems[num].go == objects[i])
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				relateItems.RemoveAt(num);
			}
		}
	}

	public void ResetController()
	{
		objects.Clear();
		properties.Clear();
		tweens.Clear();
		durings.Clear();
		eases.Clear();
		relateItems.Clear();
	}

	public List<ControllerCompareData> IsPropertyOnControl()
	{
		List<ControllerCompareData> list = new List<ControllerCompareData>();
		string state = stateValues[selectedIndex];
		for (int i = 0; i < relateItems.Count; i++)
		{
			ControllerCompareData controllerCompareData = relateItems[i].IsEqualNew(state);
			if (controllerCompareData != null)
			{
				list.Add(controllerCompareData);
			}
		}
		return list;
	}

	public int GetDefaultIndex()
	{
		if (defaultIndex == -1)
		{
			defaultIndex = selectedIndex;
			return selectedIndex;
		}
		return defaultIndex;
	}

	public void ConvertToNewVersion()
	{
		for (int i = 0; i < relateItems.Count; i++)
		{
			relateItems[i].ConvertToNewVersion();
		}
	}

	private void OnDestroy()
	{
		OnSelectChange = null;
		for (int i = 0; i < relateItems.Count; i++)
		{
			if (relateItems[i].go != null)
			{
				relateItems[i].StopTween();
			}
		}
		ResetController();
	}
}
