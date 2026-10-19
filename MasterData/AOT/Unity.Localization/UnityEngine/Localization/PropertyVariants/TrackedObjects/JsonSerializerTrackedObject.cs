using System;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using UnityEngine.Localization.PropertyVariants.TrackedProperties;
using UnityEngine.Localization.Pseudo;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization.PropertyVariants.TrackedObjects;

[Serializable]
public abstract class JsonSerializerTrackedObject : TrackedObject
{
	public enum ApplyChangesMethod
	{
		Partial,
		Full
	}

	private class DeferredJsonStringOperation
	{
		public JValue jsonValue;

		public readonly Action<AsyncOperationHandle<string>> callback;

		public DeferredJsonStringOperation()
		{
			callback = OnStringLoaded;
		}

		private void OnStringLoaded(AsyncOperationHandle<string> asyncOperationHandle)
		{
			jsonValue.Value = asyncOperationHandle.Result;
			jsonValue = null;
			GenericPool<DeferredJsonStringOperation>.Release(this);
		}
	}

	private class DeferredJsonObjectOperation
	{
		public JValue jsonValue;

		public readonly Action<AsyncOperationHandle<Object>> callback;

		public DeferredJsonObjectOperation()
		{
			callback = OnStringLoaded;
		}

		private void OnStringLoaded(AsyncOperationHandle<Object> asyncOperationHandle)
		{
			jsonValue.Value = ((asyncOperationHandle.Result != null) ? asyncOperationHandle.Result.GetInstanceID() : 0);
			jsonValue = null;
			GenericPool<DeferredJsonObjectOperation>.Release(this);
		}
	}

	internal struct ArrayResult
	{
		public string path;

		public int arrayStartIndex;

		public int arrayDataIndexStart;

		public int arrayDataIndexEnd;

		public bool IsArraySize
		{
			get
			{
				if (arrayStartIndex != -1)
				{
					return arrayDataIndexStart == -1;
				}
				return false;
			}
		}

		public bool IsArrayElement => path?.Length == arrayDataIndexEnd + 1;

		public int GetDataIndex()
		{
			if (arrayDataIndexStart == -1)
			{
				return -1;
			}
			string text = path.Substring(arrayDataIndexStart, arrayDataIndexEnd - arrayDataIndexStart);
			if (uint.TryParse(text, out var result))
			{
				return (int)result;
			}
			Debug.LogError("Failed to parse Array index `" + text + "` from property path `" + path + "`");
			return -1;
		}

		public ArrayResult(string p, int start, int bracketStart, int bracketEnd)
		{
			path = p;
			arrayStartIndex = start;
			arrayDataIndexStart = bracketStart;
			arrayDataIndexEnd = bracketEnd;
		}
	}

	[SerializeField]
	[Tooltip("Determines the type of property update that will be performed.- Full update reads the entire object into JSON, patches the properties, then reapplies the new JSON.\n- Partial update generates a partial patch and applies the changes for the tracked properties only.\nPartial update provides better performance however is not supported when modifying collections or properties that contain a serialized version such as Rect.\nThis value is automatically set based on the properties tracked.")]
	private ApplyChangesMethod m_UpdateType;

	public ApplyChangesMethod UpdateType
	{
		get
		{
			return m_UpdateType;
		}
		set
		{
			m_UpdateType = value;
		}
	}

	public override void AddTrackedProperty(ITrackedProperty trackedProperty)
	{
		base.AddTrackedProperty(trackedProperty);
		if (trackedProperty.PropertyPath.Contains(".Array.data[") || trackedProperty.PropertyPath.EndsWith(".Array.size"))
		{
			UpdateType = ApplyChangesMethod.Full;
		}
	}

