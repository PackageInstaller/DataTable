using System.Collections.Generic;

namespace T0World;

public class T0InterationMgrContext
{
	public List<T0InterationBaseData> focusEventList = new List<T0InterationBaseData>();

	public void RegisterFocusEVent(T0InterationBaseData eventData)
	{
		if (focusEventList == null)
		{
			focusEventList = new List<T0InterationBaseData>();
		}
		if (!IsFocusExist(eventData))
		{
			focusEventList.Add(eventData);
		}
	}

	public void ClearFocusEvent()
	{
		if (focusEventList != null)
		{
			focusEventList.Clear();
			focusEventList = null;
		}
	}

	public bool IsFocusExist(T0InterationBaseData eventData)
	{
		bool result = false;
		if (focusEventList != null && focusEventList.Count > 0)
		{
			int hashCode = eventData.GetHashCode();
			for (int i = 0; i < focusEventList.Count; i++)
			{
				if (focusEventList[i].GetHashCode() == hashCode)
				{
					result = true;
					break;
				}
			}
		}
		return result;
	}

	public bool CheckIsCanProcess(T0InterationBaseData eventData)
	{
		bool result = false;
		if (focusEventList != null && focusEventList.Count > 0)
		{
			int hashCode = eventData.GetHashCode();
			for (int i = 0; i < focusEventList.Count; i++)
			{
				if (focusEventList[i].GetHashCode() == hashCode)
				{
					result = true;
					break;
				}
			}
		}
		else
		{
			result = true;
		}
		return result;
	}
}
