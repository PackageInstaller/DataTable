using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace UnityEngine.Rendering;

public sealed class VolumeManager
{
	private static readonly Lazy<VolumeManager> s_Instance = new Lazy<VolumeManager>(() => new VolumeManager());

	private static readonly Dictionary<Type, List<(string, Type)>> s_SupportedVolumeComponentsForRenderPipeline = new Dictionary<Type, List<(string, Type)>>();

	private readonly Dictionary<int, List<Volume>> m_SortedVolumes;

	private readonly List<Volume> m_Volumes;

	private readonly Dictionary<int, bool> m_SortNeeded;

	private readonly List<VolumeComponent> m_ComponentsDefaultState;

	private readonly List<Collider> m_TempColliders;

	private VolumeStack m_DefaultStack;

	public static VolumeManager instance => s_Instance.Value;

	public VolumeStack stack { get; set; }

	public Type[] baseComponentTypeArray { get; private set; }

	private VolumeManager()
	{
		m_SortedVolumes = new Dictionary<int, List<Volume>>();
		m_Volumes = new List<Volume>();
		m_SortNeeded = new Dictionary<int, bool>();
		m_TempColliders = new List<Collider>(8);
		m_ComponentsDefaultState = new List<VolumeComponent>();
		ReloadBaseTypes();
		m_DefaultStack = CreateStack();
		stack = m_DefaultStack;
	}

	public VolumeStack CreateStack()
	{
		VolumeStack volumeStack = new VolumeStack();
		volumeStack.Reload(m_ComponentsDefaultState);
		return volumeStack;
	}

	private void ReloadBaseTypes()
	{
		m_ComponentsDefaultState.Clear();
		baseComponentTypeArray = (from t in CoreUtils.GetAllTypesDerivedFrom<VolumeComponent>()
			where !t.IsAbstract
			select t).ToArray();
		BindingFlags bindingAttr = BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;
		Type[] array = baseComponentTypeArray;
		foreach (Type obj in array)
		{
			obj.GetMethod("Init", bindingAttr)?.Invoke(null, null);
			VolumeComponent item = (VolumeComponent)ScriptableObject.CreateInstance(obj);
			m_ComponentsDefaultState.Add(item);
		}
	}

	public void Register(Volume volume, int layer)
	{
		if (m_Volumes.Contains(volume))
		{
			return;
		}
		m_Volumes.Add(volume);
		foreach (KeyValuePair<int, List<Volume>> sortedVolume in m_SortedVolumes)
		{
			if ((sortedVolume.Key & (1 << layer)) != 0 && !sortedVolume.Value.Contains(volume))
			{
				sortedVolume.Value.Add(volume);
			}
		}
		SetLayerDirty(layer);
	}

	public void Unregister(Volume volume, int layer)
	{
		if (!m_Volumes.Remove(volume))
		{
			return;
		}
		foreach (KeyValuePair<int, List<Volume>> sortedVolume in m_SortedVolumes)
		{
			if ((sortedVolume.Key & (1 << layer)) != 0)
			{
				sortedVolume.Value.Remove(volume);
			}
		}
	}

	internal void SetLayerDirty(int layer)
	{
		foreach (KeyValuePair<int, List<Volume>> sortedVolume in m_SortedVolumes)
		{
			int key = sortedVolume.Key;
			if ((key & (1 << layer)) != 0)
			{
				m_SortNeeded[key] = true;
			}
		}
	}

	internal void UpdateVolumeLayer(Volume volume, int prevLayer, int newLayer)
	{
		Unregister(volume, prevLayer);
		Register(volume, newLayer);
	}

	private void OverrideData(VolumeStack stack, List<VolumeComponent> components, float interpFactor)
	{
		int count = components.Count;
		for (int i = 0; i < count; i++)
		{
			VolumeComponent volumeComponent = components[i];
			if (volumeComponent.active)
			{
				VolumeComponent component = stack.GetComponent(volumeComponent.GetType());
				volumeComponent.Override(component, interpFactor);
			}
		}
	}