	public override AsyncOperationHandle ApplyLocale(Locale variantLocale, Locale defaultLocale)
	{
		if (Target == null)
		{
			return default;
		}
		JObject jsonObject;
		if (UpdateType == ApplyChangesMethod.Full)
		{
			string json = JsonUtility.ToJson(Target);
			jsonObject = JObject.Parse(json);
		}
		else
		{
			jsonObject = new JObject();
		}
		List<AsyncOperationHandle> asyncOperations = CollectionPool<List<AsyncOperationHandle>, AsyncOperationHandle>.Get();
		List<ArraySizeTrackedProperty> arraySizes = CollectionPool<List<ArraySizeTrackedProperty>, ArraySizeTrackedProperty>.Get();
		bool flag = false;
		LocaleIdentifier defaultLocaleIdentifier = ((defaultLocale != null) ? defaultLocale.Identifier : default(LocaleIdentifier));
		foreach (ITrackedProperty trackedProperty in TrackedProperties)
		{
			if (!(trackedProperty is ArraySizeTrackedProperty item))
			{
				if (!(trackedProperty is IStringProperty stringProperty))
				{
					if (!(trackedProperty is ITrackedPropertyValue<Object> trackedPropertyValue))
					{
						if (!(trackedProperty is LocalizedStringProperty localizedStringProperty))
						{
							if (trackedProperty is LocalizedAssetProperty localizedAssetProperty && !localizedAssetProperty.LocalizedObject.IsEmpty)
							{
								localizedAssetProperty.LocalizedObject.LocaleOverride = variantLocale;
								AsyncOperationHandle<Object> asyncOperationHandle = localizedAssetProperty.LocalizedObject.LoadAssetAsObjectAsync();
								JValue jValue = (JValue)GetPropertyFromPath(trackedProperty.PropertyPath + ".instanceID", jsonObject);
								if (asyncOperationHandle.IsDone)
								{
									Object result = asyncOperationHandle.Result;
									jValue.Value = ((result != null) ? result.GetInstanceID() : 0);
								}
								else if (localizedAssetProperty.LocalizedObject.WaitForCompletion)
								{
									Object obj = asyncOperationHandle.WaitForCompletion();
									jValue.Value = ((obj != null) ? obj.GetInstanceID() : 0);
								}
								else
								{
									DeferredJsonObjectOperation deferredJsonObjectOperation = GenericPool<DeferredJsonObjectOperation>.Get();
									deferredJsonObjectOperation.jsonValue = jValue;
									asyncOperationHandle.Completed += deferredJsonObjectOperation.callback;
									asyncOperations.Add(asyncOperationHandle);
								}
								flag = true;
							}
						}
						else if (!localizedStringProperty.LocalizedString.IsEmpty)
						{
							localizedStringProperty.LocalizedString.LocaleOverride = variantLocale;
							AsyncOperationHandle<string> localizedStringAsync = localizedStringProperty.LocalizedString.GetLocalizedStringAsync();
							JValue jValue2 = (JValue)GetPropertyFromPath(trackedProperty.PropertyPath, jsonObject);
							if (localizedStringAsync.IsDone)
							{
								jValue2.Value = localizedStringAsync.Result;
							}
							else if (localizedStringProperty.LocalizedString.WaitForCompletion)
							{
								jValue2.Value = localizedStringAsync.WaitForCompletion();
							}
							else
							{
								DeferredJsonStringOperation deferredJsonStringOperation = GenericPool<DeferredJsonStringOperation>.Get();
								deferredJsonStringOperation.jsonValue = jValue2;
								localizedStringAsync.Completed += deferredJsonStringOperation.callback;
								asyncOperations.Add(localizedStringAsync);
							}
							flag = true;
						}
					}
					else
					{
						trackedPropertyValue.GetValue(variantLocale.Identifier, defaultLocaleIdentifier, out var foundValue);
						((JValue)GetPropertyFromPath(trackedProperty.PropertyPath + ".instanceID", jsonObject)).Value = ((foundValue != null) ? foundValue.GetInstanceID() : 0);
						flag = true;
					}
				}
				else
				{
					string valueAsString = stringProperty.GetValueAsString(variantLocale.Identifier, defaultLocaleIdentifier);
					if (valueAsString != null)
					{
						((JValue)GetPropertyFromPath(trackedProperty.PropertyPath, jsonObject)).Value = ((variantLocale is PseudoLocale pseudoLocale) ? pseudoLocale.GetPseudoString(valueAsString) : valueAsString);
						flag = true;
					}
				}
			}
			else
			{
				arraySizes.Add(item);
				flag = true;
			}
		}
		if (asyncOperations.Count > 0)
		{
			foreach (AsyncOperationHandle item2 in asyncOperations)
			{
				AddressablesInterface.Acquire(item2);
			}
			AsyncOperationHandle<IList<AsyncOperationHandle>> asyncOperationHandle2 = AddressablesInterface.ResourceManager.CreateGenericGroupOperation(asyncOperations, releasedCachedOpOnComplete: true);
			asyncOperationHandle2.Completed += (AsyncOperationHandle<IList<AsyncOperationHandle>> res) =>
			{
				ApplyArraySizes(arraySizes, jsonObject, variantLocale.Identifier, defaultLocaleIdentifier);
				ApplyJson(jsonObject);
				CollectionPool<List<AsyncOperationHandle>, AsyncOperationHandle>.Release(asyncOperations);
				CollectionPool<List<ArraySizeTrackedProperty>, ArraySizeTrackedProperty>.Release(arraySizes);
			};
			return asyncOperationHandle2;
		}
		if (flag)
		{
			ApplyArraySizes(arraySizes, jsonObject, variantLocale.Identifier, defaultLocaleIdentifier);
			ApplyJson(jsonObject);
		}
		CollectionPool<List<AsyncOperationHandle>, AsyncOperationHandle>.Release(asyncOperations);
		CollectionPool<List<ArraySizeTrackedProperty>, ArraySizeTrackedProperty>.Release(arraySizes);
		return default;
	}

