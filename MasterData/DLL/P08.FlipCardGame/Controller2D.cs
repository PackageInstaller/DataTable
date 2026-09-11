using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class Controller2D : MonoBehaviour, IUIController
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
	public List<Controller2DProperty> properties = new List<Controller2DProperty>();

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
	public int defaultIndex = -1;

	[HideInInspector]
	[SerializeField]
	public List<string> relateKeys = new List<string>();

	[SerializeField]
	[Tooltip("请勿编辑！！！！")]
	public List<Controller2DRelateItem> relateItems = new List<Controller2DRelateItem>();

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
		properties.Add(Controller2DProperty.Active);
		tweens.Add(item: false);
		durings.Add(0.3f);
		eases.Add(LeanTweenType.linear);
		CheckUselessRelateItems();
	}

	public void SetGameObject(int index, GameObject go, Controller2DProperty property, Component target)
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
		Controller2DProperty property = properties[index];
		int index2 = GetIndex(gameObject, property);
		if (index2 >= 0)
		{
			relateKeys.RemoveAt(index2);
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

	public void LoadFromProperties()
	{
		for (int i = 0; i < objects.Count; i++)
		{
			if (!(objects[i] == null))
			{
				GetController2DValue(objects[i], properties[i]).PasteToComponent(properties[i], objects[i].GetComponent(GetTypeByProperty(properties[i])));
			}
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
		if (selectedIndex != newIndex)
		{
			selectedIndex = newIndex;
			if (OnSelectChange != null)
			{
				OnSelectChange(newIndex);
			}
			LoadFromProperties();
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
		stateValues.RemoveAt(num);
		for (int i = 0; i < relateItems.Count; i++)
		{
			for (int num2 = relateItems[i].stateValues.Count - 1; num2 >= 0; num2--)
			{
				if (relateItems[i].stateValues[num2] == value)
				{
					relateItems[i].values.RemoveAt(num2);
					break;
				}
			}
			relateItems[i].stateValues = stateValues;
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
			if (relateItems[i].values.Count < stateValues.Count)
			{
				Controller2DValue controller2DValue = Controller2DValue.CreateFromComponent(relateItems[i].property, relateItems[i].go.GetComponent(GetTypeByProperty(relateItems[i].property)));
				Controller2DValue controller2DValue2 = relateItems[i].values[relateItems[i].values.Count - 1];
				controller2DValue.during = controller2DValue2.during;
				controller2DValue.ease = controller2DValue2.ease;
				relateItems[i].values.Add(controller2DValue);
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

	public void AddRelateItem(GameObject go, Controller2DProperty property, Component target)
	{
		CheckToRemoveMissingItems();
		string key = GetKey(go, property);
		if (GetIndex(go, property) < 0)
		{
			relateKeys.Add(key);
			if (target == null)
			{
				Debug.LogError("target是空的！！！");
				return;
			}
			Controller2DRelateItem controller2DRelateItem = new Controller2DRelateItem(go, property, key, stateValues.GetRange(0, stateValues.Count), target);
			controller2DRelateItem.AddOrUpdateValue(GetSelectedState(), target);
			relateItems.Add(controller2DRelateItem);
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

	public void UpdateRelateItem(GameObject go, Controller2DProperty property, Component newValue)
	{
		int index = GetIndex(go, property);
		if (index >= 0)
		{
			relateItems[index].AddOrUpdateValue(GetSelectedState(), newValue);
		}
	}

	public void RemoveRelateItem(GameObject go, Controller2DProperty property)
	{
		if (!(go == null))
		{
			int index = GetIndex(go, property);
			if (index >= 0)
			{
				relateKeys.RemoveAt(index);
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
			for (int i = 0; i < relateItems[index].values.Count; i++)
			{
				relateItems[index].values[i].isTween = isTween;
				relateItems[index].values[i].during = during;
				relateItems[index].values[i].ease = ease;
			}
		}
	}

	private string GetKey(GameObject go, Controller2DProperty property)
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

	public Controller2DValue GetController2DValue(GameObject go, Controller2DProperty property)
	{
		int index = GetIndex(go, property);
		if (index >= 0)
		{
			return relateItems[index].GetValue(GetSelectedState());
		}
		return null;
	}

	public static Type GetTypeByProperty(Controller2DProperty property)
	{
		return property switch
		{
			Controller2DProperty.Active => typeof(Transform), 
			Controller2DProperty.Transform => typeof(Transform), 
			Controller2DProperty.SpriteRenderer => typeof(SpriteRenderer), 
			_ => null, 
		};
	}

	private int GetIndex(GameObject go, Controller2DProperty property)
	{
		if (go != null)
		{
			for (int i = 0; i < relateItems.Count; i++)
			{
				Controller2DRelateItem controller2DRelateItem = relateItems[i];
				if (controller2DRelateItem.go.GetInstanceID() == go.GetInstanceID() && controller2DRelateItem.property == property)
				{
					return i;
				}
			}
		}
		else
		{
			Debug.LogError($"{base.gameObject.name}的{name}控制器中，存在属性为{property}的空对象的序列化，请检查！！！");
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
			Controller2DValue value2 = relateItems[i].values[fromIndex];
			relateItems[i].values[fromIndex] = relateItems[i].values[toIndex];
			relateItems[i].values[toIndex] = value2;
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
				relateKeys.RemoveAt(num);
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
		relateKeys.Clear();
		relateItems.Clear();
	}

	public List<Controller2DCompareData> IsPropertyOnControl()
	{
		List<Controller2DCompareData> list = new List<Controller2DCompareData>();
		string state = stateValues[selectedIndex];
		for (int i = 0; i < relateItems.Count; i++)
		{
			Controller2DCompareData controller2DCompareData = relateItems[i].IsEqual(state);
			if (controller2DCompareData != null)
			{
				list.Add(controller2DCompareData);
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

	private void OnDestroy()
	{
		OnSelectChange = null;
		ResetController();
	}
}