	internal void ReplaceData(VolumeStack stack)
	{
		(VolumeParameter, VolumeParameter)[] defaultParameters = stack.defaultParameters;
		int num = defaultParameters.Length;
		for (int i = 0; i < num; i++)
		{
			(VolumeParameter, VolumeParameter) tuple = defaultParameters[i];
			VolumeParameter item = tuple.Item1;
			item.overrideState = false;
			item.SetValue(tuple.Item2);
		}
	}

	private bool CheckUpdateRequired(VolumeStack stack)
	{
		if (m_Volumes.Count == 0)
		{
			if (stack.requiresReset)
			{
				stack.requiresReset = false;
				return true;
			}
			return false;
		}
		stack.requiresReset = true;
		return true;
	}

	public void Update(Transform trigger, LayerMask layerMask)
	{
		Update(stack, trigger, layerMask);
	}

	public void Update(VolumeStack stack, Transform trigger, LayerMask layerMask)
	{
		if (!CheckUpdateRequired(stack))
		{
			return;
		}
		ReplaceData(stack);
		bool flag = trigger == null;
		Vector3 vector = (flag ? Vector3.zero : trigger.position);
		List<Volume> list = GrabVolumes(layerMask);
		Camera component = null;
		if (!flag)
		{
			trigger.TryGetComponent<Camera>(out component);
		}
		int count = list.Count;
		for (int i = 0; i < count; i++)
		{
			Volume volume = list[i];
			if (volume == null || !volume.enabled || volume.profileRef == null || volume.weight <= 0f)
			{
				continue;
			}
			if (volume.isGlobal)
			{
				OverrideData(stack, volume.profileRef.components, Mathf.Clamp01(volume.weight));
			}
			else
			{
				if (flag)
				{
					continue;
				}
				List<Collider> tempColliders = m_TempColliders;
				volume.GetComponents(tempColliders);
				if (tempColliders.Count == 0)
				{
					continue;
				}
				float num = float.PositiveInfinity;
				int count2 = tempColliders.Count;
				for (int j = 0; j < count2; j++)
				{
					Collider collider = tempColliders[j];
					if (collider.enabled)
					{
						float sqrMagnitude = (collider.ClosestPoint(vector) - vector).sqrMagnitude;
						if (sqrMagnitude < num)
						{
							num = sqrMagnitude;
						}
					}
				}
				tempColliders.Clear();
				float num2 = volume.blendDistance * volume.blendDistance;
				if (!(num > num2))
				{
					float num3 = 1f;
					if (num2 > 0f)
					{
						num3 = 1f - num / num2;
					}
					OverrideData(stack, volume.profileRef.components, num3 * Mathf.Clamp01(volume.weight));
				}
			}
		}
	}

	private List<Volume> GrabVolumes(LayerMask mask)
	{
		if (!m_SortedVolumes.TryGetValue(mask, out var value))
		{
			value = new List<Volume>();
			int count = m_Volumes.Count;
			for (int i = 0; i < count; i++)
			{
				Volume volume = m_Volumes[i];
				if (((int)mask & (1 << volume.gameObject.layer)) != 0)
				{
					value.Add(volume);
					m_SortNeeded[mask] = true;
				}
			}
			m_SortedVolumes.Add(mask, value);
		}
		if (m_SortNeeded.TryGetValue(mask, out var value2) & value2)
		{
			m_SortNeeded[mask] = false;
			SortByPriority(value);
		}
		return value;
	}

	private static void SortByPriority(List<Volume> volumes)
	{
		for (int i = 1; i < volumes.Count; i++)
		{
			Volume volume = volumes[i];
			int num = i - 1;
			while (num >= 0 && volumes[num].priority > volume.priority)
			{
				volumes[num + 1] = volumes[num];
				num--;
			}
			volumes[num + 1] = volume;
		}
	}
}