	private void ApplyArraySizes(IEnumerable<ArraySizeTrackedProperty> arraySizes, JObject jsonObject, LocaleIdentifier variantLocale, LocaleIdentifier defaultLocale)
	{
		foreach (ArraySizeTrackedProperty arraySize in arraySizes)
		{
			JArray jArray = (JArray)GetPropertyFromPath(arraySize.PropertyPath, jsonObject);
			if (!arraySize.GetValue(variantLocale, defaultLocale, out var foundValue))
			{
				continue;
			}
			if (jArray.Count > foundValue)
			{
				while (jArray.Count > foundValue)
				{
					jArray.RemoveAt(jArray.Count - 1);
				}
			}
			else if (jArray.Count < foundValue)
			{
				while (jArray.Count < foundValue)
				{
					jArray.Add(new JObject());
				}
			}
		}
	}

	private void ApplyJson(JObject jsonObject)
	{
		JsonUtility.FromJsonOverwrite(jsonObject.ToString(), Target);
		PostApplyTrackedProperties();
	}

	internal static ArrayResult GetNextArrayItem(string path, int startIndex)
	{
		if (path.Length < startIndex + ".Array.".Length)
		{
			return new ArrayResult(null, -1, -1, -1);
		}
		int num = path.IndexOf(".Array.", startIndex, StringComparison.Ordinal);
		if (num != -1)
		{
			if (path.Length > num + ".Array.".Length + "data[".Length)
			{
				int num2 = path.IndexOf("data[", num + ".Array.".Length, StringComparison.Ordinal);
				if (num2 != -1)
				{
					num2 += "data[".Length;
					int num3 = path.IndexOf(']', num2);
					if (num3 != -1)
					{
						return new ArrayResult(path, num + 1, num2, num3);
					}
				}
			}
			if (path.Length == num + "size".Length + ".Array.".Length && path.EndsWith("size"))
			{
				return new ArrayResult(path, num + 1, -1, -1);
			}
		}
		return new ArrayResult(null, -1, -1, -1);
	}

	internal static JToken GetPropertyFromPath(string path, JContainer obj)
	{
		int num = 0;
		ArrayResult nextArrayItem = GetNextArrayItem(path, 0);
		JContainer jContainer = obj;
		while (num != -1 && num < path.Length)
		{
			if (num == nextArrayItem.arrayStartIndex)
			{
				JArray jArray = jContainer as JArray;
				if (jArray == null)
				{
					jArray = new JArray();
					jContainer.Add(jArray);
				}
				if (nextArrayItem.IsArraySize)
				{
					return jArray;
				}
				int dataIndex = nextArrayItem.GetDataIndex();
				if (dataIndex == -1)
				{
					return null;
				}
				while (jArray.Count <= dataIndex)
				{
					jArray.Add(new JObject());
				}
				if (nextArrayItem.IsArrayElement)
				{
					JValue jValue = jArray[dataIndex] as JValue;
					if (jValue == null)
					{
						jValue = (JValue)(jArray[dataIndex] = new JValue(string.Empty));
					}
					return jValue;
				}
				jContainer = jArray[dataIndex] as JObject;
				if (jContainer == null)
				{
					jContainer = (JContainer)(jArray[dataIndex] = new JObject());
				}
				num = nextArrayItem.arrayDataIndexEnd + 2;
				nextArrayItem = GetNextArrayItem(path, num);
				continue;
			}
			int num2 = path.IndexOf('.', num);
			string text = ((num2 == -1) ? path.Substring(num) : path.Substring(num, num2 - num));
			if (num2 == -1)
			{
				JProperty jProperty = (JProperty)(jContainer[text]?.Parent);
				JValue jValue2;
				if (jProperty == null)
				{
					jValue2 = new JValue(string.Empty);
					jProperty = new JProperty(text, jValue2);
					jContainer.Add(jProperty);
				}
				else
				{
					jValue2 = jProperty.Value as JValue;
					if (jValue2 == null)
					{
						jValue2 = (JValue)(jProperty.Value = new JValue(string.Empty));
					}
				}
				return jValue2;
			}
			JContainer jContainer2 = (JContainer)jContainer[text];
			if (jContainer2 == null)
			{
				jContainer2 = (JContainer)(jContainer[text] = new JObject());
			}
			jContainer = jContainer2;
			num = num2 + 1;
		}
		return null;
	}
}
